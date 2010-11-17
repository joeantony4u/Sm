package org.np.stoman.proxy;

import java.lang.reflect.Proxy;

import org.np.stoman.ajax.dao.aop.TransactionHandler;
import org.np.stoman.ajax.interfaze.AjaxMarker;

public class ProxyProvider {

	public static Object getProxy(Class<?> c, AjaxMarker impl) {
		return Proxy.newProxyInstance(Thread.currentThread()
				.getContextClassLoader(), new Class[] { c },
				new TransactionHandler(impl));
	}
}
