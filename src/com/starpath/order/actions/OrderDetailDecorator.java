package com.starpath.order.actions;

import javax.servlet.jsp.PageContext;

import org.displaytag.decorator.DisplaytagColumnDecorator;
import org.displaytag.exception.DecoratorException;
import org.displaytag.properties.MediaTypeEnum;

public class OrderDetailDecorator implements DisplaytagColumnDecorator{
	public Object decorate(Object columnValue, PageContext pageContext,
			MediaTypeEnum media) throws DecoratorException {
		
		//return  "<a class=\"tablelink\" href=\"javascript:getRequestedPage(&quot;orderDetail.action?&orderId="+columnValue.toString()+"&quot;);changeColor(&quot;ah10&quot;,&quot;&quot;);\">Order Details</a>";
		return  "<a class=\"tablelink\" href=\"orderDetail.action?&orderId="+columnValue.toString()+"\">Order Details</a>";
		
	}

}
