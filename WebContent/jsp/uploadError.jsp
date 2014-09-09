<%@ page 
language="java" 
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<link href="<s:url value="/css/main.css"/>" rel="stylesheet" type="text/css"/>
<link href="<s:url value='/css/phokus/orderError.css'/>" rel="stylesheet" type="text/css"/>
</head>

<body class="upfail">
	<b>
		<s:actionerror />
	</b>	
</body>
<script>
	parent.document.getElementById("forPage").width = 300;
	parent.document.getElementById("forPage").height = 50;
</script>
</html>