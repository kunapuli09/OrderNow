package com.starpath.order.service;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.starpath.dao.OrderDao;
import com.starpath.dao.ShipmentDao;
import com.starpath.order.domain.Customer;
import com.starpath.order.domain.Order;
import com.starpath.order.domain.OrderStatusType;
import com.starpath.order.domain.Shipment;
import com.starpath.order.domain.ShipmentState;

@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
public class OrderServiceImpl implements OrderService {
	private static final Log log = LogFactory.getLog(OrderServiceImpl.class);

	public OrderServiceImpl() {
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void saveOrder(Order order) throws OrderServiceException {
		order.calculateTotal();
		order.setOrderStatus(OrderStatusType.PENDING.name());
		orderDao.makePersistent(order);
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void saveShipment(Shipment shipment) throws OrderServiceException {

		shipmentDao.makePersistent(shipment);
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void updateOrder(Order order) throws OrderServiceException {
		//TODO more work is pending
		Order dbOrder = orderDao.findById(order.getId());
		if (!dbOrder.getOrderStatus().equals(OrderStatusType.CANCEL.name())) {
			dbOrder.setOrderedItems(order.getOrderedItems());
			dbOrder.setBuyer(order.getBuyer());
			order.calculateTotal();
			dbOrder.setTotal(order.getTotal());
			dbOrder.setApprovalNumber(order.getApprovalNumber());
			dbOrder.setRecordNumber(order.getRecordNumber());
			dbOrder.setOrderStatus(OrderStatusType.READY.name());
		}
		
	}
	@Transactional(propagation = Propagation.REQUIRED)
	public void updateShipment(Shipment shipment) throws OrderServiceException {

		//TODO removed in the new code..work is pending
		Shipment dbShipment = shipmentDao.findById(shipment.getId());
		dbShipment.setShipmentType(shipment.getShipmentType());
		dbShipment.setState(shipment.getState());
		
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void removeOrder(Order order) {
		Order dbOrder = orderDao.findById(order.getId());
		dbOrder.setOrderStatus(OrderStatusType.CANCEL.name());
	}

	public List<Order> listOrders(String sellerId) {
		return orderDao.findAll();
	}

	public List<Order> listSellerOrders(Customer seller) {
		return orderDao.findBySellerId(seller);
	}

	public List<Order> listBuyerOrders(Customer buyer) {
		return orderDao.findByBuyerId(buyer);
	}

	public Order findOrderById(String id) {
		Long lId = Long.parseLong(id);
		return orderDao.findById(lId);
	}
	@Transactional(propagation = Propagation.REQUIRED)
	public void cancelOrder(String id) {
		Long lId = Long.parseLong(id);
		Order dbOrder = orderDao.findById(lId);
		dbOrder.setOrderStatus(OrderStatusType.CANCEL.name());
		
	}
	public List<Order> listBuyerOrders(String phoneNumber, String lastName) {
		return orderDao.findBuyerOrders(phoneNumber, lastName);
	}

	private OrderDao orderDao;
	private ShipmentDao shipmentDao;

	public void setShipmentDao(ShipmentDao shipmentDao) {
		this.shipmentDao = shipmentDao;
	}

	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}

}
