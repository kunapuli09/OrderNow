<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.starpath.order.domain.Order" %>
<%@page import="java.util.*" %>
<%@page import="com.starpath.order.domain.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="<s:url value='/css/phokus/showorder.css'/>" media="screen" rel="Stylesheet" type="text/css"/>
<link href="<s:url value='/css/phokus/phokus.css'/>" media="screen" rel="Stylesheet" type="text/css"/>
</head>
<body>

 <%
 String listCount  = request.getParameter("listCount"); 
 Order order = null;
 List<Order> orderList =(List<Order>) session.getAttribute("orderList"); 
 if(orderList!=null&&orderList.size()!=0)
	 order = orderList.get(Integer.parseInt(listCount));
 else
     order = (Order)session.getAttribute("viewOrder");
 if(order!=null){
 %> 
 <table width="50%"><tr><td class="tdborder2" width="100%">
   <tr>
		<td height="25px;" width="100%" background="../images/hashbar.png" style="padding-top:10px;" valign="bottom"><strong>
			&nbsp;Selected order Summary</strong>
		</td>
	</tr>

	<tr><td class="tdborder" width="100%">
		<table>
		<%Customer customer = order.getBuyer(); %>
			<tr><td>&nbsp;</td></tr>
			 <tr><td>
			<strong>Order Time</strong></td><td>:<%=order.getOrderDate() %>-<%=order.getOrderTime() %></td></tr>
		   
		   <tr><td>
			<strong>Service</strong> </td><td>:<%=session.getAttribute("service") %>
			</td></tr>
		   <tr><td>
			<strong>Special Note</strong> </td><td>:<%=order.getOrderNote() %>
			</td></tr>

			<tr><td colspan="2">&nbsp;</td></tr>
			</table>
		    <table><tr><td>&nbsp;</td></tr></table>
	<table><tr><td>
		<table>
			<tr>
				<td align="top"><strong>Store Addrress</strong> </td>
				<td>:&nbsp;Cafe Tandoor,&nbsp;420 Market Place,</td>
			</tr>
			<tr>
				<td align="top">&nbsp;</td>
				<td>:&nbsp;San Ramon,&nbsp;CA 98453.</td>
			</tr>
		</table>
			</td><td width="20">&nbsp;&nbsp;</td><td>
		<table>
			<tr>
				<td align="top"><strong>Billing Address</strong></td>
				<td>:&nbsp;<%=customer.getFullName()%>&nbsp;<%=customer.getAddress().getAddress()%>,</td>
			</tr>
			<tr>
				<td align="top">&nbsp;</td>
				<td>:&nbsp;<%=customer.getAddress().getCity()%>,&nbsp;<%=customer.getAddress().getState()%>,<br>&nbsp;<%=customer.getAddress().getZipCode()%>.</td>
			</tr>
		</table>
	</td></tr></table>
	<table><tr><td>&nbsp;<br>&nbsp;<br>&nbsp;</td></tr></table>

 	<table border=1 width="80%">
		<tr bgcolor="#999999">
			<th>
				Item Name
			</th>
			<th>
				Quantity
			</th>
			<th>
				Unit Price($)
			</th>
			<th>
				Amount ($)
			</th>
		</tr>
<%
	float total=0; 

	Set<OrderItem> orderedItems = null;


	 
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
	    }
	    else{
		    itemsPrice =0;
		    itemId = oItem.getItem().getId();
	    }%>
		
		<tr>
			<td>
				<%=oItem.getItem().getName()%>
			</td>
			<td align="center">
			<%=oItem.getOrderedQuantity() %>
			</td>
			<td align="center">
			<%=oItem.getItem().getItemPrice().getValue().floatValue()%>
			</td>
			<td align="center">
			<%=itemsPrice %>
			</td>
		</tr>
<%}%>
		

	</table>
		
		<table width="100%">
			<tr>
			<td colspan=3 align=right>
				<strong>Grand Total ($):</strong>
			</td>
			<td align=left>
				&nbsp;<%=total %>&nbsp;
			</td>
		  </tr>
		</table>
   <%}else{ %>
  <table height="500px" ><tr><td class="profile"> 
  Session Expired or order moved from database.
  </td></tr></table>
  <%} %>
 </table>
</body>
</html>