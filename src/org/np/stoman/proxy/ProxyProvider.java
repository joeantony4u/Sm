package org.np.stoman.proxy;

import java.lang.reflect.Proxy;

import org.np.stoman.ajax.interfaze.handler.TransactionHandler;

public class ProxyProvider {

	@SuppressWarnings("unchecked")
	public static <T, S extends T> T getProxy(T c, S impl) {
		return (T) Proxy.newProxyInstance(Thread.currentThread()
				.getContextClassLoader(), new Class[] { c.getClass() },
				new TransactionHandler<T>(impl));
	}
}
