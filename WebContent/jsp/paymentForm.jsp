<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="com.temesoft.security.Base64Coder"%>
<%@ page import="com.temesoft.security.Encrypter"%>
<%@ page import="com.temesoft.security.Config"%>
<%@ page import="java.awt.*"%>
<%@page import="com.starpath.order.domain.Customer"%>
<%@page import="com.starpath.order.domain.*"%>
<%@page import="java.util.Set"%>
<%@page import="java.text.DecimalFormat"%>
<html>
<head>

<link href="<s:url value='/css/style.css'/>" rel="stylesheet"
	type="text/css" />
<link href="../css/flexcrollstyles.css" rel="Stylesheet" type="text/css">
<link href="../css/tutorsty.css" rel="Stylesheet" type="text/css">

<script src="../Scripts/flexcroll.js" type="text/javascript"></script>
</head>

<body>

<table width="100%" cellspacing="0" cellpadding="0" class="yellowborder">
	<tr colspan="4">
		<td align="center"
			style="font: 11px Verdana, Arial, Helvetica, sans-serif;"
			background="../images/tabletopbg.gif" height="25px" colspan="3"><strong><font
			color="#ffffff">Your Order Summary</font></strong></td>
	</tr>


	<%Order order = (Order)session.getAttribute("order"); %>
	<%Customer customer = order.getBuyer(); %>
	<%Customer seller = order.getSeller(); %>
	<%if(customer==null)
							throw new NullPointerException("Customer can't be null");
							%>
	<%
					  			  CServices cServices = (CServices)session.getAttribute("cServices");
							%>
	<tr>
		<td width="84%" align="center" class="tdborder">
		<FORM NAME="paymentForm"
			ACTION="https://www.securepay.com/secure15/index.cfm" METHOD="Post">
		<INPUT TYPE="hidden" NAME="Name" VALUE="<%=customer.getFullName()%>"><BR>
		<input type="hidden" NAME="Street"
			value="<%=customer.getAddress().getAddress() %>"> <INPUT
			TYPE="hidden" NAME="City"
			VALUE="<%=customer.getAddress().getCity() %>"> <INPUT
			TYPE="hidden" NAME="State"
			VALUE="<%=customer.getAddress().getState() %>"> <input
			type="hidden" name="Zip"
			value="<%=customer.getAddress().getZipCode() %>"> <input
			type="hidden" name="Email" value="<%=customer.getEmail() %>">
		<INPUT TYPE="hidden" NAME="Amount"
			VALUE="<%=String.valueOf(order.calculateTotal().floatValue()) %>">

		<INPUT TYPE="hidden" NAME="Cust_Email" VALUE=""> <INPUT
			TYPE="hidden" NAME="Send_Mail" VALUE=""> <INPUT TYPE="hidden"
			NAME="Merch_ID" VALUE="57872"> <INPUT TYPE="hidden"
			NAME="AVSREQ" VALUE=""> <INPUT TYPE="hidden"
			NAME="VoidRecNum" VALUE=""> <INPUT TYPE="hidden"
			NAME="Tr_Type" VALUE="SALE"> <INPUT type="hidden"
			name="Success_URL"
			value="https://starpathit.com/OrderNow/jsp/creditSuccess.jsp?orderid=<%=order.getId().longValue() %>">
		<INPUT type="hidden" name="Failure_URL"
			value="https://starpathit.com/OrderNow/jsp/creditFailure.jsp?orderid=<%=order.getId().longValue() %>">
		<INPUT TYPE="hidden" NAME="Post_CallBack"
			VALUE="https://spaytest/secure15/postcallback.cfm"> <INPUT
			TYPE="hidden" NAME="F_Method" VALUE="POST">
		<input type="hidden" name="CC_Number"
				Value="<%=session.getAttribute("CC_Number1") %>">
		<input type="hidden" name="Month"
				Value="<%=session.getAttribute("Month1") %>">
		<input type="hidden" name="Year"
					Value="<%=session.getAttribute("Year1") %>">
		<table width="100%" >
			<%if(session.getAttribute("CC_Number1")!=null){ %>
			<tr>
				<td class="form_label_td" width="50%" colspan="2" ><strong>Order Confirmation</strong></td>
			</tr>
			<tr>
				<td class="form_label_td" width="50%" colspan="2">Here is your order.You will receive a
				phone call from Sai Groceries at <%=customer.getPhoneNumber()%> to
				Confirm the Order before the Order is fulfilled. Please Click on
				Confirm Order button to Authorize Sai Grocery to validate your Credit Card information and process the Order. Please PICKUP your Order during store hours.</td>
			</tr>
			<tr>
				<td class="form_label_td" width="50%"><strong>Card Type:</strong>&nbsp;&nbsp;<%=session.getAttribute("cType").toString() %></td>
				<td class="form_label_td" width="50%"><strong>Exp. Date:</strong>
				&nbsp;&nbsp;<%=session.getAttribute("Month1").toString() %>/<%=session.getAttribute("Year1").toString() %></td>
			</tr>
			<tr>
				<td class="form_label_td" width="50%">
				<%String cardNumber = session.getAttribute("CC_Number1").toString(); String cardDisplay = cardNumber.substring(cardNumber.length() - 4); %>
				<strong>Card Number:</strong>&nbsp;&nbsp;************<%=cardDisplay %></td>
				<td class="form_label_td" width="50%"><strong>Cardholder Name:</strong>&nbsp;&nbsp;<%=customer.getFullName() %></td>
			</tr>

			<%}%>

			<tr>
				<td class="form_label_td" width="50%"><strong>Order PICKUP Time is
				<%=order.getOrderDate() %>-<%=order.getOrderTime() %></strong>. Please make sure your Order PICKUP time is during store hours</td>
				<td class="form_label_td" width="50%"><strong>Special Note: </strong><%=order.getOrderNote() %>
				</td>
			</tr>

			
		</table>
		<table width="100%">
			<tr>
				<td width="50%">
				<table>
					<tr>
						<td class="form_label_td" align="top"><strong>Billing
						Address :</strong></td>
					</tr>
					<tr>
						<td class="form_label_td"><%=customer.getAddress().getAddress()%>,</td>
					</tr>
					<tr>
						<td class="form_label_td"><%=customer.getAddress().getCity()%>,&nbsp;<%=customer.getAddress().getState()%>&nbsp;<%=customer.getAddress().getZipCode()%>.</td>
					</tr>
				</table>
				</td>
				<td width="50%">
				<table>
					<tr>
						<td class="form_label_td" align="top"><strong>Store
						Address :</strong></td>
					</tr>
					<tr>
						<td class="form_label_td"><%=seller.getAddress().getAddress()%>,</td>
					</tr>
					<tr>
						<td class="form_label_td"><%=seller.getAddress().getCity() %>,&nbsp;<%=seller.getAddress().getState() %>,
						<%=seller.getAddress().getZipCode() %>.</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		

		<table align="center">
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td><INPUT TYPE="SUBMIT" NAME="TEST" VALUE="Confirm Order"
					class="buttoncss" onClick="javascript:progress_update()"> &nbsp;</td>
				<td><INPUT TYPE="button" NAME="TEST2"
					onclick='javascript:parent.parent.replaceBodyContent("doRegisterForOrder.action")'
					VALUE="Modify" class="buttoncss"></td>
				<td><INPUT TYPE="button" NAME="TEST1"
					onclick='javascript:parent.parent.replaceBodyContent("home.jsp")'
					VALUE="Cancel" class="buttoncss">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
		</table>

		</FORM>
		</td>
	</tr>

