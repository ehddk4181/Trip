package com.trip.guide.analyUtill;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.openqa.selenium.WebDriver;

import com.trip.guide.vo.HotelVo;
import com.trip.guide.vo.TabeVo;
import com.trip.guide.vo.YahooMapVo;



public class AnalysisMain {
	private HashMap<String,Integer> menuVari;
	private HashMap<String,String> totalTime;
	private HashMap<String,List<String>> mapp;
	private List<TabeVo> tabeList;
	private List<YahooMapVo> yahooList;
	private List<HotelVo> hotelAllList;
	private GetFamousDestination gfd = new GetFamousDestination();
	private TaberoguCrawl tc = new TaberoguCrawl();
	private YahooMapCrawl ymc = new YahooMapCrawl();
	private HotelCrawl rtc= new HotelCrawl();
	private SeleniumDriver sd = new SeleniumDriver();
	private Recommend rc = new Recommend();
	public void newAnaly() {
		mapp = new HashMap<>();
		menuVari = new HashMap<>();
		totalTime = new HashMap<>();
		tabeList = new ArrayList<>();
		yahooList = new ArrayList<>();
		hotelAllList = new ArrayList<>();
	}
	public HashMap<String,Integer> getMenuVari(){
		return menuVari;
	}
	public List<TabeVo> getTabeList(){
		return tabeList;
	}
	public List<HotelVo> getHotelAllList(){
		return hotelAllList;
	}
	public List<YahooMapVo> getYahooList(){
		YahooMapVo temp;
		for(int i = 0 ; i<yahooList.size();i++) {
			for(int k = i;k<yahooList.size();k++) {
				if(yahooList.get(i).getWalkLength()<yahooList.get(k).getWalkLength()) {
					temp = yahooList.get(i);
					yahooList.set(i, yahooList.get(k));
					yahooList.set(k, temp);
					
				}
			}
		}
		return yahooList;
	}
	public HashMap<String,Double> analyStart(List<String> textList) {
		WebDriver driver = sd.getDriver();
		HashMap<String,Double> result = new HashMap<>();
		Kuromoji mt = new Kuromoji();
		mapp = mt.kuromoTest(textList);

		 for(String key : mapp.keySet()){
	            System.out.println(key+" : "+mapp.get(key));
		 }
	
		double famousPoint = getPlacePoint(mapp.get("place"));
		System.out.println("진행 1");
		System.out.println(famousPoint);
		double foodPoint = getFood(mapp.get("food"),driver);
		System.out.println("진행 2");
		System.out.println(foodPoint);
		double distPoint = getDistance(mapp.get("place"),driver);
		System.out.println("진행 3");
		System.out.println(distPoint);
		double hotelPoint = getHotel(mapp.get("hotel"),driver);
		System.out.println("진행 4");
		System.out.println(hotelPoint);
		result.put("famousPoint", famousPoint);
		result.put("foodPoint", foodPoint);
		result.put("distPoint", distPoint);
		result.put("hotelPoint", hotelPoint);
		result.put("foodDiversity",getDiversityPoint());
		sd.closeDriver(driver);
		return result;
		
	}
	public double getPlacePoint(List<String> placeList) {
		return gfd.getPoint(placeList);
	}
	public double getFood(List<String> foodList,WebDriver driver) {
		tc.newPointSet();
		tabeList = tc.crawl(foodList,driver);
		menuVari = tc.getMap();
		return FoodPoint(tabeList);
	}
	public double FoodPoint(List<TabeVo> foodList) {
		double result = 0;
		for(TabeVo t:foodList) {
			result += t.getMarketPoint();
		}
		return result/foodList.size();
	}
	public double getDistance(List<String> placeList,WebDriver driver) {
		ymc.newYahoo();
		yahooList = ymc.crawl(placeList,driver);
		totalTime = ymc.getTotalTime();
		return getDistPoint(yahooList);
	}
	public double getDistPoint(List<YahooMapVo> placeList) {
		
		double result = 0 ;
		for(YahooMapVo y:placeList) {
			result += y.getPoint();
		}
		return result/placeList.size();
	}
	public double getHotel(List<String> hotelList,WebDriver driver){
		
		hotelAllList = rtc.crawl(hotelList,driver);
		return rtc.getHotelAllPoint(hotelAllList);
	}
	public double getHotelPoint(List<YahooMapVo> placeList) {
		double result = 0 ;
		for(YahooMapVo y:placeList) {
			result += y.getPoint();
		}
		return result/placeList.size();
	}
	public double getDiversityPoint() {
		double result = 0;
		for(String key : menuVari.keySet()){
            if(menuVari.get(key)!=0) {
            	result++;
            }
		}
		return (result)/1.6;
	}
	public HashMap<String,String> getTotalTime() {
		return totalTime;
	}
	public List<HashMap<String,String>> getRecommendList(){
		WebDriver driver = sd.getDriver();
		return rc.recommendStart(mapp.get("place"),yahooList,tabeList,menuVari,driver);
	}
	
}
