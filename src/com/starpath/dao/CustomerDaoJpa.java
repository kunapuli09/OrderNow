package com.starpath.dao;

import java.util.List;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;

import com.starpath.order.domain.Customer;

/**
 * @version $Revision: 1.0 $ $Date: 2008/02/02 $
 * @since Hibernate 3.2.1 / Spring 2.0.6 / Maven 2.0.4
 * @author Krishna M. Kunapuli
 *         <p>
 *         Copyright ©2007-2008 by StarpathIT Inc., all rights reserved. <br>
 */

public class CustomerDaoJpa extends GenericDaoJpa<Customer, Long> implements
		CustomerDao {

	

	public Customer getCustomerByEmail(String email) {

		Query q = entityManager.createQuery(
				"select d from Customer d where d.email=?1");
		q.setParameter(1, email);
		List matches = q.getResultList();

		return (matches.size() > 0) ? (Customer) matches.get(0) : null;

	}

	/*
	 * public Customer getCustomerByPhone(String phone) {
	 * 
	 * log.debug("entityManager=" + entityManager);
	 * 
	 * Query q = entityManager
	 * .createQuery("select d from Customer d where d.phoneNumber=?1");
	 * q.setParameter(1, phone); List matches = q.getResultList(); return
	 * (matches.size() > 0) ? (Customer) matches.get(0) : null; }
	 */
	public Customer findById(Long customerId) {
		Query q = entityManager.createQuery(
				"select d from Customer d where d.id=?1");
		q.setParameter(1, customerId);
		List matches = q.getResultList();

		return (matches.size() > 0) ? (Customer) matches.get(0) : null;
	}

}
