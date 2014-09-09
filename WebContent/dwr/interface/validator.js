
/******************************************************************************
 * JavaScript Validation file
 *
 * programmer: Jason Geissler
 *
 * purpose: To encapsulate the mundane date, ssn, phone number, and time validation
 *          in one file
 *
 * date: March 19, 2002
 *
 *****************************************************************************/


/******************************************************************************
 * method: ValidateSSN
 *
 * author: Jason Geissler
 *
 * date: March 19, 2002
 *
 * parameters: ssn (Social Security number)
 *
 * purpose: To validate a social security number to make sure the number
 *          is valid
 *****************************************************************************/
function ValidateSSN(ssn) {
  if((ssn.length == 11) || (ssn.length == 9)) {     // Make sure it's a valid length
    var segments = ssn.split("-")                   // Split the number into segments delimited by '-'
    if ((segments.length == 3)) {
			if ((segments[0].length == 3) && (segments[1].length == 2) && (segments[2].length == 4)) {
				for (var i = 0; i < 3; i++) {
					if (isNaN(segments[i]))                   // Check to see if the number is a valid number
						return false;
				}
				return true;
			}
    }
    else {
      if ((segments.length == 1) && (!isNaN(ssn)))  // Check to see if the number is a valid number
        return true;
    }
  }
  return false;
}


/******************************************************************************
 * method: ValidatePhoneNumber
 *
 * author: Jason Geissler
 *
 * date: March 19, 2002
 *
 * parameters: phoneNum (Phone number)
 *
 * purpose: To validate a phone number to make sure the number
 *          is valid. This is based from the American system of
 *          3 digit area code 3 digit city code then the number.
 *****************************************************************************/
function ValidatePhoneNumber(phoneNum) {
	var segments;		// Breaks up the phone numbers into area code, city code and number
	var i;
		
	// Check to see if they put any "( )" around the area code
	// If so we'll strip those out.
	phoneNum = phoneNum.replace("(", "");
	phoneNum = phoneNum.replace(")", "");
	
	switch (phoneNum.length) {
		case 7:																		/* The XXXXXXX case */
			if(!isNaN(phoneNum))										// Check to see if they're real numbers
				return true;
			break;
						
		case 8:																		/* The XXX-XXXX case */
			segments = phoneNum.split("-");
			if (segments.length == 2) {
				if((segments[0].length == 3) && (segments[1].length == 4)) {
					for (i = 0; i < 2; i++) {						// Check to see if they're real numbers
						if (isNaN(segments[i]))
							return false;
					}
					return true;
				}
			}
			break;
			
		case 10:																	/* The XXXXXXXXXX case */
			if(!isNaN(phoneNum))										// Check to see if they're real numbers
				return true;
			break;
			
		case 12:																	/* The XXX-XXX-XXXX case */
			segments = phoneNum.split("-");
			if (segments.length == 3) {
				if((segments[0].length == 3) && (segments[1].length == 3) && (segments[2].length == 4)) {
					for (i = 0; i < 3; i++) {						// Check to see if they're real numbers
						if (isNaN(segments[i]))
							return false;
					}
					return true;
				}
			}
			break;
				
		default:																	/* If non of the above then fail it */
			break;
	}
	return false;
}			
				

/******************************************************************************
 * method: ValidateTime
 *
 * author: Jason Geissler
 *
 * date: March 19, 2002
 *
 * parameters: time, formatType (1 - Standard format, 2- Military format)
 *
 * purpose: To validate a time in HH:MM format
 *****************************************************************************/
function ValidateTime(time, formatType) {
	var segments;			// Break up of the time into hours and minutes
	var hour;					// The value of the entered hour
	var minute;				// The value of the entered minute
		
	time = time.replace(".", ":");
		
	if (formatType == 1) {						                              /* Validating standard time */
		segments = time.split(":");
		
		if (segments.length == 2) {
			segments[1] = segments[1].substring(0,2);
			hour = segments[0];				                                  // Test the hour
			if ((hour > 12) || (hour < 1))  
				return false;
						
			minute = segments[1];			                                  // Test the minute
			if (( minute <= 59) && (minute >= 0)) 
				return true;
		}
			
	}
	else {												                                  /* Validating military time */
		segments = time.split(":");
		
		if (segments.length == 2) {
			hour = segments[0];				                                  // Test the hour
			if ((hour > 23) || (hour <= -1)) 
				return false;
				
			minute = segments[1];			                                  // Test the minute
			if (( minute <= 59) && (minute >= 0)) 
				return true;
		}
	}
	return false;
}	


