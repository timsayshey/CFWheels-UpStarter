<cfscript>
	
	// Settings
	set(URLRewriting="Partial");
	set(dataSourceName="db");
	
	// Disable annoying zip deleter/overwriter	
	set(overwritePlugins=false);
	set(deletePluginDirectories=false);		
	
	// Change styles/js paths
	set(stylesheetPath="assets");
	set(javascriptPath="assets");		
	
	// Bootstrap Form Styling		
	set(functionName="textField", labelClass="control-label", prependToLabel='<div class="control-group">', appendToLabel='<div class="controls">', append="</div></div>", labelPlacement="before");

	set(functionName="textFieldTag", labelClass="control-label", prependToLabel='<div class="control-group">', appendToLabel='<div class="controls">', append="</div></div>", labelPlacement="before");

	set(functionName="passwordFieldTag", labelClass="control-label", prependToLabel='<div class="control-group">', appendToLabel='<div class="controls">', append="</div></div>", labelPlacement="before");

	set(functionName="passwordField", labelClass="control-label", prependToLabel='<div class="control-group">', appendToLabel='<div class="controls">', append="</div></div>", labelPlacement="before");

	set(functionName="fileField", labelClass="control-label", prependToLabel='<div class="control-group">', appendToLabel='<div class="controls">', append="</div></div>", labelPlacement="before");

	set(functionName="fileFieldTag", labelClass="control-label",  prependToLabel='<div class="control-group">', appendToLabel='<div class="controls">', append="</div></div>", labelPlacement="before");

	set(functionName="select", labelClass="control-label", prependToLabel='<div class="control-group">', appendToLabel='<div class="controls">', append="</div></div>", labelPlacement="before");

	set(functionName="selectTag", labelClass="control-label", prependToLabel='<div class="control-group">', appendToLabel='<div class="controls">', append="</div></div>", labelPlacement="before");

	set(functionName="textArea", labelClass="control-label", prependToLabel='<div class="control-group">', appendToLabel='<div class="controls">', append="</div></div>", labelPlacement="before");

	set(functionName="textAreaTag", labelClass="control-label", prependToLabel='<div class="control-group">', appendToLabel='<div class="controls">', append="</div></div>", labelPlacement="before");
	
	set(functionName="textAreaTag", labelClass="control-label", prependToLabel='<div class="control-group">', appendToLabel='<div class="controls">', append="</div></div>", labelPlacement="before");
	
	set(functionName="startFormTag", class="form-horizontal");

</cfscript>