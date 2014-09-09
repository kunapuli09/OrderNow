<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="com.temesoft.security.Base64Coder"%>
<%@ page import="com.temesoft.security.Encrypter"%>
<%@ page import="com.temesoft.security.Config"%>
<%@ page import="java.awt.*"%>
<%@page import="com.starpath.order.domain.Customer"%>
<%@page import="com.starpath.order.domain.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>
<html>
<head>

   <link href="<s:url value='/css/style.css'/>" rel="stylesheet" type="text/css"/> 
	<link href="../css/flexcrollstyles.css"	rel="Stylesheet" type="text/css">
	<link href="../css/tutorsty.css"	rel="Stylesheet" type="text/css">

	<script src="../Scripts/flexcroll.js" type="text/javascript"></script>
<script src="<s:url value="/Scripts/order.js"/>" type="text/javascript"></script>
<script src="<s:url value="/struts/xhtml/validation.js"/>"
	type="text/javascript"></script>
<script src="<s:url value="/Scripts/menucontainer.js"/>"
	type="text/javascript"></script>

</head>
<script>
	
</script>

<body>
<%Order order = (Order)session.getAttribute("order"); 
Customer customer = order.getBuyer(); 
	Set privilageset = null;	
	UserPrivilege privilage = null;	
	Iterator privilageIterator = null;
	String privilageStr = "";	
	CServices cServices = null;
	java.util.List<String> roles = new ArrayList<String>(3);
	if(customer!=null){		
		privilageset = customer.getRoles();		
		privilageIterator =  privilageset.iterator();	
		while(privilageIterator.hasNext()){
			UserPrivilege privilege = (UserPrivilege)privilageIterator.next();
			roles.add(privilege.getPrivilege());
		}
		cServices = (CServices)session.getAttribute("cServices");
	}
	/*if(session.getAttribute("emailToken")!=null)
	     emailToken=(String)session.getAttribute("emailToken");*/
	
%>
<div id='mycustomscroll6' class='flexcroll' width="80%" align="center" >
<table height="25px;" width="60%" class="yellowborder"
	align="center">
	<tr>
		<td width="100%"></td>
	</tr>
	<tr>
		<td height="25px;" width="100%" background="../images/tabletopbg.gif"
			style="padding-top: 10px;" valign="bottom" ><strong><font color="#ffffff">
		Customer Order Summary</font></strong></td>
	</tr>
	<tr>
		<td class="form_label_td"><strong>Order <%=order.getShipment().getShipmentType() %>
		Time was <%=order.getOrderDate() %>-<%=order.getOrderTime() %></strong></td>
	</tr>

	<tr>
		<td class="form_label_td"><strong>Special Note: </strong><%=order.getOrderNote() %></td>
	</tr>

	<tr>
		<td colspan="2" class="form_label_td">&nbsp;</td>
	</tr>
</table>
<table>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<table width="60%">
	<tr>
		<td width="50%">
		<table>
			<tr>
				<td align="top" class="form_label_td"><strong>Billing Address:</strong></td>
			</tr>
			<tr>
				<td class="form_label_td"><%=customer.getFirstName().substring(0,1).toUpperCase()+customer.getFirstName().substring(1).toLowerCase()+" "+
			customer.getLastName().substring(0,1).toUpperCase()+customer.getLastName().substring(1).toLowerCase()%></td>
				
			</tr>
			<tr>
				<td class="form_label_td"><%=customer.getAddress().getAddress()%>,</td>
			</tr>
			<tr>

				<td class="form_label_td"><%=customer.getAddress().getCity()%>,&nbsp;<%=customer.getAddress().getState()%>&nbsp;<%=customer.getAddress().getZipCode()%>.</td>
				<!-- <td/> -->
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
		</table>
		</td>
		<td width="50%">
		<table>
			<tr>
				<td align="top" class="form_label_td"><strong>Restaurant Address :</strong></td>
			</tr>
			<tr>
				<td class="form_label_td">Cafe Tandoor</td>
			</tr>
			<tr>
				<td class="form_label_td">420 Market Place,</td>
			</tr>
			<tr>

				<td class="form_label_td">San Ramon,&nbsp;CA 98453.</td>
			</tr>
			<tr>

				<td class="form_label_td">Phone&nbsp;925-244-1599</td>
			</tr>
		</table>

		</td>
	</tr>
