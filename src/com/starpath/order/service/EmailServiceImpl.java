package com.starpath.order.service;

import java.io.File;
import java.util.ResourceBundle;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

import com.starpath.order.domain.Customer;
import com.starpath.order.domain.Order;

public class EmailServiceImpl implements EmailService {
	private static final Log log = LogFactory.getLog(EmailServiceImpl.class);
	private static ResourceBundle myResources = ResourceBundle
			.getBundle("struts");
	private static final String ADMIN_EMAIL_SERVER = myResources
			.getString("adminEmailServer");
	private static final String ADMIN_EMAIL = myResources
			.getString("adminEmail");
	private static final String EFAX_EMAIL = myResources
			.getString("faxEmail");
	// TODO use spring injection
	private PDFService pdfService = null;

	public EmailServiceImpl() {
		pdfService = new ITextPDFServiceImpl();
	}

	public void sendCustomerEmail(Customer customer)
			throws EmailServiceException {

		try {

			JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
			mailSender.setHost(ADMIN_EMAIL_SERVER);

			SimpleMailMessage message = new SimpleMailMessage();
			message.setTo(customer.getEmail());
			message.setFrom(ADMIN_EMAIL);
			// TODO move these properties to static as well
			message.setSubject(myResources.getString("emailSubject"));
			message.setText(myResources.getString("emailMessage")
					+ myResources.getString("emailNotify")
					+ myResources.getString("claims"));
			mailSender.send(message);

		} catch (MailException e1) {
			throw new EmailServiceException(e1);
		}
	}

	/**
	 * Sends an email to fax server with attached document
	 * 
	 */
	public void sendFaxEmail(String fileName) throws EmailServiceException {

		try {

			JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
			mailSender.setHost(ADMIN_EMAIL_SERVER);
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true);
			helper.setTo(EFAX_EMAIL);
			helper.setFrom(ADMIN_EMAIL);
			FileSystemResource file = new FileSystemResource(new File(fileName));
			helper.addAttachment(fileName,file);
			mailSender.send(message);
		} catch (MailException e) {
			throw new EmailServiceException(e);
		} catch (MessagingException e) {
			throw new EmailServiceException(e);
		} 
	}

public void sendOrderConfirmationEmail(Order order,String fileName) throws EmailServiceException{
		
		try{
			
			JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
			mailSender.setHost(ADMIN_EMAIL_SERVER);
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true);			
			helper.setTo(order.getBuyer().getEmail());
			helper.setFrom(ADMIN_EMAIL);	
			String realPath = "struts";
			ResourceBundle myResources = ResourceBundle.getBundle(realPath);			
			helper.setSubject(myResources.getString("orderSubject"));
			helper.setText(" You have placed the following order. Please find the attachment to see the details.<br>"  + 
					"Please call Sai Grocery during store hours at 719-264-8532 if you have any questions or to Cancel your Order. "+myResources.getString("claims"));
			FileSystemResource file = new FileSystemResource(new File(fileName));
			System.out.println(fileName);
			helper.addAttachment(fileName,file);			
			mailSender.send(message);
		
		} catch (MailException e) {
			throw new EmailServiceException(e);
		}  catch(MessagingException e){
			e.printStackTrace();
		}
	}
public void sendCustomerPasswordEmail(Customer customer) throws EmailServiceException {
	
	try {
		
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
		mailSender.setHost(ADMIN_EMAIL_SERVER);

		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(customer.getEmail());
		message.setFrom(ADMIN_EMAIL);
		
		String realPath = "struts";
		ResourceBundle myResources = ResourceBundle.getBundle(realPath);
		
		message.setSubject(myResources.getString("emailSubject"));
		message.setText("Your SaiGrocery <br/> Password is "+customer.getPassword()+" "+ myResources.getString("emailNotify") + customer.getEmail() + myResources.getString("claims"));
		mailSender.send(message);
		
	} catch (MailException e1) {
		throw new EmailServiceException(e1);
	} 
}


	public PDFService getPdfService() {
		return pdfService;
	}

	public void setPdfService(PDFService pdfService) {
		this.pdfService = pdfService;
	}	

}
