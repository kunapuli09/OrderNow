<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="java.util.*" %>
<%@page import="com.starpath.order.domain.Customer" %> 

<iframe src="router.jsp" name="forPage" width=100% height=500 frameborder="0" scrolling="no"></iframe>

<script>
 if(document.getElementById("loginDiv")){
 	 document.getElementById("loginDiv").innerHTML = "";
	 document.getElementById("loginDiv").style.display = "none";
	 
}

if(document.getElementById("rform")){
 	 document.getElementById("rform").innerHTML = "";
	 document.getElementById("rform").style.display = "none";
	 
}

	
</script>