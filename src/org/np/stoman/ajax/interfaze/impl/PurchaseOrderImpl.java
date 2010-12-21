package org.np.stoman.ajax.interfaze.impl;

import static org.np.stoman.dao.support.HibernateSupport.getHibernateSupport;
import static org.np.stoman.dao.support.Order.ASC;
import static org.np.stoman.dao.support.Restrict.EQ;
import static org.np.stoman.dao.support.Restrict.IN;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.np.stoman.ajax.interfaze.PurchaseOrder;
import org.np.stoman.persistence.Ranks;
import org.np.stoman.persistence.VendorMaterials;

public class PurchaseOrderImpl extends BaseImpl implements PurchaseOrder {

	@Override
	@SuppressWarnings("unchecked")
	public Map<Integer, List<Object>> generate(Map<String, Integer> map) {

		for (String m : map.keySet()) {
			List<VendorMaterials> vms = getHibernateSupport().get(
					VendorMaterials.class,
					EQ.restrict(new Object[] { "materials.name", m }));

			List<Integer> vIds = new ArrayList<Integer>();
			for (VendorMaterials vm : vms)
				vIds.add(vm.getVendors().getVendorId());

			List<Ranks> ranks = getHibernateSupport().get(Ranks.class,
					ASC.order(new String[] { "rank" }),
					IN.restrict(new Object[] { "vendors.vendorId", vIds }));

		}

		return null;
	}
}
