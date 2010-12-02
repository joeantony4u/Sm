package org.np.stoman.ajax.interfaze.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.np.stoman.security.LDAPAccessor;

public class BaseImpl {

	public static final String SUCCESS = "S:";
	public static final String EXCEPTION = "E:";

	protected LDAPAccessor ldap;

	protected BaseImpl() {
		ldap = new LDAPAccessor();
	}

	protected HttpServletRequest getHTTPServletRequest() {
		WebContext webCtx = WebContextFactory.get();
		return webCtx.getHttpServletRequest();
	}

	protected HttpSession getHTTPSession() {
		return getHTTPServletRequest().getSession();
	}

	// Object convert(Class<?> c, Map<String, String> fields) {
	// retBeanUtils.populate(c.newInstance(), fields);
	// }
}
