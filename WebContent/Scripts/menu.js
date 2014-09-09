function setdata(num,status) {
	if (status=="in") {
		if (num=="1") {
			$('#link1').html("<img src='/images/linkarrow.gif' width='10' height='10'>");
		}
		if (num=="2") {
			$('#link2').html("<img src='/images/linkarrow.gif' width='10' height='10'>");
		}
		if (num=="3") {
			$('#link3').html("<img src='/images/linkarrow.gif' width='10' height='10'>");
		}
		if (num=="4") {
			$('#link4').html("<img src='/images/linkarrow.gif' width='10' height='10'>");
		}
	}
	else {
		if (num=="1") {
			$('#link1').html("<font size='1'>&nbsp;&nbsp;&nbsp;</font>");
		}
		if (num=="2") {
			$('#link2').html("<font size='1'>&nbsp;&nbsp;&nbsp;</font>");
		}
		if (num=="3") {
			$('#link3').html("<font size='1'>&nbsp;&nbsp;&nbsp;</font>");
		}
		if (num=="4") {
			$('#link4').html("<font size='1'>&nbsp;&nbsp;&nbsp;</font>");
		}
	}
}