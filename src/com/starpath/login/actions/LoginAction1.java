package com.starpath.login.actions;

import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.context.ApplicationContext;

import com.opensymphony.xwork2.ActionSupport;
import com.starpath.order.domain.Customer;
import com.starpath.order.service.CustomerService;

public class LoginAction1 extends ActionSupport implements ServletRequestAware,
		ServletResponseAware {

	// private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	private static final long serialVersionUID = 6363179647232841933L;

	CustomerService customerService;
	private String firstName = null;
	private String lastName = null;

	private HttpServletRequest request;

	private HttpServletResponse response;
	private static final Log log = LogFactory.getLog(LoginAction1.class);

	/*
	 * private HttpServletRequest request; private HttpServletResponse response;
	 * 
	 * public void setServletRequest(HttpServletRequest request){ this.request =
	 * request;
	 * 
	 * }
	 * 
	 * public HttpServletRequest getServletRequest(){ return request; }
	 * 
	 * public void setServletResponse(HttpServletResponse response){
	 * this.response = response; }
	 * 
	 * public HttpServletResponse getServletResponse(){ return response;}
	 */

	public CustomerService getCustomerService() {
		return customerService;
	}

	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}

	public String execute() throws Exception {

		firstName = getFirstName();
		lastName = getLastName();

		log.debug(firstName);

		return SUCCESS;
	}

	// ---- Username property ----

	/**
	 * <p>
	 * Field to store User username.
	 * </p>
	 * <p/>
	 */

	/**
	 * <p>
	 * Provide User username.
	 * </p>
	 * 
	 * @return Returns the User username.
	 */
	public String getFirstName() {
		return firstName;
	}

	public String getLastName() {
		return lastName;
	}

	/**
	 * <p>
	 * Store new User username
	 * </p>
	 * 
	 * @param value
	 *            The username to set.
	 */
	public void setFirstName(String value) {
		firstName = value;
	}

	public void setLastName(String value) {

		lastName = value;
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
}
