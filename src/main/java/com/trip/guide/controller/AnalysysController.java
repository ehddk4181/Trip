package com.trip.guide.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.trip.guide.analyUtill.Kuromoji;
import com.trip.guide.analyUtill.OCRclass;
import com.trip.guide.vo.HotelVo;
import com.trip.guide.vo.TabeVo;
import com.trip.guide.vo.YahooMapVo;
import com.trip.guide.analyUtill.AnalysisMain;

@Controller
@RequestMapping("/analysis")
public class AnalysysController {
	private AnalysisMain am = new AnalysisMain();
	private Kuromoji mct = new Kuromoji();
	private OCRclass ocr = new OCRclass();
	private List<String> japanList;
	private List<String> timeList;

	@RequestMapping(value = "/goAnalysis", method = RequestMethod.GET)
	public String home() {
		return "Analysis/AnalysisPage";
	}

	@RequestMapping(value = "/goAnaly", method = RequestMethod.GET)
	public String goAnaly() {
		ocr.newTextList();
		return "Analysis/AnalysisWrite";
	}

	@RequestMapping(value = "/goAnalysisWithFile", method = {RequestMethod.GET,RequestMethod.POST})
	public String goAnalysisWithFile(MultipartFile mFile) {
		if (mFile != null) {
			if (!mFile.isEmpty()) {
				String savedName = UUID.randomUUID().toString();
				try {
					String filePath = "C:/test2/" + savedName;
					mFile.transferTo(new File(filePath));
					ocr.setText(filePath);
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
		}
		return "Analysis/AnalysisWrite";
	}
	@ResponseBody
	@RequestMapping(value = "/getTextList", method = {RequestMethod.GET,RequestMethod.POST})
	public List<HashMap<String,String>> getTextList() {
		if((ocr.getText())!=null){
			return (ocr.getText());}
		else {
			return null;
		}
	}
	@RequestMapping(value = "/anaResult", method = {RequestMethod.GET,RequestMethod.POST})
	public String anaResult(@RequestParam(value="japan", required=true)List<String> japanList,@RequestParam(value="time", required=true)List<String> timeList) {
		this.japanList = japanList;
		this.timeList = timeList;
		return "Analysis/AnalysisResult";
	}
	@ResponseBody
	@RequestMapping(value = "/analysis", method = {RequestMethod.GET,RequestMethod.POST})
	public HashMap<String,Double> analysis() {
		List<String> jList =new ArrayList<String>();
		for(HashMap<String,String> s:(ocr.getText())) {
			jList.add(s.get("japan"));
		}
		HashMap<String,Double> result = am.analyStart(jList);
		return result;
	}
	@ResponseBody
	@RequestMapping(value = "/analysis/getHotelList", method = {RequestMethod.GET,RequestMethod.POST})
	public List<HotelVo> getHotelList() {
		return am.getHotelAllList();
	}
	@ResponseBody
	@RequestMapping(value = "/analysis/getFoodList", method = {RequestMethod.GET,RequestMethod.POST})
	public List<TabeVo> getFoodList() {
		return am.getTabeList();
	}
	@ResponseBody
	@RequestMapping(value = "/analysis/getYahooList", method = {RequestMethod.GET,RequestMethod.POST})
	public List<YahooMapVo> getYahooList() {
		return am.getYahooList();
	}
	@ResponseBody
	@RequestMapping(value = "/analysis/getTabeList", method = {RequestMethod.GET,RequestMethod.POST})
	public HashMap<String,Integer> getTabeList() {
		return am.getMenuVari();
	}
	@ResponseBody
	@RequestMapping(value = "/analysis/getTotalTime", method = {RequestMethod.GET,RequestMethod.POST})
	public HashMap<String,String> getTotalTime() {
		return am.getTotalTime();
	}
	@ResponseBody
	@RequestMapping(value = "/analysis/getRecommend", method = {RequestMethod.GET,RequestMethod.POST})
	public List<HashMap<String,String>> getRecommend() {
		return am.getRecommendList();
	}
	
	
	
}
