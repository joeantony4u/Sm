package org.np.stoman.ajax.interfaze;

public interface Authenticate extends AjaxMarker {
	boolean getAuth();

	String login(String un, String pw);
}
