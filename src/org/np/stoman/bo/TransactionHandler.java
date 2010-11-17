package org.np.stoman.bo;

import static org.np.stoman.dao.support.HibernateSupport.getHibernateSupport;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.np.stoman.dao.conf.HibernateUtil;

public class TransactionHandler implements InvocationHandler {

	private final TransactionTest tt;

	public TransactionHandler(TransactionTest tt) {
		this.tt = tt;
	}

	@Override
	public Object invoke(Object arg0, Method arg1, Object[] arg2)
			throws Throwable {
		Session session = HibernateUtil.openSession();
		getHibernateSupport().setSession(session);
		Transaction transaction = session.beginTransaction();
		Object obj = null;
		try {
			obj = arg1.invoke(tt, arg2);
			session.flush();
			transaction.commit();
		} catch (Exception e) {
			transaction.rollback();
			System.out.println("Tran Rollbacked");
		} finally {
			session.close();
		}
		return obj;
	}
}