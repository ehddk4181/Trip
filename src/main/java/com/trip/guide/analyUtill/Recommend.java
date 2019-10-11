package com.trip.guide.analyUtill;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import com.trip.guide.vo.TabeVo;
import com.trip.guide.vo.YahooMapVo;

public class Recommend {
	private int cnt = 1 ;
	public List<HashMap<String,String>> recommendStart(List<String> placeList, List<YahooMapVo> yahooList,List<TabeVo> tabeList , HashMap<String,Integer> menuVari,WebDriver driver) {
		List<HashMap<String,String>> result = new ArrayList<>();
		String [] placeName = yahooCheck(yahooList);
		String likeFood = likeFood(menuVari);
		HashMap<String,String> hss = null;
		int pNum = 0;
		boolean flag = true;
		while(flag) {
		hss = getTabeFind(driver,placeName[pNum],likeFood);
			boolean placeFlag = true;
			for(TabeVo tv:tabeList) {
				if(tv.getMarketName().equals(hss.get("name"))||hss.get("name") == null) {
					placeFlag = false;
					break;
				}
			}
			if(placeFlag) {
				pNum++;
				result.add(hss);
			}
			if(result.size()==2||pNum>1) {
				flag= false;
				break;
			}
		}
		pNum = 0;
		cnt = 1;
		flag = true;
		while(flag) {
			hss = recommendPlace(driver,placeName[pNum]);
			boolean placeFlag = true;
				for(String p:placeList) {
					if(p.equals(hss.get("name"))||hss.get("name") == null){
						placeFlag= false;
						break;
					}
				}
				if(placeFlag) {
					pNum++;
					result.add(hss);
				}
				if(result.size()==4||pNum>2) {
					flag= false;
					break;
				}
			}
		
		driver.close();
		return result;
	}
	public String [] yahooCheck(List<YahooMapVo> yahooList){
		YahooMapVo min = yahooList.get(0);
		for(YahooMapVo ym:yahooList) {
			if(ym.getWalkLength()<min.getWalkLength()) {
				min = ym;
			}
		}
		return min.getRoute().split("~");
	}
	public String likeFood(HashMap<String,Integer> menu) {
		int max = 0;
		String menus = "";
		for (String key:menu.keySet()) {
			if(menu.get(key)>max) {
				menus = key;
			}
		}
		if(menus == "Japan") {
			menus = "和食";
		}else if (menus == "Western") {
			menus = "洋食";
		}else if (menus == "Asia") {
			menus = "アジア料理";
		}else if (menus == "Minority") {
			menus = "無国籍料理";
		}else if (menus == "Fusion") {
			menus = "創作料理";
		}else if (menus == "Drinks") {
			menus = "お酒";
		}else if (menus == "Cafe") {
			menus = "カフェ";
		}else if (menus == "Desert") {
			menus = "パン・サンドイッチ";
		}
		return menus;
	}

	public HashMap<String,String> getTabeFind(WebDriver driver,String place,String likeFood) {
		HashMap<String,String> recommendTabe = new HashMap<String, String>();
		    WebElement elem;
		    driver.get("https://tabelog.com/tokyo/rstLst/?vs=1&sa=%E6%9D%B1%E4%BA%AC%E9%83%BD&sk=&lid=hd_search1&vac_net=&svd=20190904&svt=1900&svps=2&hfc=1&sw=");		  
		    	try {
		    		
		    	driver.manage().timeouts().implicitlyWait(10,TimeUnit.SECONDS);
			    elem = driver.findElement(By.id("sa"));
			    elem.clear();
			    elem.sendKeys(place);
			    elem = driver.findElement(By.id("sk"));
			    elem.clear();
			    elem.sendKeys(likeFood);
			    elem = driver.findElement(By.id("js-global-search-btn"));
			    elem.click();
			    elem = driver.findElement(By.xpath("//*[@id=\'column-main\']/ul[1]/li["+cnt+"]/div[2]/div[1]/div/div/div/a"));
			    cnt++;
			    elem.click();
			    driver.close();
			    ArrayList<String> tabs = new ArrayList<String> (driver.getWindowHandles());
			    driver.switchTo().window(tabs.get(0));		    
			    driver.manage().timeouts().implicitlyWait(10,TimeUnit.SECONDS);
				Document doc = Jsoup.connect(driver.getCurrentUrl()).get();
				Thread.sleep(1000);
				String marketName = doc.select("div.rdheader-rstname-wrap > div > h2 > span").text();
				String links = driver.getCurrentUrl();
				
				recommendTabe.put("name",marketName);
				recommendTabe.put("links",links);
			    }catch(Exception e){
			    	e.printStackTrace();

			    }
			    
		    

		 
		 return recommendTabe;
		
	}
	public List<String> makeMenuList(String menu){
		 List<String> menuList = new ArrayList<>();
		 Matcher m =  Pattern.compile("\\S+").matcher(menu);
		 while(m.find()) {
			 menuList.add(m.group());
		 }
		 return menuList;
	 }
	public HashMap<String,String> recommendPlace(WebDriver driver,String place){
		WebElement elem;
		System.out.println(place);
		HashMap<String,String> result = new HashMap<String, String>();
		driver.get("https://www.tripadvisor.jp/Search?geo=298184&searchNearby=&pid=3825&redirect=&startTime=1569846804403&uiOrigin=MASTHEAD&q="+place+"&supportedSearchTypes=find_near_stand_alone_query&enableNearPage=true&returnTo=https%253A__2F____2F__www__2E__tripadvisor__2E__jp__2F__Attractions__2D__g298184__2D__Activities__2D__Tokyo__5F__Tokyo__5F__Prefecture__5F__Kanto__2E__html&searchSessionId=708BC7352448180408A448F8C4C676111569846443984ssid&social_typeahead_2018_feature=true&sid=708BC7352448180408A448F8C4C676111569846843785");
		//driver.manage().timeouts().implicitlyWait(10,TimeUnit.SECONDS);
		try {
	    Thread.sleep(500);
	    driver.findElement(By.xpath("//*[@id='search-filters']/ul/li[4]/a")).click();
	    driver.manage().timeouts().implicitlyWait(10,TimeUnit.SECONDS);	  
	    driver.findElement(By.xpath("//*[@id=\'BODY_BLOCK_JQUERY_REFLOW\']/div[2]/div/div[2]/div/div/div/div/div[1]/div/div[1]/div/div[2]/div/div[1]/div/div[2]/div/div/div["+cnt+"]/div/div/div/div[2]")).click();
	    cnt++;
	    driver.close();
	    ArrayList<String> tabs = new ArrayList<String> (driver.getWindowHandles());
	    driver.switchTo().window(tabs.get(0));		    
	    driver.manage().timeouts().implicitlyWait(10,TimeUnit.SECONDS);
		Document doc = Jsoup.connect(driver.getCurrentUrl()).get();
		Thread.sleep(1000);
		String marketName = doc.select("#HEADING").text();
		String links = driver.getCurrentUrl();
		result.put("name",marketName);
		result.put("links",links);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
