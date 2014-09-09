package com.starpath.admin.actions;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;
import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.springframework.util.FileCopyUtils;

import com.opensymphony.xwork2.ActionSupport;
import com.starpath.order.domain.Customer;

public class AdminStep1 extends ActionSupport implements ServletRequestAware,
		ServletResponseAware {

	private File upload1;

	private File upload2;
	// private File upload3;
	private File upload4;
	// private File upload5;

	private String upload1ContentType;
	private String upload2ContentType;
	// private String upload3ContentType;
	private String upload4ContentType;
	// private String upload5ContentType;

	private String upload1FileName;
	private String upload2FileName;
	// private String upload3FileName;
	private String upload4FileName;
	// private String upload5FileName;
	private String fileCaption;

	private HttpServletRequest request;

	private HttpServletResponse response;
	private String home = "Home";
	private String contact;
	private String addressline1;
	private String addressline2;

	private String addressline3;
	private String aboutus;
	// private String promotions;
	private String terms;
	private String restaurant;
	private String privacy;
	// private String todayspecial;
	private String phonenumber;

	private static final Log log = LogFactory.getLog(AdminStep1.class);

	public String execute() throws Exception {

		try {

			String firstTime = request.getParameter("firstTime");

			HttpSession session = request.getSession();
			Customer customer = (Customer) session.getAttribute("customer");
			String email = "";
			String emailToken = "";
			//calculating emailToken of the user(Restaurant Owner)
			if (customer != null) {

				//email = customer.getEmail();
				//int index = email.indexOf("@");
				//emailToken = email.substring(0, index);

			}

			String realPath = "struts";
			ResourceBundle myResources = ResourceBundle.getBundle(realPath);
			
			if (firstTime == null) {

				String path = "";
				String logoPath = null;
				String headerPath = null;
				String promotionsPath = null;
				String todaySpecialPath = null;
				String locationPath = null;

				File theFile;
				
				/*uploading logo image by creating directories like 
				*eg: /images/krishna/logo/logo.jpg*/
				
				if (upload1FileName != null) {

					logoPath = File.separator + "images" + File.separator
							+ emailToken + File.separator + "logo"
							+ File.separator + upload1FileName;
					String dirPath = myResources
							.getString("struts.multipart.saveDir")
							+ File.separator
							+ "images"
							+ File.separator
							+ emailToken + File.separator + "logo";
					File dfile = new File(dirPath);
					dfile.mkdirs();
					path = myResources.getString("struts.multipart.saveDir")
							+ logoPath;

					log.debug(path);
					theFile = new File(path);
					FileCopyUtils.copy(upload1, theFile);

				}
				
				//uploading header image
				if (upload2FileName != null) {

					headerPath = File.separator + "images" + File.separator
							+ emailToken + File.separator + "header"
							+ File.separator + upload2FileName;

					String dirPath = myResources
							.getString("struts.multipart.saveDir")
							+ File.separator
							+ "images"
							+ File.separator
							+ emailToken + File.separator + "header";
					File dfile = new File(dirPath);
					dfile.mkdirs();

					path = myResources.getString("struts.multipart.saveDir")
							+ headerPath;

					log.debug(path);
					theFile = new File(path);
					FileCopyUtils.copy(upload2, theFile);

				}

				/*
				 * if(upload3FileName!= null) {
				 * 
				 * 
				 * promotionsPath = File.separator + "images" + File.separator +
				 * emailToken + File.separator + "promotions" + File.separator +
				 * upload3FileName; String dirPath =
				 * myResources.getString("struts.multipart.saveDir") +
				 * File.separator + "images" + File.separator + emailToken +
				 * File.separator + "promotions"; File dfile = new
				 * File(dirPath); dfile.mkdirs(); path =
				 * myResources.getString("struts.multipart.saveDir") +
				 * promotionsPath;
				 * 
				 * log.debug(path); theFile = new File(path);
				 * FileCopyUtils.copy(upload3, theFile);
				 * 
				 * }
				 */
				
				//uploading location image
				if (upload4FileName != null) {

					locationPath = File.separator + "images" + File.separator
							+ emailToken + File.separator + "location"
							+ File.separator + upload4FileName;
					String dirPath = myResources
							.getString("struts.multipart.saveDir")
							+ File.separator
							+ "images"
							+ File.separator
							+ emailToken + File.separator + "location";
					File dfile = new File(dirPath);
					dfile.mkdirs();
					path = myResources.getString("struts.multipart.saveDir")
							+ locationPath;

					log.debug(path);
					theFile = new File(path);
					FileCopyUtils.copy(upload4, theFile);

				}

				/*
				 * if(upload5FileName!= null) {
				 * 
				 * 
				 * todaySpecialPath = File.separator + "images" + File.separator
				 * + emailToken + File.separator + "todayspecials" +
				 * File.separator + upload5FileName; String dirPath =
				 * myResources.getString("struts.multipart.saveDir") +
				 * File.separator + "images" + File.separator + emailToken +
				 * File.separator + "todayspecials"; File dfile = new
				 * File(dirPath); dfile.mkdirs(); path =
				 * myResources.getString("struts.multipart.saveDir") +
				 * todaySpecialPath;
				 * 
				 * log.debug(path); theFile = new File(path);
				 * FileCopyUtils.copy(upload5, theFile);
				 * 
				 * }
				 */
				
				/* writing uploaded file paths and contents like home,about us and etc..
				* to user's properties file*/
				try {

					ResourceBundle proResources = null;
					FileInputStream fin = null;

					try {

						String fileName = "";
						fileName = "/properties/ApplicationResources"
								+ emailToken + ".properties";
						fin = new FileInputStream(myResources
								.getString("struts.multipart.propDir")
								+ fileName);
						proResources = new PropertyResourceBundle(fin);

						// proResources = ResourceBundle.getBundle("properties"
						// + File.separator + "ApplicationResources_" +
						// emailToken);

					} catch (Exception ex) {

						String fileName = "";
						fileName = "/properties/ApplicationResources.properties";
						fin = new FileInputStream(myResources
								.getString("struts.multipart.propDir")
								+ fileName);
						proResources = new PropertyResourceBundle(fin);
						// proResources = ResourceBundle.getBundle("properties"
						// + File.separator + "ApplicationResources");
					}

					FileOutputStream fout = new FileOutputStream(myResources
							.getString("struts.multipart.propDir")
							+ File.separator
							+ "properties"
							+ File.separator
							+ "ApplicationResources"
							+ emailToken
							+ ".properties", true);
					Properties pro = new Properties();

					if (logoPath != null)
						pro.setProperty("header.logo", logoPath);
					else
						pro.setProperty("header.logo", proResources
								.getString("header.logo"));

					if (headerPath != null)
						pro.setProperty("header.header", headerPath);
					else
						pro.setProperty("header.header", proResources
								.getString("header.header"));

					/*
					 * if(promotionsPath != null)
					 * pro.setProperty("footer.promotions.image",
					 * promotionsPath); else
					 * pro.setProperty("footer.promotions.image",
					 * proResources.getString("footer.promotions.image"));
					 */

					if (locationPath != null)
						pro.setProperty("contactus.image", locationPath);
					else
						pro.setProperty("contactus.image", proResources
								.getString("contactus.image"));

					if (addressline1 != null)
						pro.setProperty("contactus.addressline1", addressline1);
					else
						pro.setProperty("contactus.addressline1", proResources
								.getString("contactus.addressline1"));

					if (addressline2 != null)
						pro.setProperty("contactus.addressline2", addressline2);
					else
						pro.setProperty("contactus.addressline2", proResources
								.getString("contactus.addressline2"));

					if (addressline3 != null)
						pro.setProperty("contactus.addressline3", addressline3);
					else
						pro.setProperty("contactus.addressline3", proResources
								.getString("contactus.addressline3"));

					if (phonenumber != null)
						pro.setProperty("contactus.phonenumber", phonenumber);
					else
						pro.setProperty("contactus.phonenumber", proResources
								.getString("contactus.phonenumber"));

					/*
					 * if(todaySpecialPath != null)
					 * pro.setProperty("footer.todaysspecial.image",
					 * todaySpecialPath); else
					 * pro.setProperty("footer.todaysspecial.image",
					 * proResources.getString("footer.todaysspecial.image"));
					 */

					if (home != null) {
						if (home.trim().length() > 0)
							pro.setProperty("home.content", home);
						else
							pro.setProperty("home.content", proResources
									.getString("home.content"));
					} else
						pro.setProperty("home.content", proResources
								.getString("home.content"));

					if (aboutus != null) {
						if (aboutus.trim().length() > 0)
							pro.setProperty("aboutus.content", aboutus);
						else
							pro.setProperty("aboutus.content", proResources
									.getString("aboutus.content"));
					} else
						pro.setProperty("aboutus.content", proResources
								.getString("aboutus.content"));

					if (contact != null) {
						if (contact.trim().length() > 0)
							pro.setProperty("contactus.content", contact);
						else
							pro.setProperty("contactus.content", proResources
									.getString("contactus.content"));
					} else
						pro.setProperty("contactus.content", proResources
								.getString("contactus.content"));

					/*
					 * if(promotions != null){ if(promotions.trim().length() >
					 * 0) pro.setProperty("promotions.content", promotions);
					 * else pro.setProperty("promotions.content",
					 * proResources.getString("promotions.content")); }else
					 * pro.setProperty("promotions.content",
					 * proResources.getString("promotions.content"));
					 */

					if (terms != null) {
						if (terms.trim().length() > 0)
							pro.setProperty("termsofuse.content", terms);
						else
							pro.setProperty("termsofuse.content", proResources
									.getString("termsofuse.content"));
					} else
						pro.setProperty("termsofuse.content", proResources
								.getString("termsofuse.content"));

					if (restaurant != null) {
						if (restaurant.trim().length() > 0)
							pro.setProperty("restaurantowners.content",
									restaurant);
						else
							pro
									.setProperty(
											"restaurantowners.content",
											proResources
													.getString("restaurantowners.content"));
					} else
						pro.setProperty("restaurantowners.content",
								proResources
										.getString("restaurantowners.content"));

					if (privacy != null) {
						if (privacy.trim().length() > 0)
							pro
									.setProperty("privacynsecurity.content",
											privacy);
						else
							pro
									.setProperty(
											"privacynsecurity.content",
											proResources
													.getString("privacynsecurity.content"));
					} else
						pro.setProperty("privacynsecurity.content",
								proResources
										.getString("privacynsecurity.content"));

					/*
					 * if(todayspecial != null){ if(todayspecial.trim().length()
					 * > 0) pro.setProperty("footer.todaysspecial.promotion1",
					 * todayspecial); else
					 * pro.setProperty("footer.todaysspecial.promotion1",
					 * proResources
					 * .getString("footer.todaysspecial.promotion1")); }else
					 * pro.setProperty("footer.todaysspecial.promotion1",
					 * proResources
					 * .getString("footer.todaysspecial.promotion1"));
					 */

					pro.store(fout, "");
					fout.close();

					return SUCCESS;

				} catch (NullPointerException ex) {

					addActionError("Error in Uploading Files - "
							+ ex.toString());
					ex.printStackTrace();

					return ERROR;

				} catch (IOException io) {

					addActionError("Unable to upload files into file system - "
							+ io.toString());
					io.printStackTrace();

					return ERROR;

				} catch (IllegalArgumentException il) {

					addActionError("Make sure property key is valid - "
							+ il.toString());
					il.printStackTrace();

					return ERROR;

				} catch (ClassCastException cs) {

					addActionError("Make sure Classpath environment setup properly - "
							+ cs.toString());
					cs.printStackTrace();

					return ERROR;
				}
			} else {
				/*reading the existing contents of home,about us and etc contents from
				 *the user's properties file to show them in uploadStep1.jsp*/
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
							fileName = "/properties/ApplicationResources"
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
					home = proResources.getString("home.content");
					contact = proResources.getString("contactus.content");
					addressline1 = proResources
							.getString("contactus.addressline1");
					addressline2 = proResources
							.getString("contactus.addressline2");
					addressline3 = proResources
							.getString("contactus.addressline3");
					aboutus = proResources.getString("aboutus.content");
					// promotions =
					// proResources.getString("promotions.content");
					terms = proResources.getString("termsofuse.content");
					restaurant = proResources
							.getString("restaurantowners.content");
					privacy = proResources
							.getString("privacynsecurity.content");
					// todayspecial =
					// proResources.getString("footer.todaysspecial.promotion1"
					// );
					phonenumber = proResources
							.getString("contactus.phonenumber");

					log.debug("came here = " + home);

					if (fin != null)
						fin.close();

				} catch (NullPointerException ex) {

					addActionError("Error in Uploading Files - "
							+ ex.toString());
					ex.printStackTrace();

					return ERROR;

				} catch (IllegalArgumentException il) {

					addActionError("Make sure property key is valid - "
							+ il.toString());
					il.printStackTrace();

					return ERROR;

				} catch (ClassCastException cs) {

					addActionError("Make sure Classpath environment setup properly - "
							+ cs.toString());
					cs.printStackTrace();

					return ERROR;
				}

				return INPUT;
			}

		} catch (Exception ex) {

			addActionError("Error in Uploading Files - " + ex.toString());
			ex.printStackTrace();
			return ERROR;

		}
	}

	public String getFileCaption() {
		return fileCaption;
	}

	public void setFileCaption(String fileCaption) {
		this.fileCaption = fileCaption;
	}

	public void setHome(String data) {
		this.home = data;
	}

	public void setContact(String data) {
		this.contact = data;
	}

	public void setAboutus(String data) {
		this.aboutus = data;
	}

	/*
	 * public void setPromotions(String data){ this.promotions = data; }
	 */

	public void setTerms(String data) {
		this.terms = data;
	}

	public void setRestaurant(String data) {
		this.restaurant = data;
	}

	public void setPrivacy(String data) {
		this.privacy = data;
	}

	/*
	 * public void setTodayspecial(String data){ this.todayspecial = data; }
	 */

	public String getHome() {
		return this.home;
	}

	public String getContact() {
		return this.contact;
	}

	public String getAboutus() {
		return this.aboutus;
	}

	/*
	 * public String getPromotions(){ return this.promotions; }
	 */

	public String getTerms() {
		return this.terms;
	}

	public String getRestaurant() {
		return this.restaurant;
	}

	public String getPrivacy() {
		return this.privacy;
	}

	/*
	 * public String getTodayspecial(){ return this.todayspecial; }
	 */

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

	public void setAddressline1(String addressline1) {
		this.addressline1 = addressline1;
	}

	public String getAddressline1() {
		return addressline1;
	}

	public void setAddressline3(String addressline3) {
		this.addressline3 = addressline3;
	}

	public String getAddressline3() {
		return addressline3;
	}

	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}

	public String getPhonenumber() {
		return phonenumber;
	}

	public File getUpload1() {
		return upload1;
	}

	public void setUpload1(File upload1) {
		this.upload1 = upload1;
	}

	public File getUpload2() {
		return upload2;
	}

	public void setUpload2(File upload2) {
		this.upload2 = upload2;
	}

	/*
	 * public File getUpload3() { return upload3; }
	 * 
	 * public void setUpload3(File upload3) { this.upload3 = upload3; }
	 */

	public File getUpload4() {
		return upload4;
	}

	public void setUpload4(File upload4) {
		this.upload4 = upload4;
	}

	/*
	 * public File getUpload5() { return upload5; }
	 * 
	 * public void setUpload5(File upload5) { this.upload5 = upload5; }
	 */

	public String getUpload1FileName() {
		return upload1FileName;
	}

	public void setUpload1FileName(String uploadFileName1) {
		this.upload1FileName = uploadFileName1;
	}

	public String getUpload2FileName() {
		return upload2FileName;
	}

	public void setUpload2FileName(String uploadFileName2) {
		this.upload2FileName = uploadFileName2;
	}

	/*
	 * public String getUpload3FileName() { return upload3FileName; }
	 * 
	 * public void setUpload3FileName(String uploadFileName3) {
	 * this.upload3FileName = uploadFileName3; }
	 */

	public String getUpload4FileName() {
		return upload4FileName;
	}

	public void setUpload4FileName(String uploadFileName4) {
		this.upload4FileName = uploadFileName4;
	}

	/*
	 * public String getUpload5FileName() { return upload5FileName; }
	 * 
	 * public void setUpload5FileName(String uploadFileName5) {
	 * this.upload5FileName = uploadFileName5; }
	 */

	public String getAddressline2() {
		return addressline2;
	}

	public void setAddressline2(String addressline2) {
		this.addressline2 = addressline2;
	}

	public String getUpload1ContentType() {
		return upload1ContentType;
	}

	public void setUpload1ContentType(String upload1ContentType) {
		this.upload1ContentType = upload1ContentType;
	}

	public String getUpload2ContentType() {
		return upload2ContentType;
	}

	public void setUpload2ContentType(String upload2ContentType) {
		this.upload2ContentType = upload2ContentType;
	}

	/*
	 * public String getUpload3ContentType() { return upload3ContentType; }
	 * 
	 * public void setUpload3ContentType(String upload3ContentType) {
	 * this.upload3ContentType = upload3ContentType; }
	 */

	public String getUpload4ContentType() {
		return upload4ContentType;
	}

	public void setUpload4ContentType(String upload4ContentType) {
		this.upload4ContentType = upload4ContentType;
	}

	/*
	 * public String getUpload5ContentType() { return upload5ContentType; }
	 * 
	 * public void setUpload5ContentType(String upload5ContentType) {
	 * this.upload5ContentType = upload5ContentType; }
	 */

}