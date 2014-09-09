package com.starpath.order.service;

import java.util.ArrayList;
import java.util.List;

import junit.framework.TestCase;

import com.starpath.order.domain.Address;
import com.starpath.order.domain.Customer;
import com.starpath.order.domain.UserPrivilege;

public class EmailServiceTest extends TestCase {

	public void testSendCustomerEmail() {
		EmailService emailService = new EmailServiceImpl();
		try {
			emailService.sendCustomerEmail(createCustomer());
		} catch (EmailServiceException e) {
			fail(e.getMessage());
		}
	}

	public Customer createCustomer() {
		Customer buyer = new Customer();
		buyer.setAccountExpired(false);
		buyer.setAccountLocked(false);
		Address address = new Address();
		address.setAddress("420 Market Place");
		address.setCity("San Roman");
		address.setCountry("USA");
		address.setState("CA");
		address.setZipCode("94583");
		buyer.setAddress(address);
		buyer.setConfirmPassword("password");
		buyer.setCredentialsExpired(false);
		buyer.setEmail("krishna@starpath.com");
		buyer.setEnabled(true);
		buyer.setFirstName("Krishna");
		buyer.setLastName("Kunapuli");
		buyer.setPassword("password");
		buyer.setPasswordHint("don't know");
		buyer.setPhoneNumber("3033468288");
		List<UserPrivilege> roles = new ArrayList<UserPrivilege>();
		UserPrivilege role1 = new UserPrivilege();
		role1.setPrivilege("ROLE_BUYER");
		roles.add(role1);
		buyer.addMoreRoles(roles);
		return buyer;
	}

}
