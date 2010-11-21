package irritate;

import org.apache.directory.ldap.client.api.LdapConnection;
import org.apache.directory.ldap.client.api.message.SearchResponse;
import org.apache.directory.shared.ldap.cursor.Cursor;
import org.apache.directory.shared.ldap.filter.SearchScope;
import org.apache.log4j.Logger;

public class LDAPClient {

	private static Logger logger = Logger.getLogger(LDAPClient.class);

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
					"&(cn=" + un + ")(userPassword=" + pw + ")",
					SearchScope.ONELEVEL, "cn");
			return cursor.next();
		} catch (Exception e) {
			logger.error("User Credentials failed for attemped username: " + un);
			logger.error(e.getStackTrace().toString());
			return false;
		}
	}
}
