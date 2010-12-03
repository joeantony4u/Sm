package org.np.stoman.ajax.interfaze.impl;

import static org.np.stoman.dao.support.HibernateSupport.getHibernateSupport;

import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;
import org.np.stoman.ajax.interfaze.Material;
import org.np.stoman.persistence.Materials;

public class MaterialImpl extends BaseImpl implements Material {

	private static final Logger logger = Logger.getLogger(MaterialImpl.class);

	@Override
	public String create(Map<String, String> params) throws Exception {
		Materials material = Materials.class.newInstance();
		BeanUtils.populate(material, params);
		getHibernateSupport().save(material);
		return SUCCESS + material.getName();
	}
}
