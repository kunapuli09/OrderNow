<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="com.starpath.order.domain.Customer"%>
<%@page import="com.starpath.order.domain.Order"%>
<%@ page import="com.temesoft.security.Base64Coder"%>
<%@ page import="com.temesoft.security.Encrypter"%>
<%@ page import="com.temesoft.security.Config"%> 
<html>
  <head>
    
<link href="<s:url value='/css/phokus/profile.css'/>" media="screen" rel="Stylesheet" type="text/css">
<link href="<s:url value='/css/style.css'/>" media="screen" rel="Stylesheet" type="text/css">
<script src="<s:url value='/Scripts/order.js'/>" type="text/javascript"></script>
  </head>
    <%Order order = (Order)session.getAttribute("order");
    Customer customer = (Customer) session.getAttribute("customer");;
      %>
   <body>
<%
		    Encrypter stringEncrypter = new Encrypter();
		    String randomLetters = new String("");
		    for (int i = 0; i < Config.getPropertyInt(Config.MAX_NUMBER); i++) {
		        randomLetters += (char) (65 + (Math.random() * 24));
		
		    }
		    randomLetters = randomLetters.replaceAll("I","X");
		    randomLetters = randomLetters.replaceAll("Q","Z");
		
		    String passlineNormal = randomLetters + "." + request.getSession().getId(); 
		    String passlineValueEncoded = stringEncrypter.encrypt(passlineNormal);
		    passlineValueEncoded  = Base64Coder.encode(passlineValueEncoded );  
		%>
		<s:div id="loginDiv" theme="ajax" executeScripts="true"  >
			<table width="80%" align="right" class="yellowborder">
				<tr>
					<td height="25px;" width="100%" background="../images/tabletopbg.gif"
						style="padding-top: 0px;"  >
						<strong><font color="#ffffff"> Edit Profile</font></strong>
					</td>
				</tr>
				<tr>
					<td width="100%" align="center" class="tdborder">
						<s:form id="lform" action="EditProfileAction" validate="true" >
