package com.starpath.admin.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ActionSupport;
import com.starpath.order.domain.Address;
import com.starpath.order.domain.Customer;
import com.starpath.order.domain.Order;
import com.starpath.order.service.CustomerService;
import com.starpath.order.service.EmailService;
import com.starpath.order.service.EmailServiceException;
import com.temesoft.security.Base64Coder;
import com.temesoft.security.Config;
import com.temesoft.security.Encrypter;

public class EditProfile extends ActionSupport implements ServletRequestAware,
		ServletResponseAware {

	private HttpServletRequest request;

	private HttpServletResponse response;

	private String firstName = null;
	private String lastName = null;
	private String phoneNumber = null;
	private String password = null;
	private String passwordHint = null;
	private String passwordHintAnswer = null;
	private String confirmPassword = null;
	private String address = null;
	private String city = null;
	private String state = null;
	private String zipCode = null;
	private String passline=null;
	private String passlineEnc=null;

	CustomerService customerService;
	EmailService emailService;
	Address addressObj = new Address();

	Customer customer;
	private static final Log log = LogFactory.getLog(EditProfile.class);

	public String execute() throws Exception {
		String firstTime = request.getParameter("firstTime");
		Order order = (Order)request.getSession().getAttribute("order");
		customer = order.getBuyer();
		if (firstTime == null) {
			firstName = getFirstName();
			lastName = getLastName();
			phoneNumber = getPhoneNumber();
			password 	=   getPassword();
			confirmPassword=getConfirmPassword();
			passwordHint =   getPasswordHint();
			passwordHintAnswer = getPasswordHintAnswer();
			address = getAddress();
			city = getCity();
			state = getState();
			zipCode = getZipCode();
			log.debug("firstname:" + firstName);
			addressObj.setAddress(address);
			addressObj.setCity(city);
			addressObj.setState(state);
			addressObj.setZipCode(zipCode);
			log.debug("customerId:" + customer.getId());

			customer.setFirstName(firstName);
			customer.setLastName(lastName);
			customer.setPhoneNumber(phoneNumber);

			customer.setPassword(password);
			customer.setConfirmPassword(confirmPassword);
			
			customer.setPasswordHint(passwordHint);
			customer.setPasswordHintAnswer(passwordHintAnswer);
			
			customer.setAddress(addressObj);
			 if(passline == null){
				 
				 addActionError("Enter text placed in the image");
				 return ERROR;
			 }

			 if(passline != null){
				 
			    Encrypter stringEncrypter = new Encrypter();
		        String passlineDecoded = Base64Coder.decode(passlineEnc);
		        String passlineCheck = stringEncrypter.decrypt(passlineDecoded);

		        passlineCheck = passlineCheck.substring(0, Config.getPropertyInt(Config.MAX_NUMBER));

		        if (!passline.toUpperCase().equals(passlineCheck.toUpperCase())) {
		            String errorMsg = "Security code is incorrect";
					addActionError(errorMsg);
					return ERROR;
		        }
			 }

			try {

				log.debug("customerService" + customerService);
				log.debug("emailService" + emailService);
				customerService.editCustomer(customer);

				/*try {
					emailService.sendCustomerEmail(customer);
				} catch (EmailServiceException em) {
					em.printStackTrace();
				} catch (Exception ex) {
					ex.printStackTrace();
				}*/

				return SUCCESS;

			} catch (Exception ex) {
				addActionError("Account already exists");
				ex.printStackTrace();
				log.debug("Creation of customer account failed");
			}
			return ERROR;
		} else {
			firstName = customer.getFirstName();
			lastName = customer.getLastName();
			phoneNumber = customer.getPhoneNumber();
			password = customer.getPassword();
			confirmPassword = customer.getConfirmPassword();
			passwordHint = customer.getPasswordHint();
			passwordHintAnswer = customer.getPasswordHintAnswer();
			address = customer.getAddress().getAddress();
			city = customer.getAddress().getCity();
			state = customer.getAddress().getState();
			zipCode = customer.getAddress().getZipCode();
			return INPUT;
		}
	}

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpServletRequest getServletRequest() {
		return request;
	}

	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}

	public HttpServletResponse getServletResponse() {
		return response;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword() {
		return password;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public String getPasswordHint() {
		return passwordHint;
	}
	
	public void setPasswordHint(String passwordHint) {
		this.passwordHint = passwordHint;
	}
	
	public String getPasswordHintAnswer() {
		return passwordHintAnswer;
	}
	
	public void setPasswordHintAnswer(String passwordHintAnswer) {
		this.passwordHintAnswer = passwordHintAnswer;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddress() {
		return address;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCity() {
		return city;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getState() {
		return state;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getZipCode() {
		return zipCode;
	}

	public CustomerService getCustomerService() {
		return customerService;
	}

	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}

	public EmailService getEmailService() {
		return emailService;
	}

	public void setEmailService(EmailService emailService) {
		this.emailService = emailService;
	}
	public String getPassline() {
		return passline;
	}

	public void setPassline(String passline) {
		this.passline = passline;
	}

	public String getPasslineEnc() {
		return passlineEnc;
	}

	public void setPasslineEnc(String passlineEnc) {
		this.passlineEnc = passlineEnc;
	}
}
