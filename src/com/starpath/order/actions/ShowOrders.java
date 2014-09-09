package com.starpath.order.actions;

import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ActionSupport;
import com.starpath.order.domain.Address;
import com.starpath.order.domain.Customer;
import com.starpath.order.domain.Order;
import com.starpath.order.domain.Shipment;
import com.starpath.order.domain.ShipmentState;
import com.starpath.order.domain.UserPrivilege;
import com.starpath.order.domain.UserPrivilegeType;
import com.starpath.order.service.CustomerService;
import com.starpath.order.service.EmailService;
import com.starpath.order.service.EmailServiceException;
import com.starpath.order.service.OrderService;

public class ShowOrders extends ActionSupport implements ServletRequestAware,
		ServletResponseAware {

	private HttpServletRequest request;

	private HttpServletResponse response;

	OrderService orderService;

	Customer customer;
	Order order;
	List<Order> orderList;
	private static final Log log = LogFactory.getLog(ShowOrders.class);

	public String execute() throws Exception {

		String orderId = request.getParameter("orderId");
		
		try {
			if(null != orderId && StringUtils.isNotEmpty(orderId)){
				order = orderService.findOrderById(orderId);
				request.getSession().setAttribute("order", order);
				return SUCCESS;
			}
			customer = (Customer) request.getSession().getAttribute("customer");
			Iterator<UserPrivilege> it = customer.getRoles().iterator();
			int k = 0;
			//checking for the user privileges and calling respective methods
			while (it.hasNext()) {
				UserPrivilege userPrivilege = it.next();
				if (userPrivilege.getPrivilege().equalsIgnoreCase(
						UserPrivilegeType.ROLE_STORE_OWNER.name())) {
					orderList = orderService.listSellerOrders(customer);
					k++;
				}

			}
			if (k == 0) {
				orderList = orderService.listBuyerOrders(customer);
			}

			log.debug("OrderList" + orderList.size());
			request.getSession().setAttribute("orderList", orderList);

		} catch (Exception ex) {
			addActionError("Show orders Failed");
			ex.printStackTrace();
			log.debug("Showing Orders Failed");
			return ERROR;
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
	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

}
