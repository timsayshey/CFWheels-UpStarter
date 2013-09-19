<cfscript>
	function capitalize(str) 
	{   
		var result = ""; 
		result = reReplace(str, "\b(\w)", "\U\1", "all");
		result = reReplace(result, "\b(The|A|An)\b", "\L\1", "all"); 
		result = reReplace(result, "(^|\()(\w)", "\1\U\2", "all");
		result = reReplace(result,"'","’","all");   
		return result; 
	} 
	
	function randomRespData(num)
	{
		if(num eq 1) {
			return ' data-class="expand"';
		} else if (num MOD 2) {
			return ' data-hide="phone,tablet"';
		}
	}
</cfscript>

<cffunction name="confirmDirectory">
	<cfargument name="dir">
	<cfif !DirectoryExists(dir)>
		<cfdirectory 
			directory = "#dir#"
			action = "create">
	</cfif>	
</cffunction>

<cffunction name="pluralizeit" returntype="string">
	<cfargument name="word" type="string" required="true" hint="The word to pluralize.">
	<cfargument name="count" type="numeric" required="false" default="-1" hint="Pluralization will occur when this value is not `1`.">
	<cfargument name="returnCount" type="boolean" required="false" default="true" hint="Will return `count` prepended to the pluralization when `true` and `count` is not `-1`.">
	<cfreturn singularizeOrpluralizeit(text=arguments.word, which="pluralize", count=arguments.count, returnCount=arguments.returnCount)>
</cffunction>

<cffunction name="singularizeit" returntype="string">
	<cfargument name="word" type="string" required="true" hint="String to singularize.">
	<cfreturn singularizeOrpluralizeit(text=arguments.word, which="singularize")>
</cffunction>

<cffunction name="singularizeOrpluralizeit" returntype="string" access="public" output="false" hint="Called by singularize and pluralize to perform the conversion.">
	<cfargument name="text" type="string" required="true">
	<cfargument name="which" type="string" required="true">
	<cfargument name="count" type="numeric" required="false" default="-1">
	<cfargument name="returnCount" type="boolean" required="false" default="true">
	<cfscript>
		var loc = {};

		// by default we pluralize/singularize the entire string
		loc.text = arguments.text;

		// when count is 1 we don't need to pluralize at all so just set the return value to the input string
		loc.returnValue = loc.text;

		if (arguments.count != 1)
		{

			if (REFind("[A-Z]", loc.text))
			{
				// only pluralize/singularize the last part of a camelCased variable (e.g. in "websiteStatusUpdate" we only change the "update" part)
				// also set a variable with the unchanged part of the string (to be prepended before returning final result)
				loc.upperCasePos = REFind("[A-Z]", Reverse(loc.text));
				loc.prepend = Mid(loc.text, 1, Len(loc.text)-loc.upperCasePos);
				loc.text = Reverse(Mid(Reverse(loc.text), 1, loc.upperCasePos));
			}
			loc.uncountables = "advice,air,blood,deer,equipment,fish,food,furniture,garbage,graffiti,grass,homework,housework,information,knowledge,luggage,mathematics,meat,milk,money,music,pollution,research,rice,sand,series,sheep,soap,software,species,sugar,traffic,transportation,travel,trash,water,feedback";
			loc.irregulars = "child,children,foot,feet,man,men,move,moves,person,people,sex,sexes,tooth,teeth,woman,women";
			if (ListFindNoCase(loc.uncountables, loc.text))
				loc.returnValue = loc.text;
			else if (ListFindNoCase(loc.irregulars, loc.text))
			{
				loc.pos = ListFindNoCase(loc.irregulars, loc.text);
				if (arguments.which == "singularize" && loc.pos MOD 2 == 0)
					loc.returnValue = ListGetAt(loc.irregulars, loc.pos-1);
				else if (arguments.which == "pluralize" && loc.pos MOD 2 != 0)
					loc.returnValue = ListGetAt(loc.irregulars, loc.pos+1);
				else
					loc.returnValue = loc.text;
			}
			else
			{
				if (arguments.which == "pluralize")
					loc.ruleList = "(quiz)$,\1zes,^(ox)$,\1en,([m|l])ouse$,\1ice,(matr|vert|ind)ix|ex$,\1ices,(x|ch|ss|sh)$,\1es,([^aeiouy]|qu)y$,\1ies,(hive)$,\1s,(?:([^f])fe|([lr])f)$,\1\2ves,sis$,ses,([ti])um$,\1a,(buffal|tomat|potat|volcan|her)o$,\1oes,(bu)s$,\1ses,(alias|status)$,\1es,(octop|vir)us$,\1i,(ax|test)is$,\1es,s$,s,$,s";
				else if (arguments.which == "singularize")
					loc.ruleList = "(quiz)zes$,\1,(matr)ices$,\1ix,(vert|ind)ices$,\1ex,^(ox)en,\1,(alias|status)es$,\1,([octop|vir])i$,\1us,(cris|ax|test)es$,\1is,(shoe)s$,\1,(o)es$,\1,(bus)es$,\1,([m|l])ice$,\1ouse,(x|ch|ss|sh)es$,\1,(m)ovies$,\1ovie,(s)eries$,\1eries,([^aeiouy]|qu)ies$,\1y,([lr])ves$,\1f,(tive)s$,\1,(hive)s$,\1,([^f])ves$,\1fe,(^analy)ses$,\1sis,((a)naly|(b)a|(d)iagno|(p)arenthe|(p)rogno|(s)ynop|(t)he)ses$,\1\2sis,([ti])a$,\1um,(n)ews$,\1ews,(.*)?ss$,\1ss,s$,#Chr(7)#";
				loc.rules = ArrayNew(2);
				loc.count = 1;
				loc.iEnd = ListLen(loc.ruleList);
				for (loc.i=1; loc.i <= loc.iEnd; loc.i=loc.i+2)
				{
					loc.rules[loc.count][1] = ListGetAt(loc.ruleList, loc.i);
					loc.rules[loc.count][2] = ListGetAt(loc.ruleList, loc.i+1);
					loc.count = loc.count + 1;
				}
				loc.iEnd = ArrayLen(loc.rules);
				for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
				{
					if(REFindNoCase(loc.rules[loc.i][1], loc.text))
					{
						loc.returnValue = REReplaceNoCase(loc.text, loc.rules[loc.i][1], loc.rules[loc.i][2]);
						break;
					}
				}
				loc.returnValue = Replace(loc.returnValue, Chr(7), "", "all");
			}

			// this was a camelCased string and we need to prepend the unchanged part to the result
			if (StructKeyExists(loc, "prepend"))
				loc.returnValue = loc.prepend & loc.returnValue;

		}

		// return the count number in the string (e.g. "5 sites" instead of just "sites")
		if (arguments.returnCount && arguments.count != -1)
			loc.returnValue = LSNumberFormat(arguments.count) & " " & loc.returnValue;
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>