/******************************************************************************
 * method: ValidateAdvancedTime
 *
 * author: Jason Geissler
 *
 * date: March 20, 2002
 *
 * parameters: time, formattype(1- Standard, 2- military)
 *
 * purpose: Calls the ValidateTime for hours and minutes but this also 
 *          calculates seconds. Time must be in XX:XX:XX style.
 *****************************************************************************/
function ValidateAdvancedTime(time, formatType){
	time = time.replace(".", ":");
	var newTime = time.substring(0, (time.indexOf(":") + 3)); // Strip out the seconds
	var status = ValidateTime(newTime, formatType);
	
	if(status == false) 
		return false;
		
	var seconds = time.substring(time.indexOf(":") + 4, time.length);
	if(seconds.length > 2) 
		seconds = seconds.substring(0, 2);                      // Remove any AM/PM afterwards
		
	if(!isNaN(seconds)) {			                                // Make sure its a number and it's between 0 and 59
		if((seconds <= 59) && (seconds >= 0)) 
			return true;
	}
	return false;	
}


/******************************************************************************
 * method: ValidateDate
 *
 * author: Jason Geissler
 *
 * date: March 20, 2002
 *
 * parameters: date, formattype(1- US, 2- International)
 *
 * purpose: Validates the passed in date for accuarcy supports
 *          US and international date format.
 *****************************************************************************/ 
function ValidateDate(date, formattype) {
	var segments;
	var year;
	var month;
	var day;
	var status;
	var i;
	var leapYear = false;
	
	if(formattype == 1) {                                 /* Standard time validation note this doesn't support a time */
		// check for time
		var spaceIndex = date.indexOf(" ");
		if (spaceIndex > 0) {
			time = date.substring(spaceIndex, date.length);
			date = date.substring(0, spaceIndex);
			status = ValidateAdvancedTime(time, 1);
			if (status == false) 
				return false;
		}
		// replace any '-' or '.' or "/" with ""
		for (i = 0; i < 2; i++) {
			date = date.replace("-", "/");
			date = date.replace(".", "/");
		}
		var slashIndex = date.indexOf("/");
		if(slashIndex == -1) 
			date = HandleSlashes(date);
		
		// Check to see if the date is a valid length
		// Supports MMDDYY, MMDDYYYY, (M)M/(D)D/YY, (M)M/(D)D/YYYY
		segments = date.split("/");
		month = segments[0];
		day = segments[1];
		year = segments[2];
				
		// Start testing
    status = TestYear(year);
		if(status == false) 
			return false;
			
		if (year.length == 4) 
		  leapYear = IsLeapYear(year);
				
		status = TestMonth(month);
		if(status == false) 
			return false;
				
		status = TestDay(day, month, leapYear);
		if(status == true) 
			return true;
	}
	else {														                    /* International Date Validation YYYY-MM-DD */
		if(date.length > 10) {
			var time = date.substring(10, date.length);
			status = ValidateAdvancedTime(time, 2);
			if (status == false) 
				return false;
			date = date.substring(0,10)
		} 
		// Get our date in a common format
		for (i = 0; i < 2; i++) {
			date = date.replace(".", "-");
			date = date.replace("/", "-");
		}
		
		var dashIndex = date.indexOf("-");
		
		if (dashIndex == -1) 
			date = HandleDashes(date);
				
		segments = date.split("-");
		year = segments[0];
		month = segments[1];
		day = segments[2];
		
		// Start testing
		if (year.length == 4) {
			status = TestYear(year);
			if(status == false) 
				return false;
			leapYear = IsLeapYear(year);
		}
		else 
			return false;
				
		status = TestMonth(month);
		if(status == false) 
			return false;
				
		status = TestDay(day, month, leapYear);
		if(status == true) 
			return true;
	}
	return false;
}		

		
/******************************************************************************
 * method: TestYear
 *
 * author: Jason Geissler
 *
 * date: March 21, 2002
 *
 * parameters: year
 *
 * purpose: Test for a valid year can be any number either YY or YYYY
 *****************************************************************************/
function TestYear(year) {
	// Test the year
	if((year.length == 4) || (year.length == 2)) {
	  // we won't restrict what a user wants to enter for a date since this method is generic
 		if (!isNaN(year)) 
			return true;
	}
	return false;
}


