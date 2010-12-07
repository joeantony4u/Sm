package org.np.stoman.ajax.interfaze;

import java.util.List;

public interface AutoComplete extends AjaxMarker {
	List<String> vendorNames(String name);

	List<String> getMaterials(String name);
}
