<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="../css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>

<table height="200">
	<tr height="200px" align="center">
		<td class="ordersuccess_td">
			<p align="left">An email has been sent to your email address. <br/>Please check your email to retrieve your password.<br/><br/>
					Thank You,<br/>
					Sai Grocery Technical Support</p>
				
		</td>
	</tr>
</table>
</body>
<script>
	document.getElementById("loginDiv").innerHTML = "";
	parent.parent.document.getElementById("forPage").width = 400;
	parent.parent.document.getElementById("forPage").height = 380;
	
</script>
</html>
