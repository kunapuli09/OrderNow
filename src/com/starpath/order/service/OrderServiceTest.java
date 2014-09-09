package com.starpath.order.service;

import java.util.Date;
import java.util.List;
import java.util.Set;

import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

import com.starpath.order.domain.CreditCard;
import com.starpath.order.domain.CreditCardType;
import com.starpath.order.domain.Customer;
import com.starpath.order.domain.Item;
import com.starpath.order.domain.Order;
import com.starpath.order.domain.OrderItem;

public class OrderServiceTest extends
		AbstractDependencyInjectionSpringContextTests {
	public OrderServiceTest() {
	}

	@Override
	protected String[] getConfigLocations() {
		return new String[] { "applicationContext-test.xml" };

	}

	public void testSaveOrder() {
		Customer customer = null;
		Item item = null;
		OrderService orderService = (OrderService) applicationContext
				.getBean("orderService");
		Order order = new Order();
		CustomerService customerService = (CustomerService) applicationContext
				.getBean("customerService");
		ItemService itemService = (ItemService) applicationContext
		.getBean("itemService");
		
		try {
			customer = customerService.lookupCustomer("3033468288");
			if(customer.getPaymentDetails().size()==0){
				CreditCard card = new CreditCard("123456781234", CreditCardType.VISA, "08",
						"2008");
				card.setCreated(new Date());
				card.setPaymentAmount(new Double(10));
				card.setPaymentDate(new Date());
				card.setPaymentReceived(true);
			customer.addPayment(card);				
				
			}
		} catch (Exception e) {
			//
		}
		item = itemService.findById(new Long(1));
		order.addItem(item);
		order.setBuyer(customer);
		try {
			orderService.saveOrder(order);			
		} catch (OrderServiceException e) {
			e.printStackTrace();
		}
	}
	
	public void testUpdateOrder(){
		OrderService orderService = (OrderService) applicationContext
		.getBean("orderService");
		Order order = orderService.findOrderById("60");
		order.setOrderNote("Hello I hate changin my code");
		try {
			orderService.updateOrder(order);
		} catch (OrderServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void testListSellerOrders() throws CustomerNotFoundException, CustomerNotActiveException{
		OrderService orderService = (OrderService) applicationContext
		.getBean("orderService");
		Customer seller = new Customer();
		seller.setId(new Long(1));
		List<Order> orders = orderService.listSellerOrders(seller);
		for(Order order : orders){
			//System.out.println("Customer Name"+order.getBuyer().getEmail());
			System.out.println("Order Id"+order.getId().longValue());
			Set<OrderItem> orderItems = order.getOrderedItems();
			for(OrderItem oItem : orderItems){
				System.out.println(oItem.getItem().getDescription());
			}
		}
		
	}
	public void testListBuyerOrders() throws CustomerNotFoundException, CustomerNotActiveException{
		OrderService orderService = (OrderService) applicationContext
		.getBean("orderService");
		Customer buyer = new Customer();
		buyer.setId(new Long(1));
		List<Order> orders = orderService.listBuyerOrders(buyer);
		for(Order order : orders){
			//System.out.println("Customer Name"+order.getBuyer().getEmail());
			System.out.println("Order Id"+order.getId().longValue());
			Set<OrderItem> orderItems = order.getOrderedItems();
			for(OrderItem oItem : orderItems){
				System.out.println(oItem.getItem().getDescription());
			}
		}
		
	}
	public void testSearchBuyerOrders() throws CustomerNotFoundException, CustomerNotActiveException{
		OrderService orderService = (OrderService) applicationContext
		.getBean("orderService");
		List<Order> orders = orderService.listBuyerOrders("", "raja");
		for(Order order : orders){
			System.out.println("Order Id"+order.getId().longValue());
			Set<OrderItem> orderItems = order.getOrderedItems();
			for(OrderItem oItem : orderItems){
				System.out.println(oItem.getItem().getDescription());
			}
		}
		
	}
}