</table>

<table align="center"><tr><td>
<div id="showbar" style="font-size:11px;padding:1px;visibility:hidden">
Please wait while your credit card is being processed 
<span style="font-size:6pt;" id="progress1">&nbsp; &nbsp;</span>
<span style="font-size:6pt;" id="progress2">&nbsp; &nbsp;</span>
<span style="font-size:6pt;" id="progress3">&nbsp; &nbsp;</span>
<span style="font-size:6pt;" id="progress4">&nbsp; &nbsp;</span>
<span style="font-size:6pt;" id="progress5">&nbsp; &nbsp;</span>
<span style="font-size:6pt;" id="progress6">&nbsp; &nbsp;</span>
<span style="font-size:6pt;" id="progress7">&nbsp; &nbsp;</span>
<span style="font-size:6pt;" id="progress8">&nbsp; &nbsp;</span>
<span style="font-size:6pt;" id="progress9">&nbsp; &nbsp;</span>
</div>
</td></tr></table>

</body>
<script>
	document.getElementById("updateservices").innerHTML = "";
	document.getElementById("updateservices").style.display = "none";
	
</script>
<script src="<s:url value='/Scripts/order.js'/>" type="text/javascript"></script>
<script src="<s:url value='/struts/validation.js'/>"
	type="text/javascript"></script>
<script src="<s:url value='/Scripts/menucontainer.js'/>"
	type="text/javascript"></script>

<script language="javascript">
var progressEnd = 9; // set to number of progress <span>'s.
var progressColor = '#8B1A1A'; // set to progress bar color
var progressInterval = 1000; // set to time between updates (milli-seconds)

var progressAt = progressEnd;
var progressTimer;
function progress_clear() {
for (var i = 1; i <= progressEnd; i++) document.getElementById('progress'+i).style.backgroundColor = 'transparent';
progressAt = 0;
}
function progress_update() {
document.getElementById('showbar').style.visibility = 'visible';
progressAt++;
if (progressAt > progressEnd) progress_clear();
else document.getElementById('progress'+progressAt).style.backgroundColor = progressColor;
progressTimer = setTimeout('progress_update()',progressInterval);
}
function progress_stop() {
clearTimeout(progressTimer);
progress_clear();
document.getElementById('showbar').style.visibility = 'hidden';
}
//progress_update(); // start progress bar

</script>
</html>