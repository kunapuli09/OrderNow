package com.starpath.dao;

import javax.persistence.Query;

import com.starpath.order.domain.Category;
import com.starpath.order.domain.Item;

/**
 * @version $Revision: 1.0 $ $Date: 2008/02/02 $
 * @since Hibernate 3.2.1 / Spring 2.0.6 / Maven 2.0.4
 * @author Krishna M. Kunapuli
 *         <p>
 *         Copyright ©2007-2008 by StarpathIT Inc., all rights reserved. <br>
 */

public class ItemDaoJpa extends GenericDaoJpa<Item, Long> implements ItemDao {
	public Item findById(long itemId) {
		Query q = entityManager.createQuery(
				"select i from Item i where i.id =?1");
		q.setParameter(1, itemId);

		return (Item) q.getSingleResult();
	}
}
