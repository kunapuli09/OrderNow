<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.starpath.order.domain.OrderItem" %>
<%@page import="com.starpath.order.domain.Order" %>
<%@page import="java.util.*" %>
<%@page import="java.text.DecimalFormat"%>
<%@ taglib prefix="s" uri="/WEB-INF/tlds/struts-tags.tld" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="<s:url value="/Scripts/order.js"/>" type="text/javascript"></script>
<link href="<s:url value='/css/style.css'/>" rel="stylesheet" type="text/css"/>
</head>
<body>
<script>
function notetool(text){
	Tip(text, FONTSIZE, '12px', HEIGHT, 50, WIDTH, 350, TITLE, 'Note', CLOSEBTN, true, STICKY, true);
}
</script>
<table valign="top" class="yellowborder" cellspacing="0" cellpadding="0">
<tr><td  align="center" background="../images/tabletopbg.gif" height="25px" colspan="3"><strong><font color="#ffffff">Your Order</font></strong> </td></tr>
			<tr height="25">
				<td width="75%">&nbsp;&nbsp;
					<strong>Item Name (Qty)</strong>
				</td>
				<td width="25%">
					<strong>Price ($)</strong>
				</td>
				
			</tr>
<%
Set<OrderItem> orderedItems = null;

if(request.getSession().getAttribute("order")!=null){
	Order order = (Order)request.getSession().getAttribute("order"); 
	orderedItems=order.getOrderedItems();
	float total=0; 
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
				<td align="left" class="yourmeals_border" >
						
						&nbsp;&nbsp;
						
						<%=oItem.getItem().getName() %>&nbsp;&nbsp; (<%=oItem.getOrderedQuantity() %>)
				</td>
				<td align="right" class="yourmeals_border">&nbsp;&nbsp;&nbsp;
					 <%=itemsPrice %>
				</td>
				
			</tr>
		
        		
<%} %>
<tr><td colspan="2" align="right" class="yourmeals_border">----------<br><b>Total</b> &nbsp;&nbsp;&nbsp;<strong>$<%=total %></strong></td><td width="3%">&nbsp;</td></tr>
<tr><td colspan="2" align="right" class="yourmeals_border"><b>Total Tax</b> &nbsp;&nbsp;&nbsp;<strong>$<%
							DecimalFormat df = new DecimalFormat();
							df.setMaximumFractionDigits(2);
							Float taxRate = Float.parseFloat(session.getAttribute("taxRate").toString());
							Float tax =  total * taxRate / 100;
							String a1 = df.format(tax);	 
											%><%=String.valueOf(Float.parseFloat(a1)) %></strong></td><td width="3%">&nbsp;</td></tr>
<tr><td colspan="2" align="right" class="yourmeals_border"><b>Grand Total</b> &nbsp;&nbsp;&nbsp;<strong>$<%String a2 = df.format(total+tax);	 
									%><%=String.valueOf(Float.parseFloat(a2)) %></strong></td><td width="3%">&nbsp;</td></tr>
	
							

<%}else{ %>
<br/>
<%} %>

</table>
<script>

<%
	if(orderedItems == null){
		out.println("orderCount = 0;");		
	}
	else
		out.println("orderCount = " + orderedItems.size() + ";");
%>

</script>
<table width="100%" height="20%"><tr>&nbsp;&nbsp;&nbsp;</tr></table>
<table width="100%" >
<tr>
<td>&nbsp;<span id="siteseal" style="width:10px;height:20px;"><script type="text/javascript" src="https://seal.godaddy.com/getSeal?sealID=1648794020048e8233612711c4ebbda6f17f28080941369275979201"></script></span></td>
</tr>
</table>
</body>
</html>