</table>
<table border="1" width="60%">
	<tr bgcolor="#59090A">
		<td class="form_label_td"><strong><font color="#ffffff"> Item Name</font> </strong></td>
		<td class="form_label_td"><strong><font color="#ffffff">Quantity </font></strong></td>
		<td class="form_label_td"><strong> <font color="#ffffff">Unit Price($) </font></strong></td>
		<td class="form_label_td"><strong> <font color="#ffffff">Amount ($) </font></strong></td>
	</tr>
	<%
	float total=0; 

	Set<OrderItem> orderedItems = null;

if(request.getSession().getAttribute("order")!=null){
	 
	orderedItems=order.getOrderedItems();
	float itemsPrice;
	Long itemId;
	for(OrderItem oItem : orderedItems){
		if(oItem.getItem().getItemPrice().getValue()!=null){
		    itemsPrice=(oItem.getItem().getItemPrice().getValue().floatValue())*oItem.getOrderedQuantity();
		    itemsPrice = (float)((int)((itemsPrice+0.005)*100.0)/100.0);
		    itemId = oItem.getItem().getId();
		    total+=itemsPrice;
		    total=(float)((int)((total+0.005)*100.0)/100.0); 
		    System.out.println(oItem.getItem().getDescription());
	    }
	    else{
		    itemsPrice =0;
		    itemId = oItem.getItem().getId();
	    }%>

	<tr>
		<td class="form_label_td"><%=oItem.getItem().getName()%></td>
		<td align="center" class="form_label_td"><%=oItem.getOrderedQuantity() %></td>
		<td align="center" class="form_label_td"><%=oItem.getItem().getItemPrice().getValue().floatValue()%>
		</td>
		<td align="center" class="form_label_td"><%=itemsPrice %></td>
	</tr>
	<%}%>
	<%}%>

</table>
<table width="60%">
	<tr>
		<td colspan="3" align="right" class="form_label_td"><strong>Sub Total ($):</strong></td>
		<td align="center" class="form_label_td">&nbsp;<%
				DecimalFormat df = new DecimalFormat("0.00");
				String a = df.format(order
					.calculateTotal()-order.getTax());	 
				%><%=String.valueOf(Float.parseFloat(a)) %>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="3" align="right" class="form_label_td">&nbsp;<strong>Total Tax
		($):</strong></td>
		<td align="center" class="form_label_td">&nbsp;<%String a1 = df.format(order.getTax());	 
				%><%=String.valueOf(Float.parseFloat(a1)) %>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="3" align="right" class="form_label_td"><strong>Grand Total ($):</strong></td>
		<td align="center" class="form_label_td">&nbsp;<%String a2 = df.format(order.calculateTotal());	 
				%><%=String.valueOf(Float.parseFloat(a2)) %>&nbsp;</td>
	</tr>
</table>
<table align="center">
	<tr>
		<td colspan="3" class="form_label_td">&nbsp;</td>
	</tr>
   <%if(roles.contains(UserPrivilegeType.ROLE_ADMIN.name()) || roles.contains(UserPrivilegeType.ROLE_STORE_OWNER.name())){
	%>
	<tr>
		<td class="form_label_td"><a
			href="cancelOrder.action?orderId=<%=order.getId().longValue() %>">Cancel
		This Order</a></td>
		<td class="form_label_td">
		  <a href="searchCustomerOrders.action?phoneNumber=<%=order.getBuyer().getPhoneNumber() %>&lastName=<%=order.getBuyer().getLastName() %>">Back To Search Results</a>
		</td>
		<!--<td><a
			href="printOrder.action?orderId=<%=order.getId().longValue() %>">Print
		This Order</a></td>
	--></tr>
	<%} else{%>	
	<tr>
		<td class="form_label_td">
		  <a href="searchCustomerOrders.action?phoneNumber=<%=order.getBuyer().getPhoneNumber() %>&lastName=<%=order.getBuyer().getLastName() %>">Back To Search Results</a>
		</td>
		</tr>
	<%} %>
</table>
</div>
</body>
<script>
	document.getElementById("uploaddivForm").innerHTML = "";
	document.getElementById("headingdiv").innerHTML = "";
	document.getElementById("uploaddivForm").style.display = "none";
</script>

</html>