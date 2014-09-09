package com.starpath.login.interceptors;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.aop.MethodBeforeAdvice;

import com.starpath.login.actions.LogoutAction;

import java.lang.reflect.Method;

public class LoggingInterceptor implements MethodBeforeAdvice {
	private static final Log log = LogFactory.getLog(LoggingInterceptor.class);

	public void before(Method method, Object[] objects, Object o)
			throws Throwable {
		log.debug("logging before!!");
	}
}
