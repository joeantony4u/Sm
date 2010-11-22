package org.np.stoman.ajax.interfaze.impl;

import org.apache.directory.shared.ldap.entry.client.ClientEntry;
import org.np.stoman.ajax.interfaze.Authenticate;

public class AuthenticateImpl extends BaseImpl implements Authenticate {

	@Override
	public boolean getAuth() {
		return getHTTPSession().getAttribute("subject") != null;
	}

	@Override
	public String login(String un, String pw) {
		ClientEntry ce = ldap.authenticate(un, pw);
		// TODO: send URL as response on success?
		return initializeSubjectSession(ce) ? "success" : "failure";
	}

	private boolean initializeSubjectSession(ClientEntry ce) {
		if (ce == null)
			return false;
		getHTTPSession().setAttribute("subject", ce);
		return true;
	}
}
