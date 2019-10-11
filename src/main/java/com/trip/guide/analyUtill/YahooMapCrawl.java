package com.trip.guide.analyUtill;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.naming.spi.DirStateFactory.Result;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import com.trip.guide.vo.YahooMapVo;

public class YahooMapCrawl {
	public static final String WEB_DRIVER_ID = "webdriver.chrome.driver";
    public static final String WEB_DRIVER_PATH = "C:/chromeDriver/chromedriver_win32/chromedriver.exe";
    private WebDriver driver;
    //크롤링 할 URL
    private String walkTotalTime = "00:00:00";
    private String carTotalTime = "00:00:00";
    private HashMap<String,String> totalTime;
    public void newYahoo() {
    	carTotalTime = "00:00:00";
    	walkTotalTime = "00:00:00";
    }
    public HashMap<String,String> getTotalTime(){
    	totalTime = new HashMap<>();
    	totalTime.put("walkTotalTime",walkTotalTime);
    	totalTime.put("carTotalTime",carTotalTime);
    	return totalTime;
    }

 
    public ArrayList<YahooMapVo> crawl(List<String> searchList,WebDriver driver) {
    	ArrayList<YahooMapVo> resultList = new ArrayList<>();
    	WebElement elem;
    	
        	for(int i=0;i<searchList.size()-1;i++) {
        		try {
	        	driver.get("https://map.yahoo.co.jp/maps?z=15&lat=35.697658&lon=139.763683");
	        	driver.manage().timeouts().implicitlyWait(5,TimeUnit.SECONDS);
	        	driver.findElement(By.id("modeRoute")).click();
	            Thread.sleep(500);
	            driver.findElement(By.id("modeWalk")).click();
	            Thread.sleep(500);
	            int cnt = 0;
	            elem = driver.findElement(By.xpath("//div[@class='start']/span/span/input"));
	            elem.clear();
	            elem.sendKeys(searchList.get(i));
	            elem = driver.findElement(By.xpath("//div[@class='end']/span/span/input"));
	            elem.clear();
	            elem.sendKeys(searchList.get(i+1));
	            driver.manage().timeouts().implicitlyWait(3,TimeUnit.SECONDS);		            
	            driver.findElement(By.xpath("//*[@id=\"panel\"]/div[4]/div[1]/label")).click();
	            //((JavascriptExecutor)driver).executeScript("$('#panel > div.postBtn.cf > div.submit > label')[0].click()");
	            
	            Thread.sleep(1000);
	            String walk = driver.findElement(By.xpath("//div[@class='routeDt']/div[@class='head']/div/div/span[position() > 1]")).getText();
	            String walkTime;
	            try {
	            	walkTime = driver.findElement(By.xpath("//div[@class='routeDt']/div[@class='head']/div/div/span[position() > 2]")).getText();
	            }
	            catch(Exception e) {
	            	 walkTime = driver.findElement(By.xpath("//*[@id=\"panel\"]/div/div/div/div/span[3]")).getText();
	            	
	            }
	            elem = driver.findElement(By.className("icnCar"));
	            elem.click();
	            Thread.sleep(1000);
	            String car = "";
	            try {
                    car = 	driver.findElement(By.xpath("//div[@class='routeDt']/div[@class='head']/div[@class='data']/span/b")).getText();
	            }catch(Exception e){
	            	car = 	driver.findElement(By.xpath("//div[@class='routeDt']/div[@class='head']/div[@class='data']/span[position() > 1]")).getText();            
	            }
	            String carTime = driver.findElement(By.xpath("//*[@id=\"panel\"]/div[8]/div[1]/div[1]/span[3]")).getText();
	            double carLength = changeLength(car);
	            double walkLength = changeLength(walk);
	            walkTime = changeDate(walkTime,"walk");
	            carTime = changeDate(carTime,"car");
	            resultList.add(new YahooMapVo(searchList.get(i)+"~"+searchList.get(i+1),walkLength,walkTime,carLength,carTime,getPoint(walkLength,carLength,carTime)));
        		} catch (Exception e) {
        			e.printStackTrace();
        			continue;
        		}	            
        	}
        	//driver.manage().timeouts().implicitlyWait(10,TimeUnit.SECONDS);
        	//Thread.sleep(500);
        
        return resultList;
    }
    public double changeLength(String item) {
    	String res = "";
    	double result = 0;
    	Matcher m = Pattern.compile("\\d+").matcher(item);
    	while(m.find()) {
    		if(res!="") {
    			res += ".";
    		}
    		res +=m.group();
    	}
    	result = Double.parseDouble(res);
    	return result;
    }
    public String changeDate(String item,String type) {
    	String hour = "";
    	String minu = "";
    	String result = "";
    	List<String> timeList = new ArrayList<>();
    	Matcher m = Pattern.compile("\\d+").matcher(item);
    	while(m.find()) {
    		timeList.add(m.group());
    	}
    	if(timeList.size()!=2) {
    		if(item.indexOf("分")==item.length()-1) {
    			minu = timeList.get(0);
    		}else {
    			hour = timeList.get(0);
    		}
    	}else {
    		hour = timeList.get(0);
    		minu = timeList.get(1);
    	}
    	
    	if(hour=="") hour = "00";
    	else if(minu=="") minu = "00";
    	timeTotal(hour,minu,type);
    	return hour+":"+minu+":"+"00";
    	
    }
    public void timeTotal(String hour,String minu,String type) {
    	String [] timeArray;
    	
    	if(type=="walk") {
    	timeArray = walkTotalTime.split(":");
    	walkTotalTime = timeCal(hour,minu,timeArray);
    	}
    	else {
    	timeArray = carTotalTime.split(":");
    	carTotalTime = timeCal(hour,minu,timeArray);
    	}
    
    }
    public String timeCal(String hour,String minu,String [] timeArray) {
    	int hoursum = Integer.parseInt(timeArray[0]) + Integer.parseInt(hour);
    	int minuSum = Integer.parseInt(timeArray[1]) + Integer.parseInt(minu);
    	if(minuSum>=60) {
    		hoursum++;
    		minuSum=minuSum%60;
    		
    	}
    	return hoursum+":"+minuSum+":"+"00";
    }
    public double getPoint(double wLen,double cLen,String cTime) {
    	double point = 0;
    	String [] carTime = cTime.split(":");
    	if(wLen > 4) {
    		int cars = Integer.parseInt(carTime[0])*60+Integer.parseInt(carTime[1]);
    		if(cars > 120) {point += 1;}
    		else if(cars > 100) {point += 1.5;}
    		else if(cars > 80) {point += 2;}
    		else if(cars > 60) {point += 2.5;}
    		else if(cars > 40) {point += 3;}
    		else if(cars > 30) {point += 3.5;}
    		else if(cars > 20) {point += 4;}
    		else if(cars > 10) {point += 4.5;}
    		else {point += 5;}
    	}else {
    		if(wLen >3.5){point += 1;}
    		else if(wLen >3){point += 1.5;}
    		else if(wLen >2.5){point += 2;}
    		else if(wLen >2){point += 2.5;}
    		else if(wLen >1.5){point += 3;}
    		else if(wLen >1){point += 3.5;}
    		else if(wLen >0.75){point += 4;}
    		else if(wLen >0.5){point += 4.5;}
    		else if(wLen >0){point += 5;}
    	}
    		
    	
    	return point;
    }
}
