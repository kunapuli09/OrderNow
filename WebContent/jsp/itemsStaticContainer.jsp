<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.starpath.order.domain.Category"%>
<%@page import="com.starpath.order.domain.CategorizedItem"%>
<%@page import="com.starpath.order.domain.Item"%>
<%@page import="com.starpath.order.domain.Price"%>
<%@page import="java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="<s:url value='/css/phokus/orderCancel.css'/>"
	rel="stylesheet" type="text/css" />
</head>
<body>
<table height="25px;" width="100%">
	<tr bgcolor="#afab98">
		<td background="../images/hashbar.png" style="padding-top: 5px;"
			valign="top"><strong>&nbsp;<a href="#"><font
			color="#000000">Main Menu </font></a></strong></td>
	</tr>
</table>
<div>&nbsp;<br>
&nbsp;<br>
&nbsp;<br>
</div>
<div id="itemheader0">

<div class="itemname" id="itemname0"><b>Item Name</b></div>
<div class="itemdesc" id="itemdesc0"><b>Description</b></div>
<div class="price" id="price0"><b>Price</b></div>
<div class="image" id="image0"><b>Image</b></div>

</div>

<%
List<Category> categoryList1 = (List<Category>) session
.getAttribute("categoryList");
for (Category category : categoryList1) {
Set<CategorizedItem> categorizedItemSet = category
	.getCategorizedItems();
int count = 0;
for (CategorizedItem catItem : categorizedItemSet) {
Item i = catItem.getItem();
Price price = i.getItemPrice();
count++;
Collection<String> imagesCollection = i.getImages();
Object[] imagearray = imagesCollection.toArray();
%>


<div  id="itemname" +<%=count%>><strong><%=i.getName()%>&nbsp;:</strong><br>
&nbsp;</div>
<div  id="itemdesc"+<%=count%> ><%=i.getDescription() %>
							<br>&nbsp;<br></div>
							
<div  id="price" +<%=count%>>
<%
	if (i.getItemPrice().getValue() != null) {
%>&nbsp;<%=i.getItemPrice().getCurrency()%>&nbsp;<%=i.getItemPrice().getValue().floatValue()%>
<%
	} else {
%>USD 0.00 <%
	}
%>
</div>
<div class="image" id="image<%=count%>"
	onMouseOver="zoomout(this);div<%=count%>.toggleFadeIn();"
	onMouseOut="zoomin(this);div<%=count%>.toggleFadeOut();"><img
	src="../<%=imagearray[0].toString()%>"
	style="width: 40px; height: 25px" /></div>
<div id="effect_object_<%=count%>" class="sizeMeImage"
	style="display: none; z-index: 25;"><img
	style='border: none; width: 200px; height: 200px;'
	src="../<%=imagearray[0].toString()%>"></div>


<%
	}
%>
<%
	}
%>


</body>

</html>