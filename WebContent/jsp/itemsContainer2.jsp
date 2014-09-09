
<%@page import="com.starpath.order.domain.Category"%>
<%@page import="com.starpath.order.domain.CategorizedItem"%>
<%@page import="com.starpath.order.domain.Item"%>
<%@page import="com.starpath.order.domain.Price"%>
<%@page import="java.util.*"%>


<link href="../css/style.css" 	rel="Stylesheet" type="text/css">
<link href="../css/flexcrollstyles.css"	rel="Stylesheet" type="text/css">
<link href="../css/tutorsty.css" 	rel="Stylesheet" type="text/css">

<script src="../Scripts/flexcroll.js" type="text/javascript"></script>
<script>
function moretool(text)
{
	Tip(text, FONTSIZE, '10px', HEIGHT, 80, WIDTH, 350, TITLE, 'ItemDescription', CLOSEBTN, true, STICKY, true);
	
}
</script>
<style type="text/css">

#apDiv3 {
position:absolute;
z-index:1;
float:left;

}

</style>

<div id="">

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="">
	<tr>
		<td align=" center" valign="top">
		<div id='mycustomscroll3' class='flexcroll'>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="left" class="tabletitle">Item Name</td>
						<td width="75" align="left" class="tabletitle">Price</td>
						
					</tr>
				</table>
				</td>
			</tr>
			<%  
			List<Category> categoryList1=(List<Category>)session.getAttribute("categoryList");
			int size=categoryList1.size();
			for(int l=0; l<size; l++){
			
			Set<CategorizedItem> categorizedItemSet=categoryList1.get(l).getCategorizedItems();
			int count=0;
			int x = 0;
			%>
			<%
							for(CategorizedItem catItem : categorizedItemSet)
							{
							Item i = catItem.getItem();
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
						<td  width="550px" class="yourmeals_border_td"><span class="itemname" ><%=i.getName() %></span><br />
						<%=i.getDescription()%><br />
						</td>
						<td width="80" align="center" class="yourmeals_border_td"><%=i.getItemPrice().getCurrency()%>&nbsp;<%=i.getItemPrice().getValue().floatValue() %></td>
						
					</tr>
				</table>
				</td>
			</tr>

			
							<%
							}
								}
							%>
		</table>
		</div>
		</td>
	</tr>
</table>
</div>