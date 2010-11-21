package irritate;

import java.util.Hashtable;

import javax.naming.Context;

public class Jndi2Ldap {
	public static void main(String[] args) {
		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY,
				"com.sun.jndi.ldap.LdapCtxFactory");
		env.put(Context.PROVIDER_URL, "ldap://localhost:10389/o=jb");

		// Authenticate as S. User and password "mysecret"
		env.put(Context.SECURITY_AUTHENTICATION, "simple");
		env.put(Context.SECURITY_PRINCIPAL, "uid=admin,ou=system");
		env.put(Context.SECURITY_CREDENTIALS, "secret");

		// Create the initial context
		// DirContext ctx = new InitialDirContext(env);
		// ctx.getAttributes("");
	}
}
