package com.trip.guide.analyUtill;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import com.trip.guide.vo.GetFamousVo;

public class GetFamousDestination {
	public List<GetFamousVo> getNumber() throws Exception{
		List<GetFamousVo> gList = new ArrayList<>();
		int x = 0;
		
		Elements destName;
		Elements destReview;
		Document doc = null;
		while(x<150){
			if(x==0) {
				String url1 = "https://www.tripadvisor.jp/Attractions-g298184-Activities-Tokyo_Tokyo_Prefecture_Kanto.html#FILTERED_LIST";
				doc = Jsoup.connect(url1).get();
				destName = doc.select("#FILTERED_LIST > div.attractions-attraction-overview-pois-PoiGrid__wrapper--2H3Mo > li > div.attractions-attraction-overview-pois-PoiCard__card_info--3scTT > div > div:nth-child(2) > a");
				destReview = doc.select("#FILTERED_LIST > div.attractions-attraction-overview-pois-PoiGrid__wrapper--2H3Mo > li > div.attractions-attraction-overview-pois-PoiCard__card_info--3scTT > div > div:nth-child(3) > a > div > span.reviewCount.styleguide-bubble-rating-BubbleRatingWithReviewCount__reviewCount--37tMc");
			}else {
				String url2 = "https://www.tripadvisor.jp/Attractions-g298184-Activities-oa"+x+"-Tokyo_Tokyo_Prefecture_Kanto.html";
				doc = Jsoup.connect(url2).get();				
				destName = doc.select("div.tracking_attraction_title.listing_title > a");
				destReview = doc.select(".more>a");
				
			}
			x+=30;
			List<String> nameList = destChange(destName);
			List<String> reviewList = reviewChange(destReview);
			for(int i=0; i<nameList.size();i++) {
				gList.add(new GetFamousVo(nameList.get(i),reviewList.get(i)));
			}
			
		}
		System.out.println(gList);
		return gList;
	}
	
	public List<String> reviewChange(Elements review) {
		List<String> numberList = new ArrayList<>();
		for(int i=0;i<review.size();i++) {
				String result= "";
				Matcher m = Pattern.compile("[0-9]").matcher(review.get(i).text());
				if(m.find()) {
					result +=m.group();
					while(m.find()) {
						result += m.group();
					}
					numberList.add(result);
				}
		}
		System.out.println(numberList);		
		return numberList;
	}
	public List<String> destChange(Elements dest){
		dest.attr("innerText()");
		List<String> destList = new ArrayList<>();
		for(int i = 0 ; i<dest.size();i++) {
			destList.add(dest.get(i).text());
		}
		
		return destList;
	}
	public double getPoint(List<String> sList) {
		int point = 0;
		int error = 0;
		System.out.println(sList);
		List<GetFamousVo> famousList = null;
		try {
			famousList = getNumber();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		for(String s:sList) {
			for(GetFamousVo vo:famousList) {
				if(s.equals(vo.getPlaceName())) {					
					if(1000<Integer.parseInt(vo.getPlaceReview())) {
						point +=5;
					}
					else if(750<Integer.parseInt(vo.getPlaceReview())) {
						point +=4;
					}
					else if(500<Integer.parseInt(vo.getPlaceReview())) {
						point +=3;
					}
					else if(250<Integer.parseInt(vo.getPlaceReview())) {
						point +=2;
					}else if(0<Integer.parseInt(vo.getPlaceReview())){
						point +=1;
					}else {
						point +=1;
					}
					break;
				}
			}
		}
		return point/sList.size();
	}
	
}
