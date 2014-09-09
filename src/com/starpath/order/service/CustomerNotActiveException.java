package com.starpath.order.service;

@SuppressWarnings("serial")
public class CustomerNotActiveException extends Exception {
	public CustomerNotActiveException() {
	}

	public CustomerNotActiveException(String message) {
		super(message);
	}
}
