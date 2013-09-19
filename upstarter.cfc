<cfcomponent>

<cfscript>

	function init()
{			
		// cfwheels version string
		this.version = "1.1";
		
		return this;
	}
	
	function go(tablelist="",datasource="db",rootpath="/")
	{		
		rootpath = getDirectoryFromPath(getBaseTemplatePath());
		
		paths = {	
			rootpath = rootpath,
			controllerspath = "#rootpath#controllers",			
			modelspath = "#rootpath#models",			
			viewspath = "#rootpath#views"		
		};
		
		for (i = 1; i lte ListLen(tablelist); i++) 
		{						
			table = trim(ListGetAt(tablelist,i));
			modelPluralLcase = pluralizeit(table);
			modelPluralCap = capitalize(pluralizeit(table));
			modelSingularLcase = singularizeit(table);
			modelSingularCap = capitalize(singularizeit(table));
			
			// Get page table columns			
			queryObj = new query();
			queryObj.setDatasource(datasource);
			queryObj.setName("qModel");	
			result = queryObj.execute(sql="SELECT * FROM #table#");
    		qModel = result.getResult();			
			
			// Create view folder
			viewpath = "#paths.viewspath#/#modelPluralLcase#/";
			confirmDirectory(viewpath);
			
			// Write pageDB Contents
			FileWrite(
				"#viewpath##modelSingularLcase#db.cfm",
				modeldb(modelPluralLcase,qModel,modelSingularCap,modelSingularLcase)
			);
				 
			// Generate page Contents
			// Write page Contents
			FileWrite(
				"#viewpath##modelPluralLcase#.cfm",
				modelList(modelPluralLcase,qModel,modelSingularCap,modelSingularLcase)
			);			
				 
			// Generate cfc Contents
			// Write cfc Contents
			FileWrite(
				"#paths.controllerspath#/#modelPluralCap#.cfc",
				controllercfc(modelPluralLcase,qModel,modelSingularCap,modelSingularLcase)
			);		
			
			// Generate cfc Contents
			// Write cfc Contents
			FileWrite(
				"#paths.modelspath#/#modelSingularCap#.cfc",
				modelcfc(modelPluralLcase,qModel,modelSingularCap,modelSingularLcase,modelPluralCap)
			);	
			
			writeDump(modelPluralLcase);
		}		
	}
</cfscript>

<cffunction name="modelList">
	<cfargument name="modelPluralLcase">
	<cfargument name="qModel">
	<cfargument name="modelSingularCap">
	<cfargument name="modelSingularLcase">
	<cfargument name="modelPluralCap">
	
	<cfset cfoutput = "cfoutput">
	<cfset cfloop = "cfloop">
	
	<cfoutput>
	<cfsavecontent variable="content">
		 
	<#cfoutput#> 
	
		##contentFor(requiresDatatableJs=true)##
		
		##contentFor(pageTitle="#modelPluralCap#")## 
		
		<p>##linkTo(text="New #modelSingularCap#", action="#modelSingularLcase#db", class="btn btn-primary pull-right")##</p>
		
		<table class="table table-striped" id="datatable">
			<thead>
			<tr>			
			<cfset cnt = 1>
			<cfloop list="#qModel.Columnlist#" index="column">				
				<cfset colname = capitalize(LCase(column))>	
				<th#randomRespData(cnt)#>#colname#</th>
				<cfset cnt++>
			</cfloop>
				<th>&nbsp;</th>
			</tr>
			</thead>
			<tbody>			
			<#cfloop# query="#modelPluralLcase#">				
				<tr>
					
				<cfloop list="#qModel.Columnlist#" index="column">				
					<cfset colname = LCase(column)>	
					<td>###colname###</td>			
				</cfloop>
			
					<td class="align-right">					
						##linkTo(text="Edit", action="#modelSingularLcase#db", key=id, class="btn btn-info")##
						##linkTo(
							 text="Delete", 
							 action="delete#modelSingularCap#", 
							 key=id, 
							 onclick="return confirm('Are you sure you want to permanently delete this?')",
							 class="btn btn-danger"
						)##					
					</td>
					
				</tr>			
			</#cfloop#>
			</tbody>
		</table>
	
	</#cfoutput#>
			
	</cfsavecontent>
	</cfoutput>
	
	<cfreturn content>

</cffunction>

<cffunction name="modeldb">
	<cfargument name="modelPluralLcase">
	<cfargument name="qModel">
	<cfargument name="modelSingularCap">
	<cfargument name="modelSingularLcase">
	
	<cfset cfoutput = "cfoutput">
	<cfset cfloop = "cfloop">
	<cfset cfif = "cfif">
	<cfset cfelse = "cfelse">
	
	<cfoutput>
	<cfsavecontent variable="content">
	
		<#cfoutput#>
		
			##contentFor(pageTitle="#modelSingularCap#")## 
			
			##errorMessagesFor("#modelSingularLcase#")##
		
			<#cfif# isDefined("params.key")> 
				##startFormTag(action="update#modelSingularCap#", key=params.key, enctype="multipart/form-data")##
			<#cfelse#>
				##startFormTag(action="create#modelSingularCap#", enctype="multipart/form-data")##
			</#cfif#>
							
				<cfloop list="#qModel.Columnlist#" index="column">			
					<cfset colname = LCase(column)>	
					##textField(objectName='#modelSingularLcase#', property='#colname#', label='#capitalize(colname)#')##
				</cfloop>
							
				##submitTag(class="btn btn-primary")##
			
			##endFormTag()##
			
			##linkTo(text="Return to listings", action="#modelPluralLcase#")##
		
		</#cfoutput#>
			
	</cfsavecontent>
	</cfoutput>
	
	<cfreturn content>

