package com.starpath.menu.actions;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ActionSupport;
import com.starpath.order.domain.Category;
import com.starpath.order.domain.Customer;
import com.starpath.order.domain.Order;
import com.starpath.order.service.ItemService;
import com.starpath.order.service.OrderService;

public class GetCategories extends ActionSupport implements
		ServletRequestAware, ServletResponseAware {

	private HttpServletRequest request;

	private HttpServletResponse response;
	private static final Log log = LogFactory.getLog(GetCategories.class);

	String parentCategory = null;
	String sellerLogin = null;
	ItemService itemService;
	OrderService orderService;
	String orderId;

	public String execute() throws Exception {

		// searchCriteria.setParentCategoryName(parentCategory);
		parentCategory = (String) request.getParameter("menu");
		sellerLogin = (String) request.getParameter("sellerLogin");
		orderId = (String)request.getParameter("orderId");
		
		try {
			if("true".equals(sellerLogin)){
				Order dbOrder = orderService.findOrderById(orderId);
				Order sessionOrder = (Order)request.getSession().getAttribute("order");
				sessionOrder.setBuyer(dbOrder.getBuyer());
				List<Category> categoryList = getItemService()
				.listMenuCategoriesForHeader(parentCategory);
				request.getSession().setAttribute("categoryList", categoryList);
				request.getSession().setAttribute("order", sessionOrder);
				return SUCCESS;
			}else{
			log.debug("itemService:" + itemService);
			List<Category> categoryList = getItemService()
					.listMenuCategoriesForHeader(parentCategory);
			request.getSession().setAttribute("categoryList", categoryList);
			return SUCCESS;
			}

		} catch (Exception ex) {
			addActionError("Categories Not Found ");
			log.debug("Categories NOT FOUND");
			ex.printStackTrace();
		}

		return ERROR;

	}

	public ItemService getItemService() {
		return itemService;
	}

	public void setItemService(ItemService itemService) {
		this.itemService = itemService;
	}
	public OrderService getOrderService() {
		return orderService;
	}

	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
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
