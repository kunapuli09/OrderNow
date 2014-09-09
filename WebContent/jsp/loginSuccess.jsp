<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="com.starpath.order.domain.Customer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="/WEB-INF/tlds/fmt.tld" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<fmt:setBundle basename="ApplicationResources" />
</head>
<body onload='alert("hi")'>

<%
	Customer customer = null; 
	customer=(Customer)session.getAttribute("customer");
%>


<table width="100%">
				<tr>
					<td width="9%" align="center" onclick="getRequestedPage('home.jsp')"><font color="#FFFFFF"><fmt:message key="header.home"/></font></td>
					<td width="8%" align="center" onclick='getRequestedPage("orderNow.jsp")'><font color="#FFFFFF"><fmt:message key="header.ordernow"/></font></td>
					<td width="8%" align="center" onclick='getRequestedPage("showorders.jsp")'><font color="#FFFFFF"><fmt:message key="header.showorders"/></font></td>
					<td width="8%" align="center" onclick='getRequestedPage("partyorders.jsp")'><font color="#FFFFFF"><fmt:message key="header.partyorders"/></font></td>
					<td width="8%" align="center" onclick='getRequestedPage("contactUs.jsp")'><font color="#FFFFFF"><fmt:message key="header.contactus"/></font></td>
					  <td width="9%" align="center" ><a  id="loginAnchor" onClick='getLogoutPage("")'>
						<font color="#FFFFFF"><fmt:message key="header.logout"/></font></a></td>
						</tr>
				
			</table>
</body>
</html>