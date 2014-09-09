package com.starpath.dao;

import java.util.List;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;

import com.starpath.order.domain.Customer;
import com.starpath.order.domain.CServices;

/**
 * @version $Revision: 1.0 $ $Date: 2008/02/02 $
 * @since Hibernate 3.2.1 / Spring 2.0.6 / Maven 2.0.4
 * @author Krishna M. Kunapuli
 *         <p>
 *         Copyright ©2007-2008 by StarpathIT Inc., all rights reserved. <br>
 */

public class CustomerServicesDaoJpa extends GenericDaoJpa<CServices, Long>
		implements CustomerServicesDao {

	/*
	 * public List<Customer> getCustomer(String lastName, String phoneNumber) {
	 * Query q = null; if (null != lastName && null != phoneNumber) { q =
	 * entityManager.createQuery(
	 * "select d from Customer d where d.phoneNumber=?1 AND d.lastName=?2");
	 * q.setParameter(1, phoneNumber); q.setParameter(2, lastName); } else if
	 * (null != lastName && null == phoneNumber) { q = entityManager
	 * .createQuery("select d from Customer d where d.lastName=?1");
	 * q.setParameter(1, lastName); } else if (null == lastName && null !=
	 * phoneNumber) { q = entityManager
	 * .createQuery("select d from Customer d where d.phoneNumber=?1");
	 * q.setParameter(1, phoneNumber); } else { q =
	 * entityManager.createQuery("select d from Customer d"); } List matches =
	 * q.getResultList(); log.debug(matches.size()); return matches; }
	 */

	public CServices getCustomerServicesById(long customerid) {

		Query q = entityManager.createQuery(
				"select d from CServices d where d.customerid=?1");
		q.setParameter(1, customerid);
		List matches = q.getResultList();

		return (matches.size() > 0) ? (CServices) matches.get(0) : null;

	}
	public CServices getCustomerServices() {

		Query q = entityManager.createQuery(
				"select d from CServices d");
		List matches = q.getResultList();

		return (matches.size() > 0) ? (CServices) matches.get(0) : null;

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

}
