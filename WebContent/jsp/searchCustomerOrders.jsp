<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<script>
	var arr = new Array(20);
	var count = 0;

	function clearErrorMessages(form) {

		for (i = 0; i < count; ++i) {
			arr[i].innerHTML = "";
		}
	}

	function clearErrorLabels(form) {
		// set all labels back to the normal class
		var elements = form.elements;
		for ( var i = 0; i < elements.length; i++) {
			var e = elements[i];
			var cells = e.parentNode.parentNode.cells;
			if (cells && cells.length >= 2) {
				var label = cells[0].getElementsByTagName("label")[0];
				if (label) {
					label.setAttribute("class", "label");
					label.setAttribute("className", "label"); //ie hack cause ie does not support setAttribute
				}
			}
		}

	}

	function addError(e, errorText) {
		try {

			// clear out any rows with an "errorFor" of e.id
			var row = e.parentNode.parentNode;

			var td_td = document.getElementById("id_" + e.id);

			document.getElementById("id_" + e.id).innerHTML = "<font color=red>"
					+ errorText + "</font>";

			arr[count++] = td_td;
			td_td.width = 20;
			td_td.align = "Justify";
			var td = document.createElement("td");
		} catch (e) {
			//alert(e);
		}
	}
</script>

<link href="<s:url value='/css//style.css'/>" rel="stylesheet" type="text/css"/>
<script src="<s:url value='/Scripts/order.js'/>" type="text/javascript"></script>
<script src="<s:url value='/struts/validation.js'/>"
	type="text/javascript"></script>

<link href="<s:url value='/css/displaytag.css'/>" media="screen"
	rel="Stylesheet" type="text/css" />
</head>
<body>
<s:div id="searchCustomerOrdersDiv1" theme="ajax">
</s:div>
<s:div id="searchCustomerOrdersDiv" theme="ajax" executeScripts="true">
	<table align="center" width="60%" class="yellowborder">
							<tr><td height="25px;" background="../images/tabletopbg.gif" style="padding-top:0px;" valign="center"><strong><font color="#ffffff">&nbsp;Search your Order</font></strong></td></tr>
			
			<tr>
			<td width="100%">
	<s:form id="searchCustomerOrders" action="searchCustomerOrders" validate="true" >
		<table align="center">
			<tr>
				<td colspan="4" class="rs" ></td>
			</tr>

			<tr >
				<td></td>
				<td class="form_label_td" >By Last Name:</td>
				<td class="form_label_td">
				<table align="center">
					<s:textfield name="lastName" value="" size="20"
						cssStyle="font-size: 10px; height: 1.75em;"></s:textfield>
				</table>
				</td>
			</tr>
			<tr><td id="id_searchCustomerOrders_lastName" class="form_label_td_error" ></td></tr>
			<tr >
				<td></td>
				<td class="form_label_td" >By Phone Number:</td>
				<td class="form_label_td">
				<table align="center">
					<s:textfield cssStyle="font-size: 10px; height: 1.75em;"
						name="phoneNumber" maxlength="12" value="" size="20"></s:textfield>
				</table>
				</td>
			</tr>
			<tr><td id="id_searchCustomerOrders_phoneNumber" class="form_label_td_error" align="right" colspan="4"></td></tr>
			<tr>
				<td></td>
				<td>&nbsp;&nbsp&nbsp&nbsp</td>
				<td align="right"><table><s:submit id="searchBtn" value="Search" theme="ajax"
					targets="searchCustomerOrdersDiv1" notifyTopics=""
					executeScripts="true" cssClass="buttoncss" /></table></td>
				<td></td>
			</tr>
		</table>
	</s:form>
	</td></tr>
			</table>
</s:div>
<script>
	document.all["username"].focus();
	var arr = new Array(20)
var count = 0;

function clearErrorMessages(form) {
	
	for(i=0; i < count;++i){
		arr[i].innerHTML = "";
	}
}

function clearErrorLabels(form) {
    // set all labels back to the normal class
    var elements = form.elements;
    for (var i = 0; i < elements.length; i++) {
        var e = elements[i];
        var cells = e.parentNode.parentNode.cells;
        if (cells && cells.length >= 2) {
            var label = cells[0].getElementsByTagName("label")[0];
            if (label) {
                label.setAttribute("class", "label");
                label.setAttribute("className", "label"); //ie hack cause ie does not support setAttribute
            }
        }
    }

}

function addError(e, errorText) {
    try {

        // clear out any rows with an "errorFor" of e.id
        var row = e.parentNode.parentNode;

        var td_td = document.getElementById("id_" + e.id);
		
        
        document.getElementById("id_" + e.id).innerHTML = "<font color=red>" + errorText + "</font>";
        
        arr[count++] = td_td;

        //var table = row.parentNode;
        //var error = document.createTextNode(errorText);
        //var tr = document.createElement("tr");
        var td = document.createElement("td");
        
        //var span = document.createElement("span");
        //td.align = "left";
        //td.valign = "top";
        //td.colSpan = 2;
        //span.setAttribute("class", "errorMessage");
        //span.setAttribute("className", "errorMessage"); //ie hack cause ie does not support setAttribute
        //span.appendChild(error);
        
        //td.appendChild();

        //tr.appendChild(td);
        //tr.setAttribute("errorFor", e.id);
        //table.insertBefore(tr, row);
		//td.innerText = errorText;
        //row.appendChild(td);
        
        //document.all["FirstName"].innerHTML="<font color='red'>FN</font>";
        // updat the label too
        //var label = row.cells[0].getElementsByTagName("label")[0];
        //label.setAttribute("class", "tdLabel");
        //label.setAttribute("className", "tdLabel"); //ie hack cause ie does not support setAttribute
    } catch (e) {
        //alert(e);
    }
}
	
</script>

</body>
</html>