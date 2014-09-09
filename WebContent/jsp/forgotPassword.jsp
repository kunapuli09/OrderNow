<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
  <head>
    
  </head>
  <link href="<s:url value='/css/style.css'/>" rel="stylesheet" type="text/css"/>
    
  <body>
    	 
	      <s:div id="loginDiv1" theme="ajax" >
	   </s:div>
	
	 <s:div id="loginDiv"  theme="ajax" executeScripts="true"  >
	 		<table align="center" width="70%" class="yellowborder" cellspacing="0" cellpadding="0" >
							<tr><td height="25px;" background="../images/tabletopbg.gif" style="padding-top:0px;" valign="center"><strong><font color="#ffffff">&nbsp;Forgot Password</font></strong></td></tr>
			
			<tr>
			<td width="100%" >
	 		<s:form id="lform" action="ForgotPasswordAction" validate="true" cssClass="formContent" cssStyle="align:center">
				<table  width="100%" align="center" style="vertical-align: top;" >
							<colgroup>
<col width="20%"/>
<col width="25%"/>
<col width="30%"/>
<col width="25%"/>
		</colgroup>	
							 <tr>
	 	     				 <td colspan="2">
	     	    				<s:actionerror />
	         					<s:fielderror />
	       					</td>
	       					</tr> 												
							
							  <tr colspan="4">
<!-- <td/> -->
<td class="form_label_td" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Email:</td>
<td><table> <s:textfield name="userName" value="" size="20" cssStyle="font-size: 10px; height: 1.75em;"></s:textfield> </table></td>
<td id="id_lform_userName" ></td>

</tr>

<tr colspan="4">
<td></td>
<td></td>
<td><table><s:submit value="Get Password " theme="ajax"  targets="loginDiv1"  notifyTopics=""  executeScripts="true" cssClass="buttoncss"/></table></td>
<td></td>
</tr>
		
				</table>			
			</s:form>
			</td></tr>
			</table>
	</s:div>
		
	
</body>
<script>

var arr = new Array(20);
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
        
        document.getElementById("id_" + e.id).innerHTML = "<font  color=red  style='font-family: sans-serif;font-size: 11px'> " + errorText + "</font>";
        
        arr[count++] = td_td;
        td_td.width=20;
        td_td.align="Justify";
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