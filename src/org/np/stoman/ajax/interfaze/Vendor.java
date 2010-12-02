package org.np.stoman.ajax.interfaze;

import java.util.Map;

public interface Vendor extends AjaxMarker {
	String create(Map<String, String> params) throws Exception;
}
