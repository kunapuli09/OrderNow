
<%@ page contentType="text/html;charset=UTF-8" language="java"  %> 

<%@ page import="com.opensymphony.xwork2.ActionContext" %>
<%@ page import="java.util.Map" %>

<%@page import="com.starpath.order.domain.Customer" %>
<%@page import="com.starpath.order.domain.Order" %>
<%@page import="com.starpath.order.domain.Category" %>
<%@page import="com.starpath.order.domain.CategorizedItem"%>
<%@page import="com.starpath.order.domain.Item"%>
<%@page import="com.starpath.order.domain.Price"%>

<%@page import="java.util.*" %> 
<%@page  import="com.starpath.order.domain.UserPrivilege"%>

<%-- JSTL tag libs --%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tlds/fmt.tld" %>

<%@ taglib prefix="s" uri="/WEB-INF/tlds/struts-tags.tld" %>

<html xmlns="http://www.w3.org/1999/xhtml">



<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">

<% String ua = request.getHeader( "User-Agent" );
 boolean isFirefox = ( ua != null && ua.indexOf( "Firefox/" ) != -1 );
boolean isMSIE = ( ua != null && ua.indexOf( "MSIE" ) != -1 ); 
%>

<% if( isMSIE ){ %> 
<link href="<s:url value="/css/phokus/phokus.css"/>" media="screen" rel="Stylesheet" type="text/css">
<link href="<s:url value="/css/phokus/phokus-ie.css"/>" media="screen" rel="Stylesheet" type="text/css">
<link href="<s:url value="/css/phokus/phokus-ie7.css"/>" media="screen" rel="Stylesheet" type="text/css">
<% } %> 
<% if( isFirefox ){ %> 

<link href="<s:url value="/css/phokus/phokus-firefox.css"/>" media="screen" rel="Stylesheet" type="text/css">
<% } %>

<link rel="stylesheet" href="<s:url value='/css/phokus/sample.css'/>" type="text/css"> 

<link href="<s:url value='/css/phokus/datepicker.css'/>" media="screen" rel="Stylesheet" type="text/css">

<link href="<s:url value='/css/phokus/orderCancel.css'/>" rel="stylesheet" type="text/css"/>

</head>
				
<body class="backgcol">
		
		
	
	<div>
			<table>
			<tr>
			<td>
				<div align="center">
					 <div id="itemscontainer">
	               		 <jsp:include page="itemsStaticContainer.jsp"></jsp:include>
					</div>
				</div>		
			</td>
			</tr>
			</table>	
	</div>

	
</body>
</html>