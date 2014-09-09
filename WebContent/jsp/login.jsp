<%@ page contentType="text/html"%>
<%@ taglib prefix="c" uri="/WEB-INF/tlds/c.tld"%>
<html>
<head>
<link href="<s:url value='/css/style.css'/>"
	rel="stylesheet" type="text/css" />
</head>
<body>

<table>
	<tr>
		<td>
		<c:if test="${not empty param.login_error}">
			<font color="red">Login failed...try again</font>
			<br>
			<br>
		</c:if>

		<form method="POST" action="<c:url value='j_acegi_security_check'/>">

		<span>Enter your user name and password</span><br>
		<table border="0" cellpadding="0">
			<tr>
				<td align="center" colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td align="right">User Name:</td>
				<td><input type='text' id='UserName' name="j_username"
					size='30'></input></td>
			</tr>
			<tr>
				<td align="right">Password:</td>
				<td><input type='password' id='Password' name="j_password"
					size='30'></input></td>
			</tr>
			<tr>
				<td align="left" colspan="2"><input type="checkbox"
					id="rememberMe" name="rememberMe"></input> &nbsp; Remember me next
				time.</td>
			</tr>

			<tr>
				<td align="center" colspan="2"><br />
				</td>
			</tr>
			<tr>
				<td align="center"><input type="submit" value="Login">
				</td>
				<td align="right"><span class="boldBlue"><a
					href="registerUser.htm"> New Users? Register Here</a></span></td>
			</tr>
		</table>
		</form>
		</td>
	</tr>
</table>

</body>
</html>