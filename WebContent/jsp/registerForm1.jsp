<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="com.temesoft.security.Base64Coder"%>
<%@ page import="com.temesoft.security.Encrypter"%>
<%@ page import="com.temesoft.security.Config"%>
<%@ page import="com.starpath.order.domain.*" %>
<%@page import="java.util.*"%>
<%@page import="com.starpath.order.domain.CServices"%>
<%@ page import="com.starpath.order.domain.Order"%>

<html>
  <head>
    
    <link href="<s:url value='/css/style.css'/>" rel="stylesheet" type="text/css"/>
  </head>
	<script src="<s:url value="/Scripts/order.js"/>" type="text/javascript"></script>
	<script src="<s:url value="/struts/xhtml/validation.js"/>" type="text/javascript"></script>
	<%CServices cServices = (CServices)session.getAttribute("cServices");%>
	<body >



		<s:div id="regDiv" theme="ajax" executeScripts="true" >
			
			
			<table  width="100%" cellspacing="0" cellpadding="0" class="yellowborder">
	<tr colspan="4">
		<td align="center" style="font:11px Verdana, Arial, Helvetica, sans-serif;" background="../images/tabletopbg.gif" height="25px" colspan="3"><strong><font color="#ffffff">Payment Form</font></strong></td>
	</tr>
				<tr>
					<td width="100%">
						<s:actionerror />
					</td>
				</tr>
				<tr>
					<td width="84%" align="center" class="tdborder">
						<s:form id="rform" action="doRegisterForOrder" validate="true">
						
					<s:hidden	name="serviceid" />
						<s:hidden name="service" value="PICKUP" />
		
<table class="tblbottom">
<colgroup>
<col width="15%"/>
<col width="20%"/>
<col width="25%"/>
<col width="20%"/>
		</colgroup>	
<tr colspan="4" >
								<td></td>
								<td class="form_label_td" colspan="3">
											&nbsp;<b>Schedule and PICKUP during Store Hours.</b>
								</td>
								<td/>
								<td></td>
							</tr>
						<tr colspan="4">
							<td></td>
							<td class="form_label_td">&nbsp;Choose Day & Hour:</td>
							<td>
							<table>
							<tr><td><s:select name="orderDate" size="1" theme="simple"
									cssStyle="font-size: 11px; height: 1.8em;"
									list="#{'Saturday' : 'Saturday','Sunday': 'Sunday','Monday': 'Monday','Tuesday':'Tuesday','Wednesday':'Wednesday','Thursday':'Thursday','Friday':'Friday'}"></s:select>
								</td>
								<td><s:select name="orderTime" size="1" theme="simple"
									cssStyle="font-size: 11px; height: 1.8em;" onselect="setTime(this);"
									list="#{'03:00 PM':'03:00 PM','03:30 PM':'03:30 PM','04:00 PM':'04:00 PM','04:30 PM':'04:30 PM','05:00 PM':'05:00 PM','05:30 PM':'05:30 PM','06:00 PM':'06:00 PM','06:30 PM':'06:30 PM','07:00 PM':'07:00 PM','07:30 PM':'07:30 PM','08:00 PM':'08:00 PM'}"></s:select></td>
								</tr>
							</table>
							</td>
							<td/>						
						</tr>
						
						<tr colspan="4">
							<td></td>
							<td class="form_label_td">&nbsp;Special Notes:</td>
							<td>
							<table><tr><td>
								<s:textarea name="orderNote" cols="18" rows="2" theme="simple"
									cssStyle="font-size: 11px;">
								</s:textarea>
								</td></tr>
							</table>
							</td>
							<% if(request.getSession().getAttribute("order")!=null){
									Order order = (Order)request.getSession().getAttribute("order"); 
									if(order.getBuyer() == null){  %>
							<td  class="form_label_td" colspan="2"><b>Existing User/Forgot Password?</b>
							<s:a href='javascript:parent.replaceBodyContent("loginTemplate.jsp");'><b>Click here</b></s:a></td>
							<%}} %>
						</tr>
						</table>
					
