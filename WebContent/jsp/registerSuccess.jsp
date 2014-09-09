<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="<s:url value='/css/phokus/orderCancel.css'/>" rel="stylesheet" type="text/css"/>
</head>
<body>

<table height="200" width="50%">
	<tr>
		<td><h1><p align="left">
					Your account successfully created.<br>
					Please check your email to activate your profile<br><br>
			   </p></h1>			
		</td>
	</tr>
</table>
</body>
<script>
	document.getElementById("loginDiv").innerHTML = "";
	document.getElementById("loginDiv").style.display = "none";
	parent.parent.document.getElementById("forPage").width = 800;
	parent.parent.document.getElementById("forPage").height = 380;
	
</script>
</html>