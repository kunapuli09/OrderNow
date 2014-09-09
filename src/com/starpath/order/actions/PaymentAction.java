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
import com.starpath.order.domain.CServices;
import com.starpath.order.domain.Customer;
import com.starpath.order.domain.Order;
import com.starpath.order.domain.OrderStatusType;
import com.starpath.order.domain.Shipment;
import com.starpath.order.service.CustomerService;
import com.starpath.order.service.CustomerServices;
import com.starpath.order.service.EmailService;
import com.starpath.order.service.ITextPDFServiceImpl;
import com.starpath.order.service.OrderService;
import com.starpath.order.service.PDFService;

public class PaymentAction extends ActionSupport implements
		ServletRequestAware, ServletResponseAware {

	private HttpServletRequest request;

	private HttpServletResponse response;

	private String service;
	private String paymentBy;
	private String orderDate;
	private String orderTime;
	private String CC_Number1;
	private String Month1;
	private String Year1;

	CustomerService customerService;
	EmailService emailService;
	OrderService orderService;
	CustomerServices customerServices;

	Customer customer;
	Customer isCustomer;
	Order order;
	Order dbOrder;
	Shipment shipment;
	private static final Log log = LogFactory.getLog(PaymentAction.class);
	public String execute() throws Exception {
		String returnCode = request.getParameter("Return_Code");
		String approvNum = request.getParameter("Approv_Num");
		String cardResponse = request.getParameter("Card_Response");
		String avsResponse = request.getParameter("AVS_Response");
		String voidRecordNum = request.getParameter("VoidRecNum");

		
		order = (Order) request.getSession().getAttribute("order");
		// verify the crditcard processing response and return error message if failed
		if (null != returnCode && returnCode.equalsIgnoreCase("N")) {
			return ERROR;
		}
		if (null!= avsResponse && !avsResponse.equalsIgnoreCase("Y")) {
			return ERROR;
		}
		if (null !=voidRecordNum && voidRecordNum.equalsIgnoreCase("000")) {
			return ERROR;
		}
		String orderId = "";
		if (null == order) {
			log
					.info("session order is null. so using orderId from call back url");
			orderId = request.getParameter("orderId");
			log.info("orderid came back from securepay" + orderId);
			order = orderService.findOrderById(orderId);
		}
		try {
			//update order with credit card transaction information
			orderId = request.getParameter("orderId");
			if(null != orderId){
			dbOrder = orderService.findOrderById(orderId);
			dbOrder.setApprovalNumber(approvNum);
			dbOrder.setRecordNumber(voidRecordNum);
			dbOrder.setOrderStatus(OrderStatusType.READY.name());
			orderService.updateOrder(dbOrder);
			System.out.println("Order with orderId="+orderId+" is updated with approvalNumber"+approvNum+"and voidRecordNum"+voidRecordNum);
			}else{
				System.out.println("OrderId is NULL so didn't update order with crdit card transaction information");
			}
			
			
			request.getSession().setAttribute("viewOrder", order);
			request.getSession().removeAttribute("order");
			
			
			String realPath = "struts";
			ResourceBundle myResources = ResourceBundle.getBundle(realPath);
			String pdfPath = myResources.getString("struts.multipart.pdfFiles");
			Customer seller = getCustomerService().lookupCustomer(
					myResources.getString("sellerEmail"));
			CServices cServices = seller.getCServices();
			PDFService pdfService = new ITextPDFServiceImpl();

			String fileName = pdfService.generatePDF(order, pdfPath);
			if (cServices != null && cServices.getEmail()) {
				emailService.sendOrderConfirmationEmail(order, fileName);
				log.debug("Sent Email to Customer");
			}
			if (cServices != null && cServices.getFax()) {
				log.debug("Sent Order Fax To Store");
				emailService.sendFaxEmail(fileName);
			}

		} catch (Exception ex) {
			addActionError("Error occured during sending Order Summary to the mail.");
			ex.printStackTrace();
			log.error(ex.getMessage());
			return ERROR;
		}
		request.getSession().invalidate();
		return SUCCESS;

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

	public CustomerServices getCustomerServices() {
		return customerServices;
	}

	public void setCustomerServices(CustomerServices customerServices) {
		this.customerServices = customerServices;
	}

}
