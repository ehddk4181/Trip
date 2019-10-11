package com.trip.guide.analyUtill;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

public class SeleniumDriver {
	public static final String WEB_DRIVER_ID = "webdriver.chrome.driver";
    public static final String WEB_DRIVER_PATH = "C:/chromeDriver/chromedriver_win32/chromedriver.exe";
    public WebDriver getDriver() {
    	WebDriver driver;
    	System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);
		driver = new ChromeDriver();
		return driver;
	}
    public void closeDriver(WebDriver driver) {
    	driver.close();
    	driver.quit();
    }
}