/******************************************************************************
 * method: TestMonth
 *
 * author: Jason Geissler
 *
 * date: March 21, 2002
 *
 * parameters: month
 *
 * purpose: Test for a valid month has to be MM
 *****************************************************************************/
function TestMonth(month) {
	// Test the month
	if ((isNaN(month)) || (month < 1) || (month > 12)){
		return false;
	}
	return true;
}


/******************************************************************************
 * method: TestDay
 *
 * author: Jason Geissler
 *
 * date: March 21, 2002
 *
 * parameters: day
 *
 * purpose: Test for a valid day has to be DD
 *****************************************************************************/
function TestDay(day, month, leapYear) {
	month -= 0;	// Convert the month into a Number for the case's
	
	if(!isNaN(day)) {
		switch(month) {	// Test the days for a particular month
			case 1:
			case 3:
			case 5:
			case 7:
			case 8:
			case 10:
			case 12:
				if ((day >= 1) && (day <= 31)) 
					return true;
				break;
					
			case 4:
			case 6:
			case 9:
			case 11:
				if ((day >= 1) && (day <= 30)) 
					return true;
				break;
					
			case 2:
			  if(leapYear) {
			    if ((day >= 1) && (day <= 29)) 
			      return true;
			  }
				else {
					if ((day >= 1) && (day <= 28)) 
						return true;
				}
				break;
						
			default:
				break;
		}
	}	
	return false;	
}


/******************************************************************************
 * method: ValidateEmailAddr
 *
 * author: Jason Geissler
 *
 * date: March 23, 2002
 *
 * parameters: emailAddress
 *
 * purpose: Makes sure the user entered a valid e-mail address. Supports the
 *          extensions .com, .org, .gov, .net, .edu
 *****************************************************************************/
function ValidateEmailAddr(emailAddress){
  var atSymbol = emailAddress.indexOf("@");																	// Get the index of the '@'
  var period = emailAddress.lastIndexOf(".");																// Get the value of the last '.'
  var suffix = emailAddress.substring(period + 1, emailAddress.length);
  
  // Make sure the '@' symbol and '.' is in a valid location
  if (((atSymbol != 0) && (atSymbol != -1)) && (suffix.length == 3) && (atSymbol < period) && (atSymbol != period - 1)) { 
    if ((suffix == "com") || (suffix == "org") || (suffix == "gov") || (suffix == "net") || (suffix == "edu")) 
      return true;
  }
	return false;
}


/******************************************************************************
 * method: IsLeapYear
 *
 * author: Jason Geissler
 *
 * date: April 28, 2002
 *
 * parameters: year
 *
 * purpose: Checks to see if the year is a leap year, we can do this
 *          with 4 digit years
 *****************************************************************************/
function IsLeapYear(year) {
  var betweenYears = 4;									// We also know that there is 4 years between leap years
  var leapYear = 2000;
  year = leapYear - year;								// Set year to the difference see if it's divisible by 4
  var remainder = year % betweenYears;

  if (remainder == 0) {
    return true;
  }
  return false;
}


/******************************************************************************
 * method: HandleSlashes
 *
 * author: Jason Geissler
 *
 * date: September 12, 2002
 *
 * parameters: date
 *
 * purpose: Inserts a "/" into a date based on date size
 *****************************************************************************/
function HandleSlashes(date) {
	date = date.substring(0, 2) + "/" + date.substring(2, 4) + "/" + date.substring(4, date.length);	
	return date;
}


/******************************************************************************
 * method: HandleDashes
 *
 * author: Jason Geissler
 *
 * date: September 12, 2002
 *
 * parameters: date
 *
 * purpose: Inserts a "-" into a date based on date size
 *****************************************************************************/
function HandleDashes(date) {
	date = date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6, date.length);
	return date;
}

/******************************************************************************
 * method: CalculateAge
 *
 * author: Jason Geissler
 *
 * date: April 15, 2003
 *
 * parameters: date
 *
 * purpose: Calculates an age for a date
 *****************************************************************************/
var format = ""; // Can be Years, Months, Days for age 
 
