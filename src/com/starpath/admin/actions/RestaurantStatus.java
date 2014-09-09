package com.starpath.admin.actions;

import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;
import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.context.ApplicationContext;

import com.opensymphony.xwork2.ActionSupport;
import com.starpath.order.domain.Customer;
import com.starpath.order.service.CustomerService;

public class RestaurantStatus extends ActionSupport implements
		ServletRequestAware, ServletResponseAware {

	private HttpServletRequest request;

	private HttpServletResponse response;

	private String holidayDates = "";

	private static final Log log = LogFactory.getLog(RestaurantStatus.class);

	public String execute() throws Exception {

		String orderDate = request.getParameter("orderdate");

		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		Date date = format.parse(orderDate);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);

		int week = calendar.get(Calendar.DAY_OF_WEEK);

		log.debug("Week:-" + week);

		String emailToken = "";
		if (request.getSession().getAttribute("emailToken") != null)
			emailToken = (String) request.getSession().getAttribute(
					"emailToken");
		String realPath = "struts";
		ResourceBundle myResources = ResourceBundle.getBundle(realPath);

		log.debug("emailToken" + emailToken);
		ResourceBundle proResources = null;
		FileInputStream fin = null;

		try {
			if (emailToken != null && emailToken.length() == 0) {
				String fileName = "";
				fileName = "/properties/ApplicationResources.properties";
				fin = new FileInputStream(myResources
						.getString("struts.multipart.propDir")
						+ fileName);
				proResources = new PropertyResourceBundle(fin);
				log.debug("in try........");
				// proResources = ResourceBundle.getBundle("properties" +
				// File.separator + "ApplicationResources");
			} else {
				String fileName = "";
				fileName = "/properties/ApplicationResources" + emailToken
						+ ".properties";
				fin = new FileInputStream(myResources
						.getString("struts.multipart.propDir")
						+ fileName);
				proResources = new PropertyResourceBundle(fin);
				log.debug("in else........");
				// proResources = ResourceBundle.getBundle("properties" +
				// File.separator + "ApplicationResources_" + emailToken);
			}

		} catch (Exception ex) {

			String fileName = "";
			fileName = "/properties/ApplicationResources.properties";
			fin = new FileInputStream(myResources
					.getString("struts.multipart.propDir")
					+ fileName);
			proResources = new PropertyResourceBundle(fin);
			// proResources = ResourceBundle.getBundle("properties" +
			// File.separator + "ApplicationResources");
			ex.printStackTrace();
		}
		try {
			holidayDates = proResources.getString("holidayDates.content");
			String issaturday = proResources.getString("issaturday");
			log.debug("isSaturday:-" + issaturday);
			String issunday = proResources.getString("issunday");
			if ((week == 1 && issunday.equals("true"))
					|| (week == 7 && issaturday.equals("true"))) {
				return ERROR;
			}

			log.debug("holidaydates:" + holidayDates);
			int index = holidayDates.indexOf(orderDate);
			if (index == -1)
				return SUCCESS;
			else
				return ERROR;
		} catch (Exception ex) {
			ex.printStackTrace();
			return SUCCESS;
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
}
