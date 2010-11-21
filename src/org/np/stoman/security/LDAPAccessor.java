package org.np.stoman.security;

import org.apache.directory.ldap.client.api.LdapConnection;
import org.apache.directory.ldap.client.api.message.SearchResponse;
import org.apache.directory.shared.ldap.cursor.Cursor;
import org.apache.directory.shared.ldap.filter.SearchScope;
import org.apache.log4j.Logger;

public class LDAPAccessor {

	private static Logger logger = Logger.getLogger(LDAPAccessor.class);

	private static LdapConnection lc;

	static {
		// TODO: Security? Hash it in server?
		lc = new LdapConnection("localhost", 10389);
		try {
			lc.bind("uid=admin,ou=system", "secret");
		} catch (Exception e) {
			logger.error("Exception in Initializing LDAP: " + e.getMessage());
		}
	}

	public static void close() {
		try {
			lc.unBind();
			lc.close();
		} catch (Exception e) {
			logger.error("LDAP closing failed due to: " + e.getMessage());
		}

	}

	public boolean authenticate(String un, String pw) {
		try {
			Cursor<SearchResponse> cursor = lc.search("ou=ad,o=jb",
					// "(userPassword={SHA}FDHR9jFFnZj60xUUI+KbjeP+L7k=)",
					"(&(cn=" + un + ")(userPassword=" + pw + "))",
					SearchScope.ONELEVEL, "cn");
			boolean authStatus = cursor.next(); // TODO: Better centralized code
			logger.debug("User Credentials status for attemped username: " + un
					+ " is " + (authStatus ? "Success" : "Failure"));
			return authStatus;
		} catch (Exception e) {
			logger.error(e.getStackTrace().toString());
			return false;
		}
	}
}