</cffunction>

<cffunction name="controllercfc">
	
	<cfargument name="modelPluralLcase">
	<cfargument name="qModel">
	<cfargument name="modelSingularCap">
	<cfargument name="modelSingularLcase">
	
	<cfoutput>
	<cfset cfscript = "cfscript">
	<cfsavecontent variable="cfccontent">
	<#cfscript#>
	component extends="controllers.Admin" output="false" 
	{
	
		/*
		/////////////////////////////////////////////////////////////////////
		/////////////////////////////////////////////////////////////////////
		/////////////////////////////////////////////////////////////////////
		///
		///  #UCase(modelSingularLcase)# ACTIONS
		///  This is where all of the #modelPluralLcase# actions are
		///  in case you weren't sure :)
		///
		/////////////////////////////////////////////////////////////////////
		/////////////////////////////////////////////////////////////////////
		/////////////////////////////////////////////////////////////////////
		*/
		
		public void function init()
		{
			super.init();		
		}
		 
		// #modelSingularCap#s
		public function #modelPluralLcase#()
		{		
			#modelSingularCap#s = model("#modelSingularCap#").findAll();
		}
		
		// #modelSingularCap#
		public function #modelSingularLcase#()
		{
			#modelSingularCap# = model("#modelSingularCap#").findByKey(params.key);
				
			if (!IsObject(#modelSingularCap#)){
				flashInsert(error="Not found");
				redirectTo(action="#modelPluralLcase#");
			}
		}
		
		// #modelSingularCap#db
		public void function #modelSingularLcase#db()
		{
			
			if(isDefined("params.key")) 
			{
				#modelSingularLcase# = model("#modelSingularCap#").findByKey(params.key);
				
				if (!IsObject(#modelSingularLcase#)){
					flashInsert(error="Not found");
					redirectTo(action="#modelPluralLcase#");
				}
				
			} else {
				#modelSingularLcase# = model("#modelSingularCap#").new();	
			}
			
			#modelPluralLcase# = model("#modelSingularCap#").findAll();	
			
		}
		
		// #modelSingularCap#s/create
		public void function create#modelSingularLcase#()
		{
			#modelSingularCap# = model("#modelSingularCap#").new(params.#modelSingularCap#);
			
			if (#modelSingularCap#.save())
			{			
				flashInsert(success="Created successfully.");
				redirectTo(action="#modelPluralLcase#");			
			} else {
				flashInsert(error="There was an error.");
				renderView(action="#modelSingularLcase#db");
			}
		}
		
		// #modelSingularCap#s/update
		public void function update#modelSingularLcase#()
		{
			#modelSingularCap# = model("#modelSingularCap#").findByKey(params.key);
			
			if (#modelSingularCap#.update(params.#modelSingularCap#)){
				flashInsert(success="Updated successfully.");
				redirectTo(action="#modelPluralLcase#");
			} else {
				flashInsert(error="There was an error updating.");
				renderView(action="#modelSingularLcase#db");
			}
		}
		
		// #modelSingularCap#s/delete/key
		public void function delete#modelSingularLcase#()
		{
			#modelSingularCap# = model("#modelSingularCap#").findByKey(params.key);
		
			if (#modelSingularCap#.delete()){
				flashInsert(success="Deleted successfully.");
				redirectTo(action="#modelPluralLcase#");
			} else {
				flashInsert(error="There was an error deleting.");
				redirectTo(action="#modelPluralLcase#");
			}
		}
	}
	</#cfscript#>
	</cfsavecontent>
	</cfoutput>
	<cfreturn cfccontent>
</cffunction>


<cffunction name="modelcfc">
	
	<cfargument name="modelPluralLcase">
	<cfargument name="qModel">
	<cfargument name="modelSingularCap">
	<cfargument name="modelSingularLcase">	
	
	<cfset cfscript = "cfscript">
	<cfset cfcomponent = "cfcomponent">
	
	<cfoutput>
	<cfsavecontent variable="cfccontent">
		<#cfcomponent# extends="Model">
			<#cfscript#>					
				function init()
				{				
					// Example
					// table("#modelSingularLcase#");
					// property(name="id", column="#modelSingularLcase#id");
				}					
			</#cfscript#>
		</#cfcomponent#>
	</cfsavecontent>
	</cfoutput>
	
	<cfreturn cfccontent>
</cffunction>

<cfinclude template="utils.cfm">

</cfcomponent>