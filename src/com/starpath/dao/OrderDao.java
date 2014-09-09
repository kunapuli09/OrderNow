package com.starpath.dao;

import java.util.List;

import com.starpath.order.domain.Customer;
import com.starpath.order.domain.Order;

/**
 * @version $Revision: 1.0 $ $Date: 2008/02/02 $
 * @since Hibernate 3.2.1 / Spring 2.0.6 / Maven 2.0.4
 * @author Krishna M. Kunapuli
 *         <p>
 *         Copyright ©2007-2008 by StarpathIT Inc., all rights reserved. <br>
 */

public interface OrderDao extends GenericDao<Order, Long> {

	Order findById(Long id);

	List<Order> findAll();

	List<Order> findBySellerId(Customer seller);

	List<Order> findByBuyerId(Customer buyer);
	
	List<Order> findBuyerOrders(String phoneNumber, String lastName);
 }
