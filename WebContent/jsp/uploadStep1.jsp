<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="java.util.*" %>
<%@page import="com.starpath.order.domain.Customer" %>
<html>
  <head>
    
    <link href="<s:url value='/css/phokus/orderError.css'/>" rel="stylesheet" type="text/css"/>
  </head>
<script src="<s:url value="/Scripts/menucontainer.js"/>" type="text/javascript"></script>

  <body class="regsuccess">
  
	 <s:div id="uploadDIV1" theme="ajax">
	 </s:div>
	
	 <s:div id="uploadDIV" theme="ajax" executeScripts="true"> 
	 <div>
		<s:form id="upload" validate="true" action="doUpload" method="POST" enctype="multipart/form-data">
	
	      <tr>
	 	      <td colspan="2">
	     	    <s:actionerror />
	         <s:fielderror />
	       		</td>
	       	</tr> 
		
		
		<tr><td colspan="2"><h1> The following form helps you to update your web site content.</h1></td></tr>
		<tr><td height="5"></td></tr>
		<s:file name="upload1" label="Company Logo"/>
		<s:file name="upload2" label="Header Image   " />
		<!--<s:file name="upload3" label="Promotion Image"/>-->
		<s:file name="upload4" label="Location Image" />
		<!--<s:file name="upload5" label="Today Special Image"/>--> 
		
		<s:textarea name="home" label="Home Content" cols="30" rows="5" value="%{home}" onkeydown="return checkTextAreaSize(this,1500);"> </s:textarea>
		<s:textarea name="contact" label="Contact Us "  cols="30" rows="5" onkeydown="return checkTextAreaSize(this,500);"> </s:textarea>
		<s:textarea name="aboutus" label="About Us " cols="30" rows="5" onkeydown="return checkTextAreaSize(this,1500);">  </s:textarea>
		<s:textfield name="addressline1" label="Address">  </s:textfield>
		<s:textfield name="addressline2" label="City" >  </s:textfield>
		<s:textfield name="addressline3"  label="State/Province"  >  </s:textfield>
		<s:textfield name="phonenumber"  label="Phone "  >  </s:textfield>
		<!--<s:textarea name="promotions" label="Promotions"  cols="30" rows="5" onkeydown="return checkTextAreaSize(this,200);">  </s:textarea>-->
		<s:textarea name="terms" label="Terms & Conditions"  cols="30" rows="5" onkeydown="return checkTextAreaSize(this,2000);">  </s:textarea>
		<s:textarea name="privacy" label="Privacy & Security" cols="30" rows="5" onkeydown="return checkTextAreaSize(this,2000);">  </s:textarea>
		<s:textarea name="restaurant" label="Restaurant Owners" cols="30" rows="5" onkeydown="return checkTextAreaSize(this,1000);">  </s:textarea>
		<!--<s:textarea name="todayspecial" label="Today Special" cols="30" rows="5" onkeydown="return checkTextAreaSize(this,200);">  </s:textarea>--><br/>
		
		<table align="center"><tr><td><table>
			<s:submit value="Submit" theme="ajax"  targets="uploadDIV1"  notifyTopics=""  executeScripts="true" cssClass="buttoncss"/>
		</table>
		</td>
		<td><table>
		
			<s:submit action="CancelPage"  value="Cancel" onclick="form.onsubmit=null" cssClass="buttoncss"/> 
		</table>
		</td>
		</tr>
		</table>
	
	</s:form>
	</div>
	</s:div>
	
</body>

<script>
	if(document.getElementById("home"))
		document.getElementById("home").value = parent.document.getElementById("home").value;
	if(document.getElementById("contact"))
		document.getElementById("contact").value = parent.document.getElementById("contact").value;
	if(document.getElementById("aboutus"))
		document.getElementById("aboutus").value = parent.document.getElementById("aboutus").value;
	if(document.getElementById("addressline1"))
		document.getElementById("addressline1").value = parent.document.getElementById("addressline1").value;
	if(document.getElementById("addressline2"))
		document.getElementById("addressline2").value = parent.document.getElementById("addressline2").value;
	if(document.getElementById("addressline3"))
		document.getElementById("addressline3").value = parent.document.getElementById("addressline3").value;
	if(document.getElementById("phonenumber"))
		document.getElementById("phonenumber").value = parent.document.getElementById("phonenumber").value;
	if(document.getElementById("terms"))
		document.getElementById("terms").value = parent.document.getElementById("terms").value;
	if(document.getElementById("privacy"))
		document.getElementById("privacy").value = parent.document.getElementById("privacy").value;
	if(document.getElementById("restaurant"))
		document.getElementById("restaurant").value = parent.document.getElementById("restaurant").value;
	if(document.getElementById("todayspecial"))
		document.getElementById("todayspecial").value = parent.document.getElementById("todayspecial").value;
</script>
</html>
