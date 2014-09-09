package com.starpath.admin.actions;

import java.util.Date;
import java.util.Properties;
import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;
import java.io.*;

import com.opensymphony.xwork2.ActionSupport;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.multipart.MultiPartRequestWrapper;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.springframework.util.FileCopyUtils;

import com.starpath.order.domain.Customer;

public class UpdateHolidays extends ActionSupport implements
		ServletRequestAware, ServletResponseAware {

	private HttpServletRequest request;

	private HttpServletResponse response;

	private String holidayDates = "";
	private boolean isSaturday = false;
	private boolean isSunday = false;
	private boolean isVisa = false;
	private boolean isMasterCard = false;
	private boolean isAmex = false;
	private boolean isDiscover = false;
	private static final Log log = LogFactory.getLog(UpdateHolidays.class);

	public String execute() throws Exception {

		try {

			String firstTime = request.getParameter("firstTime");

			HttpSession session = request.getSession();
			Customer customer = (Customer) session.getAttribute("customer");
			String email = "";
			String emailToken = "";

			if (customer != null) {

				email = customer.getEmail();
				int index = email.indexOf("@");
				emailToken = email.substring(0, index);

			}

			String realPath = "struts";
			ResourceBundle myResources = ResourceBundle.getBundle(realPath);

			if (firstTime == null) {
				log.debug("here in prooooooooooo");
				try {

					ResourceBundle proResources = null;
					FileInputStream fin = null;
					
					/*Checking Whether properties file for 
					 * email Token exists or not.
					 * If not creating that and copying the
					 *  Application_Resources file content into it*/
					
					try {

						String fileName = "";
						fileName = "/properties/ApplicationResources_"
								+ emailToken + ".properties";
						fin = new FileInputStream(myResources
								.getString("struts.multipart.propDir")
								+ fileName);
						proResources = new PropertyResourceBundle(fin);
						log.debug("here in try");
						// proResources = ResourceBundle.getBundle("properties"
						// + File.separator + "ApplicationResources_" +
						// emailToken);

					} catch (Exception ex) {
						
						String fileName = "";
						String fileName1 = "";
						fileName = "/properties/ApplicationResources.properties";
						fileName1 = "/properties/ApplicationResources_"
								+ emailToken + ".properties";
						InputStream in = new FileInputStream(myResources
								.getString("struts.multipart.propDir")
								+ fileName);
						OutputStream out = new FileOutputStream(myResources
								.getString("struts.multipart.propDir")
								+ fileName1);

						byte[] buf = new byte[1024];

						int len;

						while ((len = in.read(buf)) > 0) {

							out.write(buf, 0, len);

						}

						in.close();

						out.close();

						log.debug("File copied.");

						fin = new FileInputStream(myResources
								.getString("struts.multipart.propDir")
								+ fileName);
						proResources = new PropertyResourceBundle(fin);
						log.debug("here in catch");
						// proResources = ResourceBundle.getBundle("properties"
						// + File.separator + "ApplicationResources");
					}
					//writing the holiday dates into the properties file
					FileOutputStream fout = new FileOutputStream(myResources
							.getString("struts.multipart.propDir")
							+ File.separator
							+ "properties"
							+ File.separator
							+ "ApplicationResources_"
							+ emailToken
							+ ".properties", true);
					Properties pro = new Properties();

					if (holidayDates != null) {
						if (holidayDates.trim().length() > 0)
							pro.setProperty("holidayDates.content",
									holidayDates);
						else
							pro.setProperty("holidayDates.content",
									proResources
											.getString("holidayDates.content"));
					} else
						pro.setProperty("holidayDates.content", proResources
								.getString("holidayDates.content"));

					log.debug("isSaturday" + isSaturday);
					log.debug("isVisa" + isVisa);

					if (isSaturday)
						pro.setProperty("issaturday", "true");
					else
						pro.setProperty("issaturday", "false");

					if (isSunday)
						pro.setProperty("issunday", "true");
					else
						pro.setProperty("issunday", "false");

					if (isVisa)
						pro.setProperty("isvisa", "true");
					else
						pro.setProperty("isvisa", "false");

					if (isMasterCard)
						pro.setProperty("ismastercard", "true");
					else
						pro.setProperty("ismastercard", "false");

					if (isAmex)
						pro.setProperty("isamex", "true");
					else
						pro.setProperty("isamex", "false");

					if (isDiscover)
						pro.setProperty("isdiscover", "true");
					else
						pro.setProperty("isdiscover", "false");

					pro.store(fout, "");
					fout.close();

					return SUCCESS;

				} catch (Exception ex) {

					addActionError("Error in Updating holiday Dates - "
							+ ex.toString());
					ex.printStackTrace();

					return ERROR;

				}
			} else {
				//reading contents holiday dates,issaturday from properties file
				try {

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
							// proResources =
							// ResourceBundle.getBundle("properties" +
							// File.separator + "ApplicationResources");
						} else {
							String fileName = "";
							fileName = "/properties/ApplicationResources_"
									+ emailToken + ".properties";
							fin = new FileInputStream(myResources
									.getString("struts.multipart.propDir")
									+ fileName);
							proResources = new PropertyResourceBundle(fin);

							// proResources =
							// ResourceBundle.getBundle("properties" +
							// File.separator + "ApplicationResources_" +
							// emailToken);
						}

					} catch (Exception ex) {

						String fileName = "";
						fileName = "/properties/ApplicationResources.properties";
						fin = new FileInputStream(myResources
								.getString("struts.multipart.propDir")
								+ fileName);
						proResources = new PropertyResourceBundle(fin);
						// proResources = ResourceBundle.getBundle("properties"
						// + File.separator + "ApplicationResources");
						ex.printStackTrace();
					}

					log.debug("HOME="
							+ proResources.getString("home.content"));
					try {
						holidayDates = proResources
								.getString("holidayDates.content");
						if (proResources.getString("issaturday").equals("true"))
							isSaturday = true;
						if (proResources.getString("issunday").equals("true"))
							isSunday = true;
						if (proResources.getString("isvisa").equals("true"))
							isVisa = true;
						if (proResources.getString("ismastercard").equals(
								"true"))
							isMasterCard = true;
						if (proResources.getString("isamex").equals("true"))
							isAmex = true;
						if (proResources.getString("isdiscover").equals("true"))
							isDiscover = true;
					} catch (Exception ex) {
						ex.printStackTrace();
						return INPUT;

					}

					log.debug("came here = " + holidayDates);

					if (fin != null)
						fin.close();

				} catch (Exception ex) {

					addActionError("Error in Updating Holiday Dates - "
							+ ex.toString());
					ex.printStackTrace();

					return ERROR;

				}
				log.debug("input.....");
				return INPUT;
			}

		} catch (Exception ex) {

			addActionError("Error in Updating Holidays - " + ex.toString());
			ex.printStackTrace();
			return ERROR;

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

	public void setHolidayDates(String holidayDates) {
		this.holidayDates = holidayDates;
	}

	public String getHolidayDates() {
		return holidayDates;
	}

	public boolean getIsSaturday() {
		return isSaturday;
	}

	public void setIsSaturday(boolean isSaturday) {
		this.isSaturday = isSaturday;
	}

	public boolean getIsSunday() {
		return isSunday;
	}

	public void setIsSunday(boolean isSunday) {
		this.isSunday = isSunday;
	}

	public void setIsMasterCard(boolean isMasterCard) {
		this.isMasterCard = isMasterCard;
	}

	public boolean getIsMasterCard() {
		return isMasterCard;
	}

	public void setIsVisa(boolean isVisa) {
		this.isVisa = isVisa;
	}

	public boolean getIsVisa() {
		return isVisa;
	}

	public void setIsAmex(boolean isAmex) {
		this.isAmex = isAmex;
	}

	public boolean getIsAmex() {
		return isAmex;
	}

	public void setIsDiscover(boolean isDiscover) {
		this.isDiscover = isDiscover;
	}

	public boolean getIsDiscover() {
		return isDiscover;
	}

}