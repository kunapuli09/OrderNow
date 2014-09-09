<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page import="java.util.Map"%>

<%@page import="com.starpath.order.domain.Customer"%>
<%@page import="java.util.*"%>
<%@page import="com.starpath.order.domain.UserPrivilege"%>
<%@page import="com.starpath.order.domain.*"%>
<%@page import="com.starpath.taglib.*"%>

<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="tlt"%>

<%-- JSTL tag libs --%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tlds/fmt.tld"%>

<%@ taglib prefix="s" uri="/WEB-INF/tlds/struts-tags.tld"%>

<html xmlns="http://www.w3.org/1999/xhtml">



<head>
<title>Sai Grocery</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">

<script>
	var lockScreen = false;
</script>

<%
	String ua = request.getHeader("User-Agent");
	boolean isFirefox = (ua != null && ua.indexOf("Firefox/") != -1);
	boolean isMSIE = (ua != null && ua.indexOf("MSIE") != -1);
%>

<%
	if (isMSIE) {
%>
<%
	}
%>
<%
	if (isFirefox) {
%>

<%
	}
%>

<script type="text/javascript" src="<s:url value='/Scripts/unitpngfix.js'/>"></script>
<script src="<s:url value='/Scripts/menucontainer.js'/>" type="text/javascript"></script>

<style type="text/css">
.TableBorderColor {
	border: #004080 solid
}
</style>


</head>
<%
	Customer customer = null;
	customer = (Customer) session.getAttribute("customer");
	String emailToken = "";
	Set privilageset = null;
	UserPrivilege privilage = null;
	Iterator privilageIterator = null;
	String privilageStr = "";
	CServices cServices = null;
	List<String> roles = new ArrayList<String>(3);
	if (customer != null) {
		privilageset = customer.getRoles();
		privilageIterator = privilageset.iterator();
		while (privilageIterator.hasNext()) {
			UserPrivilege privilege = (UserPrivilege) privilageIterator
					.next();
			roles.add(privilege.getPrivilege());
		}
		cServices = customer.getCServices();
	}
	/*if(session.getAttribute("emailToken")!=null)
	     emailToken=(String)session.getAttribute("emailToken");*/
%>
<body>
<tlt:resource email="<%=emailToken %>"></tlt:resource>

<div id="wrapper">
<div id="header">
<div id="logo"><a href="starpathTemplate.jsp"><img
	src="../images/logo.png" alt="Sai Grocery" width="205" height="150" /></a></div>
<div id="topnavigation">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="right" valign="top">&nbsp;</td>
		<td width="61" align="right" valign="top"><a
			href="starpathTemplate.jsp"> <img src="../images/home.gif"
			alt="Home" width="61" height="33" id="Image1"
			onMouseOver="MM_swapImage('Image1','','../images/home_r.gif',1)"
			onMouseOut="MM_swapImgRestore()" /> </a></td>
		<td width="86" align="right" valign="top"><a
			href='javascript:replaceBodyContent("getCategories.action?menu=Main Menu")'><img
			src="../images/ordernow.gif" alt="Order Now" width="86" height="33"
			id="Image2"
			onMouseOver="MM_swapImage('Image2','','../images/ordernow_r.gif',1)"
			onMouseOut="MM_swapImgRestore()" /></a></td>


	
		<%
			if(roles.contains(UserPrivilegeType.ROLE_GUEST.name()) && roles.contains(UserPrivilegeType.ROLE_STORE_OWNER.name())){
		   %>
		<td width="118" align="right" valign="top"><a
			href='javascript:replaceBodyContent("doUpload.action?firstTime=true");'><img
			src="../images/updatecontent.gif" alt="Update Content" width="118"
			height="33" id="Image4"
			onmouseover="MM_swapImage('Image4','','../images/updatecontent_r.gif',1)"
			onmouseout="MM_swapImgRestore()" /></a></td>
		<% if(null != customer){ %>
		<td width="100" align="right" valign="top"><a
			href='javascript:replaceBodyContent("searchRequestedCustomerOrders.action");'><img
			src="../images/showorders.gif" alt="Show Orders" width="100"
			height="33" id="Image6"
			onmouseover="MM_swapImage('Image6','','../images/showorders_r.gif',1)"
			onmouseout="MM_swapImgRestore()" /></a></td>
		<%} %>
		<%}%>
		<%
			if(roles.contains(UserPrivilegeType.ROLE_GUEST.name()) && roles.contains(UserPrivilegeType.ROLE_STORE_OWNER.name()) && roles.contains(UserPrivilegeType.ROLE_ADMIN.name())){
		   %>
		<td width="121" align="right" valign="top"><a
			href='javascript:replaceBodyContent("doUpdateServices.action?firstTime=true");'><img
			src="../images/updateservices.gif" alt="Update Services" width="121"
			height="33" id="Image5"
			onmouseover="MM_swapImage('Image5','','../images/updateservices_r.gif',1)"
			onmouseout="MM_swapImgRestore()" /></a></td>
		<%} %>
		<td width="81" align="right" valign="top"><a
			href='javascript:replaceBodyContent("contactUs.jsp");'><img
			src="../images/directions.gif" alt="Directions" width="81"
			height="33" id="Image7"
			onmouseover="MM_swapImage('Image7','','../images/directions_r.gif',1)"
			onmouseout="MM_swapImgRestore()" /></a></td>
		<% if(null == customer){ %>
		<td width="66" align="right" valign="top"><a
			href='javascript:replaceBodyContent("loginTemplate.jsp");'><img
			src="../images/login.gif" alt="Logout" width="66" height="33"
			id="Image4"
			onmouseover="MM_swapImage('Image4','','../images/login_r.gif',1)"
			onmouseout="MM_swapImgRestore()" /></a></td>

		<!--<td width="66" align="right" valign="top"><a
			href='javascript:replaceBodyContent("registerTemplate.jsp");'><img
			src="../images/registerhere.gif" alt="Register Here" width="105"
			height="33" id="Image5"
			onMouseOver="MM_swapImage('Image5','','../images/registerhere_r.gif',1)"
			onMouseOut="MM_swapImgRestore()" /></a></td>
		--><%} %>
		<% if(null != customer){ %>

		<td width="66" align="right" valign="top"><a
			href='javascript:replaceBodyContent("EditProfileAction.action?firstTime=true");'><img
			src="../images/myaccount.gif" alt="My Account" width="105"
			height="33" id="Image10"
			onMouseOver="MM_swapImage('Image10','','../images/myaccount_r.gif',1)"
			onMouseOut="MM_swapImgRestore()" /></a></td>

		<td width="66" align="right" valign="top"><a
			href="javascript:getOrderPage('logoutAction.action')"><img
			src="../images/logout.gif" alt="Logout" width="66" height="33"
			id="Image8"
			onmouseover="MM_swapImage('Image8','','../images/logout_r.gif',1)"
			onmouseout="MM_swapImgRestore()" /></a></td>  
		<%} %>
	</tr>

