package com.starpath.order.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.starpath.dao.CategorizedItemDao;
import com.starpath.dao.CategoryDao;
import com.starpath.dao.ItemDao;
import com.starpath.order.domain.CategorizedItem;
import com.starpath.order.domain.Category;
import com.starpath.order.domain.Item;
import com.starpath.order.domain.ItemOption;
import com.starpath.order.domain.SearchCriteria;

@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
public class ItemServiceImpl implements ItemService {
	private static final String MAIN_MENU = "Main Menu";
	private static final String DEFAULT_SUB_CATEGORY = "Appetizers & Snacks (Chaat)";
	private static final String EMPTY_STRING = "";
	private static final Log log = LogFactory.getLog(ItemServiceImpl.class);

	public ItemServiceImpl() {
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void addItem(Item item) {
		itemDao.makePersistent(item);
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void addCategory(Long parentCategoryId,
			List<Category> childCategories) {
		Category category = categoryDao.findById(parentCategoryId);
		for (Category childCategory : childCategories) {
			category.addChildCategory(childCategory);
		}
		categoryDao.makePersistent(category);
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void addParentCategory(String parentCategoryName) {
		Category parentCategory = new Category(parentCategoryName);
		categoryDao.makePersistent(parentCategory);
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void addMenu(Long categoryId, Long itemId, String user) {
		Category category = categoryDao.findById(categoryId);
		Item item = itemDao.findById(itemId);
		CategorizedItem link = new CategorizedItem(user, category, item);
		categorizedItemDao.makePersistent(link);
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void addOptionsToItem(Long itemId, List<ItemOption> options) {
		Item item = itemDao.findById(itemId);
		item.addItemOptions(options);
	}

	public Item findById(Long id) {
		// TODO Auto-generated method stub
		return itemDao.findById(id);
	}

	/*
	 * public List<Category> listMenu(boolean rootCategory) { if (rootCategory)
	 * { return categoryDao.findRootCategories(); } else { return
	 * categoryDao.findAll(); } }
	 */

	public List<String> listMenuHeaders() {
		List<String> headers = new ArrayList<String>(10);
		List<Category> parentCats = categoryDao.findRootCategories();
		for (Category parentCat : parentCats) {
			List<Category> childCategories = parentCat.getChildCategories();
			for (Category childCategory : childCategories) {
				headers.add(childCategory.getName());
			}
		}
		return headers;
	}

	public Set<CategorizedItem> listMenuCategoriesForHeader(
			SearchCriteria searchCriteria) {
		Set<CategorizedItem> itemSet = new HashSet<CategorizedItem>();
		String header = searchCriteria.getParentCategoryName();
		String subCategory = "";
		if (null != searchCriteria) {
			subCategory = searchCriteria.getCategoryName();
			if (null == subCategory || "".equals(subCategory)) {
				subCategory = DEFAULT_SUB_CATEGORY;
			}
		} else {
			subCategory = DEFAULT_SUB_CATEGORY;
		}
		List<Category> menuCategories = categoryDao
				.findChildCategoriesForParent(header);
		Iterator it = menuCategories.iterator();
		while (it.hasNext()) {
			Category menuCategory = (Category) it.next();
			if (null != menuCategory.getName()
					&& (menuCategory.getName().equals(subCategory))) {
				itemSet.addAll(menuCategory.getCategorizedItems());
			}
		}
		return itemSet;
	}

	public List<String> listStringMenuCategoriesForHeader(
			SearchCriteria searchCriteria) {
		String parentCategory = searchCriteria.getParentCategoryName();
		List<String> categoryNames = new ArrayList<String>();
		List<Category> categories = null;
		if (null == parentCategory
				|| EMPTY_STRING.equalsIgnoreCase(parentCategory)) {
			categories = categoryDao.findChildCategoriesForParent(MAIN_MENU);
		} else {
			categories = categoryDao
					.findChildCategoriesForParent(parentCategory);
		}
		for (Category category : categories) {
			categoryNames.add(category.getName());
		}
		return categoryNames;
	}

	public List<Category> listMenuCategoriesForHeader(String parentCategory) {

		return categoryDao.findChildCategoriesForParent(parentCategory);

	}

	// injected by spring
	private ItemDao itemDao;

	public void setItemDao(ItemDao itemDao) {
		this.itemDao = itemDao;
	}

	// injected by spring
	private CategoryDao categoryDao;

	public void setCategoryDao(CategoryDao categoryDao) {
		this.categoryDao = categoryDao;
	}

	// injected by spring
	private CategorizedItemDao categorizedItemDao;

	public void setCategorizedItemDao(CategorizedItemDao categorizedItemDao) {
		this.categorizedItemDao = categorizedItemDao;
	}

	public List<Category> listMenu(boolean rootCategory) {
		// TODO Auto-generated method stub
		return null;
	}

}
