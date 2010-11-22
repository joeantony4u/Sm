package irritate;

import org.apache.directory.ldap.client.api.LdapConnection;
import org.apache.directory.ldap.client.api.message.SearchResponse;
import org.apache.directory.ldap.client.api.message.SearchResultEntry;
import org.apache.directory.shared.ldap.cursor.Cursor;
import org.apache.directory.shared.ldap.entry.client.ClientEntry;
import org.apache.directory.shared.ldap.filter.SearchScope;

public class LDAPClient {

	private static LdapConnection lc;

	static {
		// TODO: Security? Hash it in server?
		lc = new LdapConnection("localhost", 10389);
		try {
			lc.bind("uid=admin,ou=system", "secret");
		} catch (Exception e) {
		}
	}

	public static void close() {

	}

	public static void main(String[] args) {
		try {
			Cursor<SearchResponse> cursor = lc.search("ou=ad,o=jb",
					// "(userPassword={SHA}FDHR9jFFnZj60xUUI+KbjeP+L7k=)",
					"(&(cn=cuser)(userPassword=st0man))", SearchScope.ONELEVEL,
					"cn", "sn");
			while (cursor.next()) {
				System.out.println(((ClientEntry) ((SearchResultEntry) cursor
						.get()).getEntry()).get("sn"));
			}

		} catch (Exception e) {
		} finally {
			try {
				lc.unBind();
				lc.close();
			} catch (Exception e) {
			}
		}
	}
}
