package org.np.stoman.ajax.interfaze.impl;

import static org.np.stoman.dao.support.HibernateSupport.getHibernateSupport;

import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;
import org.np.stoman.ajax.interfaze.Vendor;
import org.np.stoman.persistence.Vendors;

public class VendorImpl extends BaseImpl implements Vendor {

	private static final Logger logger = Logger.getLogger(VendorImpl.class);

	@Override
	public String create(Map<String, String> params) throws Exception {
		Vendors vendor = Vendors.class.newInstance();
		BeanUtils.populate(vendor, params);
		getHibernateSupport().save(vendor);
		return SUCCESS + vendor.getName();
	}
}
