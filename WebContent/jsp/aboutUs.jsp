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

    <div id="left">
    	<tlt:message key="aboutus.content"></tlt:message> 
     
    </div>

	 <div id="center"><img src="../images/restaurenttimings.gif" alt="Restaurant Timings" />
      <p>Fine Dining, Take Out and Catering</p>
      <p><span class="bold">Lunch Buffet</span><br />
        Tue– Sun (11:30 AM – 03:00 PM)</p>
      <p><span class="bold">Dinner </span><br />
        Tue – Sat (05:30 PM – 10:00 PM)
        Sun (05:30 PM – 09:30 PM)</p>
      <p class="bold">We are closed on Mondays</p>
    </div>
    <div id="right"><img src="../images/reataurent_address.gif" alt="Restaurent Address" />
      <p>Indian Cafeteria<br />
        420 market place,<br />
        San Ramon,<br />
        CA 98453<br />
        Phone:925-244-1559</p>
      <img src="../images/order_onphone.gif" alt="Order Food on Phone" width="273" height="35" />
      <p class="bold">Call us @ 925-244-1559</p>
    </div>
   <script>
  if(parent.document.getElementById("ordernowinnerbg")){
	  parent.document.getElementById("ordernowinnerbg").id = "ordernowbg";
	  parent.document.getElementById("ordernowbg").innerHTML = '<div id="todayspecial_text">Join us for Sunday Lunch Buffet 12-3PM</div>';
  }
  parent.document.getElementById("ordernowbtn").style.display= "block";
  </script>
		 
		
</body>
</html>