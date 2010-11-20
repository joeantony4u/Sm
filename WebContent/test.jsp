<%@ page import="java.util.*,
                 java.net.*,
                 java.io.*" %>
<%
String url = request.getParameter("url");
if (url != null) {
  URL noCompress = new URL(url);
  HttpURLConnection huc =
   (HttpURLConnection)noCompress.openConnection();
  huc.setRequestProperty("user-agent",
                         "Mozilla(MSIE)");
  huc.connect();
  ByteArrayOutputStream baos =
    new ByteArrayOutputStream();
  InputStream is = huc.getInputStream();
  while(is.read() != -1) {
    baos.write((byte)is.read());
  }
  byte[] b1 = baos.toByteArray();

  URL compress = new URL(url);
  HttpURLConnection hucCompress =
   (HttpURLConnection)noCompress.openConnection();
 hucCompress.setRequestProperty("accept-encoding",
                                 "gzip");
  hucCompress.setRequestProperty("user-agent",
                                 "Mozilla(MSIE)");
  hucCompress.connect();
  ByteArrayOutputStream baosCompress =
    new ByteArrayOutputStream();
  InputStream isCompress =
    hucCompress.getInputStream();
  while(isCompress.read() != -1) {
    baosCompress.write((byte)isCompress.read());
  }
  byte[] b2 = baosCompress.toByteArray();
  request.setAttribute("t1",
                       new Integer(b1.length));
  request.setAttribute("t2",
                       new Integer(b2.length));
}
request.setAttribute("url", url);
%>
<head>
  <title>Cache Test</title>
</head>
<body>
<h1>Cache Test Page</h1>
Enter a URL to test.
<form method="POST">
<input name="url" size="50">
<input type="submit" value="Check URL">
</form>
 <p><b>Testing: ${url}</b></p>
 Request 1: ${t1} bytes<br/>
 Request 2: ${t2} bytes<br/>
 Space saved: ${t1-t2} bytes
   or ${(1-t2/t1)*100}%<br/>
</body>
</html>