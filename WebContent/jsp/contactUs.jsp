
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%-- JSTL tag libs --%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tlds/fmt.tld"%>
<%@page import="java.util.*"%>
<%@page import="com.starpath.taglib.*"%>
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
<tlt:resource email="<%=emailToken %>"></tlt:resource>

<table>
	<tr>
		<td>
			<iframe width="915px" height="400px" frameborder="0" scrolling="no" 
			marginheight="0" marginwidth="0" 
			src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=2316+Vickers+Drive+Colorado+Springs+CO+80918&amp;sll=37.0625,-95.677068&amp;sspn=34.671324,86.572266&amp;ie=UTF8&amp;hq=&amp;hnear=2316+Vickers+Dr,+Colorado+Springs,+El+Paso,+Colorado+80918&amp;ll=38.925563,-104.779615&amp;spn=0.008314,0.021136&amp;z=14&amp;iwloc=A&amp;output=embed"></iframe><br />
		</td>
		<td align="left" width="10%">
			<form action="http://maps.google.com/maps" method="get" target="_blank">
				<input type="hidden" name="daddr" value="2316 Vickers Drive, Colorado Springs, CO 80918" /> 
				<input type="submit" value="Directions" class="OrderButton" style="background-color: #59090A;border-color: #59090A; border:0px;  color:#ffffff; 2px 3px 2px 3px;"/>
			</form>
		</td>
	</tr>
</table>



</body>
</html>