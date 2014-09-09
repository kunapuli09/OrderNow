<%@ page 
language="java" 
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<title>Showcase</title>
<link href="<s:url value="/css/main.css"/>" rel="stylesheet" type="text/css"/>
</head>

<body>
<table class="wwFormTable">

<tr>
<td colspan="2"><h1>Your account successfully created - <s:property value="firstName" /></h1></td>
</tr>

<tr>
<td colspan="2"><h2>Please check your email to activate your profile</h2></td>
</tr>

</table>

</body>
</html>