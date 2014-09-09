// Set slideShowSpeed (milliseconds)
var firstTime = 0;

var imgObject;

var slideShowSpeed = 2000;
// Duration of crossfade (seconds)
var crossFadeDuration = 3;
// Specify the image files
var Pic = new Array();
// to add more images, just continue
// the pattern, adding to the array below

Pic[0] = 'images/pic1.jpg'
Pic[1] = 'images/pic2.jpg'
Pic[2] = 'images/pic3.jpg'
Pic[3] = 'images/pic4.jpg'
Pic[4] = 'images/pic5.jpg'

// do not edit anything below this line
var t;
var j = 0;

var p = Pic.length;
var preLoad = new Array();
for (i = 0; i < p; i++) {
	preLoad[i] = new Image();
	preLoad[i].src = Pic[i];
}

function setImgObject(obj){
	imgObject = obj;
	t = setTimeout('runSlideShow()', slideShowSpeed);
}

function runSlideShow() {
	
	if (document.all) {
		imgObject.style.filter="blendTrans(duration=2)";
		imgObject.style.filter="blendTrans(duration=crossFadeDuration)";
		imgObject.filters.blendTrans.Apply();
		//document.images.SlideShow.style.filter="blendTrans(duration=2)";
		//document.images.SlideShow.style.filter="blendTrans(duration=crossFadeDuration)";
		//document.images.SlideShow.filters.blendTrans.Apply();
	}
	imgObject.src = preLoad[j].src;
	//document.images.SlideShow.src = preLoad[j].src;
	if (document.all) {
		imgObject.filters.blendTrans.Play();
		//document.images.SlideShow.filters.blendTrans.Play();
	}

	j = j + 1;
	
	if (j > (p - 1)) {
		j = 0;
	}
	
	//t = setTimeout('runSlideShow()', slideShowSpeed);
}


// JavaScript Document