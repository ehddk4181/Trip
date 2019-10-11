package com.trip.guide.analyUtill;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;

import com.google.cloud.vision.v1.AnnotateImageRequest;
import com.google.cloud.vision.v1.AnnotateImageResponse;
import com.google.cloud.vision.v1.BatchAnnotateImagesResponse;
import com.google.cloud.vision.v1.EntityAnnotation;
import com.google.cloud.vision.v1.Feature;
import com.google.cloud.vision.v1.Feature.Type;
import com.google.cloud.vision.v1.Image;
import com.google.cloud.vision.v1.ImageAnnotatorClient;
import com.google.protobuf.ByteString;



public class OCRclass {
	
	private List<HashMap<String,String>> ResultList;
	public void newTextList() {
		ResultList = new ArrayList<>();
	}
	
	public void detectText(String filePath) throws Exception, IOException {
		try {
			
			String imageFilePath = filePath;
			
			List<AnnotateImageRequest> requests = new ArrayList<>();
		
			ByteString imgBytes = ByteString.readFrom(new FileInputStream(imageFilePath));
		
			Image img = Image.newBuilder().setContent(imgBytes).build();
			Feature feat = Feature.newBuilder().setType(Type.TEXT_DETECTION).build();
			AnnotateImageRequest request = AnnotateImageRequest.newBuilder().addFeatures(feat).setImage(img).build();
			requests.add(request);
		
			try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
				BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
			    List<AnnotateImageResponse> responses = response.getResponsesList();
		
			    for (AnnotateImageResponse res : responses) {
			    	if (res.hasError()) {
			    		System.out.printf("Error: %s\n", res.getError().getMessage());
			    		return;
			    	}
		
			    	ResultList = trimText(res.getTextAnnotationsList().get(0).getDescription());
			    	// For full list of available annotations, see http://g.co/cloud/vision/docs
			    	/*for (EntityAnnotation annotation : res.getTextAnnotationsList()) {
				    	  
						//System.out.printf("Text: %s\n", annotation.getDescription());
						//System.out.printf("Position : %s\n", annotation.getBoundingPoly());
					}*/
			    }
			}
		} catch(Exception e) {
			e.printStackTrace();
		} 
	}
	public List<HashMap<String,String>> getText() {
		return ResultList;
	}
	public void setText(String filePath) {
		try {
			ResultList = new ArrayList<>();
			detectText(filePath);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public List<HashMap<String,String>> trimText(String text) {
		System.out.println(text);
		String clearText = Pattern.compile("\\s|\\。").matcher(text).replaceAll("<");
		System.out.println(clearText);
		List<HashMap<String,String>> resultList = new ArrayList<>();
		List<String> jList = new ArrayList<>();
		List<String> tList = new ArrayList<>();
		Matcher japan = Pattern.compile("[あ-ん一-龥ア-ンー]+\\<").matcher(clearText);
		Matcher times = Pattern.compile("[\\d\\:\\~\\～\\-\\∼]+\\<").matcher(clearText);
		
		while(japan.find()) {
			
			jList.add(cutText(japan.group()));
		}
		while(times.find()) {
			
			tList.add(cutText(times.group()));
		}
		int endNum = 0;
		if(jList.size()>=tList.size()) {
			endNum = tList.size();
		}else {
			endNum = jList.size();
		}
		for(int i=0;i<endNum;i++) {
			HashMap<String,String> hm = new HashMap<>();
			hm.put("time", tList.get(i));
			hm.put("japan", jList.get(i));
			resultList.add(hm);
		}
		return resultList;
		
	}
	public String cutText(String text) {
		return Pattern.compile("\\<").matcher(text).replaceAll("");
	}
	
	
		
}
