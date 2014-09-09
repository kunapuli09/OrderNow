package com.starpath.dao;

import java.util.List;

import com.starpath.order.domain.Customer;

/**
 * @version $Revision: 1.0 $ $Date: 2008/02/02 $
 * @since Hibernate 3.2.1 / Spring 2.0.6 / Maven 2.0.4
 * @author Krishna M. Kunapuli
 *         <p>
 *         Copyright ©2007-2008 by StarpathIT Inc., all rights reserved. <br>
 */

public interface CustomerDao extends GenericDao<Customer, Long> {
	// public List<Customer> getCustomer(String lastName, String phoneNumber);
	public Customer getCustomerByEmail(String email);

	// public Customer getCustomerByPhone(String phone);
	public Customer findById(Long customerId);

}
