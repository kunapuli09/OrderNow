package com.starpath.admin.actions;



import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.context.ApplicationContext;

import com.opensymphony.xwork2.ActionSupport;
import com.starpath.order.domain.Customer;
import com.starpath.order.service.CustomerService;
import com.starpath.order.service.EmailService;
import com.starpath.order.service.EmailServiceException;

public class ForgotPassword extends ActionSupport implements ServletRequestAware, ServletResponseAware {
	
	//private static final long serialVersionUID = 1L; 
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6363179647232841933L;
	
	CustomerService customerService;
	EmailService emailService;
    
	private String userName 	=  null;
   //	private String phoneNumber 	=  null;
   	private String passwordHint =  null;
   	private String passwordHintAnswer = null;
	private HttpServletRequest request;

	private HttpServletResponse response; 
       public String execute() throws Exception {
    	
    	if(request.getSession().getAttribute("customer")==null){
				
    				userName 			= getUserName();
					//phoneNumber 		= getPhoneNumber();
					//passwordHint		= getPasswordHint();
					//passwordHintAnswer	= getPasswordHintAnswer();
					try{
						 Customer customer = getCustomerService().lookupCustomer(userName);
						// if(passwordHint.equals(customer.getPasswordHint())&&passwordHintAnswer.equals(customer.getPasswordHintAnswer())){
							 	try{
							 		emailService.sendCustomerPasswordEmail(customer);
							 		
							 	}catch(EmailServiceException em){
							 		em.printStackTrace();
							 	}catch(Exception ex){
							 		ex.printStackTrace();
							 	}
							 	
								return SUCCESS;
					   /*}else{
						   		addActionError("Username and Password hint  do not match");
						   		return ERROR;
					   } 
					   */
					 }catch(com.starpath.order.service.CustomerNotFoundException ex){
						 addActionError("Customer Not Found ");	
						 System.out.println("Customer NOT FOUND");			 
					 }
					 catch(com.starpath.order.service.CustomerNotActiveException ex){
						 
						 addActionError("Your Account is not activated");
						 System.out.println("Customer NOT Activated");
					 }
			
					 return ERROR;
    	}
    	else{
    		return SUCCESS;
    	}
       		
	}
    
   /* public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}*/

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

    public void setServletRequest(HttpServletRequest request){
        this.request = request;
    }

    public HttpServletRequest getServletRequest(){
        return request;
    }

    public void setServletResponse(HttpServletResponse response){
        this.response = response;
    }

    public HttpServletResponse getServletResponse(){
        return response;
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


}
