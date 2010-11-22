package org.np.stoman.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet Filter implementation class SecurityFilter
 */
public class SecurityFilter implements Filter {

	private final List<String> excludeURLs;

	/**
	 * Default constructor.
	 */
	public SecurityFilter() {
		excludeURLs = new ArrayList<String>();
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

		HttpServletRequest req = (HttpServletRequest) request;
		String uri = req.getRequestURI();

		if (!(req.getContextPath() + "/").equalsIgnoreCase(uri))
			secureURI: {
				for (String excludeURL : excludeURLs)
					if (uri.endsWith(excludeURL))
						break secureURI;
				if (!isSessionAlive(req, (HttpServletResponse) response))
					return;
			}
		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	private boolean isSessionAlive(HttpServletRequest req,
			HttpServletResponse res) throws IOException {

		if (req.getSession().getAttribute("subject") != null)
			return true;
		String encodedURL = res.encodeURL("http://localhost/Sm");
		encodedURL += encodedURL.contains("?") ? "" : "?";
		res.sendRedirect(encodedURL + "&next=" + req.getRequestURL());
		return false;
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO: constants
		String excludes = fConfig.getInitParameter("excludeURLs");
		for (String excludeURL : Arrays.asList(excludes.split(",")))
			excludeURLs.add(excludeURL);
	}
}