function CalculateAge(date) {
	var slashIndex = date.indexOf("/");
	var birthday, birthmonth, birthyear;
	
	if (slashIndex != -1) { // With slashes
		var segments = date.split("/");
		birthmonth = segments[0];
		birthday = segments[1];
		birthyear = segments[2];
	}
	else {									// No slashes
		birthmonth = date.substring(0, 2);
		birthday = date.substring(2, 4);
		birthyear = date.substring(4, date.length);
	}
	
	var today = new Date();
	var thisDay = today.getDate();        // Returns the day of the month
	var thisMonth = today.getMonth() + 1; // Need to add a one since the month is zero based - January
	var thisYear = today.getFullYear();   // Returns the year
	
	var yearsDiff = CalculateYear(birthyear, thisYear);
	var monthsDiff = CalculateMonth(birthmonth, thisMonth);
	var daysDiff = CalculateDay(birthday, thisDay);
	format = "Years"; // set the format to years
	
	// For the year is greater than zero
	if (yearsDiff > 0) {
		if (monthsDiff > 0) {		// Month is greater than zero so return we have our age
			return yearsDiff;
		}
		else if (monthsDiff < 0) { // Month is less than zero so return the age minus 1
			if (yearsDiff != 1) {
				return yearsDiff - 1;
			}
			else {
				if (monthsDiff == -11) { // Turn of the year
					if (daysDiff >= 0) {	 // greater than one month
						format = "Months";
						return 1;
					}
					else {								// less than one month
						format = "Days";
						return thisDay - (31 - birthday);
					}
				}
				else {
					format = "Months";		// Next year but not quite a year old
					if (daysDiff >= 0) {
						return thisMonth + (12 - birthmonth);
					}
					else {
						return thisMonth + (12 - birthmonth) - 1;
					}
				}
			}			
		}	
		else {								 // We are in the persons birth month
			if (daysDiff >= 0) { // Today is greater or equal to the person's birthdate
				return yearsDiff;
			}
			else if (daysDiff < 0 && yearsDiff != 1) { // Today is less than the person's birthdate
				return yearsDiff - 1;
			}
			else {
				format = "Months";
				return 11;
			}
		}
	}
	else {  // For the year equaling zero or same year as birthdate
		format = "Months";
		if (monthsDiff > 0) { // Later in the same year
			if (daysDiff >= 0) {
				return monthsDiff;
			}
			else {
				if (monthsDiff != 1) {
					return monthsDiff - 1;
				}
				else {
					format = "Days";
					return thisDay + (DaysInMonth(birthmonth, birthyear) - birthday);
				}
			}
		}
		else {	// Same month as birth month
			format = "Days";
			if (daysDiff == 0) {
				return 1; // Today's the birthdate
			}
			else {
				return daysDiff;
			}
		}
	}							
}

/******************************************************************************
 * method: CalculateYear
 *
 * author: Jason Geissler
 *
 * date: April 15, 2003
 *
 * parameters: birthYear, thisYear
 *
 * purpose: Calculates the year based on the offsets between the birthyear and 
 *          thisYear
 *****************************************************************************/
function CalculateYear(birthYear, thisYear) {
  return thisYear - birthYear;
}  

/******************************************************************************
 * method: CalculateMonth
 *
 * author: Jason Geissler
 *
 * date: April 15, 2003
 *
 * parameters: birthMonth, thisMonth
 *
 * purpose: Calculates the month based on the offsets between the birthMonth and 
 *          thisMonth
 *****************************************************************************/
function CalculateMonth(birthMonth, thisMonth) {
  return thisMonth - birthMonth;
} 

/******************************************************************************
 * method: CalculateDay
 *
 * author: Jason Geissler
 *
 * date: April 15, 2003
 *
 * parameters: birthday, thisday
 *
 * purpose: Calculates the month based on the offsets between the birthDay and 
 *          thisDay
 *****************************************************************************/
function CalculateDay(birthDay, thisDay) {
  return thisDay - birthDay;
} 

/******************************************************************************
 * method: DaysInMonth
 *
 * author: Jason Geissler
 *
 * date: April 15, 2003
 *
 * parameters: birthday, thisday
 *
 * purpose: Calculates the days in the month based on month (year for leap year
 *
 *****************************************************************************/
function DaysInMonth(month, year) {
	month -= 0;
	if (month == 2) {
		var leapYear = IsLeapYear(year);
	}
	
	switch (month) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			return 31;
		case 4:
		case 6:
		case 9:
		case 11:
			return 30;
		case 2:
			if (leapYear) {
				return 29;
			}
			else {
				return 28;
			}
	}
}
