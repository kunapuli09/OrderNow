package com.starpath.order.actions;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;

import javax.servlet.jsp.PageContext;

import org.displaytag.decorator.DisplaytagColumnDecorator;
import org.displaytag.exception.DecoratorException;
import org.displaytag.properties.MediaTypeEnum;
import org.displaytag.util.Anchor;
import org.displaytag.util.DefaultHref;
import org.displaytag.util.Href;

import com.starpath.order.domain.Customer;


public class MapDecorator implements DisplaytagColumnDecorator{
	public Object decorate(Object columnValue, PageContext pageContext,
			MediaTypeEnum media) throws DecoratorException {
		Customer customer = (Customer) columnValue;
		String daddr = customer.getAddress().getAddress()+"," +customer.getAddress().getCity()+"," +customer.getAddress().getState()+" " +customer.getAddress().getZipCode();
		String realPath = "struts";
		ResourceBundle myResources = ResourceBundle.getBundle(realPath);
		FileInputStream fin = null;
		String fileName = "/properties/ApplicationResources.properties";
		ResourceBundle proResources = null;
		try
		{
			fin = new FileInputStream(myResources
				.getString("struts.multipart.propDir")
				+ fileName);
		}
		catch(Exception e){}
		
		try {
			proResources = new PropertyResourceBundle(fin);
		} catch (IOException e) {
			e.printStackTrace();
		}
		String saddr = proResources.getString("contactus.addressline1")+proResources.getString("contactus.addressline2")+proResources.getString("contactus.addressline3");
		Href h= new DefaultHref("http://maps.google.com/maps?daddr="+daddr+"&saddr="+saddr);
		Anchor a = new Anchor(h, "Map");
		return a;
	}
}