package org.np.stoman.ajax.interfaze.handler;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.np.stoman.dao.conf.HibernateUtil;
import org.np.stoman.dao.support.HibernateSupport;

public class TransactionHandler<T> implements InvocationHandler {

	public TransactionHandler(T bo) {
		this.bo = bo;
	}

	private final T bo;

	@Override
	public Object invoke(Object proxy, Method method, Object[] args)
			throws Throwable {
		Session session = HibernateUtil.openSession();
		HibernateSupport.getInstance().setSession(session);
		Transaction transaction = session.beginTransaction();
		Object obj = null;
		try {
			obj = method.invoke(bo, args);
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
