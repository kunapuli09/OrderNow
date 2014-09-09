package com.starpath.order.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Currency;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

import com.starpath.order.domain.CategorizedItem;
import com.starpath.order.domain.Category;
import com.starpath.order.domain.Item;
import com.starpath.order.domain.ItemOption;
import com.starpath.order.domain.ItemState;
import com.starpath.order.domain.Price;
import com.starpath.order.domain.SearchCriteria;

public class ItemServiceTest extends
AbstractDependencyInjectionSpringContextTests 
{
	public ItemServiceTest() {
	}

	@Override
	protected String[] getConfigLocations() {
		return new String[] { "applicationContext.xml"};
	
	}
	
	public void testAddItem() {
		ItemService itemService = (ItemService) applicationContext
				.getBean("itemService");
		CustomerService customerService = (CustomerService) applicationContext
		.getBean("customerService");
		Item i = createItem();
		try {
			i.setApprovedBy(customerService.lookupCustomer("33333"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		itemService.addItem(i);	
	}
	public void testAddItemWithOptions() {
		ItemService itemService = (ItemService) applicationContext
				.getBean("itemService");
		Price optionPrice = new Price(new BigDecimal(0), Currency.getInstance("USD"));		
		ItemOption option = new ItemOption();
		option.setOptionDescription("Hot");
		option.setOptionPrice(optionPrice);
		List<ItemOption> options = new ArrayList<ItemOption>(1);
		options.add(option);
		itemService.addOptionsToItem(new Long(6), options);		
	}
	public void testAddMenu(){
		ItemService itemService = (ItemService) applicationContext
		.getBean("itemService");
		itemService.addMenu(new Long(11), new Long(7), "starpath");
	}
	
	private Item createItem() {		
		Price p = new Price(new BigDecimal(1.00), Currency.getInstance("USD"));		
		Item i = new Item();
		i.setApprovalDatetime(new Date());		
		i.setDescription("Boiled Spinach");
		i.setName("Spring Roll");
		i.setCreated(new Date());
		i.setStartDate(new Date());
		i.setEndDate(new Date());
		i.setState(ItemState.ACTIVE);
		i.setItemPrice(p);					
		return i;
	}
	private Category createCategory(){
		Category lunchMenu = new Category();
		lunchMenu.setName("KKLunchMenu");		
		return lunchMenu;
	}
	public void testAddParentCategory(){
		ItemService itemService = (ItemService) applicationContext
		.getBean("itemService");
		itemService.addParentCategory("Menu");
		
	}
	public void testAddNewCategory(){
		ItemService itemService = (ItemService) applicationContext
		.getBean("itemService");
		List<Category> childCats = new ArrayList<Category>();
		Category mainMenu = new Category();
		mainMenu.setName("Main Menu");
		childCats.add(mainMenu);	
		Category kidsMenu = new Category();
		kidsMenu.setName("Kid's Menu");
		childCats.add(kidsMenu);
		Category partyMenu = new Category();
		partyMenu.setName("Party Menu");
		childCats.add(partyMenu);
		Category dailySpecialMenu = new Category();
		dailySpecialMenu.setName("Daily Special Menu");
		childCats.add(dailySpecialMenu);
		itemService.addCategory(new Long(6), childCats);
	}
	public void testAddMoreCategories(){
		ItemService itemService = (ItemService) applicationContext
		.getBean("itemService");
		List<Category> childCats = new ArrayList<Category>();
		Category mainMenu = new Category();
		mainMenu.setName("Appetizers & Snacks (Chaat)");
		childCats.add(mainMenu);	
		Category kidsMenu = new Category();
		kidsMenu.setName("Pakora");
		childCats.add(kidsMenu);
		Category partyMenu = new Category();
		partyMenu.setName("Tandoori Salads");
		childCats.add(partyMenu);
		Category dailySpecialMenu = new Category();
		dailySpecialMenu.setName("Tandoor Wraps");
		childCats.add(dailySpecialMenu);
		itemService.addCategory(new Long(7), childCats);
	}
	public void testListMenu(){
		ItemService itemService = (ItemService) applicationContext
		.getBean("itemService");
		List<Category> cats = itemService.listMenu(true);
		for(Category cat : cats){
			System.out.println(cat.getName());
			List<Category> childCats = cat.getChildCategories();
			
		}
	}
	public void testListMenuHeader(){
		ItemService itemService = (ItemService) applicationContext
		.getBean("itemService");
		List<String> headers = itemService.listMenuHeaders();
		for(String header : headers){
			System.out.println(header);
		}
	}
	public void testListMenuCategoriesForHeader(){
		ItemService itemService = (ItemService) applicationContext
		.getBean("itemService");
		SearchCriteria criteria = new SearchCriteria();
		criteria.setCategoryName("Appetizers & Snacks (Chaat)");
		Set<CategorizedItem> categorizedItems = itemService.listMenuCategoriesForHeader(criteria);
			for(CategorizedItem catItem : categorizedItems){
				Item i = catItem.getItem();
				System.out.println(i.getName());
				System.out.println(i.getDescription());
				Price price = i.getItemPrice();
				System.out.println(price.getCurrency().getCurrencyCode() + price.getValue());
			}
			
		
	}


}
