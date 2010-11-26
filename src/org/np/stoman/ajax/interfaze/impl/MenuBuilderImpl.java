package org.np.stoman.ajax.interfaze.impl;

import java.util.LinkedHashMap;
import java.util.Map;

import org.np.stoman.ajax.interfaze.MenuBuilder;

public class MenuBuilderImpl extends BaseImpl implements MenuBuilder {

	@Override
	public Map<String, String> build() {
		// TODO: Call cache being developed by Joe
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("Administration", "services.htm");
		return map;
	}
}
