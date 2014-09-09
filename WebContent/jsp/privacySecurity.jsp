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
<% System.out.println("emailToken:"+emailToken);%>
<tlt:resource email="<%=emailToken %>" ></tlt:resource>

     <div id="left"><p class="bold">Welcome to Sai Groceries Online.</p></div>
	 <div id="center"><img src="../images/restaurenttimings.gif" alt="Store Timings" />
	 <p>Tue - Fri (3:00PM – 8:00 PM)<br />
 	Sat - Sun (12:00 PM – 08:00 PM)</p>
		<p class="bold">We are closed on Mondays</p>
	</div>
    <div id="right"><img src="../images/reataurent_address.gif"	alt="Store Address" />
		<p>2316 Vickers Drive,<br />
		 Colorado Springs, CO 80918 </p>
		<p class="bold">Call us @ (719)264-8532</p>
	</div>
    
   <script>
  if(parent.document.getElementById("ordernowinnerbg")){
	  parent.document.getElementById("ordernowinnerbg").id = "ordernowbg";
	  parent.document.getElementById("ordernowbg").innerHTML = '<div id="todayspecial_text">Farm fresh vegetables are available every Wednesday and Thursday!</div>';
  }
  parent.document.getElementById("ordernowbtn").style.display= "block";
  </script>
		 
		
</body>
</html>