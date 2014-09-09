package com.starpath.order.actions;

import com.opensymphony.xwork2.ActionSupport;
import java.util.*;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class OrderTimeAction extends ActionSupport {

	private List orderDay;
	private static final Log log = LogFactory.getLog(OrderTimeAction.class);

	public String execute() throws Exception {
		orderDay = new ArrayList();
		Calendar calendar = Calendar.getInstance();
		for (int i = 0; i < 7; i++) {
			String date = calendar.get(Calendar.DAY_OF_MONTH) + "/"
					+ (calendar.get(Calendar.MONTH) + 1) + "/"
					+ calendar.get(Calendar.YEAR);
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			log.debug("date" + date);
			orderDay.add(date);
		}
		return SUCCESS;

	}

	public List getOrderDay() {
		return orderDay;
	}
}