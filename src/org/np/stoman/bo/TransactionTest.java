package org.np.stoman.bo;

import static org.np.stoman.dao.support.HibernateSupport.getHibernateSupport;

import org.np.stoman.persistence.Vendors;

public class TransactionTest implements TransactionTestInterface {

	@Override
	public String addVendor(boolean b) {
		System.out.println("called");
		Vendors v = new Vendors();
		v.setName("V5");
		getHibernateSupport().save(v);
		System.out.println(v.getName());
		if (b)
			throw (new NullPointerException());
		v.setName("V5Mod");
		getHibernateSupport().save(v);
		return String.valueOf(v.getVendorId());
	}
}
