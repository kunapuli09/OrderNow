// This file contains common functions that are used in the site.  


function ExecuteTrigger(triggerId)
{
    var trigger = document.getElementById(triggerId);
    if (trigger != null)
    {
        trigger.click();
    }        
}

