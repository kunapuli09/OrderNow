package com.starpath.order.service;

import org.springframework.jmx.export.annotation.ManagedResource;

import com.starpath.order.domain.CServices;

@ManagedResource(objectName = "starpath:name=customerServices")
public interface CustomerServices {
	public CServices lookupCustomerSevices(long customerid)
			throws CustomerNotFoundException;
	public CServices lookupCustomerSevices();

	public void addCustomerServices(CServices customerServices);

	public void updateCustomerServices(CServices customerServices);
	// public void editCustomer(Customer customer);
}