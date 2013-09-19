<!doctype html>
<html lang="en-US">
<cfoutput>	
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	
		#styleSheetLinkTag(
			sources='
				vendor/bootstrap/css/bootstrap.min.css,
				vendor/bootstrap/css/bootstrap-responsive.min.css,				
				css/style.css,
				css/admin.css
		')#
		#javaScriptIncludeTag(
			sources="
				vendor/jquery.min.js,
				vendor/bootstrap/js/bootstrap.min.js
		")# 
		
		<title>#includeContent("pageTitle")# | Web Panel</title>
		
		<!--[if lt IE 9]>
			<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
		
	</head>
	<body>
	
	<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          #linkTo(text="Web Panel", class="brand", controller="main", action="home")#
          <div class="nav-collapse collapse">
            <ul class="nav">
			
              <li class="dropdown">
                <a href="##" class="dropdown-toggle" data-toggle="dropdown">Manage <b class="caret"></b></a>
                <ul class="dropdown-menu">
				
					<li>#linkTo(text="Items", controller="items", action="items")#</li>
					<li>#linkTo(text="Videos", controller="videos", action="videos")#</li>
						
					<li class="divider"></li>
					
                </ul>
              </li>
			  
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>
	
	<cfif NOT flashIsEmpty()>
		<div class="container">
			<cfif flashKeyExists("error")>
				<div class="alert alert-error"> 
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<strong>#flash("error")#</strong>
				</div>
			</cfif>
			
			<cfif flashKeyExists("success")>
				<div class="alert alert-success">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<strong>#flash("success")#</strong>
				</div>
			</cfif>
		</div>
	</cfif>
	
	<div class="container" id="contentwrap">
		<div class="page-header">
			<h1>#includeContent("pageTitle")#</h1>
		</div>
		#includeContent()#
	</div>	
	
	<cfif len(includeContent("requiresDatatableJs"))>
		#styleSheetLinkTag(head=true,
			sources='
				vendor/jquery.dataTables/css/DT_bootstrap,
				vendor/resptable/css/datatables.responsive,
				vendor/resptable/css/style,
				vendor/datatables/dataTables.bootstrap.css
		')# 
		#javaScriptIncludeTag(
			sources="
				vendor/lodash/lodash.min,
				vendor/jquery.dataTables/js/jquery.dataTables.min,
				vendor/jquery.dataTables/js/DT_bootstrap,
				vendor/resptable/js/datatables.responsive,
				vendor/datatables/TableTools,
				vendor/datatables/ZeroClipboard,
				js/datatables.init
		")#		
	</cfif>
	
	</body>
</cfoutput>
</html>