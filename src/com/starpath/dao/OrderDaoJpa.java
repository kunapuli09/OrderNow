package com.starpath.dao;

import java.util.List;

import javax.persistence.Query;

import org.apache.commons.lang.StringUtils;

import com.starpath.order.domain.Category;
import com.starpath.order.domain.Customer;
import com.starpath.order.domain.Order;

/**
 * @version $Revision: 1.0 $ $Date: 2008/02/02 $
 * @since Hibernate 3.2.1 / Spring 2.0.6 / Maven 2.0.4
 * @author Krishna M. Kunapuli
 *         <p>
 *         Copyright ©2007-2008 by StarpathIT Inc., all rights reserved. <br>
 */

public class OrderDaoJpa extends GenericDaoJpa<Order, Long> implements OrderDao {
	public Order findById(long orderId) {
		Query q = entityManager
				.createQuery("select c from Order c where c.id =?1");
		q.setParameter(1, orderId);

		return (Order) q.getResultList();
	}

	public List<Order> findBySellerId(Customer seller) {
		Query q = entityManager
				.createQuery("select c from Order c where c.seller.id =?1");
		q.setParameter(1, seller.getId().longValue());

		return (List<Order>) q.getResultList();
	}

	public List<Order> findByBuyerId(Customer buyer) {
		Query q = entityManager
				.createQuery("select c from Order c where c.buyer.id =?1");
		q.setParameter(1, buyer.getId().longValue());

		return (List<Order>) q.getResultList();
	}

	public List<Order> findBuyerOrders(String phoneNumber, String lastName) {
		if (null != phoneNumber && null != lastName) {
			if (StringUtils.isNotEmpty(phoneNumber)
					&& StringUtils.isNotEmpty(lastName)) {
				Query q = entityManager
						.createQuery("select c from Order c where c.buyer.phoneNumber =?1 and c.buyer.lastName=?2");
				q.setParameter(1, phoneNumber);
				q.setParameter(2, lastName);
				return (List<Order>) q.getResultList();

			} else if (StringUtils.isNotEmpty(phoneNumber)
					&& StringUtils.isEmpty(lastName)) {
				Query q = entityManager
						.createQuery("select c from Order c where c.buyer.phoneNumber =?1");
				q.setParameter(1, phoneNumber);
				return (List<Order>) q.getResultList();

			} else if (StringUtils.isEmpty(phoneNumber)
					&& StringUtils.isNotEmpty(lastName)) {
				Query q = entityManager
						.createQuery("select c from Order c where c.buyer.lastName=?1");
				q.setParameter(1, lastName);
				return (List<Order>) q.getResultList();
			} else {
				return findAll();
			}
		}
		return null;
	}

}
