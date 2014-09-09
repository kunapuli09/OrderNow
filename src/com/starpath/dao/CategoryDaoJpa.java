package com.starpath.dao;

import java.util.List;

import javax.persistence.Query;

import com.starpath.order.domain.Category;

/**
 * @version $Revision: 1.0 $ $Date: 2008/02/02 $
 * @since Hibernate 3.2.1 / Spring 2.0.6 / Maven 2.0.4
 * @author Krishna M. Kunapuli
 *         <p>
 *         Copyright ©2007-2008 by StarpathIT Inc., all rights reserved. <br>
 */

public class CategoryDaoJpa extends GenericDaoJpa<Category, Long> implements
		CategoryDao {

	public List<Category> findRootCategories() {
		return entityManager.createQuery(
				"select c from Category c where c.parentCategory is null")
				.getResultList();
		
	}

	public List<Category> findChildCategoriesForParent(String parentCategory) {
		Query q = entityManager.createQuery(
				"select c from Category c where c.parentCategory.name =?1");
		q.setParameter(1, parentCategory);
		return q.getResultList();
	}

	public Category findById(long categoryId) {
		Query q = entityManager.createQuery(
				"select c from Category c where c.id =?1");
		q.setParameter(1, categoryId);

		return (Category) q.getResultList();
	}

}
