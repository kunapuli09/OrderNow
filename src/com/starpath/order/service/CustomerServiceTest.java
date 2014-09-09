package com.starpath.order.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

import com.starpath.order.domain.Address;
import com.starpath.order.domain.CServices;
import com.starpath.order.domain.Customer;
import com.starpath.order.domain.UserPrivilege;

public class CustomerServiceTest extends
AbstractDependencyInjectionSpringContextTests 
{
	public CustomerServiceTest() {
	}

	@Override
	protected String[] getConfigLocations() {
		return new String[] { "applicationContext.xml"};
	}

	public void testLookupCustomer() {
		CustomerService customerService = (CustomerService) applicationContext
				.getBean("customerService");
		Customer customer;
		try {
			customer = customerService.lookupCustomer("3468288");
			assertNotNull(customer);
		} catch (Exception e) {
			//
		}
		
	}
	public void testAddCustomer() {
		CustomerService customerService = (CustomerService) applicationContext
				.getBean("customerService");
		customerService.addCustomer(createCustomer());			
	}
	private Customer createCustomer() {
		Customer user = new Customer();
		user.setAccountExpired(false);
		user.setAccountLocked(false);
		Address address = new Address();
		address.setAddress("420 Market Place");
		address.setCity("San Roman");
		address.setCountry("USA");
		address.setState("CA");
		address.setZipCode("94583");
		user.setAddress(address);
		/*Md5PasswordEncoder encoder = new Md5PasswordEncoder();
		 SystemWideSaltSource salt = new SystemWideSaltSource();
		 salt.setSystemWideSalt("ABC123XYZ789");
		 String pwd = encoder.encodePassword("pwd", salt);
		 */
		user.setConfirmPassword("password");
		user.setCredentialsExpired(false);
		user.setEmail("krishna@starpath.com");
		user.setEnabled(true);
		user.setFirstName("Krishna");
		user.setLastName("Kunapuli");
		user.setPassword("password");
		user.setPasswordHint("don't know");
		user.setPhoneNumber("3033468288");		
		List<UserPrivilege> roles = new ArrayList<UserPrivilege>();
		UserPrivilege role = new UserPrivilege();
		role.setPrivilege("ROLE_STORE_MANAGER");
		user.addRole(role);
		UserPrivilege role1 = new UserPrivilege();
		role1.setPrivilege("ROLE_GUEST");
		roles.add(role);
		roles.add(role1);
		user.addMoreRoles(roles);
		return user;
	}
	public void testEditCServices(){
		Customer seller = new Customer();
	    seller.setId(new Long(1));
	    CServices cServices = new CServices();
	    cServices.setCredit(false);
	    cServices.setDelivery(true);
	    cServices.setEmail(true);
	    cServices.setFax(true);
	    cServices.setPhone(false);
	    cServices.setOrders(true);
	    cServices.setUpdateOrders(true);
	    seller.setCServices(cServices);
	}


}
