package org.np.stoman.ajax.interfaze.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.np.stoman.security.LDAPAccessor;

public class BaseImpl {
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
}
