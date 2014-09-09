package com.starpath.admin.actions;
import java.util.Set;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ActionSupport;
import com.starpath.order.domain.Address; 
import com.starpath.order.domain.CServices;
import com.starpath.order.domain.Customer;
import com.starpath.order.domain.UserPrivilege;
import com.starpath.order.domain.UserPrivilegeType;
import com.starpath.order.service.CustomerService;
import com.starpath.order.service.EmailService;
import com.starpath.order.service.EmailServiceException;

import com.temesoft.security.Base64Coder;
import com.temesoft.security.Encrypter;
import com.temesoft.security.Config;

public class Register extends ActionSupport implements ServletRequestAware, ServletResponseAware{
	 
	private HttpServletRequest request;
 
	private HttpServletResponse response;
	
	private String firstName=null;
	private String lastName=null;
	private String phoneNumber=null;
	private String email=null;
	private String password=null;
	private String passwordHint=null;
	private String passwordHintAnswer=null;
	private String confirmPassword=null;
	private String address=null;
	private String city=null;
	private String state=null;
	private String zipCode=null;
	//private String roles[] = null;
	private String passline=null;
	private String passlineEnc=null;
		
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

	CustomerService customerService;
	EmailService emailService;
	
	Address addressObj=new Address();
		
	Customer customer=new Customer();
	
	
	public String execute() throws Exception {
		
		firstName 	=   getFirstName();
		lastName  	=   getLastName();
		phoneNumber =   getPhoneNumber();
		email	 	=   getEmail();
		password 	=   getPassword();
		passwordHint=   getPasswordHint();
		confirmPassword=getConfirmPassword();
		address 	=   getAddress();
		city 		=   getCity();
		state 		=	getState();
		zipCode		=	getZipCode();
		addressObj.setAddress(address);
		addressObj.setCity(city);
		addressObj.setState(state);
		addressObj.setZipCode(zipCode);
		
		
		customer.setFirstName(firstName);
		customer.setLastName(lastName);
		customer.setPhoneNumber(phoneNumber);
		customer.setEmail(email);
		customer.setPassword(password);
		customer.setPasswordHint(passwordHint);
		customer.setPasswordHintAnswer(passwordHintAnswer);
		customer.setConfirmPassword(confirmPassword);
		customer.setAddress(addressObj);
		UserPrivilege privilage = new UserPrivilege();
		privilage.setPrivilege(UserPrivilegeType.ROLE_GUEST.name());
		customer.addRole(privilage);
		if(!(password.equals(confirmPassword))){
			 addActionError("Password and Confirm password are not same ");
			 return ERROR;
		 }
		
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
		 
		/* if(roles != null && customer != null){
			 
			 for(int i=0; i < roles.length;++i){
				 UserPrivilege privilage = new UserPrivilege();
				 privilage.setPrivilege(roles[i]);
				 customer.addRole(privilage);
			 }			 
		 }*/
		 try{
			 
			 customer.setCServices(new CServices());
			 customerService.addCustomer(customer);
			 
			 try{
				 emailService.sendCustomerEmail(customer);				 
			 }catch(EmailServiceException em){
				 addActionError("Sending mail to your Email Id failed.<br/>Please Check your Email id. ");
				 em.printStackTrace();
			 }catch(Exception ex){
				 addActionError("Sending mail to your Email Id failed.<br/>Please Check your Email id. ");
				 ex.printStackTrace();
			 }
			  
			 return SUCCESS;
			 
		 } catch(Exception ex){
			 addActionError("Account already exists");
			 ex.printStackTrace();			 
		 }
		return ERROR; 
	 }
	
	public void setServletRequest(HttpServletRequest request){
        this.request = request;
	}

	public HttpServletRequest getServletRequest()
	{
		return request;
	}
	
	public void setServletResponse(HttpServletResponse response){
		this.response = response;
	}
	
	public HttpServletResponse getServletResponse(){
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

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmail() {
		return email;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword() {
		return password;
	}

	public void setPasswordHint(String passwordHint) {
		this.passwordHint = passwordHint;
	}

	public String getPasswordHint() {
		return passwordHint;
	}
	
	public void setPasswordHintAnswer(String passwordHintAnswer) {
		this.passwordHintAnswer = passwordHintAnswer;
	}

	public String getPasswordHintAnswer() {
		return passwordHintAnswer;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	public String getConfirmPassword() {
		return confirmPassword;
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
	/*public String[] getRoles() {
		return roles;
	}

	public void setRoles(String[] roles) {
		this.roles = roles;
	}
	*/
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
	
	
	
}
