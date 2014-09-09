package com.starpath.order.actions;

import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ActionSupport;
import com.starpath.order.domain.Order;
import com.starpath.order.domain.OrderItem;
import com.starpath.order.service.OrderService;

public class CancelOrder extends ActionSupport implements ServletRequestAware,
		ServletResponseAware {

	private HttpServletRequest request;

	private HttpServletResponse response;

	private OrderService orderService;

	public String execute() throws Exception {

		String orderId = request.getParameter("orderId");
		if (null != orderId && StringUtils.isNotEmpty(orderId)) {
			orderService.cancelOrder(orderId);
			return SUCCESS;
		} else {
			Order order = (Order) request.getSession().getAttribute("order");
			orderService.cancelOrder(String.valueOf(order.getId()));
			Set<OrderItem> orderedItems = new HashSet<OrderItem>(1, 1);
			order.setOrderedItems(orderedItems);
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

	public OrderService getOrderService() {
		return orderService;
	}

	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}

}
