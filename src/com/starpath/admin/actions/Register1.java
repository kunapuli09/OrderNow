package com.starpath.admin.actions;

import java.util.Calendar;
import java.util.ResourceBundle;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.googlecode.sslplugin.annotation.Secured;
import com.opensymphony.xwork2.ActionSupport;
import com.starpath.order.domain.Address;
import com.starpath.order.domain.CServices;
import com.starpath.order.domain.Customer;
import com.starpath.order.domain.Order;
import com.starpath.order.domain.Shipment;
import com.starpath.order.domain.ShipmentState;
import com.starpath.order.domain.UserPrivilege;
import com.starpath.order.domain.UserPrivilegeType;
import com.starpath.order.service.CustomerNotFoundException;
import com.starpath.order.service.CustomerService;
import com.starpath.order.service.CustomerServices;
import com.starpath.order.service.EmailService;
import com.starpath.order.service.OrderService;

public class Register1 extends ActionSupport implements ServletRequestAware,
		ServletResponseAware {

	private HttpServletRequest request;
	private HttpServletResponse response;
	private String fullName = null;
	private String phoneNumber = null;
	private String password = null;
	private String confirmPassword = null;
	private String email = null;
	private String address = null;
	private String city = null;
	private String state = null;
	private String zipCode = null;
	private String service;
	private String orderDate;
	private String orderTime;
	private String orderNote;
	private String CC_Number1;
	private String cType;
	private String Month1;
	private String Year1;
	CustomerService customerService;
	CustomerServices customerServices;
	EmailService emailService;
	OrderService orderService;
	Address addressObj = new Address();
	Customer sessionCustomer;
	Customer dbCustomer;
	Customer seller;
	CServices cServices;
	Order order;
	private static final String AM = "AM";
	private static final String PM = "PM";
	private static final Log log = LogFactory.getLog(Register1.class);

	public String execute() throws Exception {

		Order order = (Order) (request.getSession().getAttribute("order"));
		try {
			String realPath = "struts";
			ResourceBundle myResources = ResourceBundle.getBundle(realPath);
			String taxRateStr = myResources.getString("taxRate");
			service = getService();
			fullName = getFullName();
			phoneNumber = getPhoneNumber();
			email = getEmail();
			address = getAddress();
			password = getPassword();
			confirmPassword = getConfirmPassword();
			city = getCity();
			state = getState();
			zipCode = getZipCode();
			addressObj.setAddress(address);
			addressObj.setCity(city);
			addressObj.setState(state);
			addressObj.setZipCode(zipCode);
			orderDate = getOrderDate();
			orderTime = getOrderTime();
			orderNote = getOrderNote();
			sessionCustomer = order.getBuyer();
			seller = getCustomerService().lookupCustomer(
					myResources.getString("sellerEmail"));
			cServices = seller.getCServices();
			request.getSession().setAttribute("cServices", cServices);
			order.setSeller(seller);
			order.setOrderDate(orderDate);
			order.setOrderTime(orderTime);
			order.setOrderNote(orderNote);
			Calendar calendar = Calendar.getInstance();
			Calendar calendar1 = Calendar.getInstance();
			calendar1.set(Calendar.HOUR, Integer.parseInt(orderTime.substring(
					0, 2)));
			calendar1.set(Calendar.MINUTE, Integer.parseInt(orderTime
					.substring(3, 5)));
			StringTokenizer tokenizer = new StringTokenizer(orderDate, "/");
			String day = "";
			while (tokenizer.hasMoreTokens()) {
				// puts the last token in the day
				day = tokenizer.nextToken();
			}
			calendar1.set(Calendar.DAY_OF_MONTH, Integer.parseInt(day));
			String amOrPM = orderTime.substring(orderTime.length() - 2,
					orderTime.length());
			if (AM.equalsIgnoreCase(amOrPM)) {
				calendar1.set(Calendar.AM_PM, 0);
			}
			if (PM.equalsIgnoreCase(amOrPM)) {
				calendar1.set(Calendar.AM_PM, 1);
			}
			// if the chosen month and day are same
			if (calendar1.before(calendar)) {
				addActionError("Please choose a future Order Time");
				return ERROR;
			}
			if (calendar1.get(Calendar.DAY_OF_WEEK) == 2){
				addActionError("Pickup on Monday is not available");
				return ERROR;
			}
			
			// customer information not available in the session
			if (null == sessionCustomer) {
				// if the email entered by using the new registration form is
				// not null
				try {
					// customer found in the database
					dbCustomer = customerService.lookupCustomer(email);
					addActionError(email+" is registered. Please Login to Continue.");
					return ERROR;

				} catch (CustomerNotFoundException e) {
					// customer is not found in the database
					// create a new customer
					sessionCustomer = new Customer();
					sessionCustomer = (Customer) setCustomerInfo(sessionCustomer);
					UserPrivilege privilage = new UserPrivilege();
					privilage.setPrivilege(UserPrivilegeType.ROLE_GUEST.name());
					sessionCustomer.addRole(privilage);
					sessionCustomer.setCServices(new CServices());
					customerService.addCustomer(sessionCustomer);
					order.setBuyer(sessionCustomer);
					try {
						// send a test email to the email that user entered
						emailService.sendCustomerEmail(sessionCustomer);
					} catch (Exception e1) {
						// if the email entered by the user is dummy then return
						// an error
						addActionError("Email Address "+email+" appears to be invalid.");
						return ERROR;
					}
				}
				Shipment shipment = new Shipment(sessionCustomer.getAddress(),
						sessionCustomer, seller, 1);
				ShipmentState state = ShipmentState.ACCEPTED;
				shipment.setState(state);
				shipment.setShipmentType(service);
				order.setShipment(shipment);
				order.setOrderStatus("PENDING");
				orderService.saveOrder(order);
			} else {
				sessionCustomer = (Customer) setCustomerInfo(sessionCustomer);
				customerService.editCustomer(sessionCustomer);
				Shipment shipment = new Shipment(sessionCustomer.getAddress(),
						sessionCustomer, seller, 1);
				ShipmentState state = ShipmentState.ACCEPTED;
				shipment.setState(state);
				shipment.setShipmentType(service);
				order.setShipment(shipment);
				order.setOrderStatus("PENDING");
				if (order.getId() != null)
					orderService.updateOrder(order);
				else
					orderService.saveOrder(order);
			}
			request.getSession().setAttribute("CC_Number1", CC_Number1);
			request.getSession().setAttribute("cType", cType);
			request.getSession().setAttribute("Month1", Month1);
			request.getSession().setAttribute("Year1", Year1);
			request.getSession().setAttribute("order", order);

		} catch (Exception ex) {
			addActionError("" + ex.getMessage());
			ex.printStackTrace();
			return ERROR;
		}

		return SUCCESS;

	}

	public Customer setCustomerInfo(Customer sessionCustomer) {
		sessionCustomer.setFullName(fullName);
		sessionCustomer.setPhoneNumber(phoneNumber);
		sessionCustomer.setEmail(email);
		sessionCustomer.setPassword(password);
		sessionCustomer.setConfirmPassword(confirmPassword);
		sessionCustomer.setAddress(addressObj);
		return sessionCustomer;
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

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getFullName() {
		return fullName;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmail() {
		return email;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddress() {
		return address;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCity() {
		return city;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getState() {
		return state;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getZipCode() {
		return zipCode;
	}

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public String getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}

	public String getOrderNote() {
		return orderNote;
	}

	public void setOrderNote(String orderNote) {
		this.orderNote = orderNote;
	}

	public CustomerService getCustomerService() {
		return customerService;
	}

	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}

	public CustomerServices getCustomerServices() {
		return customerServices;
	}

	public void setCustomerServices(CustomerServices customerServices) {
		this.customerServices = customerServices;
	}

	public EmailService getEmailService() {
		return emailService;
	}

	public void setEmailService(EmailService emailService) {
		this.emailService = emailService;
	}

	public OrderService getOrderService() {
		return orderService;
	}

	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}

	public void setCC_Number1(String cC_Number1) {
		CC_Number1 = cC_Number1;
	}

	public String getCC_Number1() {
		return CC_Number1;
	}

	public String getCType() {
		return cType;
	}

	public void setCType(String type) {
		cType = type;
	}

	public void setMonth1(String month1) {
		Month1 = month1;
	}

	public String getMonth() {
		return Month1;
	}

	public void setYear1(String year1) {
		Year1 = year1;
	}

	public String getYear1() {
		return Year1;
	}
}
