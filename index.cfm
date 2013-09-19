<cfoutput>

	<h1>UpStarter (Scaffolding on Roids)</h1>
	<br />	
	
	Submitting the form below will cause Up Starter to generate your Views, Models, and Controllers.
	<br />
	<br />
	
	<form action="/rewrite.cfm?#cgi.QUERY_STRING#" method="post">
	
		#hiddenFieldTag("method","go")#
		
		#textFieldTag(name="tablelist", label="Comma Separated List of Tables<br />")#<br /><br />
		#textFieldTag(name="datasource", label="Datasource<br />")#<br />
		
		<br />
		#submitTag(value="DO IT!!")#
		
	</form>
	
	<cfif !isNull(form.tablelist)>
		<cfset upstarter = CreateObject("component","upstarter")>
		<h2>Success!</h2>
		<strong>The following tables were processed:</strong><br />
		#upstarter.go(form.tablelist,form.datasource)#
	</cfif>
	
	<br />
	<br />

	<h2>Installation</h2>
	
	<strong>Note:</strong> I suggest you only use this on a blank cfwheels project, otherwise it could overwrite important stuff.<br />
	<br />
	
	<strong>Another note:</strong> I made this for myself so you may not like certain things about how things are done. Thats fine. Just edit the plugin and make it fit your needs. I suggest disabling auto zip delete and overwrite (as seen in resources/config/settings.cfm) so you can hack and mod UpStarter to suite your needs. And hey if you make it better make a pull request on Github :)<br />
<br />
	
	It would be easiest for you to just copy all assets from the "Resources" folder to your main CFWheels project. Some overwriting will ensue.<br />
	<br />
	
	Make sure to update the settings file to match your configuration.<br />
	<br />
	
	To UpStart your project just create a comma separated list of your tables and put the in the form above along with your datasource name. Then press the shiny button and hope nothing explodes.<br />
<br />

	If you like it please star the Github repo to show your support:<br />
	<a href="https://github.com/timsayshey/cfwheels-upstarter">https://github.com/timsayshey/cfwheels-upstarter</a>

</cfoutput>

