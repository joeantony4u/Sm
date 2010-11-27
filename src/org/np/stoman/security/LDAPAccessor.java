package org.np.stoman.security;

import java.util.ArrayList;
import java.util.List;

import javax.naming.directory.InvalidAttributeValueException;

import org.apache.directory.ldap.client.api.LdapConnection;
import org.apache.directory.ldap.client.api.message.SearchResponse;
import org.apache.directory.ldap.client.api.message.SearchResultEntry;
import org.apache.directory.shared.ldap.cursor.Cursor;
import org.apache.directory.shared.ldap.entry.client.ClientEntry;
import org.apache.directory.shared.ldap.filter.SearchScope;
import org.apache.log4j.Logger;

public class LDAPAccessor {

	private static final Logger logger = Logger.getLogger(LDAPAccessor.class);

	private static final LdapConnection lc;

	static {
		// TODO: Security? Hash it in server?
		lc = new LdapConnection("localhost", 10389);
		try {
			lc.bind("uid=admin,ou=system", "secret");
		} catch (Exception e) {
			logger.error("Exception in Initializing LDAP: "
					+ e.getStackTrace().toString());
		}
	}

	public static void close() {
		try {
			lc.unBind();
			lc.close();
		} catch (Exception e) {
			logger.error("LDAP closing failed due to: "
					+ e.getStackTrace().toString());
		}

	}

	public ClientEntry authenticate(final String un, final String pw) {
		ClientEntry ce = null;
		List<ClientEntry> entries = search("ou=ad,o=jb", "(&(cn=" + un
				+ ")(userPassword=" + pw + "))", SearchScope.ONELEVEL, "cn",
				"sn");
		if (entries.size() > 1) {
			logger.error("Duplicate User credentials for username: " + un);
			return ce;
		}
		if (!entries.isEmpty())
			ce = entries.get(0);
		logger.debug("User Credentials status for attemped username: " + un
				+ " is " + (ce != null ? "Success" : "Failure"));
		return ce;
	}

	public List<ClientEntry> buildMenu(String dn, ClientEntry ce) {
		List<ClientEntry> entries = new ArrayList<ClientEntry>();
		try {
			entries = search(dn, "(l=" + ce.get("sn").getString() + ")",
					SearchScope.ONELEVEL, "*");
		} catch (InvalidAttributeValueException e) {
			e.printStackTrace();
		}
		return entries;
	}

	private static List<ClientEntry> search(final String dn,
			final String filter, final SearchScope scope,
			final String... attributes) {
		List<ClientEntry> dns = new ArrayList<ClientEntry>();
		try {
			Cursor<SearchResponse> cursor = lc.search(dn, filter, scope,
					attributes);
			while (cursor.next())
				dns.add((ClientEntry) ((SearchResultEntry) cursor.get())
						.getEntry());
		} catch (Exception e) {
			logger.error(e.getStackTrace().toString());
		}
		return dns;
	}
}
