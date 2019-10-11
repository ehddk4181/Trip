package com.trip.guide.analyUtill;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Pattern;

import org.atilika.kuromoji.Token;
import org.atilika.kuromoji.Tokenizer;
import org.atilika.kuromoji.Tokenizer.Builder;




public class Kuromoji {
	private List<String> food = new ArrayList<>();
	private List<String> place = new ArrayList<>();
	private List<String> hotel = new ArrayList<>();


	public HashMap<String,List<String>> kuromoTest(List<String> textList) {
		HashMap<String,List<String>> result = new HashMap<>();
		for(String text:textList) {
		List<Integer> chosaList = new ArrayList<>();
		Tokenizer tokenizer = Tokenizer.builder().build();
		Builder builder = Tokenizer.builder();
		List<Token> tokens = tokenizer.tokenize(text);
		for (int i = 0; i < tokens.size(); i++) {
			System.out.println("allFeaturesArray : " + Arrays.asList(tokens.get(i).getAllFeaturesArray()));
			if(tokens.get(i).getAllFeaturesArray()[0].equals("助詞")) {
				chosaList.add(i);
			}
			if (checkWord(tokens.get(i))) {
				String type = typeSelect(tokens.get(i));
				if (!type.equals("pass")) {
					if (type.equals("hotel")) {
						hotel.add(getName(tokens,chosaList));
					} else if (type.equals("place")) {
						place.add(getName(tokens,chosaList));
					} else if (type.equals("food")) {
						food.add(getName(tokens,chosaList));
					}
					break;
				}
			} else if (tokens.get(i).getAllFeaturesArray()[1].equals("サ変接続")) {
				String type = checkVerbWord(tokens.get(i));
				if (!type.equals("pass")) {
					if (type.equals("hotel")) {
						hotel.add(getName(tokens,chosaList));
					} else if (type.equals("place")) {
						place.add(getName(tokens,chosaList));
					} else if (type.equals("food")) {
						food.add(getName(tokens,chosaList));
					}
					break;

				}

			}

		}
		result.put("food", food);
		result.put("place", place);
		result.put("hotel", hotel);
		}
		return result;
	}

	public String checkVerbWord(Token t) {
		System.out.println(t.getBaseForm());
		if (Pattern.compile("食事").matcher(t.getBaseForm()).find()) {
			return "food";
		} else if (Pattern.compile("旅|観光|旅行").matcher(t.getBaseForm()).find()) {
			return "place";
		} else if (Pattern.compile("宿泊").matcher(t.getBaseForm()).find()) {
			return "hotel";
		} else {
			return "pass";
		}
	}

	public String typeSelect(Token t) {
		if (Pattern.compile("食|飲").matcher(t.getBaseForm()).find()) {
			return "food";
		} else if (Pattern.compile("行|出|遊|見").matcher(t.getBaseForm()).find()) {
			return "place";
		} else if (Pattern.compile("泊|寝").matcher(t.getBaseForm()).find()) {
			return "hotel";
		} else {
			return "pass";
		}
	}

	public String getName(List<Token> tokens,List<Integer> numList) {
		System.out.println(numList);
		int startNum = 0;
		int endNum = tokens.size();
		if(numList.size()<3) {
			endNum = numList.get(0);
		}else if(numList.size()>=3) {
			startNum = numList.get(0);
			endNum = numList.get(1);
			
		}
		String name = "";
		for (int x = startNum; x <= endNum ; x++) {			
			if (tokens.get(x).getAllFeaturesArray()[0].equals("名詞")|| tokens.get(x).getAllFeaturesArray()[0].equals("接頭詞")) {
				name += tokens.get(x).getBaseForm();
			}
			
		}
		return name;
	}



	public boolean checkWord(Token word) {
		if (Pattern.compile("動詞").matcher(word.getAllFeaturesArray()[0]).find()
				|| word.getAllFeaturesArray()[1].equals("自立"))
			return true;
		else
			return false;
	}

	public void ex() {
		// 結果を出力してみる
		Tokenizer tokenizer = Tokenizer.builder().build();
		List<Token> tokens = tokenizer.tokenize("a");
		for (Token token : tokens) {
			System.out.println("==================================================");
			System.out.println("allFeatures : " + token.getAllFeatures());
			System.out.println("partOfSpeech :" + " " + token.getPartOfSpeech());
			System.out.println("position : " + token.getPosition());
			System.out.println("reading : " + token.getReading());
			System.out.println("surfaceFrom : " + token.getSurfaceForm());
			System.out.println("allFeaturesArray : " + Arrays.asList(token.getAllFeaturesArray()));
			System.out.println("辞書にある言葉? : " + token.isKnown());
			System.out.println("未知語? : " + token.isUnknown());
			System.out.println("ユーザ定義? : " + token.isUser());

		}
	}
}
