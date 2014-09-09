<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="com.temesoft.security.Base64Coder"%>
<%@ page import="com.temesoft.security.Encrypter"%>
<%@ page import="com.temesoft.security.Config"%> 
<%@ page import="java.awt.*"%>

<html>
  <head>
     <style type="text/css">
	 .jawa{}
	  </style>  
    <link href="<s:url value='/css/style.css'/>" rel="stylesheet" type="text/css"/>
	<script src="<s:url value='/Scripts/order.js'/>" type="text/javascript"></script>
	<script src="<s:url value='/struts/xhtml/validation.js'/>" type="text/javascript"></script>	
	<script src="<s:url value='/Scripts/flexcroll.js'/>" type="text/javascript"></script>
  </head>
   <body style="height: 100%;"> 
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
	 <s:div id="loginDiv"  theme="ajax" executeScripts="true" cssClass="divborder">
			
			<table align="center" width="60%"  class="yellowborder" cellspacing="0" cellpadding="0">
				<tr><td  width="100%" height="25px;" background="../images/tabletopbg.gif" style="padding-top:0px;" valign="center"><strong><font color="#ffffff">&nbsp;Create New Account</font></strong></td></tr>
			
				<tr>
					<td width="100%" align="center" class="tdborder">
	 					<s:form  action="doRegister" validate="true"  >
	 						<table align="center" width="100%" style="vertical-align: top;"  >
								<colgroup>
									<col width="20%"/>
									<col width="25%"/>
									<col width="30%"/>
									<col width="25%"/>
								</colgroup>	
						       <tr colspan="4">
						       		<td></td><!-- deleted <td/> -->
						       		<td class="form_label_td">First Name:<font color="red">*</font></td>
						       		<td>
						       			<table>
							   				<s:textfield name="firstName" value="" size="20" cssStyle="font-size: 10px; height: 1.75em;"></s:textfield>
							   			</table>
							   		</td>
							   		<td id="id_doRegister_firstName" class="form_label_td_error"></td>
							   </tr>  
							 
						       <tr colspan="4">
						       		<td></td><!-- deleted <td/> -->
						       		<td class="form_label_td">Last Name:<font color="red">*</font></td>
						       		<td>
						       			<table>
							   				<s:textfield name="lastName" value="" size="20" cssStyle="font-size: 10px; height: 1.75em;"></s:textfield> 
							   			</table>
							   		</td>
							   		<td id="id_doRegister_lastName" class="form_label_td_error"></td>
							   </tr>  
							   
							   	<tr colspan="4">
						       		<td></td><!-- deleted <td/> -->
							   		<td class="form_label_td">Phone Number:<font color="red">*</font></td>
							   		<td>
							   			<table>
							   				<s:textfield cssStyle="font-size: 10px; height: 1.75em;" name="phoneNumber" maxlength="12" onkeypress="return onlyNumbers(event)" value="" size="20"></s:textfield>
							   			</table>
							   		</td>
							   		<td id="id_doRegister_phoneNumber" class="form_label_td_error"></td>
							   </tr> 
							    
								<tr colspan="4"><td/><td/><td class="form_label_td">&nbsp;&nbsp;Ex: xxx-xxx-xxxx</td><td/></tr>  
							    <!-- <tr><td width="50%">&nbsp;</td></tr>
							   
							  <tr><td class="heading" align="left"><h1>2.Give an ID and select Password....</h1> </td></tr> -->
							   
							   <tr colspan="4">
						       		<td></td><!-- deleted <td/> -->
						       		<td class="form_label_td">Email:<font color="red">*</font></td>
						       		<td>
						       			<table>
							   				<s:textfield name="email" value="" size="20" cssStyle="font-size: 10px; height: 1.75em;"></s:textfield>  
							   			</table>
							   		</td>
							   		<td id="id_doRegister_email" class="form_label_td_error"></td>
							   </tr>  
							   
						       <tr colspan="4">
						       		<td></td><!-- deleted <td/> -->
						       		<td class="form_label_td">Password:<font color="red">*</font></td>
						       		<td>
						       			<table>
							   				<s:password name="password" value="" size="25" cssStyle="font-size: 10px; height: 1.75em;"> </s:password> 
							   			</table>
							   		</td>
							   		<td style="width: 30%;" id="id_doRegister_password" class="form_label_td_error"></td>
							   </tr>  
							 
						       <tr colspan="4">
						       		<td/><td class="form_label_td">Confirm Password:<font color="red">*</font></td>
						       		<td>
						       			<table>
											<s:password name="confirmPassword" value="" size="25" cssStyle="font-size: 10px; height: 1.75em;"></s:password>
							   			</table>
							   		</td>
							   		<td id="id_doRegister_confirmPassword" class="form_label_td_error"></td>
							   </tr>  
							
						       <tr colspan="4">
						       		<td></td><!-- deleted <td/> -->
						       		<td class="form_label_td">Password Hint:<font color="red">*</font></td>
						       		<td>
						       			<table>
							   				<s:select name="passwordHint" cssStyle="font-size: 10px; height: 1.75em;" size="1" list="#{'':'','mothersMaidenName': 'What is your mother maiden name?','colorOfFirstCar': 'What was the color of your first car?','childhoodNickName': 'What was your childhood nickname?','childhoodToy': 'What was your favorite childhood toy?','childhoodGame': 'What was your favorite childhood game?','favouriteSchoolTeacher': 'What was your favorite schoolteacher name?','favouriteSubject': 'What was your favorite subject at school?','firstPetName': 'What was your first pet name?'}"> </s:select>
							   			</table>
							   		</td>
							   		<td id="id_doRegister_passwordHint" class="form_label_td_error"></td>
							   </tr>  
								
						       <tr colspan="4">
						       		<td></td><!-- deleted <td/> -->
						       		<td class="form_label_td">Password Hint Answer:<font color="red">*</font></td>
						       		<td>
						       			<table>
											<s:textfield name="passwordHintAnswer" value="" size="20" cssStyle="font-size: 10px; height: 1.75em;"></s:textfield>
							   			</table>
							   		</td>
							   		<td id="id_doRegister_passwordHintAnswer" class="form_label_td_error"></td>
							   </tr>
							 
						       <tr colspan="4">
						       		<td></td><!-- deleted <td/> -->
						       		<td class="form_label_td">Address:</td>
						       		<td>
						       			<table>
							   				<s:textfield name="address" value="" cssStyle="font-size: 10px; height: 1.75em;" ></s:textfield> 
							   			</table>
							   		</td>
							   		<td id="id_doRegister_address" class="form_label_td_error"></td>
							   </tr>  
						       
						       <tr colspan="4">
						       		<td></td><!-- deleted <td/> -->
						       		<td class="form_label_td">City:</td>
						       		<td>
						       			<table>
						       				<s:textfield name="city" value="" size="20" cssStyle="font-size: 10px; height: 1.75em;"></s:textfield>  
							   			</table>
							   		</td>
							   		<td id="id_doRegister_city" class="form_label_td_error"></td>
							   </tr>  
							 
						       <tr colspan="4">
						       		<td></td><!-- deleted <td/> -->
						       		<td class="form_label_td">State:</td>
						       		<td>
						       			<table>
							  				<s:select name="state" size="1" list="#{'CO': 'CO'}" cssStyle="font-size: 10px; height: 1.75em;"> </s:select>						 
						   				</table>
						   			</td>
							   		<td id="id_doRegister_state" class="form_label_td_error"></td>
							   </tr>  
								
						       <tr colspan="4">
						       		<td></td><!-- deleted <td/> -->
						       		<td class="form_label_td">Zip Code:</td>
						       		<td>
						       			<table>
							   				<s:textfield name="zipCode" cssStyle="font-size: 10px; height: 1.75em;" maxlength="5"  onkeypress="return onlyNumbers(event)" value="80918" size="15"></s:textfield> 
							   			</table>
							   		</td>
							   		<td id="id_doRegister_zipCode" class="form_label_td_error"></td>
							   </tr>  
							   
							   <!-- <s:select name="roles" label="Role" multiple="true" size="3" list="#{'ADMIN' : 'Administrator','RESTAURANT_OWNER': 'Restaurant Owner','GUEST': 'Guest'}"></s:select>-->
							   
							   
						       <tr colspan="4">
						       		<td></td><!-- deleted <td/> -->
						   			<td class="form_label_td">Security Code:<font color="red">*</font></td>
							   		<td>
							   			<table>
											<s:textfield name="passline"  size="20" cssStyle="font-size: 10px; height: 1.75em;"/>
							   			</table>
							   		</td>
							   		<td id="id_doRegister_passline" class="form_label_td_error"></td>
							   </tr>  
					
						       <tr colspan="4">
						       		<td/>
						   			<td class="form_label_td"></td>
							   		<td>
							   			<table>
											<img src="../PassImageServlet/<%=passlineValueEncoded %>" border="0" height="30" height="30" >
									   </table>
									</td>
							   		<td id="id_doRegister_passline" class="form_label_td_error"></td>
							   </tr>  
								
								 <input type="hidden" name="passlineEnc" value="<%=passlineValueEncoded %>" >
								 <table>
									 <tr>
										 <td></td><!-- deleted <td/> -->
										 <td align="left">
											 <s:textarea cols="60" cssClass="form_label_td" rows="10" value="                   Terms and Conditions    
											 Access to and use of this website is provided on the following basis:
			
			By using this website you agree to be legally bound by these terms, which shall take effect immediately on your first use of the website If you do not agree to be legally bound by all the following terms please do not access and/or use this website. 
			We may change these terms at any time by posting changes online. Please review these terms regularly to ensure you are aware of any changes made. 
			You may not copy, reproduce, republish, download, post, broadcast, transmit, make available to the public, or otherwise use content in any way except for your own personal, non-commercial use. You also agree not to adapt, alter or create a derivative work from any content except for your own personal, non-commercial use. Any other use of content requires our prior written permission. 
			You agree to use this website only for lawful purposes, and in a way that does not infringe the rights of, restrict or inhibit anyone else's use and enjoyment. 
			Our content, including the information, names, images, pictures, logos and icons regarding or relating to our products and services is provided 'AS IS' and on an 'IS AVAILABLE' basis without any representations or any kind of warranty made (whether express or implied by law) to the extent permitted by law, including the implied warranties of satisfactory quality, fitness for a particular purpose, non-infringement, compatibility, security and accuracy. 
			Under no circumstances will we be liable for any of the following losses or damage (whether such losses where foreseen, foreseeable, known or otherwise): (a) loss of data; (b) loss of revenue or anticipated profits; (c) loss of business; (d) loss of opportunity; (e) loss of goodwill or injury to reputation; (f) losses suffered by third parties; or (g) any indirect, consequential, special or exemplary damages arising from the use of this website regardless of the form of action. 
			We do not warrant that functions contained in this website, content will be uninterrupted or error free, that defects will be corrected, or that we or the server that makes it available are free of viruses or bugs. 
			The names, images and logos identifying the this website and products and services are subject to copyright, design rights and trade marks. Nothing contained in these terms shall be construed as conferring by implication or otherwise any licence or right to use any trademark, patent, design right or copyright. 
			Where you are invited to submit any contribution (including any text, photographs or graphics) you agree, by submitting your contribution, to grant us a perpetual, royalty-free, non-exclusive, sub-licenseable right and license to use, reproduce, modify, adapt, publish, translate, create derivative works from, distribute, perform, play, make available to the public, and exercise all copyright and publicity rights with respect to your contribution worldwide and/or to incorporate your contribution in other works in any media now known or later developed for the full term of any rights that may exist in your contribution, and in accordance with privacy restrictions set out in the Privacy Policy. 
			If you do not want to grant to us the rights set out above, please do not submit your contribution.">
											 </s:textarea>
									 
							 			</td>
								 		<td></td><!-- deleted <td/> -->
								 		<td></td><!-- deleted <td/> -->
							 		</tr>
								 </table>
								 
								 <table><tr><td></td><td align="left" class="form_label_td"><input type="checkbox" id="termsCheck" onClick="onTerms();" name="checkBox"/>I agree to the above terms and conditions.</td><td></td><td/></tr></table>	
								 <table align="center">
									<tr>
										<td>
											<table>
												<s:submit id="registerBtn" value="Register" theme="ajax"  targets="loginDiv1"  notifyTopics=""  executeScripts="true" />
											</table>
										</td>
										<td align="right">
											<table>
												<s:submit id="cancelBtn" action="CancelPage"  value="Cancel" onclick="form.onsubmit=null" cssClass="buttoncss"/>
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

	<table align="center" width="100%">
		<tr>
			<td>
	  			<s:div id="loginDiv1" theme="ajax" cssStyle="height:0px;top:-20px;">
	   			</s:div>
	   		</td>
	   	</tr>
	</table>
</body>
<script>
onTerms();
	function onTerms()
	{
		if(document.getElementById("termsCheck").checked == false)
		{
			document.getElementById("registerBtn").className="jawa";
			document.getElementById("registerBtn").disabled ="disabled";
			//document.getElementById("cancelBtn").className="jawa";
			//document.getElementById("cancelBtn").disabled ="disabled";
			
		}
		else if(document.getElementById("termsCheck").checked == true)
		{
			document.getElementById("registerBtn").className="buttoncss";
			document.getElementById("registerBtn").disabled =false;
			//document.getElementById("cancelBtn").className="buttoncss";
			//document.getElementById("cancelBtn").disabled =false;
			
		}
	}
	
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
        
        document.getElementById("id_" + e.id).innerHTML = "<font color=red>" + errorText + "</font>";
        
        arr[count++] = td_td;

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