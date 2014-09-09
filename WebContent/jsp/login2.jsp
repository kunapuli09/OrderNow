<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
  <head>
    <link href="<s:url value='/css/phokus/orderCancel.css'/>" rel="stylesheet" type="text/css"/>
  </head>
  <body>
    <s:div id="loginDiv1" theme="ajax">
    </s:div>
    
    <s:div id="loginDiv" theme="ajax">
    <div class="lgin2div">
      <s:form action="loginAction"  validate="true" method="GET"> 
        <tr>
          <td colspan="2">
            Login
          </td>
        </tr>
        <tr>
          <td colspan="2">
            <s:actionerror />
            <s:fielderror />
          </td>  
          <s:textfield name="username" label="Login name"/>
          <s:password name="password" label="Password"/>
          <s:submit value="Submit" theme="ajax" targets="loginDiv1" 
 notifyTopics="/ajaxloginCancel"/>
          <s:submit action="showAjaxLoginCancelForm" value="Cancel" onclick="form.onsubmit=null" cssClass="buttoncss"/>
          
      </s:form>
    </div>
    </s:div>
  </body>
</html> 