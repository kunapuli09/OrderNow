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
<% 
	String returnCode = request.getParameter("Return_Code");
	String approvNum = request.getParameter("Approv_Num");
	String cardResponse = request.getParameter("Card_Response");
	String avsResponse = request.getParameter("AVS_Response");
	String voidRecordNum = request.getParameter("VoidRecNum"); 
	String orderId = request.getParameter("orderid");
	System.out.println("SecurePay ReturnCode"+returnCode);
	System.out.println("SecurePay VoidRecNum"+voidRecordNum);
	System.out.println("SecurePay Approv_Num"+approvNum);
%>
</body>


<script>
   
	//parent.document.getElementById("styled_popup").style.display = "none";
	parent.parent.replaceBodyContent("PaymentAction.action?Return_Code=<%=returnCode%>&Approv_Num=<%=approvNum%>&AVS_Response=<%=avsResponse%>&VoidRecNum=<%=voidRecordNum%>&orderId=<%=orderId%>"); 
	//parent.window.refresh();
	
</script>
</html>