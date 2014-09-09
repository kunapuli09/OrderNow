package com.starpath.order.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Currency;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import junit.framework.TestCase;

import com.starpath.order.domain.Address;
import com.starpath.order.domain.Category;
import com.starpath.order.domain.Customer;
import com.starpath.order.domain.Item;
import com.starpath.order.domain.ItemState;
import com.starpath.order.domain.Order;
import com.starpath.order.domain.OrderItem;
import com.starpath.order.domain.Price;
import com.starpath.order.domain.Shipment;
import com.starpath.order.domain.ShipmentState;
import com.starpath.order.domain.UserPrivilege;

public class PDFServiceTest extends TestCase {
	public void testGeneratePDF() {
		PDFService pdfService = new ITextPDFServiceImpl();
		try {
			pdfService.generatePDF(createDummyOrder(), "/Users/krishna/pdf/");
		} catch (PDFGenerationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public Order createDummyOrder() {
		Order order = new Order();
		order.setId(new Long(10001));
		order.setBuyer(createCustomer());
		OrderItem orderedItem = new OrderItem();
		orderedItem.setItem(createItem());
		orderedItem.setOrder(order);
		orderedItem.setOrderedQuantity(new Integer(5));
		Set<OrderItem> orderedItems = new HashSet<OrderItem>();
		orderedItems.add(orderedItem);
		order.setOrderedItems(orderedItems);
		Shipment shipment = new Shipment();
		shipment.setShipmentType("PICKUP");
		shipment.setState(ShipmentState.ACCEPTED);
		order.setShipment(shipment);
		order.setSeller(createCustomer());
		
		return order;
	}

	private Customer createCustomer() {
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

	private Item createItem() {
		Price p = new Price(new BigDecimal(4.99), Currency.getInstance("USD"));
		Item i = new Item();
		i.setApprovalDatetime(new Date());
		i.setDescription("Boiled Spinach");
		i.setName("Spring Roll");
		i.setCreated(new Date());
		i.setStartDate(new Date());
		i.setEndDate(new Date());
		i.setState(ItemState.ACTIVE);
		i.setItemPrice(p);
		return i;
	}

	private Category createCategory() {
		Category lunchMenu = new Category();
		lunchMenu.setName("KKLunchMenu");
		return lunchMenu;
	}

}
