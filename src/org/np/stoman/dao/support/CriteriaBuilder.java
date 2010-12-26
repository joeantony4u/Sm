package org.np.stoman.dao.support;

import static org.np.stoman.dao.support.HibernateSupport.getHibernateSupport;

import java.util.HashMap;
import java.util.Map;

import org.hibernate.Criteria;

public class CriteriaBuilder {

	private final Criteria criteria;
	private final Map<String, String> aliases;
	private int count;

	public CriteriaBuilder(Class<?> c) {
		criteria = getHibernateSupport().getSession().createCriteria(c);
		aliases = new HashMap<String, String>();
	}

	public CriteriaBuilder(Class<?> c, int pageNo, int pageSize) {
		this(c);
		criteria.setFirstResult((pageNo - 1) * pageSize);
		criteria.setMaxResults(pageSize);
	}

	public String wrap1(String field) {
		if (field.indexOf(".") < 0)
			return field;
		String path = field.substring(0, field.lastIndexOf("."));
		String target = field.substring(field.lastIndexOf(".") + 1);
		String alias = target + count++;
		criteria.createAlias(path, alias);
		return alias + "." + target;
	}

	public String wrap(String field) {
		if (field.indexOf(".") < 0)
			return field;
		String[] fields = field.split("\\.");
		String alias = "a" + count++;
		String path = field.substring(0, field.lastIndexOf("."));
		boolean newAlias = isNewAlias(path, alias);
		wrap(path);
		if (newAlias)
			criteria.createAlias(path, aliases.get(path));
		return aliases.get(path) + "." + fields[fields.length - 1];
	}

	private boolean isNewAlias(String path, String alias) {
		if (aliases.get(path) == null) {
			aliases.put(path, alias);
			return true;
		}
		return false;
	}

	public Criteria getCriteria() {
		return criteria;
	}
}
