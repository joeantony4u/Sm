package org.np.stoman.optimize;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.zip.GZIPOutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

public class GZIPResponseStream extends ServletOutputStream {
	protected ByteArrayOutputStream baos = null;
	protected GZIPOutputStream gzipstream = null;
	protected boolean closed = false;
	protected HttpServletResponse response = null;
	protected ServletOutputStream output = null;

	public GZIPResponseStream(HttpServletResponse paramHttpServletResponse)
			throws IOException {
		this.response = paramHttpServletResponse;
		this.output = paramHttpServletResponse.getOutputStream();
		this.baos = new ByteArrayOutputStream();
		this.gzipstream = new GZIPOutputStream(this.baos);
	}

	@Override
	public void close() throws IOException {
		if (this.closed)
			throw new IOException("This output stream has already been closed");
		this.gzipstream.finish();
		byte[] arrayOfByte = this.baos.toByteArray();
		this.response.addHeader("Content-Length",
				Integer.toString(arrayOfByte.length));
		this.response.addHeader("Content-Encoding", "gzip");
		this.output.write(arrayOfByte);
		this.output.flush();
		this.output.close();
		this.closed = true;
	}

	@Override
	public void flush() throws IOException {
		if (this.closed)
			throw new IOException("Cannot flush a closed output stream");
		this.gzipstream.flush();
	}

	@Override
	public void write(int paramInt) throws IOException {
		if (this.closed)
			throw new IOException("Cannot write to a closed output stream");
		this.gzipstream.write((byte) paramInt);
	}

	@Override
	public void write(byte[] paramArrayOfByte) throws IOException {
		write(paramArrayOfByte, 0, paramArrayOfByte.length);
	}

	@Override
	public void write(byte[] paramArrayOfByte, int paramInt1, int paramInt2)
			throws IOException {
		if (this.closed)
			throw new IOException("Cannot write to a closed output stream");
		this.gzipstream.write(paramArrayOfByte, paramInt1, paramInt2);
	}

	public boolean closed() {
		return this.closed;
	}

	public void reset() {
	}
}

/*
 * Location: D:\Gears\Programmer\Tests\jspbook.jar Qualified Name:
 * com.jspbook.GZIPResponseStream JD-Core Version: 0.6.0
 */