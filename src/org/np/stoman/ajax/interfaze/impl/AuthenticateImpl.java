package org.np.stoman.ajax.interfaze.impl;

import org.np.stoman.ajax.interfaze.Authenticate;

public class AuthenticateImpl extends BaseImpl implements Authenticate {

	@Override
	public String login(String un, String pw) {
		// TODO: send URL as response on success?
		return ldap.authenticate(un, pw) ? "success" : "failure";
	}

}
