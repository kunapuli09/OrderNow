<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.starpath.order.domain.Order" %>
<%@page import="java.util.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="<s:url value='/css/phokus/orderCancel.css'/>" media="screen" rel="Stylesheet" type="text/css"/>
</head>
<body>
 <%List<Order> orderList =(List<Order>) session.getAttribute("orderList"); 
 System.out.println("OrderdList"+orderList);
 if(orderList.size()!=0){
	 System.out.println("OrderdItem"+orderList.get(0).getId());
 %> 
 <table align="center" width="60%" height="25px;"></table>
  <table align="center" width="60%"  style="border:1px solid #006600;">
      <tr>
		<td height="25px;" width="100%" background="../images/hashbar.png" style="padding-top:10px;" valign="top"><strong>
			&nbsp;Show Orders</strong>
		</td>
		</tr>
		</table>
		<div style="overflow:auto; width:60%;height:100%; border:1px solid #006600;"> 
		<table width="100%"  > 
		
	  <tr valign="top" height="50px">
		
	  	<td class="tdLabel"><strong>Order Id</strong></td>
	  	<td class="tdLabel"><strong>Buyer Name</strong></td>
	  	<td class="tdLabel"><strong>Total Price</strong></td>
	  	<td class="tdLabel"><strong>Order Status</strong></td>
	  	<td>&nbsp;</td>
	  </tr>
	  <%for(int i=0;i<orderList.size();i++){ %>
	  <tr valign="top">
	  	<td class="tdLabel"><%=orderList.get(i).getId() %></td>
	  	<td class="tdLabel"><%=orderList.get(i).getBuyer().getFullName() %></td>
	   	<td class="tdLabel"><%=orderList.get(i).getTotal() %></td>
	  	<td class="tdLabel"><%=orderList.get(i).getOrderStatus() %></td>
	  	<td class="tdLabel"><a href="javascript:getRequestedPage('viewOrder.jsp?listCount=<%=i%>')">View Order</a></td>
	  </tr>
	  <tr></tr>
	 <%} %>

   </table>
   </div>
   <%}else{ %>
  <table height="500px" ><tr><td class="tdLabel"> 
  There are no Orders to Show.
  </td></tr></table>
  <%} %>

</body>
</html>