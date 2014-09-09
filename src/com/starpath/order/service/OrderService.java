package com.starpath.order.service;

import java.util.List;

import org.springframework.jmx.export.annotation.ManagedResource;

import com.starpath.order.domain.Customer;
import com.starpath.order.domain.Order;
import com.starpath.order.domain.Shipment;

@ManagedResource(objectName = "starpath:name=orderService")
public interface OrderService {
	public void saveOrder(Order order) throws OrderServiceException;

	public List<Order> listOrders(String sellerId);

	public Order findOrderById(String id);

	public void updateOrder(Order order) throws OrderServiceException;

	public void removeOrder(Order order);

	public void saveShipment(Shipment shipment) throws OrderServiceException;
	
	public void updateShipment(Shipment shipment) throws OrderServiceException;

	public List<Order> listSellerOrders(Customer seller);

	public List<Order> listBuyerOrders(Customer buyer);
	
	public List<Order> listBuyerOrders(String phoneNumber, String lastName);
	
	public void cancelOrder(String id);
}
