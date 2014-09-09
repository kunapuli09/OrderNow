$(document).ready(function(){
	$(".striped tr").mouseover(function() {$(this).addClass("over");}).mouseout(function() {$(this).removeClass("over");});
	$(".visible").mouseover(function() {$(this).removeClass("over");}).mouseout(function() {$(this).removeClass("over");});
	$(".inner_visible").mouseover(function() {$(this).removeClass("over");}).mouseout(function() {$(this).removeClass("over");});
	$(".inner_extra").mouseover(function() {$(this).removeClass("over");}).mouseout(function() {$(this).removeClass("over");});
	// $(".striped tr:even").addClass("alt");
	$('#qo_hover').mouseover(function(){$('#qo_popup').show();}).mouseout(function(){$('#qo_popup').hide();});
	$('#iphone_swf').click(function(){window.location.href='/users/new'});
});
$.fn.toggler = function(options) {
  options = $.extend({}, $.fn.toggler.defaults, options);
  var handler = (options.livequery) ? 'livequery' : 'bind';
  this[handler]('click', function() {
    $(this)
        .toggleClass('toggler_up')
        .parents(options.toggleContainer).find(options.toggled).slideToggle('fast');
    return false;
  });
  return this;
}

$.fn.toggler.defaults = {
  toggled: '.toggled',
  toggleContainer: '.toggle',
  livequery: false
};

$(function() {
  $('.toggler').toggler();
});


$.fn.item_toggler = function(options) {
  options = $.extend({}, $.fn.item_toggler.defaults, options);
  var handler = (options.livequery) ? 'livequery' : 'bind';
  this[handler]('click', function() {
    $(this)
        .toggleClass('item_toggler_up')
        .parents(options.item_toggleContainer).find(options.item_toggled).slideToggle('fast');
    return false;
  });
  return this;
}

$.fn.item_toggler.defaults = {
  item_toggled: '.item_toggled',
  item_toggleContainer: '.item_toggle',
  livequery: false
};

$(function() {
  $('.item_toggler').item_toggler();
});

function fmt_money(obj,target){
	amt=eval(obj.value);
	var i = parseFloat(amt);
	if(isNaN(i)) { i = 0.00; }
	var minus = '';
	if(i < 0) { minus = '-'; }
	i = Math.abs(i);
	i = parseInt(i + .005);
	i = i / 100;
	s = new String(i);
	if(s.indexOf('.') < 0) { s += '.00'; }
	if(s.indexOf('.') == (s.length - 2)) { s += '0'; }
	s = minus + s;
	$(target).html("$"+s);
}

function tax_price(obj){
	var tax=eval(obj.options[obj.selectedIndex].value);
	var amt=eval($('#clean_price').html());
	var val = Math.round(tax+amt)/100;
	s = new String(val);
	if(s.indexOf('.') < 0) { s += '.00'; }
	if(s.indexOf('.') == (s.length - 2)) { s += '0'; }
	$('#formatted_price').html("$"+s);

}
function hov(loc, cls){
	if(loc.className){
		loc.className = cls;
	}
}
}
