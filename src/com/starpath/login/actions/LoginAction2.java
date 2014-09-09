package com.starpath.login.actions;

import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;


import com.opensymphony.xwork2.ActionSupport;
import com.starpath.admin.actions.UpdateServices;
import com.starpath.order.domain.CServices;
import com.starpath.order.domain.Customer;
import com.starpath.order.domain.Order;
import com.starpath.order.service.CustomerService;
import com.starpath.order.service.CustomerServices;

public class LoginAction2 extends ActionSupport implements ServletRequestAware,
		ServletResponseAware {

	// private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	private static final long serialVersionUID = 6363179647232841933L;

	CustomerService customerService; 
	//CustomerServices customerServices;
	private String username = null;
	private String password = null;
	
	private HttpServletRequest request;

	private HttpServletResponse response;
	private static final Log log = LogFactory.getLog(LoginAction2.class);

	

	public String execute() throws Exception {

		if (request.getSession().getAttribute("customer") == null) {
			//username from login page
			username = getUsername();
			//password from login page
			password = getPassword();

			this.response.setCharacterEncoding("utf-8");

			try {
				Customer customer = getCustomerService().lookupCustomer(
						username);
				Set set = customer.getRoles();
				// Set set1 = customer.getServices();
				if (password.equals(customer.getPassword())) {

					// getSession().put("customer", customer);
					// log.debug("set1 =" + set1);
					request.getSession().setAttribute("customer", customer);
					
					/*calculating 'emailToken' and setting it into the session-
					*-for the purpose of reading logged in user's properties file 
					*/ 
					String emailToken = "";
					
					String email = customer.getEmail();
					int index = email.indexOf("@");

					if (index > 0) {
						emailToken = email.substring(0, index);
						emailToken = "_" + emailToken;
					}
					request.getSession()
							.setAttribute("emailToken", emailToken);
					
					String realPath = "struts";
					ResourceBundle myResources = ResourceBundle
							.getBundle(realPath);

					Customer seller = getCustomerService().lookupCustomer(
							myResources.getString("sellerEmail"));
					CServices cServices = seller.getCServices(); 
					
					request.getSession().setAttribute("cServices", cServices);
					if(request.getSession().getAttribute("order")==null){									
						Order order = new Order();
						order.setBuyer(customer);
						order.setSeller(seller);
						request.getSession().setAttribute("order", order);
						//order.setSeller(seller);
					}else{
						Order order = (Order)request.getSession().getAttribute("order");
						order.setBuyer(customer);
						order.setSeller(seller);
						request.getSession().setAttribute("order", order);
					}
					return SUCCESS;
					
				} else {
					addActionError("Username and Password do not match");
					return ERROR;
				}

			} catch (com.starpath.order.service.CustomerNotFoundException ex) {
				addActionError("Customer Not Found ");
				log.debug("Customer NOT FOUND");
			} catch (com.starpath.order.service.CustomerNotActiveException ex) {

				addActionError("Your account is not activated. Please activate it via email sent to you.");
				log.debug("Customer NOT Activated");
			}

			return ERROR;
		} else {
			return SUCCESS;
		}

	}

	
	
	public String getUsername() {
		return username;
	}

	public String getPassword() {
		return password;
	}

	
	public void setUsername(String value) {
		username = value;
	}

	public void setPassword(String value) {

		password = value;
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

	/*public CustomerServices getCustomerServices() {
		return customerServices;
	}

	public void setCustomerServices(CustomerServices customerServices) {
		this.customerServices = customerServices;
	}*/

}
