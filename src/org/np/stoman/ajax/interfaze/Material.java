package org.np.stoman.ajax.interfaze;

import java.util.List;
import java.util.Map;

public interface Material extends AjaxMarker {
	String create(Map<String, String> params) throws Exception;

	List<String> getMaterials();
}
