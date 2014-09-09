<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.starpath.order.domain.Category" %>
<%@page import="java.util.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">

<link href="<s:url value="/css/phokus/phokus.css"/>" media="screen" rel="Stylesheet" type="text/css">

<link href="<s:url value="/css/phokus/phokus-ie.css"/>" media="screen" rel="Stylesheet" type="text/css">

<link href="<s:url value="/css/phokus/phokus-ie7.css"/>" media="screen" rel="Stylesheet" type="text/css">

<link rel="stylesheet" href="<s:url value="/css/phokus/sample.css"/>" type="text/css"> 

<link href="<s:url value="/css/phokus/datepicker.css"/>" media="screen" rel="Stylesheet" type="text/css">


<script src="<s:url value="/Scripts/rico.js"/>" type="text/javascript"></script>

<script src="<s:url value="/Scripts/order.js"/>" type="text/javascript"></script>

<script src="<s:url value="/Scripts/menucontainer.js"/>" type="text/javascript"></script>

<script src="<s:url value="/Scripts/datepicker.js"/>" type="text/javascript"></script>
<script type='text/javascript'>
Rico.loadModule('Corner','Effect');
var EffectDemo,div1,div2,div3;
Rico.onLoad( function() {
  EffectDemo = Class.create();
  EffectDemo.prototype = {
    initialize: function(element) {
      this.animator = new Rico.Effect.Animator();
      this.element = $(element);
      this.startLeft = this.element.offsetLeft;
      this.startSize = this.element.offsetWidth;
	  this.startHeight=this.element.offsetHeight;
    },
	heightEffectStarted:false,
    sizeEffectStarted: false,
    positionEffectStarted: false,
    fadeEffectStarted: false,
    play: function(effect) {
      this.animator.play(effect, {steps:20, duration:700});
	  return;
    },
    togglePosition: function(){
      this.play(new Rico.Effect.Position(this.element, this.nextPosition(), null));
    },
    toggleSize: function(){
      this.play(new Rico.Effect.SizeAndPosition(this.element, null, this.nextHeight, this.nextSize(), null));
	 this.toggleHeight();
    },
    toggleSizeAndPosition: function(){
      this.play(new Rico.Effect.SizeAndPosition(this.element, this.nextPosition(), null, this.nextSize(), null ));
    },
	toggleHeight:function(){
	  this.play(new Rico.Effect.Height(this.element,this.nextHeight()));
	},
    togglePositionAndFade: function(){
      this.play(new Rico.Effect.SizeAndPositionFade(this.element, this.nextPosition(), null, null, null, this.nextFadeState() ));
    },
    toggleFadeIn: function(){
      this.play(new Rico.Effect.FadeIn(this.element));
    },
	toggleFadeOut: function(){
      this.play(new Rico.Effect.FadeOut(this.element));
    },
    nextPosition: function(){
      this.positionEffectStarted = !this.positionEffectStarted;
      return !this.positionEffectStarted ? this.startLeft : 520;
    },
    nextSize: function(){
      this.sizeEffectStarted = !this.sizeEffectStarted;
      return !this.sizeEffectStarted ? this.startSize : 300;
    },
	nextHeight: function(){
	  this.heightEffectStarted = !this.heightEffectStarted;
      return !this.heightEffectStarted ? this.startHeight : 300;
	},
    nextFadeState: function(){
      this.fadeEffectStarted = !this.fadeEffectStarted;
      return !this.fadeEffectStarted ? 1 : 0;
    }
  };
  Rico.Corner.round('effect_object_1', { useMoz: false });
  Rico.Corner.round('effect_object_2', { useMoz: false });
  Rico.Corner.round('effect_object_3', { useMoz: false });  
  Rico.Corner.round('effect_object_4', { useMoz: false });
  Rico.Corner.round('effect_object_5', { useMoz: false });
  Rico.Corner.round('effect_object_6', { useMoz: false });
   Rico.Corner.round('effect_object_7', { useMoz: false });
    // don't use native corner rounding in Gecko because animation leaves artifacts
  
  div1=new EffectDemo('effect_object_1');
  div2=new EffectDemo('effect_object_2');
  div3=new EffectDemo('effect_object_3');
  div4=new EffectDemo('effect_object_4');
  div5=new EffectDemo('effect_object_5');
  div6=new EffectDemo('effect_object_6');
  div7=new EffectDemo('effect_object_7');
  div8=new EffectDemo('effect_object_8');
  div9=new EffectDemo('effect_object_9');
  div10=new EffectDemo('effect_object_10');
  div11=new EffectDemo('effect_object_11');
  div12=new EffectDemo('effect_object_12');
  div13=new EffectDemo('effect_object_13');
  div14=new EffectDemo('effect_object_14');
  
});
</script>
<script type="text/javascript">
function zoomout(target)
{
var divid="effect_object_"+target.id.substr(5);
document.getElementById(divid).style.display="block";
//div1.toggleFade();

}
function zoomin(target)
{
var divid="effect_object_"+target.id.substr(5);
//alert(divid);
document.getElementById(divid).style.display="none";
//div1.toggleFade();

}
</script>

