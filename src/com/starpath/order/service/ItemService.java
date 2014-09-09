package com.starpath.order.service;

import java.util.List;
import java.util.Set;

import org.springframework.jmx.export.annotation.ManagedResource;
import org.springmodules.cache.annotations.Cacheable;

import com.starpath.order.domain.CategorizedItem;
import com.starpath.order.domain.Category;
import com.starpath.order.domain.Item;
import com.starpath.order.domain.ItemOption;
import com.starpath.order.domain.SearchCriteria;

@ManagedResource(objectName = "starpath:name=itemService")
public interface ItemService {
	
	 public void addItem(Item item); 
	 public void addOptionsToItem(Long itemId,List<ItemOption> options); 
	 public void addParentCategory(String parentCategoryName); 
	 public void addCategory(Long parentCategoryId, List<Category> childCategories); 
	 public void addMenu(Long categoryId, Long itemId, String user); 
	 public List<Category> listMenu(boolean rootCategory);
	 
	public List<String> listMenuHeaders();

	public Set<CategorizedItem> listMenuCategoriesForHeader(
			SearchCriteria searchCriteria);
	@Cacheable(modelId = "itemCacheModel")
	public List<Category> listMenuCategoriesForHeader(String parentCategory);

	public Item findById(Long id);

	@Cacheable(modelId = "categoryCacheModel")
	public List<String> listStringMenuCategoriesForHeader(
			SearchCriteria searchCriteria);
}