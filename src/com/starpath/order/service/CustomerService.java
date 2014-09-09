package com.starpath.order.service;

import org.springframework.jmx.export.annotation.ManagedResource;

import com.starpath.order.domain.Customer;

@ManagedResource(objectName = "starpath:name=customerService")
public interface CustomerService {
	public Customer lookupCustomer(String email)
			throws CustomerNotFoundException, CustomerNotActiveException;

	public void addCustomer(Customer customer);

	public void activateCustomer(String email) throws Exception;
	
	public void editCustomer(Customer customer);
	
	public void updateSellerServices(Customer seller);
}