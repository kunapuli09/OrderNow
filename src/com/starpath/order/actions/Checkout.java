package com.starpath.order.actions;

import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.googlecode.sslplugin.annotation.Secured;
import com.opensymphony.xwork2.ActionSupport;
import com.starpath.order.domain.Address;
import com.starpath.order.domain.Customer;
import com.starpath.order.domain.Order;
import com.starpath.order.domain.UserPrivilege;
import com.starpath.order.service.CustomerService;
import com.starpath.order.service.EmailService;
import com.starpath.order.service.EmailServiceException;

public class Checkout extends ActionSupport implements ServletRequestAware,
		ServletResponseAware {

	private HttpServletRequest request;

	private HttpServletResponse response;

	Customer customer;
	CustomerService customerService;
	EmailService emailService;
	private static final Log log = LogFactory.getLog(Checkout.class);
	String realPath = "struts";
	ResourceBundle myResources = ResourceBundle.getBundle(realPath);
	String taxRateStr = myResources.getString("taxRate");
	

	
	public String execute() throws Exception {

		Order order = (Order) request.getSession().getAttribute("order");
		customer = order.getBuyer();
		Float taxRate = Float.parseFloat(taxRateStr);
		Float tax = 0.0f;
		Float total = 0.0f;
		total = order.calculateTotal();
		tax = total * taxRate / 100;
		order.setTax(tax);
		order.calculateTotal();
	    String registered = request.getParameter("registered");
	    request.getSession().setAttribute("taxRate", taxRateStr);
		/*here if user is not logged in then user is forwarded to 
		 * registerform1.jsp otherwise pickupDelivery.jsp*/
		if (customer == null && registered == null) {
			return ERROR;
		} else {
			return SUCCESS;
			/*
			 * try{ order.setBuyer(customer);
			 * emailService.sendOrderCustomerEmail(customer,order); return
			 * SUCCESS; }catch(EmailServiceException em){ em.printStackTrace();
			 * }catch(Exception ex){ ex.printStackTrace(); }
			 */
		}

	}

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpServletRequest getServletRequest() {
		return request;
	}

	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}

	public HttpServletResponse getServletResponse() {
		return response;
	}

	public CustomerService getCustomerService() {
		return customerService;
	}

	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}

	public EmailService getEmailService() {
		return emailService;
	}

	public void setEmailService(EmailService emailService) {
		this.emailService = emailService;
	}
}
