package org.np.stoman.ajax.interfaze.impl;

import static org.np.stoman.dao.support.HibernateSupport.getHibernateSupport;
import static org.np.stoman.dao.support.Order.ASC;
import static org.np.stoman.dao.support.Restrict.EQ;
import static org.np.stoman.dao.support.Restrict.IN;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.np.stoman.ajax.interfaze.PurchaseOrder;
import org.np.stoman.dao.support.CriteriaBuilder;
import org.np.stoman.persistence.Ranks;
import org.np.stoman.persistence.VendorMaterials;
import org.np.stoman.persistence.Vendors;

public class PurchaseOrderImpl extends BaseImpl implements PurchaseOrder {

	@Override
	@SuppressWarnings("unchecked")
	public Map<Integer, List<VendorMaterials>> generate(Map<String, Integer> map) {
		Map<Integer, List<VendorMaterials>> vMaterials = new HashMap<Integer, List<VendorMaterials>>();
		for (String m : map.keySet()) {
			CriteriaBuilder cb = new CriteriaBuilder(VendorMaterials.class);
			List<VendorMaterials> vms = getHibernateSupport().get(
					cb.getCriteria(),
					EQ.restrict(new Object[] { cb.wrap("materials.name"), m }));

			Map<Integer, VendorMaterials> vIds = new HashMap<Integer, VendorMaterials>();
			for (VendorMaterials vm : vms)
				vIds.put(vm.getVendors().getVendorId(), vm);

			cb = new CriteriaBuilder(Ranks.class, 1, 1);
			List<Ranks> ranks = getHibernateSupport().get(
					cb.getCriteria(),
					ASC.order(new String[] { "rank" }),
					IN.restrict(new Object[] { cb.wrap("vendors.vendorId"),
							vIds.keySet() }));
			Vendors vChosen = ranks.get(0).getVendors();
			if (vMaterials.get(vChosen.getVendorId()) == null)
				vMaterials.put(vChosen.getVendorId(),
						new ArrayList<VendorMaterials>());
			vMaterials.get(vChosen.getVendorId()).add(
					vIds.get(vChosen.getVendorId()));
		}
		return vMaterials;
	}
}
