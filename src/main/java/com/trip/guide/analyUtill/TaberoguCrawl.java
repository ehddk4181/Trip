package com.trip.guide.analyUtill;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import com.trip.guide.vo.TabeVo;


public class TaberoguCrawl {
	public static final String WEB_DRIVER_ID = "webdriver.chrome.driver";
    public static final String WEB_DRIVER_PATH = "C:/chromeDriver/chromedriver_win32/chromedriver.exe";
    private WebDriver driver;
    private Elements destName;
    private Elements destReview;
    private Document doc;
    private List<String> japanes = Arrays.asList("日本料理","寿司","魚介料理","海鮮料理","天ぷら","揚げ物","そば","うどん","麺類","串焼","うなぎ","どじょう","あなご","鳥料理",
    		"おでん","お好み焼き","ちりとり鍋","もつ鍋","うどんすき","ちゃんこ鍋","水炊き","てっちゃん鍋","ラーメン","つけ麵","汁なしラーメン",
    		"油そば","カレー");
    private List<String> western = Arrays.asList("イタリアン","ピザ","ファミレス","パスタ","ステーキ","ハンバーグ","ハンバーガー","洋食","洋食","欧米料理","フレンチ","スペイン料理", 
    		"西洋各国料理","鉄板焼き");
    private List<String> asia = Arrays.asList("串揚げ","串かつ","韓国料理","東南アジア料理","南アジア料理","西アジア料理","台湾まぜそば","汁なし担々麵");
    private List<String> minority = Arrays.asList("中南米料理","アフリカ料理");
    private List<String> fusion = Arrays.asList("創作料理","イノベーティブ","フュージョン","無国籍料理");
    private List<String> drinks = Arrays.asList("ダイニングバー","バー","居酒屋","パブ","ラウンジ","ビアガーデン","ビアバー","スポーツバー","お酒");
    private List<String> cafe = Arrays.asList("喫茶店","カフェ","コーヒー専門店","紅茶専門店","中国茶専門店","日本茶専門店");
    private List<String> desert = Arrays.asList("パン","スイーツ","サンドイッチ");
    private HashMap<String, Integer> pointMap;
    
   
    public TaberoguCrawl() {
    	newPointSet();
    }
    public void newPointSet() {
    	pointMap = new HashMap<>();
    	pointMap.put("Japan", 0);
		 pointMap.put("Western", 0);
		 pointMap.put("Asia", 0);
		 pointMap.put("Minority", 0);
		 pointMap.put("Fusion", 0);
		 pointMap.put("Drinks", 0);
		 pointMap.put("Cafe", 0);
		 pointMap.put("Desert", 0);
    }
    //부르면 간다

	 public List<TabeVo> crawl(List<String> searchList,WebDriver driver) {
		 List<TabeVo> resultArray = new ArrayList<>();
	    WebElement elem;
	    System.out.println(searchList);
	    
	    driver.get("https://tabelog.com/tokyo/rstLst/?vs=1&sa=%E6%9D%B1%E4%BA%AC%E9%83%BD&sk=&lid=hd_search1&vac_net=&svd=20190904&svt=1900&svps=2&hfc=1&sw=");
	    for(int i = 0 ; i<searchList.size();i++) {
	    	try {
	    		
	    		driver.manage().timeouts().implicitlyWait(10,TimeUnit.SECONDS);
		    elem = driver.findElement(By.id("sa"));
		    elem.clear();
		    elem.sendKeys("東京");
		    elem = driver.findElement(By.id("sk"));
		    elem.clear();
		    elem.sendKeys(searchList.get(i));
		    elem = driver.findElement(By.id("js-global-search-btn"));
		    elem.click();
		    elem = driver.findElement(By.xpath("//div[@class='list-rst__rst-name']/a"));
		    elem.click();
		    driver.close();
		    ArrayList<String> tabs = new ArrayList<String> (driver.getWindowHandles());
		    driver.switchTo().window(tabs.get(0));		    
		    driver.manage().timeouts().implicitlyWait(10,TimeUnit.SECONDS);
			Document docu = Jsoup.connect(driver.getCurrentUrl()).get();
			Thread.sleep(1000);
			resultArray.add(getFoodList(docu));
		    
		    }catch(Exception e){
		    	e.printStackTrace();
		    	continue;
		    }
		    
	    }

	 
	 return resultArray;
	 }
	 public TabeVo getFoodList(Document doc){
		 String marketName = doc.select("div.rdheader-rstname-wrap > div > h2 > span").text();
		 String marketPoint = doc.select("#js-detail-score-open > p > b > span").text();
		 String marketDayPrice = doc.select("p.rdheader-budget__icon.rdheader-budget__icon--lunch > span > a").text();
		 String marketNightPrice = doc.select("p.rdheader-budget__icon.rdheader-budget__icon--dinner > span > a").text();
		 String marketMenu = doc.select("div.rdheader-info-data > div > div > div:nth-child(1) > dl:nth-child(3) > dd > div > div > a > span").text();
		 List<String> mmList = makeMenuList(marketMenu);
		 getPoint(mmList);
		 return new TabeVo(marketName,changePrice(marketDayPrice),changePrice(marketNightPrice),changePoint(marketPoint),mmList);
	 }
	 public double changePoint(String point) {
		 String result = "";
		 int cnt = 0;
		 Matcher m = Pattern.compile("\\d+").matcher(point);
		 while(m.find()) {
			 result += m.group();
			 if(cnt == 0) {
				 result +=".";
				 cnt++;
			 }
		 }
		 return Double.parseDouble(result);
	 }
	 public int changePrice(String price) {
		 String [] str = price.split("～");

		 int front = 0;
		 int back = 0;
		 int cnt = 0;
		 int result = 0;
		 for(String s:str) {
			 if(!s.equals("")&&!s.equals("-")) {
			 Matcher m = Pattern.compile("\\d+").matcher(s);
			 String results = "";
			 while(m.find()) {
				 results += m.group();
			 }
			 if(cnt == 0){
				 
				 front = Integer.parseInt(results);
				 cnt++;
				 back = -1;
			 }else {back = Integer.parseInt(results);}
			 }
		 }
		 if(back == -1) {
			 result = front;
		 }else {
			 result = (front+back)/str.length;
		 }
		 return result;
	 }
	 public List<String> makeMenuList(String menu){
		 List<String> menuList = new ArrayList<>();
		 Matcher m =  Pattern.compile("\\S+").matcher(menu);
		 while(m.find()) {
			 menuList.add(m.group());
		 }
		 return menuList;
	 }
	 public void getPoint(List<String> menuList) {
		 List<String> strList = Arrays.asList("Japan","Western","Western","Asia","Minority","Fusion","Drinks","Cafe","Desert");
		 boolean flag = true;
		 int cnt = 0;
		 List<List<String>> sList = Arrays.asList(japanes,western,asia,minority,fusion,drinks,cafe,desert);
		 for(String menus:menuList) {
			 cnt = 0;
			 if(flag) {
				for(List<String> li:sList) {
					for(String s:li) {
						if(menus.equals(s)) {
							pointMap.put(strList.get(cnt),pointMap.get(strList.get(cnt)) + 1);
							flag = false;
							break;
						}
					}
					cnt++;
				}
			 }
		 }
		 if(!flag) {
			 System.out.println("성공 ");
		 }
	 }
	 //결과 포인트 조회
	 public HashMap<String,Integer> getMap() {
		 return this.pointMap;
	 }
}
