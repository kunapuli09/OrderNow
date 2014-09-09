<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.starpath.order.domain.Customer" %>
<%@page import="com.starpath.order.domain.Order" %>
<%@page import="java.util.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
    <style type="text/css">
   
    a.ProfileLink {
    font-weight:bold;
    font-family:verdana;
    text-decoration:none; color:#004080;
    }
	a.ProfileLink.vistited {color:#FF0000;}
   
    </style>
   
    <script type="text/javascript" language="javascript">
    function changeColor(idObj,colorObj)
    {
        document.getElementById(idObj.id).style.color = colorObj;
    }
    </script> 
</head>
<%
Order order = (Order)session.getAttribute("order");
Customer customer = order.getBuyer(); %>
<body>
<table><tr><td></td></tr></table>
<table>
<%if(customer!=null){ %>
<tr><td>&nbsp;&nbsp;Name:</td><td style="font-style:italic"> <%=customer.getFirstName().substring(0,1).toUpperCase()+customer.getFirstName().substring(1).toLowerCase()+" "+
			customer.getLastName().substring(0,1).toUpperCase()+customer.getLastName().substring(1).toLowerCase()%></td></tr>
<tr><td></td></tr> 
<tr><td>&nbsp;&nbsp;Email:</td><td style="font-style:italic"> <%=customer.getEmail() %></td></tr>
<tr><td></td></tr> 
<tr><td>&nbsp;&nbsp;Phone:</td><td style="font-style:italic"> <%=customer.getPhoneNumber() %></td></tr>
<tr></tr> 
<tr><td>&nbsp;&nbsp;Address: </td><td style="font-style:italic"><%=customer.getAddress().getAddress() %></td></tr>
<tr><td></td></tr> 
<tr><td>&nbsp;&nbsp;City: </td><td style="font-style:italic"><%=customer.getAddress().getCity().substring(0,1).toUpperCase()+ customer.getAddress().getCity().substring(1).toLowerCase()%></td></tr>
<tr><td></td></tr> 
<tr><td>&nbsp;&nbsp;Zip Code:</td><td style="font-style:italic"> <%=customer.getAddress().getZipCode() %></td></tr> 
<tr><td></td></tr>
<%}else{ %>
Customer not yet logged in. 
<%} %>
 <tr><td>&nbsp;&nbsp;<a href='javascript:parent.parent.getRequestedPage("EditProfileAction.action?firstTime=true");' onMouseOver="this.style.color='red'" class="ProfileLink" onMouseOut="this.style.color='#004080'">Your Profile</a>  </td></tr>
 </table>
</body>
</html>