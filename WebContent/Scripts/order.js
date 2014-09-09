function displaylogin()
{
document.getElementById("login").style.display="inline";
}

var ie = document.all;
var nn6 = document.getElementById &&! document.all;

var isdrag = false;
var x, y;
var dobj;

var orderCount = 0;

function movemouse( e ) {
  if( isdrag ) {
    dobj.style.left = nn6 ? tx + e.clientX - x : tx + event.clientX - x;
    dobj.style.top  = nn6 ? ty + e.clientY - y : ty + event.clientY - y;
    return false;
  }
}

function selectmouse( e ) {
  var fobj       = nn6 ? e.target : event.srcElement;
  var topelement = nn6 ? "HTML" : "BODY";

  while (fobj.tagName != topelement && fobj.className != "dragme") {
    fobj = nn6 ? fobj.parentNode : fobj.parentElement;
  }

  if (fobj.className=="dragme") {
    isdrag = true;
    dobj = document.getElementById("styled_popup");
    tx = parseInt(dobj.style.left+0);
    ty = parseInt(dobj.style.top+0);
    x = nn6 ? e.clientX : event.clientX;
    y = nn6 ? e.clientY : event.clientY;
    document.onmousemove=movemouse;
    return false;
  }
}

function styledPopupClose() {
  document.getElementById("styled_popup").style.display = "none";
}

document.onmousedown=selectmouse;
document.onmouseup=new Function("isdrag=false");

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
		 true;
}
function getUpdatedShoppingCart(itemid){
	//alert(itemid);
	var url="GetUpdatedShoppingCart.action?itemId="+itemid;
	new Ajax.Updater('shoppingCartDiv',''+url, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
	
}
function getCheckoutPage(){
	var url ="Checkout.action";
	if(orderCount > 0){
		//new Ajax.Updater('post-caption',''+url, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
		parent.parent.getRequestedPage(url);
	}
    else{
		alert("Please select atleast one item");
	}
	
} 
function getConfirmOrderCancel()
{
	getConfirmOrderCancelPage(); 
}