<table width="100%" class="tblbottom">
<colgroup>
<col width="14%"/>
<col width="17%"/>
<col width="22%"/>
<col width="35%"/>
		</colgroup>	
							<tr colspan="4">
								<td></td>
								<td class="form_label_td">
									Phone number:<font color="red">*</font>
								</td>
								<td>
									<table>
										<s:textfield name="phoneNumber" size="20" maxlength="12" 
											onkeypress="return onlyNumbers(event)" cssStyle="font-size: 11px; height: 1.8em;" theme="simple">
										</s:textfield>
									</table>
								</td>

								<td id="id_rform_phoneNumber" class="form_label_td_error">Ex: xxx-xxx-xxxx</td>
							</tr>
							
							<tr colspan="4">
								<td></td>
								<td class="form_label_td">
									Email:<font color="red">*</font>
								</td>
								<td>
									<table>
										<s:textfield name="email" size="20" cssStyle="font-size: 11px; height: 1.8em;" theme="simple">
										</s:textfield>
									</table>
								</td>
								<td id="id_rform_email" align="left" class="form_label_td_error"></td>
							</tr>


							<tr colspan="4">
						       		<td></td>
						       		<td class="form_label_td">Password:<font color="red">*</font></td>
						       		<td>
						       			<table>
							   				<s:password name="password" value="" size="20"  maxlength="10"  cssStyle="font-size: 11px; height: 1.8em;" theme="simple"> </s:password> 
							   			</table>
							   		</td>
							   		<td id="id_rform_password" class="form_label_td_error"></td>
							   </tr>  
							 
						       <tr colspan="4">
						       		<td/>
						       		<td class="form_label_td">Confirm Password:<font color="red">*</font></td>
						       		<td>
						       			<table>
											<s:password name="confirmPassword" value="" size="20" maxlength="10" cssStyle="font-size: 11px; height: 1.8em;" theme="simple"></s:password>
							   			</table>
							   		</td>
							   		<td id="id_rform_confirmPassword" class="form_label_td_error"></td>
							   </tr>  
							 
						       
							</table>
						
							
							<table width="100%">
<colgroup>
<col width="15%"/>
<col width="20%"/>
<col width="25%"/>
<col width="35%"/>
		</colgroup>	
<tr colspan="4">
								<td></td>
								<td class="form_label_td" align="left">
									&nbsp;Cardholder's Name:<font color="red">*</font>
								</td>
								<td>
									<table>
										<s:textfield name="fullName" size="20" cssStyle="font-size: 11px; height: 1.8em;" theme="simple">
										</s:textfield>
									</table>
								</td>
								<td id="id_rform_fullName" align="left" class="form_label_td_error"></td>
							</tr>
							<tr colspan="4">
								<td></td>
								<td class="form_label_td">
									&nbsp;Address:<font color="red">*</font>
								</td>
								<td>
									<table>
										<s:textfield name="address" cssStyle="font-size: 11px; height: 1.8em;" maxlength="100" theme="simple">
										</s:textfield>
									</table>
								</td>
								<td id="id_rform_address" align="left" class="form_label_td_error"></td>
							</tr>

							<tr colspan="4">
								<td></td>
								<td class="form_label_td">
									&nbsp;City:<font color="red">*</font>
								</td>
								<td>
									<table>
										<s:textfield name="city" size="20" cssStyle="font-size: 11px; height: 1.8em;" maxlength="25" theme="simple">
										</s:textfield>
									</table>
								</td>
								<td id="id_rform_city" align="left" class="form_label_td_error"></td>
							</tr>

							<tr colspan="4">
								<td></td>
								<td class="form_label_td">
									&nbsp;State - Zipcode:<font color="red">*</font>
								</td>
								<td>
									<table><tr><td>
										<s:select name="state" size="1" theme="simple"
											list="#{'CO': 'CO'}" cssStyle="font-size: 11px; height: 1.8em;">
										</s:select>  -  </td>
										<td><s:textfield name="zipCode" size="10"  theme="simple"
											maxlength="5" onkeypress="return onlyNumbers(event)" cssStyle="font-size: 11px; height: 1.8em;">
										</s:textfield>
										</td></tr>
									</table>
								</td>
								<td id="id_rform_zipCode" align="left" class="form_label_td_error"></td><td/>						
							</tr>

		
							<tr colspan="4">
					<td></td>
						<td class="form_label_td">&nbsp;Card Type</td>
						<td>
						<table><tr><td>
							<s:select name="cType" cssClass="form_label_td" theme="simple"
								list="#{'Visa' : 'Visa','Master Card': 'Master Card','Discover':'Discover','Amex':'Amex'}"
								onclick="getPaymentDiv()"
								cssStyle="font-size: 11px; height: 2.1em;"></s:select>
							</td></tr>
						</table>
						</td>
						<td><div>
