package org.np.stoman.ajax.interfaze.impl;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.naming.directory.InvalidAttributeValueException;

import org.apache.directory.shared.ldap.entry.client.ClientEntry;
import org.np.stoman.ajax.interfaze.MenuBuilder;

public class MenuBuilderImpl extends BaseImpl implements MenuBuilder {

	@Override
	public Map<String, String> build() {
		return build("ou=menu,o=jb");
	}

	@Override
	public Map<String, String> build(String mDN) {
		// TODO: Call cache being developed by Joe
		ClientEntry ce = (ClientEntry) getHTTPSession().getAttribute("subject");
		Map<String, String> map = new LinkedHashMap<String, String>();
		for (ClientEntry c : ldap.buildMenu(mDN, ce))
			try {
				map.put(c.get("description").getString() + "#"
						+ c.get("searchGuide").getString(), "");
			} catch (InvalidAttributeValueException e) {
				e.printStackTrace();
			}
		System.out.println(map);
		return map;
	}
}
