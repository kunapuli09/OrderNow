package com.starpath.order.actions;

import javax.servlet.jsp.PageContext;

import org.displaytag.decorator.DisplaytagColumnDecorator;
import org.displaytag.exception.DecoratorException;
import org.displaytag.properties.MediaTypeEnum;

public class OrderDecorator implements DisplaytagColumnDecorator{
	public Object decorate(Object columnValue, PageContext pageContext,
			MediaTypeEnum media) throws DecoratorException {		
		return "<a class=\"tablelink\" href=\"getCategories.action?menu=Main Menu&sellerLogin=true&orderId="+columnValue.toString()+"\">Add Order</a>";
		
	}

}

