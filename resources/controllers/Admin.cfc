<cfscript>
component output="false" extends="controllers.Controller"  
{
	function init()
	{
		usesLayout("../layout.admin");	
		filters(through="adminSettings");
	}
	
	function adminSettings()
	{
		if(!isNull(adminSettings)) 
		{
			adminSettings = {};
		}
		
		adminSettings = {
			// setting go here
		};
	}
			
}
</cfscript>