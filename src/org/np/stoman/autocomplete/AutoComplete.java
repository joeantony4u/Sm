package org.np.stoman.autocomplete;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.np.stoman.ajax.interfaze.impl.AutoCompleteImpl;
import org.np.stoman.proxy.ProxyProvider;

/**
 * Servlet implementation class AutoComplete
 */
public class AutoComplete extends HttpServlet {

	private static final Logger logger = Logger.getLogger(AutoComplete.class);
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AutoComplete() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			autoComplete(request, response);
		} catch (Exception e) {
			logger.error("AutoComplete Failed", e);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

	}

	@SuppressWarnings("unchecked")
	protected void autoComplete(HttpServletRequest request,
			HttpServletResponse response) throws IOException,
			SecurityException, NoSuchMethodException, IllegalArgumentException,
			IllegalAccessException, InvocationTargetException {
		String name = request.getParameter("q");
		String method = request.getParameter("method");
		if (name == null || method == null)
			return;
		org.np.stoman.ajax.interfaze.AutoComplete autoCom = (org.np.stoman.ajax.interfaze.AutoComplete) ProxyProvider
				.getProxy(org.np.stoman.ajax.interfaze.AutoComplete.class,
						new AutoCompleteImpl());
		Method m = autoCom.getClass().getMethod(method, String.class);
		List<String> matches = (List<String>) m.invoke(autoCom, name);
		for (String match : matches)
			response.getWriter().write(
					match + System.getProperty("line.separator"));
	}
}
