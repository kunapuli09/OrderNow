<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="java.util.*" %>
<%@page import="com.starpath.order.domain.Customer" %>
<html>
  <head>
  
    
  <script src="<s:url value="/Scripts/menucontainer.js"/>" type="text/javascript"></script>  
  <link href="<s:url value='/css/phokus/orderCancel.css'/>" rel="stylesheet" type="text/css"/>
  <link href="<s:url value='/css/phokus/datepicker.css'/>" rel="stylesheet" type="text/css"/>
 </head>
 
  <body class="regsuccess"> 
 
     <s:div id="updateDIV1" theme="ajax">
	 </s:div>
	
	<div id="addDateDiv" class="adddate">
	           <h1>The following form helps you to update your Holidays/Payment Options.</h1><br/>
	         <input type="text" id="holidaysText" name="holidaysText" />
		     <img src="<s:url value="/images/calander.png"/>" onclick="displayDatePicker('holidaysText', false, 'dmy', '/');" width="15" height="15">
		   	 <input type="button" value="Add" onclick="addDatesToDiv()" class="buttoncss">
	  	 </div>
	
	<div id="textAreaDiv" class="holidaydates">
 	  <h1>Your holiday dates</h1>
	 <form name="temp">
 	 	<textarea name="showDateText" cols="50" rows="10" >test</textarea>
 	 </form>
 	 </div>
 	 
	 <s:div id="uploadDIV" theme="ajax" executeScripts="true"> 
	 <div>
		<s:form id="updateHolidays"  action="doUpdateHolidays" method="POST" >
	
	      <tr>
	 	      <td colspan="2">
	     	    <s:actionerror />
	         <s:fielderror />
	       		</td>
	       	</tr> 
		
		<%
				
				Customer customer = null; 
				customer = (Customer)session.getAttribute("customer");
				String emailToken = "";
				String emailToken1 = "";
				 if(customer!=null)
					{
						String email = customer.getEmail();
						int index = email.indexOf("@");
						if(index > 0){
								emailToken = email.substring(0,index);
								emailToken1="_"+emailToken;
								}
					}
		
				String fileName;
				fileName = "/properties/ApplicationResources" +emailToken1;
				
				ResourceBundle myResources = null;
				
				try{
					
					myResources = ResourceBundle.getBundle(fileName);
					
				}catch(Exception ex){
					myResources = ResourceBundle.getBundle("/properties/ApplicationResources");
					ex.printStackTrace();
				}
				
		%>
		<s:hidden name="holidayDates" value=""></s:hidden>
		
		<s:hidden name="isSaturday" value="false"></s:hidden>
		<s:hidden name="isSunday" value="false"></s:hidden>
		<!-- 
		<s:checkbox name="isSaturday" label="saturday"></s:checkbox>
		<s:checkbox name="isSunday" label="sunday"></s:checkbox>
		-->
		
		<tr><td class="ordercancel"><h1>Select the Payment Options you provide</h1></td></tr>
		<s:checkbox name="isVisa" label="Visa Service"></s:checkbox>
		<s:checkbox name="isMasterCard" label="Mastercard Service"></s:checkbox>
		<s:checkbox name="isAmex" label="Amex Service"></s:checkbox>
		<s:checkbox name="isDiscover" label="Discover Service"></s:checkbox>
		
		<table align="center"><tr><td><table>
			<s:submit value="Submit" theme="ajax"  targets="updateDIV1"  notifyTopics=""  executeScripts="true" cssClass="buttoncss"/>
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
	document.getElementById("holidayDates").value = parent.document.getElementById("holidayDates").value;
	document.temp.showDateText.value = parent.document.getElementById("holidayDates").value;
	
	if(parent.document.getElementById("isSaturday").value == "true")
		document.getElementById("isSaturday").checked = true;
	
	if(parent.document.getElementById("isSunday").value == "true")
		document.getElementById("isSunday").checked = true;

	if(parent.document.getElementById("isVisa").value == "true")
		document.getElementById("isVisa").checked = true;
	
	if(parent.document.getElementById("isMasterCard").value == "true")
		document.getElementById("isMasterCard").checked = true;

	if(parent.document.getElementById("isAmex").value == "true")
		document.getElementById("isAmex").checked = true;
	
	if(parent.document.getElementById("isDiscover").value == "true")
		document.getElementById("isDiscover").checked = true;
	
	
</script>
</html>
