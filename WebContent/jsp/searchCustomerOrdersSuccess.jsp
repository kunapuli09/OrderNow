<%@page import="com.starpath.order.domain.Order"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="tlt"%>
<%@ taglib uri="http://displaytag.sf.net/el" prefix="display"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<link href="../css/style.css" rel="stylesheet" type="text/css"/> 
<link href="../css/flexcrollstyles.css"	rel="Stylesheet" type="text/css">
	<link href="../css/tutorsty.css"	rel="Stylesheet" type="text/css">
<link href="../css/displaytag.css" media="screen"
	rel="Stylesheet" type="text/css" /> 
	<script src="../Scripts/flexcroll.js" type="text/javascript"></script>
<script src="<s:url value='/Scripts/order.js'/>" type="text/javascript"></script>
<script src="<s:url value='/struts/xhtml/validation.js'/>"
	type="text/javascript"></script>



</head>
<body>

<table align="center" width="100%" height="25px"  background="../images/tabletopbg.gif" style="padding-top:0px;" valign="center"><tr><td><strong><font color="#ffffff">Customer Orders</font></strong></td></tr></table>
<table ><tr><td>
<div id='mycustomscroll5' class='flexcroll'>
<s:set value="orders" scope="request" name="orders" />
<display:table  name="orders" class="its" export="true" sort="list"
	pagesize="10" requestURI="">
	<display:column property="buyer.firstName" title="First Name"
		sortable="true" headerClass="sortable" maxWords="1" />
	<display:column property="buyer.lastName" title="Last Name"
		sortable="true" headerClass="sortable" maxWords="1" />
	<display:column property="buyer.phoneNumber" title="Phone Number"
		sortable="true" headerClass="sortable" />
	<display:column property="buyer.address.address" title="Phone Number"
		sortable="true" headerClass="sortable" />
	<display:column property="total" title="Order Amount" sortable="true"
		headerClass="sortable" />
	<display:column property="orderStatus" title="Order Status"
		sortable="true" headerClass="sortable" />
	<display:column property="orderDate" title="Order Date" sortable="true"
		headerClass="sortable" />
	<display:column property="id" headerClass="sortable" sortable="true"
		title="Order Details" media="html"
		decorator="com.starpath.order.actions.OrderDetailDecorator" />
	<display:column property="buyer" title="Map To Customer"
		headerClass="sortable" sortable="true" media="html"
		decorator="com.starpath.order.actions.MapDecorator" />
</display:table>
</div>
</td></tr></table>
<table height="30px"><tr><td>&nbsp;</td></tr></table>
</body>
</html>