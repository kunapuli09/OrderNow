
<%@page import="com.starpath.order.domain.OrderItem"%>
<%@page import="com.starpath.order.domain.Order"%>
<%@page import="java.util.*"%>
<%@ taglib prefix="s" uri="/WEB-INF/tlds/struts-tags.tld"%>


<link href="<s:url value='/css/style.css'/>" rel="Stylesheet"
	type="text/css">
<link href="<s:url value='/css/flexcrollstyles.css'/>" rel="Stylesheet"
	type="text/css">

<script src="<s:url value='/Scripts/flexcroll.js'/>"
	type="text/javascript"></script>
<link href="<s:url value='/css/tutorsty.css'/>" rel="Stylesheet"
	type="text/css">
<script>
function getUpdatedShoppingCart(itemid){
	var url="GetUpdatedShoppingCart.action?itemId="+itemid;
	new Ajax.Updater('mealorder',''+url, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
}

function getCheckoutPage(){
var url ="Checkout.action";
if(orderCount > 0){
	if(minimumtotal < 11){
	    alert("Order total must be $10 or more");
	} else{
		new Ajax.Updater('bodycontent',''+url, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});		
	}
}
else{
	alert("Please select atleast one item");
}
} 

</script>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="yellowborder">
	<tr>
		<td align="left" valign="top"><img
			src="../images/yourmealsorder.gif" alt="Your Order" width="200"
			height="25" /></td>
	</tr>
	<tr>
		<td align="left" valign="top" class="yourmeals_border">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="25" class="price">&nbsp;</td>
				<td class="price">Item Name(Qty)</td>
				<td width="60" class="price">Price ($)<br />
				</td>
			</tr>
		</table>
		<div id='mycustomscroll' class='flexcroll'>
		<table width="100%" border="0" cellspacing="3" cellpadding="0">
			<%
				Set<OrderItem> orderedItems = null;
				float total = 0;
				if (request.getSession().getAttribute("order") != null) {
					Order order = (Order) request.getSession()
							.getAttribute("order");
					orderedItems = order.getOrderedItems();

					float itemsPrice;
					Long itemId;
					for (OrderItem oItem : orderedItems) {
						if (oItem.getItem().getItemPrice().getValue() != null) {
							itemsPrice = (oItem.getItem().getItemPrice().getValue()
									.floatValue())
									* oItem.getOrderedQuantity();
							itemsPrice = (float) ((int) ((itemsPrice + 0.005) * 100.0) / 100.0);
							itemId = oItem.getItem().getId();
							total += itemsPrice;
							total = (float) ((int) ((total + 0.005) * 100.0) / 100.0);
						} else {
							itemsPrice = 0;
							itemId = oItem.getItem().getId();
						}
			%>
			<tr>
				<td width="20" align="center"><a
					href='javascript:getUpdatedShoppingCart(<%=itemId%>);'> <img
					src="../images/close.gif" alt="Remove Item" width="10" height="10" />
				</a></td>
				<td class="yourmeals_border_td"><%=oItem.getItem().getName()%>
				(<%=oItem.getOrderedQuantity()%>)</td>
				<td width="65" align="right" class="yourmeals_border_td"><%=itemsPrice%><br />
				</td>
			</tr>
			<%
				}
			%>
		</table>
		</div>

		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="25" class="total">&nbsp;</td>
				<td class="total">Total</td>
				<td width="60" class="total">US$<%=total%></td>
			</tr>
		</table>
		<%
			}
		%>
		</td>
	</tr>
	<tr>
		<td align="right" valign="top"><img src="../images/checkout.gif"
			onclick='javascript:getCheckoutPage();' alt="CheckOut" width="76"
			height="22" class="pointer" /></td>
	</tr>
</table>
<script>
<%if (total < 10) {
				out.println("minimumtotal = 10;");
			}
			else{
				out.println("minimumtotal=11;");
			}%>
<%if (orderedItems == null) {
				out.println("orderCount = 0;");
			} else
				out.println("orderCount = " + orderedItems.size() + ";");%>

</script>