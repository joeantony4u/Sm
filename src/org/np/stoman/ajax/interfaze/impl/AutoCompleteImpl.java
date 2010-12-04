package org.np.stoman.ajax.interfaze.impl;

import static org.np.stoman.dao.support.FieldConstants.NAME;
import static org.np.stoman.dao.support.HibernateSupport.getHibernateSupport;
import static org.np.stoman.dao.support.Restrict.LIKE;

import java.util.ArrayList;
import java.util.List;

import org.np.stoman.ajax.interfaze.AutoComplete;
import org.np.stoman.persistence.Vendors;

public class AutoCompleteImpl extends BaseImpl implements AutoComplete {

	@SuppressWarnings("unchecked")
	@Override
	public List<String> vendorNames(String name) {
		// TODO: is it possible to fetch only name column?
		List<String> auto = new ArrayList<String>();
		List<Vendors> vendors = getHibernateSupport().get(Vendors.class,
				LIKE.restrict(new Object[] { NAME, "%" + name + "%" }));
		for (Vendors vendor : vendors)
			auto.add(vendor.getName());
		return auto;
	}
}
