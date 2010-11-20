package org.np.stoman.optimize;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet Filter implementation class DataCompressor
 */
public class DataCompressor implements Filter {

	/**
	 * Default constructor.
	 */
	public DataCompressor() {
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {

		// pass the request along the filter chain
		if ((request instanceof HttpServletRequest)) {
			HttpServletRequest localHttpServletRequest = (HttpServletRequest) request;
			HttpServletResponse localHttpServletResponse = (HttpServletResponse) response;
			String str = localHttpServletRequest.getHeader("accept-encoding");
			if ((str != null) && (str.indexOf("gzip") != -1)) {
				GZIPResponseWrapper gzipResponse = new GZIPResponseWrapper(
						localHttpServletResponse);
				chain.doFilter(request, gzipResponse);
				gzipResponse.finishResponse();
				return;
			}
			chain.doFilter(request, response);
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
	}

}