<table  width="100%" style="vertical-align: top;"  >
<colgroup>
<col width="20%"/>
<col width="30%"/>
<col width="20%"/>
<col width="30%"/>
		</colgroup>	
							<tr colspan="4" height="20">
								 <td/>
								<td>
									<s:actionerror />
									<s:fielderror />
								</td>
							</tr>
							<tr colspan="4">
							<td/>
								<td class="form_label_td">
									First Name:<font color="red">*</font>
								</td>
								<td valign="top">
									<table>
										<s:textfield id="firstName" name="firstName" size="20" cssStyle="font-size: 10px; height: 1.75em;"></s:textfield>
									</table>
								</td>
								<td id="id_firstName" class="form_label_td_error"></td>
							</tr>


							<tr colspan="4">
							 <td/>
								<td class="form_label_td">
									Last Name:<font color="red">*</font>
								</td>
								<td>
									<table>
										<s:textfield id="lastName" name="lastName" size="20" cssStyle="font-size: 10px; height: 1.75em;">
										</s:textfield>
									</table>
								</td>
								<td id="id_lastName"  class="form_label_td_error"></td>
							</tr>

							<tr colspan="4">
							<td/> 
								<td class="form_label_td">
									Phone Number:<font color="red">*</font>
								</td>
								<td>
									<table>
										<s:textfield id="phoneNumber" name="phoneNumber" size="20" maxlength="12" cssStyle="font-size: 10px; height: 1.75em;"
											onkeypress="return onlyNumbers(event)">
										</s:textfield>
									</table>
								</td>
								<td id="id_phoneNumber"  class="form_label_td_error"></td>
							</tr>
							<tr colspan="4">
							 <td/>
								<td class="form_label_td">
									Password:<font color="red">*</font>
								</td>
								<td>
									<table>
										<s:password id="password" name="password" value="" size="25" cssStyle="font-size: 10px; height: 1.75em;"></s:password>
									</table>
								</td>
								<td  id="id_password"  class="form_label_td_error"></td>
							</tr>


					
						
									<tr colspan="4">
								<td/> 
								<td class="form_label_td">
									Confirm Password:<font color="red">*</font>
								</td>
								<td>
									<table>
										<s:password id="confirmPassword" name="confirmPassword" value="" size="25" cssStyle="font-size: 10px; height: 1.75em;"></s:password>
									</table>
								</td>
								<td id="id_confirmPassword"  class="form_label_td_error"></td>
							</tr>

												<tr colspan="4">
							 <td/>

								<td class="form_label_td">
									Password Hint:<font color="red">*</font>
								</td>
								<td>
									<table>
										<s:select id="passwordHint" name="passwordHint" size="1" cssStyle="font-size: 10px; height: 1.75em;"
											list="#{'':'','mothersMaidenName': 'What is your mother maiden name?','colorOfFirstCar': 'What was the color of your first car?','childhoodNickName': 'What was your childhood nickname?','childhoodToy': 'What was your favorite childhood toy?','childhoodGame': 'What was your favorite childhood game?','favouriteSchoolTeacher': 'What was your favorite schoolteacher name?','favouriteSubject': 'What was your favorite subject at school?','firstPetName': 'What was your first pet name?'}">
										</s:select>

									</table>
								</td>
								<td id="id_passwordHint"  class="form_label_td_error"></td>
							</tr>

													<tr colspan="4">
							 <td/> 

								<td class="form_label_td">
									Password Hint Answer:<font color="red">*</font>
								</td>
								<td>
									<table>
										<s:textfield id="passwordHintAnswer" name="passwordHintAnswer" value="" size="20" cssStyle="font-size: 10px; height: 1.75em;"></s:textfield>
									</table>
								</td>
								<td id="id_passwordHintAnswer"  class="form_label_td_error"></td>
							</tr>


													<tr colspan="4">
							<td/>
								<td class="form_label_td">
									Address:
								</td>
								<td>
									<table>
										<s:textfield id="address" name="address" size="20" maxLength="30" cssStyle="font-size: 10px; height: 1.75em;">
										</s:textfield>
									</table>
								</td>
								<td id="id_address"  class="form_label_td_error"></td>
							</tr>

														<tr colspan="4">
							 <td/> 
								<td class="form_label_td">
									City:
								</td>
								<td>
									<table>
										<s:textfield id="city" name="city" size="20" cssStyle="font-size: 10px; height: 1.75em;">
										</s:textfield>
									</table>
								</td>
								<td id="id_city"  class="form_label_td_error"></td>
							</tr>

														<tr colspan="4">
							<td/> 
								<td class="form_label_td">
									State:
								</td>
								<td>
									<table>
										<s:textfield id="state" name="state" size="20" cssStyle="font-size: 10px; height: 1.75em;">
										</s:textfield>
									</table>
								</td>
								<td id="id_state"  class="form_label_td_error"></td>
							</tr>

														<tr colspan="4">
							<td/> 
								<td class="form_label_td">
									Zip Code:
								</td>
								<td>
									<table>
										<s:textfield id="zipCode" name="zipCode" size="20" maxlength="5"
											onkeypress="return onlyNumbers(event)" cssStyle="font-size: 10px; height: 1.75em;">
										</s:textfield>
									</table>
								</td>
								<td id="id_zipCode"  class="form_label_td_error"></td>
							</tr>
							<tr colspan="4">
								 <td/>
							   <td class="form_label_td">Security Code:<font color="red">*</font></td>
							   <td><table>
								<s:textfield id="passline" name="passline"  size="20" cssStyle="font-size: 10px; height: 1.75em;"/>
							   </table></td>
							   <td id="id_passline" class="form_label_td_error"></td>
							   </tr>  
							   <tr colspan="4">
								  		 <td/>
							   			<td class="form_label_td"></td>
							   			<td><table>
										<img src="../PassImageServlet/<%=passlineValueEncoded %>" border="0" height="30" height="30" >
							   			</table></td>
							   			<td id="id_passline" class="form_label_td_error"></td>
							   </tr>  
								
								 <input type="hidden" name="passlineEnc" value="<%=passlineValueEncoded %>" >
							
									<table align="center">
										<tr>
											<td>
												<table>
													<s:submit value="Update" theme="ajax" targets="loginDiv1" 
														notifyTopics="" executeScripts="true" cssClass="buttoncss" />
												</table>
											</td> 
											<td>
												<table>
													<s:submit action="CancelPage" value="Cancel"
														onclick="form.onsubmit=null" cssClass="buttoncss" />
												</table>
											</td>
										</tr>
									</table>
							
		


