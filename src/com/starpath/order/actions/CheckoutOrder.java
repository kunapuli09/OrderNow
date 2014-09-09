package com.starpath.order.actions;

import java.util.Calendar;
import java.util.ResourceBundle;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ActionSupport;
import com.starpath.order.domain.CServices;
import com.starpath.order.domain.Customer;
import com.starpath.order.domain.Order;
import com.starpath.order.domain.OrderStatusType;
import com.starpath.order.domain.Shipment;
import com.starpath.order.domain.ShipmentState;
import com.starpath.order.service.CustomerService;
import com.starpath.order.service.EmailService;
import com.starpath.order.service.OrderService;

public class CheckoutOrder extends ActionSupport implements
		ServletRequestAware, ServletResponseAware {

	private HttpServletRequest request;

	private HttpServletResponse response;

	private String service;
	private String paymentBy;
	private String orderDate;
	private String orderTime;
	private String orderNote;
	private String CC_Number1;
	private String Month1;
	private String Year1;
	public static int save = 0;

	CustomerService customerService;
	EmailService emailService;
	OrderService orderService;

	Customer customer;
	Customer dbCustomer;
	Order order;
	private static final String AM = "AM";
	private static final String PM = "PM";

	public String execute() throws Exception {
		String realPath = "struts";
		ResourceBundle myResources = ResourceBundle.getBundle(realPath);
		String taxRateStr = myResources.getString("taxRate");
		Float taxRate = Float.parseFloat(taxRateStr);
		Float tax = 0.0f;
		Float total = 0.0f;
		if (service == null) {
			addActionError("Please Choose any one option(Pickup/Delivery)");
			return ERROR;
		}
		if (paymentBy == null) {
			addActionError("Please Choose any one option(Pay Now/Pay Later) ");
			return ERROR;
		}
		// roles = request.getParameterValues("roles");
		else {
			Order order = (Order) request.getSession().getAttribute("order");
			Customer customer = order.getBuyer();
			if (customer == null) {
				// do we ever go into this condition??
				// this is more of the original logic
				// everything should be taken from order domain object
				customer = (Customer) request.getSession().getAttribute(
						"customer");
				order.setBuyer(customer);
			} else {

				try {
					dbCustomer = customerService.lookupCustomer(customer
							.getEmail());
				} catch (Exception ex) {
					// First time there will be a Customer Not FoundException
				}
				if (dbCustomer == null) {
					customer.setCServices(new CServices());
					customerService.addCustomer(customer);
				} else {
					customerService.editCustomer(dbCustomer);
					order.setBuyer(dbCustomer);
				}
			}
			request.getSession().setAttribute("service", service);
			request.getSession().setAttribute("CC_Number", CC_Number1);
			request.getSession().setAttribute("Month", Month1);
			request.getSession().setAttribute("Year", Year1);
			request.getSession().setAttribute("paymentBy", paymentBy);
			Calendar calendar = Calendar.getInstance(); 
			Calendar calendar1 = Calendar.getInstance();
			calendar1.set(Calendar.HOUR,Integer.parseInt(orderTime.substring(0,2)));
			calendar1.set(Calendar.MINUTE,Integer.parseInt(orderTime.substring(3,5)));
			StringTokenizer tokenizer = new StringTokenizer(orderDate, "/");
			String day = "";
			while(tokenizer.hasMoreTokens()){
			 //puts the last token in the day
			  day = tokenizer.nextToken();			
			}
			
			
			calendar1.set(Calendar.DAY_OF_MONTH, Integer.parseInt(day));
			String amOrPM = orderTime.substring(orderTime.length()-2, orderTime.length());
			if(AM.equalsIgnoreCase(amOrPM)){
				calendar1.set(Calendar.AM_PM, 0);	
				if(service.equalsIgnoreCase("delivery")){
					addActionError("Cafe-Tandoor DELIVRY hours are in 5PM-10PM in the evening");
				    return ERROR;
				}
			}
			if(PM.equalsIgnoreCase(amOrPM)){
				calendar1.set(Calendar.AM_PM, 1);
				if(service.equalsIgnoreCase("delivery")){
				if(calendar1.get(Calendar.HOUR) < 5){
					addActionError("Please choose a DELIVERY after 5PM in the evening.");
				    return ERROR;
				}
				}
					
			}			
			//if the chosen month and day are same
			if(calendar1.before(calendar)){
					addActionError("Please choose a future Order Time");
				    return ERROR;
			}
			
				
			
			if (order != null) {
				if (order.getId() != null) {
					try {
						Order dbOrder = orderService.findOrderById(String
								.valueOf(order.getId().longValue()));
						// set order info
						dbOrder.setOrderDate(orderDate);
						dbOrder.setOrderTime(orderTime);						
						dbOrder.setOrderNote(orderNote);
						Shipment shipment = new Shipment(customer.getAddress(),
								customer, customer, 1);
						ShipmentState state = ShipmentState.ACCEPTED;
						shipment.setState(state);
						shipment.setShipmentType(service);
						dbOrder.setShipment(shipment);
						dbOrder.setOrderStatus(OrderStatusType.PENDING.name());
						dbOrder.setBuyer(order.getBuyer());
						dbOrder.setOrderedItems(order.getOrderedItems());
						// total before adding tax
						total = dbOrder.calculateTotal();
						tax = total * taxRate / 100;
						dbOrder.setTax(tax);
						// total after tax
						dbOrder.calculateTotal();
						orderService.updateOrder(dbOrder);
						// set the order to the session
						request.getSession().setAttribute("order", dbOrder);
					} catch (Exception ex) {
						addActionError("Error in updating an order");
						ex.printStackTrace();
						return ERROR;
					}
				} else {
					try {
						// set order info
						order.setOrderDate(orderDate);
						order.setOrderTime(orderTime);
						order.setOrderNote(orderNote);
						Shipment shipment = new Shipment(customer.getAddress(),
								customer, customer, 1);
						ShipmentState state = ShipmentState.ACCEPTED;
						shipment.setState(state);
						shipment.setShipmentType(service);
						order.setShipment(shipment);
						order.setOrderStatus("PENDING");
						// total before adding tax
						total = order.calculateTotal();
						tax = total * taxRate / 100;
						order.setTax(tax);
						// total after tax
						order.calculateTotal();
						orderService.saveOrder(order);
						// set the order to the session
						request.getSession().setAttribute("order", order);
					} catch (Exception ex) {
						addActionError("Error in placing an order");
						ex.printStackTrace();
						return ERROR;
					}

				}
			}
			return SUCCESS;
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

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
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

	public OrderService getOrderService() {
		return orderService;
	}

	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}

	public void setService(String service) {
		this.service = service;
	}

	public String getService() {
		return service;
	}

	public void setPaymentBy(String paymentBy) {
		this.paymentBy = paymentBy;
	}

	public String getPaymentBy() {
		return paymentBy;
	}

	public void setCC_Number1(String cC_Number1) {
		CC_Number1 = cC_Number1;
	}

	public String getCC_Number1() {
		return CC_Number1;
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

	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}

	public String getOrderTime() {
		return orderTime;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderNote(String orderNote) {
		this.orderNote = orderNote;
	}

	public String getOrderNote() {
		return orderNote;
	}

}