<img  src='http://www.securepay.com/cardlogos/images/credit_card_logos_11.gif' width='150' height='20' border='0' /></div><div style="width:192; text-align:center; font-size:10px; font-family:Verdana, Arial, Helvetica, sans-serif;">
</div>
</td>
						
					</tr>
					<tr colspan="4">
					<td></td>
						
						<td class="form_label_td">&nbsp;Credit Card #:<font color="red">*</font></td>
						<td>
						<table><tr><td>
							<s:textfield name="CC_Number1" value="" onkeypress="return onlyNumbers(event)" maxlength="16" theme="simple"
								cssStyle="font-size: 11px; height: 1.8em;"></s:textfield>
						</td></tr>
						</table>
						</td>
						<td id="id_rform_CC_Number1" align="left" class="form_label_td_error"></td>
					</tr>
					
					<tr colspan="4">
						<td></td>
						<td class="form_label_td">&nbsp;Exp. Date :</td>
						<td>
						<table><tr><td>
							<s:select name="Month1"  size="1" theme="simple"
								cssStyle="font-size: 11px; height: 1.8em;"
								list="#{'01' : '01','02': '02','03': '03','04': '04','05': '05','06': '06','07': '07','08': '08','09': '09','10': '10','11': '11','12': '12'}"></s:select>
							<s:select name="Year1" size="1" theme="simple"
								cssStyle="font-size: 11px; height: 1.8em;"
								list="#{'10': '2010','11':'2011','12':'2012','13':'2013','14':'2014','15':'2015','16':'2016','17':'2017','18':'2018','19':'2019','20':'2020'}"></s:select>
								</td>
								
								</tr>
						</table>
						</td>
						<td/>
					</tr>
							
</table>

							<table>
								<tr colspan="4">
									<td></td>									
									<td>
										<table>
											<s:submit value="Continue" theme="ajax"
												 executeScripts="true"
												cssClass="buttoncss" />
										</table>
									</td>	
									<td>
										<table>
											<s:submit action="CheckoutOrderCancel" value="   Cart   "
												onclick="form.onsubmit=null" cssClass="buttoncss"/>
										</table>
									</td>		
									<td>
										<table>
											<s:submit value="Cancel" 
												 notifyTopics="" 
												cssClass="buttoncss"  action="CancelPage" onclick="form.onsubmit=null"/>
												
										</table>
									</td>
									 <td/> 
								</tr>
							</table>
						</s:form>

					</td>
				</tr>
			</table>
		</s:div>


	</body>
	<script>
<%Order order = (Order)session.getAttribute("order");
if(order.getBuyer()!=null){
	if(null != order.getBuyer().getFullName()){
	  out.println("document.forms[0].fullName.value= \"" + order.getBuyer().getFullName() + "\"");
	}else{
		out.println("document.forms[0].fullName.value= \"" + "" + "\"");
	}
	if(null !=order.getBuyer().getPassword()){
		out.println("document.forms[0].password.value= \"" + order.getBuyer().getPassword() + "\"");
	}
	if(null !=order.getBuyer().getConfirmPassword()){
		out.println("document.forms[0].confirmPassword.value= \"" + order.getBuyer().getConfirmPassword() + "\"");
	}
	out.println("document.forms[0].phoneNumber.value= \"" + order.getBuyer().getPhoneNumber() + "\"");
	out.println("document.forms[0].email.value= \"" + order.getBuyer().getEmail() + "\"");
	out.println("document.forms[0].address.value= \"" + order.getBuyer().getAddress().getAddress() + "\"");
	out.println("document.forms[0].city.value= \"" + order.getBuyer().getAddress().getCity() + "\"");
	out.println("document.forms[0].state.value= \"" + order.getBuyer().getAddress().getState() + "\"");
	out.println("document.forms[0].zipCode.value= \"" + order.getBuyer().getAddress().getZipCode() + "\"");
}%>
<%String ctype = (String)session.getAttribute("cType");
String month1 = (String)session.getAttribute("Month1");
String year1 = (String)session.getAttribute("Year1");
String ccnumber = (String)session.getAttribute("CC_Number1");
if(ctype!=null){
	out.println("document.forms[0].cType.value= \"" + ctype + "\"");
}
if(month1!=null){
	out.println("document.forms[0].Month1.value= \"" + month1 + "\"");
}
if(year1!=null){
	out.println("document.forms[0].Year1.value= \"" + year1 + "\"");
}
if(ccnumber!=null){
	out.println("document.forms[0].CC_Number1.value= \"" + ccnumber + "\"");
}
%>
 

</script>
<script>
	document.forms[0].phoneNumber.focus();
	
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

	 Order order1= (Order)session.getAttribute("order"); 
	if(order1.getOrderDate()!=null){ 
		
			out.println("var i=0;for(i=0;i<7;i++){if(document.forms[0].orderDate.options[i].text==\"" + order1.getOrderDate() + "\"){document.forms[0].orderDate.selectedIndex=i;}}");
			out.println("var i=0;for(i=0;i<22;i++){if(document.forms[0].orderTime.options[i].text==\"" + order1.getOrderTime() + "\"){document.forms[0].orderTime.selectedIndex=i;}}");
			out.println("document.forms[0].orderNote.value= \"" + order1.getOrderNote() + "\"");
	}
	%>


</script>
</html>