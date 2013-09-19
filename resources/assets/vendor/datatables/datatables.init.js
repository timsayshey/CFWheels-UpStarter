/*$(document).ready( function () {
	$('#datatable').dataTable( {
		"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
		"oTableTools": {
			"sSwfPath": "/assets/vendor/datatables/copy_csv_xls_pdf.swf",
			"aButtons": [
				"copy",
				"print",
				{
					"sExtends":    "collection",
					"sButtonText": 'Save <span class="caret" />',
					"aButtons":    [ "csv", "xls", "pdf" ]
				}
			]
		}
	} );
} ); */

$(function() {
	
	var responsiveHelper;
	var breakpointDefinition = {
		tablet: 1024,
		phone : 480
	};
	
	var tableContainer = $('#datatable');
	
	tableContainer.dataTable({
	
		// Setup for Bootstrap support.
		sDom           : '<"row"<"span6"l><"span6"f>r>t<"row"<"span6"i><"span6"p>>',
		sPaginationType: 'bootstrap',
		oLanguage      : {
			sLengthMenu: '_MENU_ records per page'
    },

		// Setup for responsive datatables helper.
		bAutoWidth     : false,
		fnPreDrawCallback: function () {
			// Initialize the responsive datatables helper once.
			if (!responsiveHelper) {
				responsiveHelper = new ResponsiveDatatablesHelper(tableContainer, breakpointDefinition);
			}
		},
		fnRowCallback  : function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
			responsiveHelper.createExpandIcon(nRow);
		},
		fnDrawCallback : function (oSettings) {
			responsiveHelper.respond();
		}
	
	});

});
/*
// Set the classes that TableTools uses to something suitable for Bootstrap
$.extend( true, $.fn.DataTable.TableTools.classes, {
	"container": "btn-group",
	"buttons": {
		"normal": "btn",
		"disabled": "btn disabled"
	},
	"collection": {
		"container": "DTTT_dropdown dropdown-menu",
		"buttons": {
			"normal": "",
			"disabled": "disabled"
		}
	}
} );

// Have the collection use a bootstrap compatible dropdown
$.extend( true, $.fn.DataTable.TableTools.DEFAULTS.oTags, {
	"collection": {
		"container": "ul",
		"button": "li",
		"liner": "a"
	}
} );
*/