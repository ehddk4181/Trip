package com.trip.guide.analyUtill;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.regex.Pattern;

import javax.xml.crypto.Data;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import com.trip.guide.vo.HotelVo;

public class HotelCrawl {
	public static final String WEB_DRIVER_ID = "webdriver.chrome.driver";
    public static final String WEB_DRIVER_PATH = "C:/chromeDriver/chromedriver_win32/chromedriver.exe";
    private List<HotelVo> hotelList = new ArrayList<>();
    private double hotelAllPoint = 0;
    private WebDriver driver;
    public void newHotel() {
    	hotelList = new ArrayList<>();
    	hotelAllPoint = 0;
    }

	public List<HotelVo> crawl(List<String> searchList,WebDriver driver) {
		WebElement elem;
		String nowS="";
		String next="";
		try {
			Date now = new Date();
			SimpleDateFormat timeSet = new SimpleDateFormat("yyyy/MM/dd");
			nowS = timeSet.format(now);
			Calendar cal = Calendar.getInstance();
	        cal.setTime(now);
	        cal.add(Calendar.DATE, 2);
	        next = timeSet.format(cal.getTime());
	        System.out.println(next);
		    
		}
		catch(Exception e) {
			
		}
	    for(String hotel:searchList) {
	    	try {
	    		driver.manage().timeouts().implicitlyWait(10,TimeUnit.SECONDS);
	    		driver.get("https://jp.trip.com/hotels/list?city=228&checkin="+nowS+"&checkout="+next+"&lat=35.71106&lon=139.77786&optionId=688327&optionType=Hotel&optionName=%E4%B8%8A%E9%87%8E%20%E6%9D%B1%E9%87%91%E5%B1%8B%E3%83%9B%E3%83%86%E3%83%AB&display=%E4%B8%8A%E9%87%8E%20%E6%9D%B1%E9%87%91%E5%B1%8B%E3%83%9B%E3%83%86%E3%83%AB%2C%20%E6%9D%B1%E4%BA%AC%2C%20%E6%9D%B1%E4%BA%AC%E9%83%BD%2C%20%E6%97%A5%E6%9C%AC&crn=1&adult=1&children=0&searchBoxArg=t&travelPurpose=0&ctm_ref=ix_sb_dl&showtotalamt=0");
	    		driver.manage().timeouts().implicitlyWait(10,TimeUnit.SECONDS);
	    		elem = driver.findElement(By.id("hotelsCity"));
	    		elem.clear();
	    		elem.sendKeys(hotel);
	    		elem = driver.findElement(By.xpath("//*[@id=\"txtSearchKeyword\"]"));
	    		elem.clear();
	    		elem.sendKeys(hotel);
	    		driver.findElement(By.xpath("//*[@id=\"btnSearch_SearchBox\"]")).click();
	    		driver.manage().timeouts().implicitlyWait(10,TimeUnit.SECONDS);
	    		Thread.sleep(2000);
	    		String hotelName = driver.findElement(By.xpath("//*[@id=\"searchResult\"]/ul[1]/div/ul/li/div[3]/h3/strong/a")).getText();
	    		String hotelPoint = driver.findElement(By.xpath("/html/body/div[4]/div[2]/div[1]/div/div[2]/div[6]/ul[1]/div/ul/li/div[3]/div[2]/div[1]/a/span[1]/span[1]")).getText();
	    		String hotelStars = driver.findElement(By.xpath("//*[@id=\"searchResult\"]/ul[1]/div/ul/li/div[3]/h3/strong/span/i")).getAttribute("class");
	    		
	    		hotelList.add(new HotelVo(changeName(hotelName),getStar(hotelStars),getPoint(hotelPoint)));
	    	}catch(Exception e){
	    		e.printStackTrace();
	    		continue;
	    	}
	    }

	    return hotelList;
	   
	}
	public int getStar(String staris) {
		int star = Integer.parseInt(staris.charAt(staris.length()-1)+"");
		return star;
	}
	public String changeName(String hotelName) {
		String name = null;
		try {
			name = hotelName.split("(")[0];
			}
		catch(Exception e) {
				name = hotelName;
		}
		name = Pattern.compile("\\S").matcher(name).replaceAll("");
		return name;
	}
	public double getPoint(String hotelPoint) {
		return Double.parseDouble(hotelPoint.split("/")[0]);
	}
	public double getHotelAllPoint(List<HotelVo> hList) {
		double result = 0;
		for(HotelVo h:hList) {
			result += h.getHotelPoint();
		}
		return result/hList.size();
	}
	
}