</table>
</div>
<div id="ordernowinnerbg">
<div style="width:100px; float:left; margin:20px 10px 10px 70px;">
<a href='javascript:replaceBodyContent("getCategories.action?menu=Main Menu")'><img src="../images/order_online.png" width="117" height="19"/></a>
</div>
<div id="todayspecial_text">Farm fresh vegetables are available every Wednesday and Thursday!</div>
</div>


</div>
<div id="banner"><img src="../images/Banner_01.jpg" alt="Banner"
	width="250" height="219" /><img src="../images/Banner_02.jpg"
	alt="Banner" width="250" height="219" /><img
	src="../images/Banner_03.jpg" alt="Banner" width="250" height="219" /><img
	src="../images/Banner_04.jpg" alt="Banner" width="250" height="219" /></div>
	<div id="bodycontent">

<div id="left">
<p class="bold">Welcome to Sai Groceries Online.</p><p>
Sai Grocery provides service to its valuable customers since 2004 by selling grocery and fresh vegetables at a best price. <br/>
Indian grocery like rice,wheat powder, spices and snacks are sold at a good price.
<br/>Frozen roti and vegetables are always available.  <br/>
Products from popular brands like Deep, Lakshmi, Swad, Sujata and Manish are available.  
Customers' favorite snacks from Haldiram and Harika snacks are sold here.<br/>
On Thursdays, and Fridays fresh vegetables are available!<br/>
Also a good quality brand new DVDs available at affordable price. Movies from Telugu, Tamil and Hindi are available.
</p>
</div>


<div id="center"><img src="../images/restaurenttimings.gif"
	alt="Store Timings" />
<p>
	Tue - Fri (3:00PM – 8:00 PM)<br />
 	Sat - Sun (12:00 PM – 08:00 PM)</p>
<p class="bold">We are closed on Mondays</p>
<p class="bold"><a href='javascript:replaceBodyContent("getCategories.action?menu=Main Menu")'>Order Online</a> and Pickup during Store hours.</p>
</div>

<div id="right"><img src="../images/reataurent_address.gif"
	alt="Store Address" />

 <p>2316 Vickers Drive,<br />
 Colorado Springs, CO 80918</br>
 Email:saigrocery@gmail.com
</p>
<p class="bold">Call us @ (719)264-8532</p>
</div>


</div>
</div>
<div class="clear"></div>
<div id="footer" class="inner">
	 <a href="javascript:replaceBodyContent('getCategories.action?menu=Main Menu');">Order
Online</a> |  <a href="javascript:replaceBodyContent('contactUs.jsp');">Directions</a>
|<a href="javascript:replaceBodyContent('privacySecurity.jsp');">Privacy
Policy</a> | <a href="javascript:replaceBodyContent('termsOfUse.jsp');">Terms
Of Use</a><br/>
Copyright 2009 - 2010 <a href="http://www.webadexperts.com">WEB presence LLC</a> All rights reserved.</div>
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-6668350-12");
pageTracker._trackPageview();
} catch(err) {}</script>
</body>


<script>

	if("<%=request.getAttribute("emailActivate")%>" == "true")
		getRequestedPage("emailactivate.jsp");
	else if("<%=request.getAttribute("emailActivate")%>" == "false")
		getRequestedPage("emailactivateerror.jsp");

	//document.getElementById('dimmer').style.width = parent.window.screen.width;
	//document.getElementById('dimmer').style.height = parent.window.screen.height;
	
</script>
<script>

	if("<%=request.getParameter("pdt")%>" == "true")
		replaceBodyContent("getCategories.action?menu=Main Menu");
	
	//document.getElementById('dimmer').style.width = parent.window.screen.width;
	//document.getElementById('dimmer').style.height = parent.window.screen.height;
	
</script>
</html>