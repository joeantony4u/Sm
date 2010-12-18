package org.np.stoman.ajax.interfaze;

import java.util.Map;

public interface PurchaseOrder extends AjaxMarker {

	Map generate(Map<String, Integer> map);
}
