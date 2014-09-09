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
import com.starpath.login.actions.LogoutAction;
import com.starpath.order.domain.Customer;
import com.starpath.order.domain.Item;
import com.starpath.order.domain.Order;
import com.starpath.order.domain.OrderItem;
import com.starpath.order.service.CustomerService;
import com.starpath.order.service.ItemService;

public class AddOrder extends ActionSupport implements ServletRequestAware,
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
	private static final Log log = LogFactory.getLog(AddOrder.class);

	public String execute() throws Exception {

		Order order = null;
		Set<OrderItem> orderedItems = null;
		Long itemId = Long.parseLong(request.getParameter("itemId"));
		int quantity = Integer.parseInt(request.getParameter("quantity"));

		if (request.getSession().getAttribute("order") == null) {
		  
			//creating an order for the first time and adding an item
			orderedItems = new HashSet<OrderItem>(1, 1);
			item = getItemService().findById(itemId);
			order = new Order();
			OrderItem orderedItem = new OrderItem(order, item, quantity);
			orderedItems.add(orderedItem);
			for (OrderItem oItem : orderedItems) {
				log.debug(oItem.getItem().getDescription());
			}
			order.setOrderedItems(orderedItems);
			request.getSession().setAttribute("orderedItems", orderedItems);
			request.getSession().setAttribute("order", order);
			log.debug("here....");

		} else {
			//creating an ordered item and adding it to the existing order
			OrderItem orderedItem;
			order = (Order) request.getSession().getAttribute("order");
			orderedItems = new HashSet<OrderItem>(1, 1);
			orderedItems = order.getOrderedItems();
			item = getItemService().findById(itemId);

			int k = 0, existQuantity = 0;
			Iterator<OrderItem> it = orderedItems.iterator();
			while (it.hasNext()) {

				OrderItem orderItem = (OrderItem) it.next();
				/*checking whether added item exists already in orderedItems
				 * if already exists adding the existing quantity 
				 * with now entered quantity
				 */
				if (orderItem.getItem().getId().longValue() == itemId) {
					existQuantity = orderItem.getOrderedQuantity();
					quantity = quantity + existQuantity;
					it.remove();
					k++;
					log.debug("k=" + k);
				}

			}

			orderedItem = new OrderItem(order, item, quantity);
			orderedItems.add(orderedItem);

			order.setOrderedItems(orderedItems);
			request.getSession().setAttribute("orderedItems", orderedItems);
			request.getSession().setAttribute("order", order);
			log.debug("here in else....");
		}

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