</table>
			</s:form>
			</td>
			</tr>
			</table>
		</s:div>

		<s:div id="loginDiv1" theme="ajax" cssStyle="height:0px;top:-20px;">
		</s:div>

	</body>
<script>
	document.getElementById("firstName").value ="<%=customer.getFirstName()%>";
	document.getElementById("lastName").value = "<%=customer.getLastName()%>";
	document.getElementById("phoneNumber").value = "<%=customer.getPhoneNumber()%>";
	document.getElementById("address").value ="<%=customer.getAddress().getAddress()%>";
	document.getElementById("city").value = "<%=customer.getAddress().getCity()%>";
	document.getElementById("state").value ="<%=customer.getAddress().getState()%>";
	document.getElementById("zipCode").value ="<%=customer.getAddress().getZipCode()%>";
	
</script>
<script>

var arr = new Array(20);
var count = 0;

function clearErrorMessages(form) {
	
	for(i=0; i < count;++i){
		arr[i].innerHTML = "";
	}
}

function clearErrorLabels(form) {
    // set all labels back to the normal class
    var elements = form.elements;
    for (var i = 0; i < elements.length; i++) {
        var e = elements[i];
        var cells = e.parentNode.parentNode.cells;
        if (cells && cells.length >= 2) {
            var label = cells[0].getElementsByTagName("label")[0];
            if (label) {
                label.setAttribute("class", "label");
                label.setAttribute("className", "label"); //ie hack cause ie does not support setAttribute
            }
        }
    }

}

function addError(e, errorText) {
    try {

        // clear out any rows with an "errorFor" of e.id
        var row = e.parentNode.parentNode;

        var td_td = document.getElementById("id_" + e.id);
        
        document.getElementById("id_" + e.id).innerHTML = "<font  color=red  style='font-family: sans-serif;font-size: 11px'> " + errorText + "</font>";
        
        arr[count++] = td_td;
        td_td.width=20;
        td_td.align="Justify";
        //var table = row.parentNode;
        //var error = document.createTextNode(errorText);
        //var tr = document.createElement("tr");
        var td = document.createElement("td");
        
        //var span = document.createElement("span");
        //td.align = "left";
        //td.valign = "top";
        //td.colSpan = 2;
        //span.setAttribute("class", "errorMessage");
        //span.setAttribute("className", "errorMessage"); //ie hack cause ie does not support setAttribute
        //span.appendChild(error);
        
        //td.appendChild();

        //tr.appendChild(td);
        //tr.setAttribute("errorFor", e.id);
        //table.insertBefore(tr, row);
		//td.innerText = errorText;
        //row.appendChild(td);
        
        //document.all["FirstName"].innerHTML="<font color='red'>FN</font>";
        // updat the label too
        //var label = row.cells[0].getElementsByTagName("label")[0];
        //label.setAttribute("class", "tdLabel");
        //label.setAttribute("className", "tdLabel"); //ie hack cause ie does not support setAttribute
    } catch (e) {
        //alert(e);
    }
}
</script>
</html>