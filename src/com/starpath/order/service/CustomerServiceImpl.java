package com.starpath.order.service;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.starpath.dao.CustomerDao;
import com.starpath.dao.CustomerServicesDao;
import com.starpath.order.actions.UpdateOrder;
import com.starpath.order.domain.Customer;
import com.starpath.order.domain.CServices;

@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
public class CustomerServiceImpl implements CustomerService {
	private static final Log log = LogFactory.getLog(CustomerServiceImpl.class);

	public CustomerServiceImpl() {
	}

	public Customer lookupCustomer(String email)
			throws CustomerNotFoundException, CustomerNotActiveException {
		Customer customer = customerDao.getCustomerByEmail(email);

		if (null != customer) {

			/*if (customer.isEnabled() == false)
				throw new CustomerNotActiveException(
						"Activate your account. Please check your email account");
			else*/
				return customer;
		} else {
			throw new CustomerNotFoundException();
		}
	}

	

	@Transactional(propagation = Propagation.REQUIRED)
	public void addCustomer(Customer customer) {

		customerDao.makePersistent(customer);
		log.debug("Adding Customer");
	}

	

	@Transactional(propagation = Propagation.REQUIRED)
	public void activateCustomer(String email) throws Exception {
		try {
			Customer dbCustomer = customerDao.getCustomerByEmail(email);
			dbCustomer.setEnabled(true);
			log.debug("Activation Completed");
		} catch (NullPointerException ne) {
			ne.printStackTrace();
			throw new NullPointerException();
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new Exception();
		}
	}

	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public void editCustomer(Customer customer) {
		Customer dbCustomer = customerDao.findById(customer.getId());
		dbCustomer.setAddress(customer.getAddress());
		dbCustomer.setEmail(customer.getEmail());
		dbCustomer.setFirstName(customer.getFirstName());
		dbCustomer.setLastName(customer.getLastName());
		dbCustomer.setPassword(customer.getPassword());
		dbCustomer.setConfirmPassword(customer.getConfirmPassword());
		/*dbCustomer.setPasswordHint(customer.getPasswordHint());
		dbCustomer.setPasswordHintAnswer(customer.getPasswordHintAnswer());*/
		dbCustomer.setPhoneNumber(customer.getPhoneNumber());
		CServices dbCServices = dbCustomer.getCServices();
		dbCServices.setCredit(false);
	    dbCServices.setDelivery(false);
	    dbCServices.setEmail(false);
	    dbCServices.setFax(false);
	    dbCServices.setOrders(false);
	    dbCServices.setPhone(false);
	    dbCServices.setUpdateOrders(false);
	}
	@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
	public void updateSellerServices(Customer seller) {
		Customer dbCustomer = customerDao.findById(seller.getId());
		CServices dbCServices = dbCustomer.getCServices();
		dbCServices.setCredit(seller.getCServices().getCredit());
	    dbCServices.setDelivery(seller.getCServices().getDelivery());
	    dbCServices.setEmail(seller.getCServices().getEmail());
	    dbCServices.setFax(seller.getCServices().getFax());
	    dbCServices.setOrders(seller.getCServices().getOrders());
	    dbCServices.setPhone(seller.getCServices().getPhone());
	    dbCServices.setUpdateOrders(seller.getCServices().getUpdateOrders());
	}

	// injected by spring
	private CustomerDao customerDao;
	
	public void setCustomerDao(CustomerDao customerDao) {
		this.customerDao = customerDao;
	}

}