</head>
<body>

	<div id="sidebar1">
     	<div id="accordionExample">
        	<div class="panel">
		  		<div class="panelheader">
		  			<h3>Menu Details</h3>
		  		</div>
				<div class="panelContent">
            		<p>
            			<span ><a href="#example/js">Non-Veg Appetizers</a></span><br>
						<span><a href="#example/dhtml">Veg Appetizers</a></span><br>
						<span><a href="#example/flash-fx">Soups</a></span><br>
						<span><a href="#example/smooth">Chowmein & Chop Suey</a></span><br>
						<span ><a href="#example/rico">Noodles </a></span><br>
						<span ><a href="#example/easy">Malaysian Noodles</a></span><br>
						<span ><a href="#example/extend">Rice</a></span><br>
            	</p>
		  	 </div>
		 </div>
		<div align="center" id="resttimes">
		<font color="#ffffff">
		&nbsp;<br>
		<b>Restuarent Opening Times:</b><br>
		<table>
			<tr>
				<th colspan="3">&nbsp;
					
				</th>
			</tr>
			<tr>
				<th>
					Status :
				</th>
				<th>
					OPENED
				</th>
			</tr>
			<tr>
				<th colspan="3">&nbsp;
					
				</th>
			</tr>
			<tr>
				<td>&nbsp;
					
				</td>
				<td>
					<b>opening</b>
				</td>
				<td>
					<b>closing</b>
				</td>
			</tr>
			<tr>
				<th colspan="3">&nbsp;
					
				</th>
			</tr>
			<tr>
				<td>
					<b>MON</b>
				</td>
				<td>
					<b>11:00 </b>
				</td>
				<td>
					<b>23:00 </b>
				</td>
			</tr>
			<tr>
				<th colspan="3">&nbsp;
					
				</th>
			</tr>
			<tr>
				<td colspan="3">
					order on
					&nbsp;&nbsp;
					<input type="text" size="13" name="DDate">
					&nbsp;&nbsp;
					 <img src="images/calander.png" onclick="displayDatePicker('DDate', false, 'dmy', '/');" width="15" height="15">
				</td>
				
			</tr>
			<tr>
				<th colspan="3">&nbsp;
					
				</th>
			</tr>
		</table><br>
		<b>Restuarent Delivery Times:</b><br>
		<table>
			<tr>
				<th colspan="3">&nbsp;
					
				</th>
			</tr>
			<tr>
				<td>&nbsp;
					
				</td>
				<td>
					<b>opening</b>
				</td>
				<td>
					<b>closing</b>
				</td>
			</tr>
			<tr>
				<th colspan="3">&nbsp;
					
				</th>
			</tr>
			<tr>
				<td>
					<b>MON</b>
				</td>
				<td>
					<b>11:45</b>
				</td>
				<td>
					<b>23:45</b>
				</td>
			</tr>
			<tr>
				<th colspan="3">&nbsp;
					
				</th>
			</tr>
			<tr>
				<td colspan="3">
					order on
					&nbsp;&nbsp;
					<input type="text" size="13" name="ODate">
					&nbsp;&nbsp;
					<img src="images/calander.png" onclick="displayDatePicker('ODate', false, 'dmy', '/');" width="15" height="15">
				</td>
				
			</tr>
			<tr>
				<th colspan="3">&nbsp;
					
				</th>
			</tr>
		</table>		
		</font>
		</div>
	  </div>
    </div>
	
	<div id="main">
		<table><tr><td class="post" width="100%">
		
			<div class="post-content" id="post-caption" align="center">
			
					 <div id="itemscontainer" class="cornerSamples" style="height:100 px;">
	
						<div id="itemheader0" class="itemheader"  >
						
							<div class="itemname" id="itemname0" ><b>Item Name</b></div>
							<div class="itemdesc" id="itemdesc0" ><b>Description</b></div>
							<div class="price" id="price0"	><b>Price</b></div>
							<div class="image" id="image0"><b>Image</b></div>
							<div class="quantity" id="quantity0" ><b>Quantity</b></div>
							
						</div>
						
						
						<div id="itemheader1" class="itemheader" style="top:50px;height:70px;">
						
							<div class="itemname" id="itemname1" >Samosa<br> </div>
							<div class="itemdesc" id="itemdesc1" style="height:100%">
							Deep-fried triangular pastry filled with spicy potatoes  and  green peas; served with Cholay (2 pecies)<br>&nbsp;
							</div>
							<div class="price" id="price1">$4.49</div>
							<div class="image" id="image1" onMouseOver="div1.toggleFadeIn();zoomout(this)" onMouseOut="div1.toggleFadeOut();zoomin(this)" >
							<img src="images/pic1.jpg"  style="width:40px; height:25px"/></div>
							<div class="quantity" id="quantity1" >
							<input type="text" id="quantity1txt" maxlength="2" value="1" size="2"  align="middle"/></div>
							<div class="Layer1" id="button2"><input type="button" id="item1" value="add"/></div>
										   
						</div>
						
						<div id="itemheader2" class="itemheader" style="top:120px;height:70px;">
						
							<div class="itemname" id="itemname2" >Papri Chaat </div>
							<div class="itemdesc" id="itemdesc2">Papri (chips), garbanzo beans, potatoes, yogurt, chutneys  and  chaat spices</div>
							<div class="price" id="price2">$4.49</div>
							<div class="image" id="image2" onMouseOver="div2.toggleFadeIn();zoomout(this)" onMouseOut="div2.toggleFadeOut();zoomin(this)" >
								<img src="images/pic2.jpg"  style="width:40px; height:25px"/>
							</div>
							<div class="quantity" id="quantity2" >
								<input type="text" id="quantity1txt" maxlength="2" value="1" size="2"  align="middle"/>
							</div>
							<div class="Layer1" id="button2">
								<input type="button" id="item2" value="add"/>
							</div>
				   
						</div>
						
						<div id="itemheader3" class="itemheader" style="top:205px;height:70px;">
						
							<div class="itemname" id="itemname3" >Papri Chaat </div>
							<div class="itemdesc" id="itemdesc3">Papri (chips), garbanzo beans, potatoes, yogurt, chutneys  and  chaat spices</div>
							<div class="price" id="price3">$4.49</div>
							<div class="image" id="image3" onMouseOver="div3.toggleFadeIn();zoomout(this)" onMouseOut="div3.toggleFadeOut();zoomin(this)" >
							<img src="images/pic3.jpg"  style="width:40px; height:25px"/></div>
							<div class="quantity" id="quantity3" >
							<input type="text" id="quantity1txt" maxlength="2" value="1" size="2"  align="middle"/></div>
							<div class="Layer1" id="button3">
							<input type="button" id="item3" value="add"/></div>
				   
						</div>
						
						<div id="itemheader4" class="itemheader" style="top:280px;height:70px;">
							<div class="itemname" id="itemname4" >Papri Chaat </div>
							<div class="itemdesc" id="itemdesc4">Papri (chips), garbanzo beans, potatoes, yogurt, chutneys  and  chaat spices</div>
							<div class="price" id="price4">$4.49</div>
							<div class="image" id="image4" onMouseOver="div4.toggleFadeIn();zoomout(this)" onMouseOut="div4.toggleFadeOut();zoomin(this)" >
							<img src="images/pic4.jpg"  style="width:40px; height:25px"/></div>
							<div class="quantity" id="quantity4" >
							<input type="text" id="quantity1txt" maxlength="2" value="1" size="2"  align="middle"/></div>
							<div class="Layer1" id="button2">
							<input type="button" id="item4" value="add"/></div>
				   
						</div>
						
						<div id="itemheader5" class="itemheader" style="top:355px;height:70px;">
						
							<div class="itemname" id="itemname5" >Papri Chaat </div>
							<div class="itemdesc" id="itemdesc5">Papri (chips), garbanzo beans, potatoes, yogurt, chutneys  and  chaat spices</div>
							<div class="price" id="price5">$4.49</div>
							<div class="image" id="image5" onMouseOver="div5.toggleFadeIn();zoomout(this)" onMouseOut="div5.toggleFadeOut();zoomin(this)" >
							<img src="images/pic5.jpg"  style="width:40px; height:25px"/></div>
							<div class="quantity" id="quantity2" >
							<input type="text" id="quantity1txt" maxlength="2" value="1" size="2"  align="middle"/></div>
							<div class="Layer1" id="button5">
							<input type="button" id="item5" value="add"/></div>
				   
						</div>
						
						<div id="itemheader6" class="itemheader" style="top:430px;height:70px;">
						
							<div class="itemname" id="itemname6" >Papri Chaat </div>
							<div class="itemdesc" id="itemdesc6">Papri (chips), garbanzo beans, potatoes, yogurt, chutneys  and  chaat spices</div>
							<div class="price" id="price6">$4.49</div>
							<div class="image" id="image6" onMouseOver="div6.toggleFadeIn();zoomout(this)" onMouseOut="div6.toggleFadeOut();zoomin(this)" ><img src="images/pic2.jpg"  style="width:40px; height:25px"/></div>
							<div class="quantity" id="quantity6" >
							<input type="text" id="quantity1txt" maxlength="2" value="1" size="2"  align="middle"/></div>
							<div class="Layer1" id="button6">
							<input type="button" id="item6" value="add"/></div>
				   
						</div>
						
						<div id="itemheader7" class="itemheader" style="top:505px;height:70px;">
						
							<div class="itemname" id="itemname7" >Papri Chaat </div>
							<div class="itemdesc" id="itemdesc7">Papri (chips), garbanzo beans, potatoes, yogurt, chutneys  and  chaat spices</div>
							<div class="price" id="price7">$4.49</div>
							<div class="image" id="image7" onMouseOver="div7.toggleFadeIn();zoomout(this)" onMouseOut="div7.toggleFadeOut();zoomin(this)" ><img src="images/pic2.jpg"  style="width:40px; height:25px"/></div>
							<div class="quantity" id="quantity7" >
							<input type="text" id="quantity1txt" maxlength="2" value="1" size="2"  align="middle"/></div>
							<div class="Layer1" id="button7">
							<input type="button" id="item7" value="add"/></div>
				   
						</div>
						
						<div id="itemheader8" class="itemheader" style="top:580px;height:70px;">
						
							<div class="itemname" id="itemname8" >Papri Chaat </div>
							<div class="itemdesc" id="itemdesc8">Papri (chips), garbanzo beans, potatoes, yogurt, chutneys  and  chaat spices</div>
							<div class="price" id="price8">$4.49</div>
							<div class="image" id="image8" onMouseOver="div8.toggleFadeIn();zoomout(this)" onMouseOut="div8.toggleFadeOut();zoomin(this)" ><img src="images/pic2.jpg"  style="width:40px; height:25px"/></div>
							<div class="quantity" id="quantity8" >
							<input type="text" id="quantity1txt" maxlength="2" value="1" size="2"  align="middle"/></div>
							<div class="Layer1" id="button8">
							<input type="button" id="item8" value="add"/></div>
				   
						</div>
						
						<div id="itemheader9" class="itemheader" style="top:655px;height:70px;">
						
							<div class="itemname" id="itemname9" >Papri Chaat </div>
							<div class="itemdesc" id="itemdesc9">Papri (chips), garbanzo beans, potatoes, yogurt, chutneys  and  chaat spices</div>
							<div class="price" id="price9">$4.49</div>
							<div class="image" id="image9" onMouseOver="div9.toggleFadeIn();zoomout(this)" onMouseOut="div9.toggleFadeOut();zoomin(this)" ><img src="images/pic2.jpg"  style="width:40px; height:25px"/></div>
							<div class="quantity" id="quantity9" >
							<input type="text" id="quantity1txt" maxlength="2" value="1" size="2"  align="middle"/></div>
							<div class="Layer1" id="button9">
							<input type="button" id="item9" value="add"/></div>
				   
						</div>
						
						<div id="itemheader10" class="itemheader" style="top:730px;height:70px;">
						
							<div class="itemname" id="itemname10" >Papri Chaat </div>
							<div class="itemdesc" id="itemdesc10">Papri (chips), garbanzo beans, potatoes, yogurt, chutneys  and  chaat spices</div>
							<div class="price" id="price10">$4.49</div>
							<div class="image" id="image10" onMouseOver="div10.toggleFadeIn();zoomout(this)" onMouseOut="div10.toggleFadeOut();zoomin(this)" ><img src="images/pic2.jpg"  style="width:40px; height:25px"/></div>
							<div class="quantity" id="quantity10" >
							<input type="text" id="quantity1txt" maxlength="2" value="1" size="2"  align="middle"/></div>
							<div class="Layer1" id="button10">
							<input type="button" id="item10" value="add"/></div>
				   
						</div>
						
						<div id="itemheader11" class="itemheader" style="top:805px;height:70px;">
						
							<div class="itemname" id="itemname11" >Papri Chaat </div>
							<div class="itemdesc" id="itemdesc11">Papri (chips), garbanzo beans, potatoes, yogurt, chutneys  and  chaat spices</div>
							<div class="price" id="price11">$4.49</div>
							<div class="image" id="image11" onMouseOver="div11.toggleFadeIn();zoomout(this)" onMouseOut="div11.toggleFadeOut();zoomin(this)" ><img src="images/pic2.jpg"  style="width:40px; height:25px"/></div>
							<div class="quantity" id="quantity11" >
							<input type="text" id="quantity1txt" maxlength="2" value="1" size="2"  align="middle"/></div>
							<div class="Layer1" id="button11">
							<input type="button" id="item11" value="add"/></div>
				   
						</div>
						<div id="itemheader12" class="itemheader" style="top:880px;height:70px;">
						
							<div class="itemname" id="itemname12" >Papri Chaat </div>
							<div class="itemdesc" id="itemdesc12">Papri (chips), garbanzo beans, potatoes, yogurt, chutneys  and  chaat spices</div>
							<div class="price" id="price12">$4.49</div>
							<div class="image" id="image12" onMouseOver="div12.toggleFadeIn();zoomout(this)" onMouseOut="div12.toggleFadeOut();zoomin(this)" ><img src="images/pic2.jpg"  style="width:40px; height:25px"/></div>
							<div class="quantity" id="quantity12" >
							<input type="text" id="quantity1txt" maxlength="2" value="1" size="2"  align="middle"/></div>
							<div class="Layer1" id="button12">
							<input type="button" id="item12" value="add"/></div>
				   
						</div>
						<div id="itemheader13" class="itemheader" style="top:955px;height:70px;">
						
							<div class="itemname" id="itemname13" >Papri Chaat </div>
							<div class="itemdesc" id="itemdesc13">Papri (chips), garbanzo beans, potatoes, yogurt, chutneys  and  chaat spices</div>
							<div class="price" id="price13">$4.49</div>
							<div class="image" id="image13" onMouseOver="div13.toggleFadeIn();zoomout(this)" onMouseOut="div13.toggleFadeOut();zoomin(this)" ><img src="images/pic2.jpg"  style="width:40px; height:25px"/></div>
							<div class="quantity" id="quantity13" >
							<input type="text" id="quantity1txt" maxlength="2" value="1" size="2"  align="middle"/></div>
							<div class="Layer1" id="button13">
							<input type="button" id="item13" value="add"/></div>
				   
						</div>
						<div id="itemheader14" class="itemheader" style="top:1030px;height:70px;">
						
							<div class="itemname" id="itemname14" >Papri Chaat </div>
							<div class="itemdesc" id="itemdesc14">Papri (chips), garbanzo beans, potatoes, yogurt, chutneys  and  chaat spices</div>
							<div class="price" id="price14">$4.49</div>
							<div class="image" id="image14" onMouseOver="div14.toggleFadeIn();zoomout(this)" onMouseOut="div14.toggleFadeOut();zoomin(this)" ><img src="images/pic2.jpg"  style="width:40px; height:25px"/></div>
							<div class="quantity" id="quantity14" >
							<input type="text" id="quantity1txt" maxlength="2" value="1" size="2"  align="middle"/></div>
							<div class="Layer1" id="button14">
							<input type="button" id="item14" value="add"/></div>
				   
						</div>
						<div id="effect_object_1" class="sizeMe"  style="display:none; top:60px;">
						
  							 <div  style="background-color:red;">
							 	<img style='border:none; width:60%;height:60%;' src="images/pic1.jpg ">
							 </div>
							 
						</div>											
  							     
						<div id="effect_object_2" class="sizeMe" style="display:none;top:130px;" >
						
     						<div style="background-color:red;">
								<img style='border:none; width:60%;height:60%;' src="images/pic2.jpg ">
							</div>
							
   						</div>					

						<div id="effect_object_3" class="sizeMe" style="display:none;top:200px;" >
						
     						<div style="background-color:red;">
								<img style='border:none; width:60%;height:60%;' src="images/pic3.jpg "> 
							</div>
							
   						</div>	
								 		
						<div id="effect_object_4" class="sizeMe" style="display:none;top:270px;" >
						
     						<div style="background-color:red;">
								<img style='border:none; width:60%;height:60%;' src="images/pic4.jpg "> 
							</div>
							
   						</div>
								 			
						<div id="effect_object_5" class="sizeMe" style="display:none;top:340px;" >
						
     						<div style="background-color:red;">
								<img style='border:none; width:60%;height:60%;' src="images/pic5.jpg "> 
							</div>
							
   						</div>
						
						<div id="effect_object_6" class="sizeMe" style="display:none;top:410px;" >
						
     						<div style="background-color:red;">
								<img style='border:none; width:60%;height:60%;' src="images/pic2.jpg "> 
							</div>
							
   						</div>	
								 		
						<div id="effect_object_7" class="sizeMe" style="display:none;top:480px;" >
						
     						<div style="background-color:red;">
								<img style='border:none; width:60%;height:60%;' src="images/pic2.jpg "> 
							</div>
						
   						</div>
						
						<div id="effect_object_8" class="sizeMe"  style="display:none; top:550px;">
						
  							 <div  style="background-color:red;">
							 	<img style='border:none; width:60%;height:60%;' src="images/pic1.jpg ">
							 </div>
							 
						</div>		
						
						<div id="effect_object_9" class="sizeMe"  style="display:none; top:620px;">
						
  							 <div  style="background-color:red;">
							 	<img style='border:none; width:60%;height:60%;' src="images/pic1.jpg ">
							 </div>
							 
						</div>		
						
						<div id="effect_object_10" class="sizeMe"  style="display:none; top:690px;">
						
  							 <div  style="background-color:red;">
							 	<img style='border:none; width:60%;height:60%;' src="images/pic1.jpg ">
							 </div>
							 
						</div>		
						
						<div id="effect_object_11" class="sizeMe"  style="display:none; top:760px;">
						
  							 <div  style="background-color:red;">
							 	<img style='border:none; width:60%;height:60%;' src="images/pic1.jpg ">
							 </div>
							 
						</div>		
						
						<div id="effect_object_12" class="sizeMe"  style="display:none; top:830px;">
						
  							 <div  style="background-color:red;">
							 	<img style='border:none; width:60%;height:60%;' src="images/pic1.jpg ">
							 </div>
							 
						</div>		
						
						<div id="effect_object_13" class="sizeMe"  style="display:none; top:900px;">
						
  							 <div  style="background-color:red;">
							 	<img style='border:none; width:60%;height:60%;' src="images/pic1.jpg ">
							 </div>
							 
						</div>		
						
						<div id="effect_object_14" class="sizeMe"  style="display:none; top:1000px;">
						
  							 <div  style="background-color:red;">
							 	<img style='border:none; width:60%;height:60%;' src="images/pic1.jpg ">
							 </div>
							 
						</div>					
								 
				</div>
			</div>
			
		</td></tr></table>
		</div>
		<div id="sidebar">
     <div id="accordionExample">
        <div  class="panel">
            <div class="panelheader">
                <h3><font color="#ffffff">Shoping Cart</font></h3>
            </div>
            <div class="panelContent">
            		<p style="overflow:hidden; text-align:left;">
            			<span style="font-size:100.4285714285714%"><a href="#example/js"><font color="#ffffff">Item1 (5)  US$2.0</font></a></span><br>
            			<span style="font-size:100.4285714285714%"><a href="#example/js"><font color="#ffffff">Item2 (5)  US$2.0</font></a></span><br>
            			<span style="font-size:100.4285714285714%"><a href="#example/js"><font color="#ffffff">Item3 (5)  US$2.0</font></a></span><br>
            			<span style="font-size:100.4285714285714%"><a href="#example/js"><font color="#ffffff">Item4 (5)  US$2.0</font></a></span><br>
            			<span style="font-size:100.4285714285714%"><a href="#example/js"><font color="#ffffff">Item5 (5)  US$2.0</font></a></span><br>
            			<span style="font-size:100.4285714285714%"><a href="#example/js"><font color="#ffffff">Item6 (5)  US$2.0</font></a></span><br>
            			<span style="font-size:100.4285714285714%"><a href="#example/js"><font color="#ffffff">Item7 (5)  US$2.0</font></a></span><br>
            			<span style="font-size:100.4285714285714%"><a href="#example/js"><font color="#ffffff">Item8 (5)  US$2.0</font></a></span><br>
            			<span style="font-size:100.4285714285714%"><a href="#example/js"><font color="#ffffff">Item9 (5)  US$2.0</font></a></span><br>
            			<span style="font-size:100.4285714285714%"><a href="#example/js"><font color="#ffffff">Item10 (5)  US$2.0</font></a></span><br>
            			<span style="font-size:100.4285714285714%"><a href="#example/js"><font color="#ffffff">Item11 (5)  US$2.0</font></a></span><br>
            			<span style="font-size:100.4285714285714%"><a href="#example/js"><font color="#ffffff">Item12 (5)  US$2.0</font></a></span><br>
            			<span style="font-size:100.4285714285714%"><a href="#example/js"><font color="#ffffff">Item13 (5)  US$2.0</font></a></span><br>
            			<span style="font-size:100.4285714285714%"><a href="#example/js"><font color="#ffffff">Item14 (5)  US$2.0</font></a></span><br>
            			<span style="font-size:100.4285714285714%"><a href="#example/js"><font color="#ffffff">Item15 (5)  US$2.0</font></a></span><br>
            			<span style="font-size:100.4285714285714%"><a href="#example/js"><font color="#ffffff">Item16 (5)  US$2.0</font></a></span><br>
            	</p>
            </div>
        </div>
		<div class="panel">
          <div id="search" class="panelheader">
            <label for="q"><font color="#ffffff">Payment Types</font></label>
          </div>
          <div id="search-results" class="panelContent">
            <form action="/#example" id="sform" method="get">
             <div>
             <input type="text" id="q" name="qZ123" value="" size="15"><br>
			 <img src="images/visa.gif"> 
			 <img src="images/mastercard.gif">
			 <img src="images/amex.gif"> 
			 <img src="images/discover.gif"> <br>			 
             <span id="search_spinner" style="display:none"></span>
             </div>
            </form>
          </div>
		</div>
		<div class="panel">
		  <div class="panelheader">
		  	<h3><font color="#ffffff">Address Details</font></h3>
		  </div>
			<div style="display: none;"  class="panelContent">
               <font color="#ffffff">	Name :<br> <input type="text"></font><br>
				<font color="#ffffff">E-Mail :<br> <input type="text"></font><br>
				<font color="#ffffff">Address :<br> <textarea></textarea></font>
            </div>
		</div>
		<div class="panel">
		  <div class="panelheader">
             <h3><font color="#ffffff">Check Out</font></h3>
		  </div>
			<div class="panelContent">
            <ul>
                <li><font color="#ffffff">Articles</font></li>
                <li><a href="/xml/rss20/comments/feed.xml" title="Comments feed"><font color="#ffffff">Comments</font></a></li>
            </ul>
		  </div>
		</div>
		<div class="panel">
		  <div class="panelheader">
             <h3><font color="#ffffff">Special Notes</font></h3>
		  </div>
			<div class="panelContent">
            <ul>
                <li><font color="#ffffff">notes is applciable for whole order instead of by item</font></li>
            </ul>
		  </div>
		</div>
    </div>
  </div>  
	

</body>
</html>