
<%@ page contentType="text/html;charset=UTF-8" language="java"  %> 

<%@ page import="com.opensymphony.xwork2.ActionContext" %>
<%@ page import="java.util.Map" %>

<%@page import="com.starpath.order.domain.Customer" %>
<%@page import="com.starpath.order.domain.Order" %>
<%@page import="com.starpath.order.domain.Category" %>
<%@page import="com.starpath.order.domain.CategorizedItem"%>
<%@page import="com.starpath.order.domain.Item"%>
<%@page import="com.starpath.order.domain.Price"%>
<%@page import="com.starpath.order.domain.*"%>

<%@page import="java.util.*" %> 
<%@page  import="com.starpath.order.domain.UserPrivilege"%>

<%-- JSTL tag libs --%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tlds/fmt.tld" %>

<%@ taglib prefix="s" uri="/WEB-INF/tlds/struts-tags.tld" %>





<link href="<s:url value="/css/style.css"/>" media="screen"
	rel="Stylesheet" type="text/css">

<link href="<s:url value="/css/tutorsty.css"/>" media="screen"
	rel="Stylesheet" type="text/css">
<script src="<s:url value="/Scripts/rico.js"/>" type="text/javascript"></script>
<script src="<s:url value="/Scripts/flexcroll.js"/>" type="text/javascript"></script> 

<script type="text/javascript">
	function getRequestedPage(url) {
	new Ajax.Updater('left', '' + url, {
	asynchronous : true,
	evalScripts : true,
	parameters : 'id=' + encodeURIComponent("")
	});
	}
	function getItemsContainerPageContent1(url) {
		new Ajax.Updater('tabulardata', '' + url, {
		asynchronous : true,
		evalScripts : true,
		parameters : 'id=' + encodeURIComponent("")
		});
		}
	function getOrderPage(url) {
		new Ajax.Updater('body', '' + url, {
		asynchronous : true,
		evalScripts : true,
		parameters : 'id=' + encodeURIComponent("")
		});
		}
	function replaceBodyContent(url) {
		new Ajax.Updater('bodycontent', '' + url, {
		asynchronous : true,
		evalScripts : true,
		parameters : 'id=' + encodeURIComponent("")
		});
		}
	
	
	
</script>
<script type="text/javascript">
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
</script>
				<%
					Calendar calendar = Calendar.getInstance();
					String date = calendar.get(Calendar.DAY_OF_MONTH) + "/" + (calendar.get(Calendar.MONTH)+1 ) + "/" + calendar.get(Calendar.YEAR);
				 %>
				 <%
	Customer customer = null; 
	customer = (Customer)session.getAttribute("customer");
	String emailToken = "";    
	Set privilageset = null;	
	UserPrivilege privilage = null;	
	Iterator privilageIterator = null;
	String privilageStr = "";	
	CServices cServices = null;
	List<String> roles = new ArrayList<String>(3);
	if(customer!=null){		
		privilageset = customer.getRoles();		
		privilageIterator =  privilageset.iterator();	
		while(privilageIterator.hasNext()){
			UserPrivilege privilege = (UserPrivilege)privilageIterator.next();
			roles.add(privilege.getPrivilege());
		}
		cServices = (CServices)session.getAttribute("cServices");
	}
	/*if(session.getAttribute("emailToken")!=null)
	     emailToken=(String)session.getAttribute("emailToken");*/
	
%>
<div id="bodycontent">				 

    <div id="tabulardata">
    <jsp:include page="itemsContainer1.jsp"></jsp:include>
    </div>
    
</div>

 <script>
       
        parent.document.getElementById("ordernowbtn").style.display= "none";
        if(parent.document.getElementById("ordernowbg")){
                parent.document.getElementById("ordernowbg").id = "ordernowinnerbg";
                parent.document.getElementById("ordernowinnerbg").innerHTML = '<div id="leftblock"><span class="bold"><img src="../images/order_online.png" width="117" height="19"/></div><div id="todayspecial_inner">Farm fresh vegetables are available every Wednesday and Thursday!</div>';
        }
       
</script>
 
 
