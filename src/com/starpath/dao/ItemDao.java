package com.starpath.dao;

import com.starpath.order.domain.Category;
import com.starpath.order.domain.Item;

/**
 * @version $Revision: 1.0 $ $Date: 2008/02/02 $
 * @since Hibernate 3.2.1 / Spring 2.0.6 / Maven 2.0.4
 * @author Krishna M. Kunapuli
 *         <p>
 *         Copyright ©2007-2008 by StarpathIT Inc., all rights reserved. <br>
 */

public interface ItemDao extends GenericDao<Item, Long> {
	Item findById(long itemId);
}
