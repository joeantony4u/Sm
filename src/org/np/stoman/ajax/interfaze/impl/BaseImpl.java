package org.np.stoman.ajax.interfaze.impl;

import org.np.stoman.security.LDAPAccessor;

public class BaseImpl {
	protected LDAPAccessor ldap;

	protected BaseImpl() {
		ldap = new LDAPAccessor();
	}
}
