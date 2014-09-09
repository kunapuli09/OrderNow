<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="java.util.*" %>
<%@page import="com.starpath.order.domain.Customer" %>
<%@page import="com.starpath.order.domain.Order" %>
<%@page import="com.starpath.order.domain.CServices" %>
<html>
  <head>
    
     <link href="<s:url value='/css/phokus/orderCancel.css'/>" rel="stylesheet" type="text/css"/>
  </head>
  <body class="regsuccess">
	<s:div theme="ajax" id="updateservicesdiv">
		
	</s:div>
	
	<s:div theme="ajax" id="uploaddivForm" executeScripts="true">
		<s:form id="updateservices" action="doUpdateServices" validate="true">
			<%
			    Order order = (Order)session.getAttribute("order");
				Customer seller = order.getSeller(); 
				if(seller != null)
				{
					CServices cServices = seller.getCServices();
					%>
					<s:hidden name="customerid" value=""> </s:hidden>
					<script>
						document.updateservices.customerid.value = "<%=seller.getId() %>";
						document.getElementById("email").value ="<%=cServices.getEmail()%>";
						document.getElementById("phone").value = "<%=cServices.getPhone()%>";
						document.getElementById("fax").value = "<%=cServices.getFax()%>";
						document.getElementById("delivery").value ="<%=cServices.getDelivery()%>";
						document.getElementById("orders").value = "<%=cServices.getOrders()%>";
						document.getElementById("updateOrders").value ="<%=cServices.getUpdateOrders()%>";
						document.getElementById("credit").value ="<%=cServices.getCredit()%>";
					</script>
					<%
				}
			%>
		      <tr>
		 	      <td colspan="2">
		     	    <s:actionerror />
		         <s:fielderror />
		       		</td>
		       	</tr>
		       <tr> 
					<td colspan="2" class="order">
						<h1> This form helps you to enable and disable your web site services.</h1>
					</td>
				</tr>
				
				<s:hidden name="serviceid" />
				 
				<s:checkbox id="email" name="email" label="Email Service"></s:checkbox> 
				<s:checkbox id="phone" name="phone" label="Phone Service"></s:checkbox> 
				<s:checkbox id="fax" name="fax" label="Fax Service"></s:checkbox> 
				<s:checkbox id="delivery" name="delivery" label="Delivery Service"></s:checkbox> 
				<s:checkbox id="orders" name="orders" label="Online Order Monitoring Service"></s:checkbox> 
				<s:checkbox id="updateOrders" name="updateOrders" label="Cancel/Update order Service"></s:checkbox>
				<s:checkbox id="credit" name="credit" label="Credit Service"></s:checkbox>
				
				
				<table align="center"><tr><td><table>
				 
					<s:submit value="Update" theme="ajax"  targets="updateservicesdiv"  notifyTopics=""  executeScripts="true" align="center" cssClass="buttoncss"/>
				</table>
			</td>
			<td align="right"><table>
					
				<s:submit action="CancelPage"  value="Cancel" onclick="form.onsubmit=null" cssClass="buttoncss"/>
			</table>
			</td>
			</tr>
				</table>
				 
			</s:form>
	</s:div>
</body>

<script>

	document.getElementById("serviceid").value = parent.document.getElementById("serviceid").value;

	if(parent.document.getElementById("email").value == "true")
		document.getElementById("email").checked = true;
	
	if(parent.document.getElementById("phone").value == "true")
		document.getElementById("phone").checked = true;
	
	if(parent.document.getElementById("fax").value == "true")
		document.getElementById("fax").checked = true;
	if(parent.document.getElementById("delivery").value == "true")
		document.getElementById("delivery").checked = true;
	if(parent.document.getElementById("orders").value == "true")
		document.getElementById("orders").checked = true;
	if(parent.document.getElementById("updateOrders").value == "true")
		document.getElementById("updateOrders").checked = true;
		if(parent.document.getElementById("credit").value == "true")
		document.getElementById("credit").checked = true;
</script>
</html>