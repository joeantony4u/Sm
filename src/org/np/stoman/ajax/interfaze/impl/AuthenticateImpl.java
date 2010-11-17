package org.np.stoman.ajax.interfaze.impl;

import static org.np.stoman.dao.support.FieldConstants.NAME;
import static org.np.stoman.dao.support.HibernateSupport.getHibernateSupport;
import static org.np.stoman.dao.support.Restrict.EQ;

import java.util.List;

import org.np.stoman.ajax.interfaze.Authenticate;
import org.np.stoman.persistence.Users;

public class AuthenticateImpl implements Authenticate {

	@Override
	@SuppressWarnings("unchecked")
	public String login(String un, String pw) {
		List<Users> users = getHibernateSupport().get(Users.class,
				EQ.restrict(new Object[] { NAME, un }));
		if (users.isEmpty())
			return "failure";
		return "success";
	}
}
