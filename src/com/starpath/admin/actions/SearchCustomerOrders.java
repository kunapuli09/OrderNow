package com.starpath.admin.actions;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ActionSupport;
import com.starpath.order.domain.Order;
import com.starpath.order.service.OrderService;

public class SearchCustomerOrders extends ActionSupport implements
		ServletRequestAware, ServletResponseAware {

	private static final long serialVersionUID = 6363179647232841933L;

	private OrderService orderService;

	private HttpServletRequest request;

	private HttpServletResponse response;
	
	private List<Order> orders;
	
	public String execute() throws Exception {
		String phoneNumber = request.getParameter("phoneNumber");
		String lastName = request.getParameter("lastName");
		try {
			orders = orderService.listBuyerOrders(phoneNumber,
					lastName);
			request.getSession().setAttribute("orders", orders);
			return SUCCESS;
		} catch (Exception e) {
			addActionError("Failed to retrieve Orders");
			return ERROR;
		}
	}
	public List<Order> getOrders() {
		return orders;
	}

	public void setOrders(List<Order> orders) {
		this.orders = orders;
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
