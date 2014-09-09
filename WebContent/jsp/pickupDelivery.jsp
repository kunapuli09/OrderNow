<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="java.util.*"%>
<%@page import="com.starpath.order.domain.Customer"%>
<%@page import="com.starpath.order.domain.CServices"%>
<%@page import="java.util.*"%>
<%@ page import="com.starpath.order.domain.Order"%>
<html>
<head>
<script type="text/javascript"> 

  function successSubmit(){
		return true;
  }

  function validateForm() {
        form = document.getElementById("updateservices");
        clearErrorMessages(form);
        clearErrorLabels(form);

        
    }
</script>
</head>
<%CServices cServices = (CServices)session.getAttribute("cServices");%>

<body>


		<table align="center" width="100%" cellspacing="0" cellpadding="0" class="yellowborder">
			<tr>
				<td align="center" width="100%" >
					<div id='mycustomscroll2' class='flexcroll'>
					<table  width="100%" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<div id="leftmenu">User PickUp/Delivery Information</div>
								</td>
						   </tr>
					</table>
					<table  width="100%" height="60%"  cellpadding="0" cellspacing="0" >
							<colgroup>
								<col width="20%"  />
								<col width="20%" />
								<col width="30%" />
								<col width="30%" />
							</colgroup>
							<tr>
								<td></td>
								<td class="form_label_td"></td>
								<td>
									<table>
										<tr><td>
										</td></tr>
									</table>
								</td>
				</td>
				</tr>
							<tr colspan="4" >
								<td></td>
								<td class="form_label_td">Services:</td>
								<td colspan="2">
								<table>
									<tr><td class="form_label_td">
			
													<%if(cServices != null && cServices.getDelivery()){%>
													<s:radio name="service"
														list="#{'PICKUP' : 'Pickup','Delivery': 'Delivery'}"></s:radio>
													<%}else{%>
													<s:hidden name="service" value="PICKUP" />
													We are not providing Delivery Service.
													<br />
													Please PICKUP your Order at our Restaurant.
												<%}%>
									</td></tr>
								</table>
								</td>
								<td></td>
							</tr>
						<tr colspan="4">
							<td></td>
							<td class="form_label_td">Choose Day:</td>
							<td>
							<table>
							<tr><td><s:select name="orderDate" size="1"
									cssStyle="font-size: 10px; height: 1.75em;"
									list="#{'Saturday' : 'Saturday','Sunday': 'Sunday','Monday': 'Monday','Tuesday':'Tuesday','Wednesday':'Wednesday','Thursday':'Thursday','Friday':'Friday'}"></s:select>
							</td></tr>
							</table>
							</td>
							</td>
						</tr>
						<tr colspan="4">
							<td></td>
							<td></td>
							<td  style="font-size: 11px; height: 1.75em;"  colspan="2"><b>Delivery service starts at 5pm.</b></td>
						</tr>
						<tr colspan="4">
							<td></td>
							<td class="form_label_td">Choose Hour:</td>
							<td>
							<table><tr><td>
								<s:select name="orderTime" size="1"
									cssStyle="font-size: 10px; height: 1.75em;"
									list="#{'11:30 AM' : '11:30 AM','12:00 AM': '12:00 AM','12:30 PM': '12:30 PM','01:00 PM':'01:00 PM','01:30 PM':'01:30 PM','02:00 PM':'02:00 PM','02:30 PM':'02:30 PM','03:00 PM':'03:00 PM','03:30 PM':'03:30 PM','04:00 PM':'04:00 PM','04:30 PM':'04:30 PM','05:00 PM':'05:00 PM','05:30 PM':'05:30 PM','06:00 PM':'06:00 PM','06:30 PM':'06:30 PM','07:00 PM':'07:00 PM','07:30 PM':'07:30 PM','08:00 PM':'08:00 PM','08:30 PM':'08:30 PM','09:00 PM':'09:00 PM','09:30 PM':'09:30 PM','10:00 PM':'10:00 PM'}"></s:select>
								</td></tr>
							</table>
							</td>
							<td/>
						</tr>
						<tr colspan="4">
							<td></td>
							<td class="form_label_td">Special Note For Order:</td>
							<td>
							<table><tr><td>
								<s:textarea name="orderNote" cols="15" rows="2"
									cssStyle="font-size: 11px;">
								</s:textarea>
								</td></tr>
							</table>
							</td>
							<td />
						</tr>
						
					</table>
					</div>
				</td>
			</tr>
		</table>
</body>
<script>
 document.getElementById("service").checked=true;
</script>

<script>
<%

	Calendar calendar = Calendar.getInstance();
	out.println("document.forms[0].orderDate.options.length = 0;");
	out.println("document.forms[0].orderDate.options.length = 7;");
	
	for(int i=0;i<7;i++){
		
		int day = calendar.get(Calendar.DAY_OF_WEEK);
		String str = "";
		
		System.out.println(day);
		if(day == 7)
			str = "Saturday";
		else if(day == 1)
			str = "Sunday";
		else if(day == 2)
			str = "Monday";
		else if(day == 3)
			str = "Tuesday";
		else if(day == 4)
			str = "Wednesday";
		else if(day == 5)
			str = "Thursday";
		else if(day == 6)
			str = "Friday";
		
		String date = str + "-" + (calendar.get(Calendar.MONTH)+1)  + "/" + calendar.get(Calendar.DAY_OF_MONTH);
		
		out.println("document.forms[0].orderDate.options[" + i + "].text = \"" + date + "\"");
		out.println("document.forms[0].orderDate.options[" + i + "].value = \"" + date + "\"");
		
		calendar.add(Calendar.DAY_OF_MONTH, 1); 
	}

	 Order order = (Order)session.getAttribute("order"); 
	if(order.getOrderDate()!=null){ 
		
			out.println("var i=0;for(i=0;i<7;i++){if(document.forms[0].orderDate.options[i].text==\"" + order.getOrderDate() + "\"){document.forms[0].orderDate.selectedIndex=i;}}");
			out.println("var i=0;for(i=0;i<22;i++){if(document.forms[0].orderTime.options[i].text==\"" + order.getOrderTime() + "\"){document.forms[0].orderTime.selectedIndex=i;}}");
			out.println("document.forms[0].orderNote.value= \"" + order.getOrderNote() + "\"");
	}
	%>


</script>
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

        document.getElementById("id_" + e.id).innerHTML = "<font color=red>" + errorText + "</font>";
        
        arr[count++] = td_td;
        
        var td = document.createElement("td");
        
        
    } catch (e) {
        //alert(e);
    }
}

</script>
</html>
