/* 
 * Copyright 2000 Sun Microsystems, Inc. All rights reserved.
 * Copyright 2000 Sun Microsystems, Inc. Tous droits réservés. 
 */

package taglib;

import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


import java.util.*;
import java.io.*;

public class StarPathResource extends BodyTagSupport {

	private String email;
	private String key;

	private String strutsFileName = "struts";
	private PageContext pageContext;

	private ResourceBundle strutsmyResources = null;
	private PropertyResourceBundle myResources = null;
	private static final Log log = LogFactory.getLog(StarPathResource.class);

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
		init();
	}

	public void setPageContext(final javax.servlet.jsp.PageContext pageContext) {
		this.pageContext = pageContext;
	}

	public void init() {

		try {

			strutsmyResources = ResourceBundle.getBundle(strutsFileName);

			String fileName;
			fileName = "/properties/ApplicationResources.properties";

			try {

				log.debug(strutsmyResources
						.getString("struts.multipart.propDir")
						+ fileName);
				FileInputStream fin = new FileInputStream(strutsmyResources
						.getString("struts.multipart.propDir")
						+ fileName);
				myResources = new PropertyResourceBundle(fin);

				pageContext.setAttribute("myResources", myResources);

			} catch (Exception ex) {

				fileName = "/properties/ApplicationResources.properties";
				FileInputStream fin = new FileInputStream(strutsmyResources
						.getString("struts.multipart.propDir")
						+ fileName);
				myResources = new PropertyResourceBundle(fin);
				// pageContext.getOut().write(myResources.getString(key));
				pageContext.setAttribute("myResources", myResources);
				ex.printStackTrace();

			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public int doStartTag() throws JspException {
		return SKIP_BODY;
	}

	public int doAfterBody() throws JspException {
		return SKIP_BODY;
	}
}
