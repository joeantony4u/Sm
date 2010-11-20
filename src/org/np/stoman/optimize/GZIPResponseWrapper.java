package org.np.stoman.optimize;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

public class GZIPResponseWrapper extends HttpServletResponseWrapper {
	protected HttpServletResponse origResponse = null;
	protected ServletOutputStream stream = null;
	protected PrintWriter writer = null;

	public GZIPResponseWrapper(HttpServletResponse paramHttpServletResponse) {
		super(paramHttpServletResponse);
		this.origResponse = paramHttpServletResponse;
	}

	public ServletOutputStream createOutputStream() throws IOException {
		return new GZIPResponseStream(this.origResponse);
	}

	public void finishResponse() {
		try {
			if (this.writer != null)
				this.writer.close();
			else if (this.stream != null)
				this.stream.close();
		} catch (IOException localIOException) {
		}
	}

	@Override
	public void flushBuffer() throws IOException {
		this.stream.flush();
	}

	@Override
	public ServletOutputStream getOutputStream() throws IOException {
		if (this.writer != null)
			throw new IllegalStateException(
					"getWriter() has already been called!");
		if (this.stream == null)
			this.stream = createOutputStream();
		return this.stream;
	}

	@Override
	public PrintWriter getWriter() throws IOException {
		if (this.writer != null)
			return this.writer;
		if (this.stream != null)
			throw new IllegalStateException(
					"getOutputStream() has already been called!");
		this.stream = createOutputStream();
		this.writer = new PrintWriter(new OutputStreamWriter(this.stream,
				"UTF-8"));
		return this.writer;
	}

	@Override
	public void setContentLength(int paramInt) {
	}
}

/*
 * Location: D:\Gears\Programmer\Tests\jspbook.jar Qualified Name:
 * com.jspbook.GZIPResponseWrapper JD-Core Version: 0.6.0
 */