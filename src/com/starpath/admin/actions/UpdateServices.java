package com.starpath.admin.actions;

import java.util.Date;
import java.util.Properties;
import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;
import java.io.File;
import java.io.FileOutputStream;

import com.opensymphony.xwork2.ActionSupport;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.starpath.order.domain.*;
import com.starpath.order.service.*;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.multipart.MultiPartRequestWrapper;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.springframework.util.FileCopyUtils;

import com.starpath.order.domain.Customer;

public class UpdateServices extends ActionSupport implements
		ServletRequestAware, ServletResponseAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2501529860079188663L;
	private String serviceid;
	private Long customerid;

	private boolean email = false;
	private boolean phone = false;
	private boolean fax = false;
	private boolean delivery = false;
	private boolean credit = false;
	private boolean orders = false;
	private boolean updateorders = false;

	private HttpServletRequest request;

	private HttpServletResponse response;
	CustomerService customerService;
	private static final Log log = LogFactory.getLog(UpdateServices.class);

	public String execute() throws Exception {

		String firstTime = (String) request.getParameter("firstTime");
		Order order = (Order) request.getSession().getAttribute("order");
		Customer seller = order.getSeller();
		CServices cServices = (CServices) request.getSession().getAttribute(
				"cServices");

		// firstTime means view the jsp
		// else the user could edit the jsp with the changes which means update
		// the database

		if (firstTime == null) {

			try {
				cServices = seller.getCServices();
				// we should never reach this condition as the data is preloaded
				// with some service values
				if (cServices == null) {
					cServices = new CServices();
				}
				System.out.println("cServices" + cServices);
				System.out.println("email" + email);
				cServices.setEmail(email);
				cServices.setPhone(phone);
				cServices.setFax(fax);
				cServices.setDelivery(delivery);
				cServices.setCredit(credit);
				cServices.setOrders(orders);
				cServices.setUpdateOrders(updateorders);
				seller.setCServices(cServices);
				customerService.updateSellerServices(seller);
			} catch (Exception ex) {
				ex.printStackTrace();
				return ERROR;
			}

			return SUCCESS;
		} else {

			log.debug("customerService=" + customerService);
			cServices = seller.getCServices();
			if (cServices != null) {
				serviceid = "" + cServices.getID().longValue();
				email = cServices.getEmail();
				phone = cServices.getPhone();
				fax = cServices.getFax();
				delivery = cServices.getDelivery();
				credit = cServices.getCredit();
				orders = cServices.getOrders();
				updateorders = cServices.getUpdateOrders();
			}

			return INPUT;
		}
	}

	public Long getCustomerid() {
		return customerid;
	}

	public void setCustomerid(Long customerid) {
		this.customerid = customerid;
	}

	public String getServiceid() {
		return serviceid;
	}

	public void setServiceid(String serviceid) {
		this.serviceid = serviceid;
	}

	public boolean getEmail() {
		return email;
	}

	public void setEmail(boolean email) {
		this.email = email;
	}

	public boolean getPhone() {
		return phone;
	}

	public void setPhone(boolean phone) {
		this.phone = phone;
	}

	public boolean getFax() {
		return fax;
	}

	public void setFax(boolean fax) {
		this.fax = fax;
	}

	public boolean getDelivery() {
		return delivery;
	}

	public void setDelivery(boolean delivery) {
		this.delivery = delivery;
	}

	public boolean getOrders() {
		return orders;
	}

	public void setOrders(boolean orders) {
		this.orders = orders;
	}

	public boolean getUpdateOrders() {
		return updateorders;
	}

	public void setUpdateOrders(boolean updateorders) {
		this.updateorders = updateorders;
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

	public void setCredit(boolean credit) {
		this.credit = credit;
	}

	public boolean getCredit() {
		return credit;
	}

}