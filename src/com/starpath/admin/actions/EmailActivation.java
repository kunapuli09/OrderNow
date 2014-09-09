package com.starpath.admin.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ActionSupport;
import com.starpath.order.domain.Address;
import com.starpath.order.domain.Customer;
import com.starpath.order.domain.UserPrivilege;
import com.starpath.order.service.CustomerService;
import com.starpath.order.service.EmailService;

public class EmailActivation extends ActionSupport implements
		ServletRequestAware, ServletResponseAware {

	private HttpServletRequest request;

	private HttpServletResponse response;

	CustomerService customerService;
	private static final Log log = LogFactory.getLog(EmailActivation.class);

	public String execute() throws Exception {
		/*checking whether user with given email is registered or not
		 * if registered then activating the account and forwarding
		 * to success page*/
		
		try {
			String email = request.getParameter("email");
			customerService.activateCustomer(email);

			request.setAttribute("emailActivate", "true");

			return SUCCESS;

		} catch (Exception ex) {
			ex.printStackTrace();
			log.debug("here");
			request.setAttribute("emailActivate", "false");
		}

		return ERROR;
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

}
