
<%@page import="com.starpath.order.domain.Category"%>
<%@page import="com.starpath.order.domain.CategorizedItem"%>
<%@page import="com.starpath.order.domain.Item"%>
<%@page import="com.starpath.order.domain.Price"%>
<%@page import="java.util.*"%>


<link href="../css/style.css" 	rel="Stylesheet" type="text/css">
<link href="../css/flexcrollstyles.css"	rel="Stylesheet" type="text/css">
<link href="../css/tutorsty.css" 	rel="Stylesheet" type="text/css">
<script src="../Scripts/wz_tooltip.js" type="text/javascript"></script>
<script src="../Scripts/flexcroll.js" type="text/javascript"></script>
<script>
function moretool(text)
{
	Tip(text, FONTSIZE, '10px', HEIGHT, 80, WIDTH, 350, TITLE, 'ItemDescription', CLOSEBTN, true, STICKY, true);
	
}
</script>
	<script>
	
		function getShoppingCartPage(index,url)
	{
		//alert("test");
		var quantityTxtId="quantitytxt"+index;
		
		var quantity=document.getElementById(quantityTxtId).value;
		
		if(quantity > 0){
			url=url+"&quantity="+quantity;
			new Ajax.Updater('mealorder',''+url, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
			
			document.getElementById("mealorder").click();
		}else
			alert("Enter non zero value");
	}
	function onlyNumbers(e)
	{
		var keynum;
		var keychar;
		var numcheck;

		if(window.event) // IE
		  {
		  keynum = e.keyCode; 
		  }
		else if(e.which) // Netscape/Firefox/Opera
		  {
		  keynum = e.which;
		  }
		 if(keynum){
			if(keynum==45 || keynum == 8)
				return true;
			else{
			keychar = String.fromCharCode(keynum);
			numcheck = /\d/;
			return numcheck.test(keychar);
			}
		 }else
			 return true;
	}
	
</script>
<style type="text/css">

#apDiv3 {
position:absolute;
z-index:1;
float:left;

}

</style>


<script type="text/javascript">
// <![CDATA[
var glbInc, glbDec;

function decreaseSizeImage(count) // will get back to its normal default size
{
	
//if(glbInc != null) {clearTimeout(glbInc); glbInc = null;};
if (document.getElementById("image"+count).height > 70)
{
document.getElementById("image"+count).height -= 100;
document.getElementById("image"+count).width -= 100;
if(document.all)
	document.getElementById("image"+count).style.position="absolute"; 

count =count+1;
if(document.getElementById("image"+count)){

	document.getElementById("image"+count).height = 35;
	document.getElementById("image"+count).width = 35;
	document.getElementById("image"+count).style.zIndex=20;
	if(document.all)
	document.getElementById("image"+count).style.position="absolute"; 

	
	}
//glbDec = setTimeout("decreaseSizeImage()", 0);
};
}

function increaseSizeImage(count)
{
	
//if(glbDec != null) {clearTimeout(glbDec); glbDec = null;};
if (document.getElementById("image"+count).height < 50)
{

document.getElementById("image"+count).height += 100;
document.getElementById("image"+count).width += 100;
document.getElementById("image"+count).style.zIndex=20;
if(document.all)
	document.getElementById("image"+count).style.position="absolute"; 
count =count+1;
if(document.getElementById("image"+count)){
	document.getElementById("image"+count).height = 0;
	document.getElementById("image"+count).width = 0;
	document.getElementById("image"+count).style.zIndex=20;
if(document.all)
	document.getElementById("image"+count).style.position="absolute"; 
}
//glbInc = setTimeout("increaseSizeImage()", 0);
};
}
// ]]>
</script>
<table width="80%" border="0" cellpadding="0" cellspacing="0" class="yellowborder">
	<tr>
		<td align="left" valign="top">
		<div id='mycustomscroll2' class='flexcroll'>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="65" align="left" class="tabletitle">Image</td>
						<td align="left" class="tabletitle">Item Name</td>
						<td width="75" align="left" class="tabletitle">Price</td>
						<td width="80" align="left" class="tabletitle">Quantity</td>
						<td width="45" align="left" class="tabletitle">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
			<%  
			List<Category> categoryList1=(List<Category>)session.getAttribute("categoryList");
			int itemIndex=0;
			if(request.getParameter("itemIndex")!=null)
			   itemIndex=Integer.parseInt(request.getParameter("itemIndex"));
			
			Set<CategorizedItem> categorizedItemSet=categoryList1.get(itemIndex).getCategorizedItems();
			int count=0;
			int x = 0;
			%>
			<%
							for(CategorizedItem catItem : categorizedItemSet)
							{
							Item i = catItem.getItem();
							if(!(i.getState().name().equals("ACTIVE"))){
								continue;
							}
							Price price = i.getItemPrice();
							//log.debug(price.getCurrency().getCurrencyCode() + price.getValue());
							count++;
							Collection<String> imagesCollection=i.getImages();
							Object[] imagearray=imagesCollection.toArray();
							 for (int j = 0; j < imagearray.length; j++)
        					 {
								 
       						 }		
				%>
			<tr>
				<td align="left" valign="top" class="cellone">
				<table  border="0" cellspacing="5" cellpadding="0">
					<tr>
						<td class="yourmeals_border_td" id="apDiv3">
							<a href="#" onmouseover="increaseSizeImage(<%=count%>);" onmouseout="decreaseSizeImage(<%=count%>);" >
								<img src="../<%=imagearray[0].toString() %>" alt="samosa" width="35" height="35" id="image<%=count%>" style="position:absolute;"/>
							</a>
						</td>
						<td align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td  width="300px" class="yourmeals_border_td"><span class="itemname" ><%=i.getName() %></span><br />
						<%=i.getDescription()%><br />
						<a onclick='moretool("<%=i.getDescription()%>");' ><img src="../images/more.gif"/></a>
						</td>
						<td width="80" align="center" class="yourmeals_border_td"><%=i.getItemPrice().getCurrency()%>&nbsp;<%=i.getItemPrice().getValue().floatValue() %></td>
						<td width="70" align="center" class="yourmeals_border_td"><input type="text"
							class="quantity" id="quantitytxt<%=count%>" maxlength="2"
							value="1" size="2" onKeyPress="return onlyNumbers(event)" /></td>
						<td width="35" align="center" class="yourmeals_border_td"><input name="button"
							type="submit" class="addbutton" id="item<%=count%>"
							onclick='getShoppingCartPage(""+<%=count %>,"addOrder.action?itemId="+<%=i.getId()%>);'
							value="Add" /></td>
					</tr>
				</table>
				</td>
			</tr>

			
							<%
								}
							%>
		</table>
		</div>
		</td>
	</tr>
</table>