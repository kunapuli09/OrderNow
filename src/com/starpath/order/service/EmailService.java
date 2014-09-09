package com.starpath.order.service;

import com.starpath.order.domain.Customer;
import com.starpath.order.domain.Order;

public interface EmailService {
	public void sendCustomerEmail(Customer customer)
			throws EmailServiceException;

	public void sendOrderConfirmationEmail(Order order,
			String fileName) throws EmailServiceException;

	public void sendCustomerPasswordEmail(Customer customer)
			throws EmailServiceException;
	public void sendFaxEmail(String fileName) throws EmailServiceException;
}
