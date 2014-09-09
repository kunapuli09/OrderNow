<%@ page 
language="java" 
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<link href="<s:url value='/css/main.css'/>" rel="stylesheet" type="text/css"/>
<link href="<s:url value='/css/phokus/orderError.css'/>" rel="stylesheet" type="text/css"/>
</head>

<body >
	
	<table align="center" width="100%" class="yellowborder" height="400px"  border="0">
<tr>
<td width="10%"></td>

<td style="font:13px Verdana, Arial, Helvetica, sans-serif;" width="80%">

		<s:actionerror />
		Unfortunately we are unable to complete the processing of your order because payment authorization to your credit/debit card has failed.
		This means your credit/debit card issuer has declined our request for authorization due to invalid credit/debit card number.
<br/> <br/>
<INPUT TYPE="button" NAME="TEST1"  onclick='parent.parent.getRequestedPage("orderFailureAction.action")' VALUE="Order Again" class="buttoncss">&nbsp;
	<%
	System.out.println("Failed to place an Order");
	%>
</td>
<td width="10%">
</td>
</tr>
<tr><td width="10%" height="150px"/><td width="80%"/><td width="10%"/></tr>
</table>


</body>
<script>
	
</script>
</html>