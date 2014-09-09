<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- JSTL tag libs --%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tlds/fmt.tld" %>
<%@page import="java.util.*" %>
<%@page import="com.starpath.taglib.*" %> 
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="tlt"%>

<%
		
		String emailToken ="";
		
	
		if(session.getAttribute("emailToken")!=null)
		     emailToken=(String)session.getAttribute("emailToken");
		
		
%>
<html>
<head>
	
</head>
<body>
<tlt:resource email="<%=emailToken %>" ></tlt:resource>

		<table class="HomeContentTable">
			<tr>
			<td  width="25%"  class="toplinks2" >
				<table>
					<tr>
						<td>
						<img width="170px" height="136px" src="../<tlt:message key="contactus.image"></tlt:message>">
						<br>
						</td>
					</tr>
					<tr>
						<td align="center">
						<font color="#000000">
						&nbsp;<strong><b>Address:</b></strong><br>
							<tlt:message key="contactus.addressline1"></tlt:message><br><tlt:message key="contactus.addressline2"></tlt:message> <br><tlt:message key="contactus.addressline3"></tlt:message><br>Phone:<tlt:message key="contactus.phonenumber"></tlt:message>&nbsp;
							</font>
							<br>&nbsp;
						</td>
					</tr>
					<tr>
						<td >
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" class="OrderButton" value="Order Online" alt="Order Online" 
						onClick='javascript:getRequestedPage("getCategories.action?menu=Main Menu");'>

						</td>
					</tr>
				</table>
			</td>
			<td class="post">	
					
						<tlt:message key="restaurantowners.content"></tlt:message>
			</td>			
			</tr>
		</table>
		
</body>
</html>