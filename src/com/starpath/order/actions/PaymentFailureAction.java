package com.starpath.order.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.googlecode.sslplugin.annotation.Secured;
import com.opensymphony.xwork2.ActionSupport;
import com.starpath.order.domain.Order;
import com.starpath.order.service.OrderService;

public class PaymentFailureAction extends ActionSupport implements
		ServletRequestAware, ServletResponseAware {

	private HttpServletRequest request;

	private HttpServletResponse response;

	OrderService orderService;
	Order order;
	private static final Log log = LogFactory.getLog(PaymentAction.class);

	
	public String execute() throws Exception {	
		order = (Order) request.getSession().getAttribute("order");
		String orderId = "";
		if(null == order){
			System.out.println("session order is null. so using orderId from call back url");
			log.debug("session order is null. so using orderId from call back url");
			orderId = request.getParameter("orderId");
			log.debug("orderid came back from securepay"+orderId);
			System.out.println("orderid came back from securepay"+orderId);
			order = orderService.findOrderById(orderId);
		}
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
	public OrderService getOrderService() {
		return orderService;
	}

	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}

}
