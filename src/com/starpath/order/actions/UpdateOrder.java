package com.starpath.order.actions;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ActionSupport;
import com.starpath.order.domain.Customer;
import com.starpath.order.domain.Item;
import com.starpath.order.domain.Order;
import com.starpath.order.domain.OrderItem;
import com.starpath.order.service.CustomerService;
import com.starpath.order.service.ItemService;

public class UpdateOrder extends ActionSupport implements ServletRequestAware,
		ServletResponseAware {

	// private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	private static final long serialVersionUID = 6363179647232841933L;

	private HttpServletRequest request;
	private HttpServletResponse response;
	ItemService itemService;
	Item item = null;
	private static final Log log = LogFactory.getLog(UpdateOrder.class);

	public String execute() throws Exception {

		Order order = null;
		Set<OrderItem> orderedItems = null;
		Long itemId = Long.parseLong(request.getParameter("itemId"));
		// String itemId = request.getParameter("itemId");

		order = (Order) request.getSession().getAttribute("order");
		orderedItems = new HashSet<OrderItem>(1, 1);
		// orderedItems =
		// (Set<OrderItem>)request.getSession().getAttribute("orderedItems");
		orderedItems = order.getOrderedItems();
		// item=getItemService().findById(itemId);
		log.debug("Order:" + order);
		Iterator<OrderItem> it = orderedItems.iterator();
		while (it.hasNext()) {
			OrderItem orderItem = (OrderItem) it.next();
			if (orderItem.getItem().getId().longValue() == itemId) {
				it.remove();
			}
		}

		// order.removeItem(itemId);
		order.setOrderedItems(orderedItems);

		// request.getSession().setAttribute("orderedItems",orderedItems);
		request.getSession().setAttribute("order", order);
		log.debug("here in else....");

		log.debug("Success....");
		return SUCCESS;

	}

	public ItemService getItemService() {
		return itemService;
	}

	public void setItemService(ItemService itemService) {
		this.itemService = itemService;
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
}
