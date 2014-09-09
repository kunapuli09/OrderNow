<%@ page 
language="java" 
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<title>Showcase</title>
<link href="<s:url value="/css/main.css"/>" rel="stylesheet" type="text/css"/>
<link href="<s:url value='/css/phokus/orderError.css'/>" rel="stylesheet" type="text/css"/>
</head>

<body class="upsuccess">
</body>

<script>
	parent.parent.getOrderPage("starpathTemplate1.jsp?pdt=true"); 
	//parent.document.getElementById("styled_popup").style.display = "none";
	//parent.parent.getRequestedPage("pickupDeliveryTemplate.jsp");
	//parent.window.refresh();
	
</script>
</html>