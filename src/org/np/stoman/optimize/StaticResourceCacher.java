package org.np.stoman.optimize;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet Filter implementation class StaticResourceCacher
 */
public class StaticResourceCacher implements Filter {

	FilterConfig fc;

	/**
	 * Default constructor.
	 */
	public StaticResourceCacher() {
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		fc = null;
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	@SuppressWarnings("unchecked")
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {

		HttpServletResponse res = (HttpServletResponse) response;
		// set the provided HTTP response parameters
		for (Enumeration<String> e = fc.getInitParameterNames(); e
				.hasMoreElements();) {
			String headerName = e.nextElement();
			res.addHeader(headerName, fc.getInitParameter(headerName));
		}
		// pass the request/response on
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		this.fc = fConfig;
	}

}
