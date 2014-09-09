var datePickerDivID = "datepicker";
var iFrameDivID = "datepickeriframe";

var dayArrayShort = new Array('Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa');
var dayArrayMed = new Array('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat');
var dayArrayLong = new Array('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
var monthArrayShort = new Array('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
var monthArrayMed = new Array('Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'July', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec');
var monthArrayLong = new Array('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');
 
// these variables define the date formatting we're expecting and outputting.
// If you want to use a different format by default, change the defaultDateSeparator
// and defaultDateFormat variables either here or on your HTML page.
var defaultDateSeparator = "/";        // common values would be "/" or "."
var defaultDateFormat = "mdy"    // valid values are "mdy", "dmy", and "ymd"
var dateSeparator = defaultDateSeparator;
var dateFormat = defaultDateFormat;


function displayDatePicker(dateFieldName, displayBelowThisObject, dtFormat, dtSep)
{
  var targetDateField = document.getElementsByName (dateFieldName).item(0);
 
  // if we weren't told what node to display the datepicker beneath, just display it
  // beneath the date field we're updating
  if (!displayBelowThisObject)
    displayBelowThisObject = targetDateField;
 
  // if a date separator character was given, update the dateSeparator variable
  if (dtSep)
    dateSeparator = dtSep;
  else
    dateSeparator = defaultDateSeparator;
 
  // if a date format was given, update the dateFormat variable
  if (dtFormat)
    dateFormat = dtFormat;
  else
    dateFormat = defaultDateFormat;
 
  var x = displayBelowThisObject.offsetLeft;
  var y = displayBelowThisObject.offsetTop + displayBelowThisObject.offsetHeight ;
 
  // deal with elements inside tables and such
  var parent = displayBelowThisObject;
  while (parent.offsetParent) {
    parent = parent.offsetParent;
    x += parent.offsetLeft;
    y += parent.offsetTop ;
  }
 
  drawDatePicker(targetDateField, x, y);
}


/**
Draw the datepicker object (which is just a table with calendar elements) at the
specified x and y coordinates, using the targetDateField object as the input tag
that will ultimately be populated with a date.

This function will normally be called by the displayDatePicker function.
*/
function drawDatePicker(targetDateField, x, y)
{
  var dt = getFieldDate(targetDateField.value );
 
  // the datepicker table will be drawn inside of a <div> with an ID defined by the
  // global datePickerDivID variable. If such a div doesn't yet exist on the HTML
  // document we're working with, add one.
  if (!document.getElementById(datePickerDivID)) {
    // don't use innerHTML to update the body, because it can cause global variables
    // that are currently pointing to objects on the page to have bad references
    //document.body.innerHTML += "<div id='" + datePickerDivID + "' class='dpDiv'></div>";
    var newNode = document.createElement("div");
    newNode.setAttribute("id", datePickerDivID);
    newNode.setAttribute("class", "dpDiv");
    newNode.setAttribute("style", "visibility: hidden;");
    document.body.appendChild(newNode);
  }
 
  // move the datepicker div to the proper x,y coordinate and toggle the visiblity
  var pickerDiv = document.getElementById(datePickerDivID);
  pickerDiv.style.position = "absolute";
  pickerDiv.style.left = x + "px";
  pickerDiv.style.top = y + "px";
  pickerDiv.style.visibility = (pickerDiv.style.visibility == "visible" ? "hidden" : "visible");
  pickerDiv.style.display = (pickerDiv.style.display == "block" ? "none" : "block");
  pickerDiv.style.zIndex = 10000;
 
  // draw the datepicker table
  refreshDatePicker(targetDateField.name, dt.getFullYear(), dt.getMonth(), dt.getDate());
}


/**
This is the function that actually draws the datepicker calendar.
*/
function refreshDatePicker(dateFieldName, year, month, day)
{
  // if no arguments are passed, use today's date; otherwise, month and year
  // are required (if a day is passed, it will be highlighted later)
  var thisDay = new Date();
 
  if ((month >= 0) && (year > 0)) {
    thisDay = new Date(year, month, 1);
  } else {
    day = thisDay.getDate();
    thisDay.setDate(1);
  }
 
  // the calendar will be drawn as a table
  // you can customize the table elements with a global CSS style sheet,
  // or by hardcoding style and formatting elements below
  var crlf = "\r\n";
  var TABLE = "<table cols=7 class='dpTable'>" + crlf;
  var xTABLE = "</table>" + crlf;
  var TR = "<tr class='dpTR'>";
  var TR_title = "<tr class='dpTitleTR'>";
  var TR_days = "<tr class='dpDayTR'>";
  var TR_todaybutton = "<tr class='dpTodayButtonTR'>";
  var xTR = "</tr>" + crlf;
  var TD = "<td class='dpTD' onMouseOut='this.className=\"dpTD\";' onMouseOver=' this.className=\"dpTDHover\";' ";    // leave this tag open, because we'll be adding an onClick event
  var TD_title = "<td colspan=5 class='dpTitleTD'>";
  var TD_buttons = "<td class='dpButtonTD'>";
  var TD_todaybutton = "<td colspan=7 class='dpTodayButtonTD'>";
  var TD_days = "<td class='dpDayTD'>";
  var TD_selected = "<td class='dpDayHighlightTD' onMouseOut='this.className=\"dpDayHighlightTD\";' onMouseOver='this.className=\"dpTDHover\";' ";    // leave this tag open, because we'll be adding an onClick event
  var xTD = "</td>" + crlf;
  var DIV_title = "<div class='dpTitleText'>";
  var DIV_selected = "<div class='dpDayHighlight'>";
  var xDIV = "</div>";
 
  // start generating the code for the calendar table
  var html = TABLE;
 
  // this is the title bar, which displays the month and the buttons to
  // go back to a previous month or forward to the next month
  html += TR_title;
  html += TD_buttons + getButtonCode(dateFieldName, thisDay, -1, "&lt;") + xTD;
  html += TD_title + DIV_title + monthArrayLong[ thisDay.getMonth()] + " " + thisDay.getFullYear() + xDIV + xTD;
  html += TD_buttons + getButtonCode(dateFieldName, thisDay, 1, "&gt;") + xTD;
  html += xTR;
 
  // this is the row that indicates which day of the week we're on
  html += TR_days;
  for(i = 0; i < dayArrayShort.length; i++)
    html += TD_days + dayArrayShort[i] + xTD;
  html += xTR;
 
  // now we'll start populating the table with days of the month
  html += TR;
 
  // first, the leading blanks
  for (i = 0; i < thisDay.getDay(); i++)
    html += TD + "&nbsp;" + xTD;
 
  // now, the days of the month
  do {
    dayNum = thisDay.getDate();
    TD_onclick = " onclick=\"updateDateField('" + dateFieldName + "', '" + getDateString(thisDay) + "');\">";
    
    if (dayNum == day)
      html += TD_selected + TD_onclick + DIV_selected + dayNum + xDIV + xTD;
    else
      html += TD + TD_onclick + dayNum + xTD;
    
    // if this is a Saturday, start a new row
    if (thisDay.getDay() == 6)
      html += xTR + TR;
    
    // increment the day
    thisDay.setDate(thisDay.getDate() + 1);
  } while (thisDay.getDate() > 1)
 
  // fill in any trailing blanks
  if (thisDay.getDay() > 0) {
    for (i = 6; i > thisDay.getDay(); i--)
      html += TD + "&nbsp;" + xTD;
  }
  html += xTR;
 
  // add a button to allow the user to easily return to today, or close the calendar
  var today = new Date();
  var todayString = "Today is " + dayArrayMed[today.getDay()] + ", " + monthArrayMed[ today.getMonth()] + " " + today.getDate();
  html += TR_todaybutton + TD_todaybutton;
  html += "<button class='dpTodayButton' onClick='refreshDatePicker(\"" + dateFieldName + "\");'>this month</button> ";
  html += "<button class='dpTodayButton' onClick='updateDateField(\"" + dateFieldName + "\");'>close</button>";
  html += xTD + xTR;
 
  // and finally, close the table
  html += xTABLE;
 
  document.getElementById(datePickerDivID).innerHTML = html;
  // add an "iFrame shim" to allow the datepicker to display above selection lists
  adjustiFrame();
}


/**
Convenience function for writing the code for the buttons that bring us back or forward
a month.
*/
function getButtonCode(dateFieldName, dateVal, adjust, label)
{
  var newMonth = (dateVal.getMonth () + adjust) % 12;
  var newYear = dateVal.getFullYear() + parseInt((dateVal.getMonth() + adjust) / 12);
  if (newMonth < 0) {
    newMonth += 12;
    newYear += -1;
  }
 
  return "<button class='dpButton' onClick='refreshDatePicker(\"" + dateFieldName + "\", " + newYear + ", " + newMonth + ");'>" + label + "</button>";
}


/**
Convert a JavaScript Date object to a string, based on the dateFormat and dateSeparator
variables at the beginning of this script library.
*/
function getDateString(dateVal)
{
  var dayString = "00" + dateVal.getDate();
  var monthString = "00" + (dateVal.getMonth()+1);
  dayString = dayString.substring(dayString.length - 2);
  monthString = monthString.substring(monthString.length - 2);
 
  switch (dateFormat) {
    case "dmy" :
      return dayString + dateSeparator + monthString + dateSeparator + dateVal.getFullYear();
    case "ymd" :
      return dateVal.getFullYear() + dateSeparator + monthString + dateSeparator + dayString;
    case "mdy" :
    default :
      return monthString + dateSeparator + dayString + dateSeparator + dateVal.getFullYear();
  }
}


/**
Convert a string to a JavaScript Date object.
*/
function getFieldDate(dateString)
{
  var dateVal;
  var dArray;
  var d, m, y;
 
  try {
    dArray = splitDateString(dateString);
    if (dArray) {
      switch (dateFormat) {
        case "dmy" :
          d = parseInt(dArray[0], 10);
          m = parseInt(dArray[1], 10) - 1;
          y = parseInt(dArray[2], 10);
          break;
        case "ymd" :
          d = parseInt(dArray[2], 10);
          m = parseInt(dArray[1], 10) - 1;
          y = parseInt(dArray[0], 10);
          break;
        case "mdy" :
        default :
          d = parseInt(dArray[1], 10);
          m = parseInt(dArray[0], 10) - 1;
          y = parseInt(dArray[2], 10);
          break;
      }
      dateVal = new Date(y, m, d);
    } else if (dateString) {
      dateVal = new Date(dateString);
    } else {
      dateVal = new Date();
    }
  } catch(e) {
    dateVal = new Date();
  }
 
  return dateVal;
}



/**
Try to split a date string into an array of elements, using common date separators.
If the date is split, an array is returned; otherwise, we just return false.
*/
function splitDateString(dateString)
{
  var dArray;
  if (dateString.indexOf("/") >= 0)
    dArray = dateString.split("/");
  else if (dateString.indexOf(".") >= 0)
    dArray = dateString.split(".");
  else if (dateString.indexOf("-") >= 0)
    dArray = dateString.split("-");
  else if (dateString.indexOf("\\") >= 0)
    dArray = dateString.split("\\");
  else
    dArray = false;
 
  return dArray;
}


function updateDateField(dateFieldName, dateString)
{
  var targetDateField = document.getElementsByName (dateFieldName).item(0);
  if (dateString)
    targetDateField.value = dateString;
 
  var pickerDiv = document.getElementById(datePickerDivID);
  pickerDiv.style.visibility = "hidden";
  pickerDiv.style.display = "none";
 
  adjustiFrame();
  targetDateField.focus();
 
  // after the datepicker has closed, optionally run a user-defined function called
  // datePickerClosed, passing the field that was just updated as a parameter
  // (note that this will only run if the user actually selected a date from the datepicker)
  if ((dateString) && (typeof(datePickerClosed) == "function"))
    datePickerClosed(targetDateField);
}


/**
Use an "iFrame shim" to deal with problems where the datepicker shows up behind
selection list elements, if they're below the datepicker. The problem and solution are
described at:

http://dotnetjunkies.com/WebLog/jking/archive/2003/07/21/488.aspx
http://dotnetjunkies.com/WebLog/jking/archive/2003/10/30/2975.aspx
*/
function adjustiFrame(pickerDiv, iFrameDiv)
{
  // we know that Opera doesn't like something about this, so if we
  // think we're using Opera, don't even try
  var is_opera = (navigator.userAgent.toLowerCase().indexOf("opera") != -1);
  if (is_opera)
    return;
  
  // put a try/catch block around the whole thing, just in case
  try {
    if (!document.getElementById(iFrameDivID)) {
      // don't use innerHTML to update the body, because it can cause global variables
      // that are currently pointing to objects on the page to have bad references
      //document.body.innerHTML += "<iframe id='" + iFrameDivID + "' src='javascript:false;' scrolling='no' frameborder='0'>";
      var newNode = document.createElement("iFrame");
      newNode.setAttribute("id", iFrameDivID);
      newNode.setAttribute("src", "javascript:false;");
      newNode.setAttribute("scrolling", "no");
      newNode.setAttribute ("frameborder", "0");
      document.body.appendChild(newNode);
    }
    
    if (!pickerDiv)
      pickerDiv = document.getElementById(datePickerDivID);
    if (!iFrameDiv)
      iFrameDiv = document.getElementById(iFrameDivID);
    
    try {
      iFrameDiv.style.position = "absolute";
      iFrameDiv.style.width = pickerDiv.offsetWidth;
      iFrameDiv.style.height = pickerDiv.offsetHeight ;
      iFrameDiv.style.top = pickerDiv.style.top;
      iFrameDiv.style.left = pickerDiv.style.left;
      iFrameDiv.style.zIndex = pickerDiv.style.zIndex - 1;
      iFrameDiv.style.visibility = pickerDiv.style.visibility ;
      iFrameDiv.style.display = pickerDiv.style.display;
    } catch(e) {
    }
 
  } catch (ee) {
  }
 
}

var ie = document.all;
var nn6 = document.getElementById &&! document.all;

var isdrag = false;
var x, y;
var dobj;

function movemouse( e ) {
	
  if( isdrag ) {
	  
    dobj.style.left = nn6 ? tx + e.clientX - x : x + event.clientX - x;
    dobj.style.top  = nn6 ? ty + e.clientY - y : y + event.clientY - y;
    return false;
  }

  return true;
}

function selectmouse( e ) {
	
  	var fobj       = nn6 ? e.target : event.srcElement;
  	var topelement = nn6 ? "HTML" : "BODY";

  	while (fobj.tagName != topelement && fobj.className != "dragme") {
    	fobj = nn6 ? fobj.parentNode : fobj.parentElement;
  }

  if (fobj.className == "dragme") {
	  
    isdrag = true;
    
    dobj = document.getElementById("styled_popup");
    
    tx = parseInt(dobj.style.left+0);
    
    ty = parseInt(dobj.style.top+0);
    
    x = nn6 ? e.clientX : event.clientX;
    y = nn6 ? e.clientY : event.clientY;
    document.onmousemove=movemouse;

    return false;
    
  }

  return true;
}

function styledPopupClose() {
	
  document.getElementById("styled_popup").style.display = "none";
  hiddenFloatingDiv("styled_popup");
}

document.onmousedown=selectmouse;
document.onmouseup=new Function("isdrag=false");


var url;

function getStyledPopupClose()
{
	document.getElementById("styled_popup").style.display="none";
	
}
function getStyledPopupOpen()
{
	var url="loginTemplate.jsp";  
	
	new Ajax.Updater('styled_popup',''+url, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
	
	if(document.getElementById("styled_popup"))
		document.getElementById("styled_popup").style.visibility="visible"; 
	//alert(document.getElementById("styled_popup").style.visibility);
	document.getElementById("styled_popup").style.display="block";
	
	displayWindow(); 
}
function displayWindow()
{
    var w, h, l, t;
    w = 400;
    h = 200;
    l = screen.width/4;
    t = screen.height/4;
    
    // no title		        
    // displayFloatingDiv('windowcontent', '', w, h, l, t);

    // with title		        
    displayFloatingDiv('styled_popup', 'Floating and Dimming Div', w, h, l, t);
}
function getRequestedPage(url)
{

	document.getElementById("styled_popup").style.display="none";
	new Ajax.Updater('post-caption',''+url, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
	styledPopupClose();
}
function getRequestedPageOrder(url)
{
	
	document.getElementById("home-footer").style.display="none";
	new Ajax.Updater('home-main',''+url, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
   
}
function getRequestedMenuPage(url)
{

	
	new Ajax.Updater('menu-container',''+url, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
   
}
function getRequestedLoginPage(url)
{
	document.getElementById("styled_popup").style.display="block";

	new Ajax.Updater('styled_popup',''+url, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
   
}

function getLogoutPage(url)
{
	
	new Ajax.Updater('page1',''+url, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
	//getlogout("");
	styledPopupClose();
}

function getlogin(userName)
{
	new Ajax.Updater('home-header1','homeHeader1.jsp?userName=' + userName, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
	new Ajax.Updater('home-header','homeHeader.jsp?userName=' + userName, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
	new Ajax.Updater('home-footer','homeFooter.jsp?userName=' + userName, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
	new Ajax.Updater('post-caption','Home.jsp?userName=' + userName, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
	 
	styledPopupClose();
	
}

function getlogout(userName)
{
	new Ajax.Updater('home-header1','homeHeader2.jsp?userName=' + userName, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
	new Ajax.Updater('home-header','homeHeader.jsp?userName=' + userName, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
	new Ajax.Updater('home-footer','homeFooter.jsp?userName=' + userName, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
	new Ajax.Updater('post-caption','Home.jsp?userName=' + userName, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
	new Ajax.Updater('styled_popup','loginForm.jsp?userName=' + userName, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
	
}

function login()
{   var username=document.getElementById("username").value;
	var password=document.getElementById("password").value;
	var url="/tandoorstruts/LoginServlet";
	url+="?username="+username+"&password="+password;
	new Ajax.Updater('loginmsg',''+url, {asynchronous:true, evalScripts:true, method:"get", parameters:'id=' + encodeURIComponent("")});
	   
}

function zoomout(target)
{
	//alert("zoomout");
var id=target.id.substr(5);
//alert("zoomout"+id);
var divid="effect_object_"+target.id.substr(5);

document.getElementById(divid).style.display="block";
//alert("document.getElementById(divid).style.display="+document.getElementById(divid).style.display);

}
function zoomin(target)
{
var id=target.id.substr(5);	

var divid="effect_object_"+target.id.substr(5);
//alert("zoomout"+id);
document.getElementById(divid).style.display="none";
}

function getItemsContainerPage(url)
{
 new Ajax.Updater('itemscontainer',''+url, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
   
}
function getRestaurantStatus(orderdate)
{
//alert("orderdate"+orderdate);
var url='getRestaurantStatus.action?orderdate='+orderdate;
//alert(url);
new Ajax.Updater('restaurantStatusDiv',''+url, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
 
}

function displaylogin()
{
document.getElementById("login").style.display="inline";
}
function scroll_1()
{
	scroller1.stop();
}
function scroll_2()
{
	scroller2.stop();
}

function startScrolling1()
{
	scroller1.start();
}  
function startScrolling2()
{
	scroller2.start();
}  

function getShoppingCartPage(index,url)
{
	//alert("test");
	var quantityTxtId="quantitytxt"+index;
	
	var quantity=document.getElementById(quantityTxtId).value;
	
	if(quantity > 0){
		url=url+"&quantity="+quantity;
		new Ajax.Updater('shoppingCartDiv',''+url, {asynchronous:true, evalScripts:true,parameters:'id=' + encodeURIComponent("")});
		
		document.getElementById("yourOrder").click();
	}else
		alert("Enter non zero value");
}

var holidayDates="";
function addDatesToDiv(){
	
	if(document.getElementById("holidaysText").value.length > 0){
		holidayDates = holidayDates + document.getElementById("holidaysText").value + ",";
		document.getElementById("holidayDates").value = document.getElementById("holidayDates").value + "," + document.getElementById("holidaysText").value;	
		
		document.temp.showDateText.value = document.temp.showDateText.value + "," + document.getElementById("holidaysText").value + ",";
	}else{
		alert("Please select a Date.")
	}
}

function checkTextAreaSize(tarea,size){
	
	if( event.keyCode == 8 || event.keyCode == 46){
		return true;
	}
	else{
		if(tarea.value.length > size){
			alert("The Home content should not exceed more than 2000 characters");
			return false;
		}
		else
			return true;
	}
}

	
	/*Example message arrays for the two demo scrollers*/
	
	var pausecontent=new Array()
	var promotionsPage = "promotionsPage.jsp";
	pausecontent[0]='<a href="javascript:getItemsContainerPage(promotionsPage)" class="AScroll">More Promotions</a>'
	/***********************************************
	* Pausing up-down scroller- © Dynamic Drive (www.dynamicdrive.com)
	* This notice MUST stay intact for legal use
	* Visit http://www.dynamicdrive.com/ for this script and 100s more.
	***********************************************/
	
	function pausescroller(content, divId, divClass, delay){
	this.content=content //message array content
	this.tickerid=divId //ID of ticker div to display information
	this.delay=delay //Delay between msg change, in miliseconds.
	this.mouseoverBol=0 //Boolean to indicate whether mouse is currently over scroller (and pause it if it is)
	this.hiddendivpointer=1 //index of message array for hidden div
	document.write('<div id="'+divId+'" class="'+divClass+'" style="position: relative; overflow: hidden"><div class="innerDiv" style="position: absolute; width: 100%" id="'+divId+'1">'+content[0]+'</div><div class="innerDiv" style="position: absolute; width: 100%; visibility: hidden" id="'+divId+'2">'+content[1]+'</div></div>')
	var scrollerinstance=this
	if (window.addEventListener) //run onload in DOM2 browsers
	window.addEventListener("load", function(){scrollerinstance.initialize()}, false)
	else if (window.attachEvent) //run onload in IE5.5+
	window.attachEvent("onload", function(){scrollerinstance.initialize()})
	else if (document.getElementById) //if legacy DOM browsers, just start scroller after 0.5 sec
	setTimeout(function(){scrollerinstance.initialize()}, 500)
	}
	
	// -------------------------------------------------------------------
	// initialize()- Initialize scroller method.
	// -Get div objects, set initial positions, start up down animation
	// -------------------------------------------------------------------
	
	pausescroller.prototype.initialize=function(){
	this.tickerdiv=document.getElementById(this.tickerid)
	this.visiblediv=document.getElementById(this.tickerid+"1")
	this.hiddendiv=document.getElementById(this.tickerid+"2")
	this.visibledivtop=parseInt(pausescroller.getCSSpadding(this.tickerdiv))
	//set width of inner DIVs to outer DIV's width minus padding (padding assumed to be top padding x 2)
	this.visiblediv.style.width=this.hiddendiv.style.width=this.tickerdiv.offsetWidth-(this.visibledivtop*5)+"px"
	this.getinline(this.visiblediv, this.hiddendiv)
	this.hiddendiv.style.visibility="visible"
	var scrollerinstance=this
	document.getElementById(this.tickerid).onmouseover=function(){scrollerinstance.mouseoverBol=1}
	document.getElementById(this.tickerid).onmouseout=function(){scrollerinstance.mouseoverBol=0}
	if (window.attachEvent) //Clean up loose references in IE
	window.attachEvent("onunload", function(){scrollerinstance.tickerdiv.onmouseover=scrollerinstance.tickerdiv.onmouseout=null})
	setTimeout(function(){scrollerinstance.animateup()}, this.delay)
	}
	
	
	// -------------------------------------------------------------------
	// animateup()- Move the two inner divs of the scroller up and in sync
	// -------------------------------------------------------------------
	
	pausescroller.prototype.animateup=function(){
	var scrollerinstance=this
	if (parseInt(this.hiddendiv.style.top)>(this.visibledivtop+5)){
	this.visiblediv.style.top=parseInt(this.visiblediv.style.top)-5+"px"
	this.hiddendiv.style.top=parseInt(this.hiddendiv.style.top)-5+"px"
	setTimeout(function(){scrollerinstance.animateup()}, 50)
	}
	else{
	this.getinline(this.hiddendiv, this.visiblediv)
	this.swapdivs()
	setTimeout(function(){scrollerinstance.setmessage()}, this.delay)
	}
	}
	
	// -------------------------------------------------------------------
	// swapdivs()- Swap between which is the visible and which is the hidden div
	// -------------------------------------------------------------------
	
	pausescroller.prototype.swapdivs=function(){
	var tempcontainer=this.visiblediv
	this.visiblediv=this.hiddendiv
	this.hiddendiv=tempcontainer
	}
	
	pausescroller.prototype.getinline=function(div1, div2){
	div1.style.top=this.visibledivtop+"px"
	div2.style.top=Math.max(div1.parentNode.offsetHeight, div1.offsetHeight)+"px"
	}
	
	// -------------------------------------------------------------------
	// setmessage()- Populate the hidden div with the next message before it's visible
	// -------------------------------------------------------------------
	
	pausescroller.prototype.setmessage=function(){
	var scrollerinstance=this
	if (this.mouseoverBol==1) //if mouse is currently over scoller, do nothing (pause it)
	setTimeout(function(){scrollerinstance.setmessage()}, 100)
	else{
	var i=this.hiddendivpointer
	var ceiling=this.content.length
	this.hiddendivpointer=(i+1>ceiling-1)? 0 : i+1
	this.hiddendiv.innerHTML=this.content[this.hiddendivpointer]
	this.animateup()
	}
	}
	
	pausescroller.getCSSpadding=function(tickerobj){ //get CSS padding value, if any
	if (tickerobj.currentStyle)
	return tickerobj.currentStyle["paddingTop"]
	else if (window.getComputedStyle) //if DOM2
	return window.getComputedStyle(tickerobj, "").getPropertyValue("padding-top")
	else
	return 0
	}
	
function changeColor(id,footer){
	
	var i =0;
	var ah = "ah";

	for(i=1; i <= 50;++i){
		ah = ah + i;
		if(document.all[ah]){
			if(ah == id){
				if(footer == "")
					document.all[ah].style.color = "#ff0000";
				else
					document.all[ah].style.color = "#000000";
			}
			else
				document.all[ah].style.color = "#ffffff";
		}
		ah = "ah";
	}

	

}

