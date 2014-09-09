<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>

</head>
<link href="<s:url value='/css//style.css'/>" rel="stylesheet" type="text/css"/>
<link href="<s:url value='/css/phokus/orderCancel.css'/>" rel="stylesheet" type="text/css"/>
<body>

<table width="100%">
	<tr valign="top" align="left">
		<td colspan="2" width="100%" class="form_label_td"><b>Log In</b></td>
	</tr>
</table>
<s:div id="loginDiv" theme="ajax" executeScripts="true">

	<s:form id="lform" action="loginAction" validate="true"
		onsubmit="javascript:document.getElementById('loginDiv1').innerHTML='';">


		<table align="left">
			<tr>
				<td class="form_label_td">Email<font color="red">*</font></td>
				<td ><table align="center"><s:textfield name="username"  label="" value=""
					size="10" ></s:textfield></table></td>
				
			</tr>
			<tr><td colspan="2" id="id_lform_username" class="form_label_td_error"></td></tr>
			<tr>
				<td class="form_label_td">Password<font color="red">*</font></td>
				<td class="form_label_td"><table align="center"><s:password name="password" label=""  value=""
					size="10" ></s:password></table></td>
				
			</tr>
			<tr><td colspan="2" id="id_lform_password" class="form_label_td_error"></td></tr>
			<tr>
				<td></td>
				<td align=center>
				<table >
					<s:submit value="Login" theme="ajax" targets="loginDiv1"
						notifyTopics="" executeScripts="true" cssClass="buttoncss"  />
				</table>
				</td>

			</tr>

		<TR>
			<td  ></td>
			<TD align=left  class="form_label_td">&nbsp;<s:a
				href='javascript:parent.replaceBodyContent("registerTemplate.jsp");'>Register</s:a>&nbsp;&nbsp;&nbsp;<s:a
				href='javascript:parent.replaceBodyContent("forgotPasswordTemplate.jsp");'>Forgot Password</s:a>&nbsp;
			</TD>
		</TR>
		</table>

	</s:form>
</s:div>

<s:div id="loginDiv1" theme="ajax">
</s:div>


	


</body>
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

</html>