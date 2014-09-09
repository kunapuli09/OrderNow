/* 
 * Copyright 2000 Sun Microsystems, Inc. All rights reserved.
 * Copyright 2000 Sun Microsystems, Inc. Tous droits réservés. 
 */

package taglib;

import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

import java.util.*;
import java.io.*;

public class StarPathMessage extends BodyTagSupport {

	private String key;
	private PropertyResourceBundle myResources = null;

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
		init();
	}

	public void setPageContext(final javax.servlet.jsp.PageContext pageContext) {
		this.pageContext = pageContext;
	}

	public void init() {

		try {
			myResources = (PropertyResourceBundle) pageContext
					.getAttribute("myResources");
			pageContext.getOut().write(myResources.getString(key));

		} catch (Exception ex) {
			ex.printStackTrace();

		}
	}

	public int doAfterBody() throws JspException {
		return SKIP_BODY;
	}
}
