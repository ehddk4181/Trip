package com.trip.guide.vo;

public class GetFamousVo {

	public GetFamousVo(String placeName, String placeReview) {
		super();
		this.placeName = placeName;
		this.placeReview = placeReview;
	}

	public GetFamousVo() {
		super();
	}
	private String placeName,placeReview;

	public String getPlaceName() {
		return placeName;
	}

	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}

	public String getPlaceReview() {
		return placeReview;
	}

	public void setPlaceReview(String placeReview) {
		this.placeReview = placeReview;
	}

	@Override
	public String toString() {
		return "GetFamousVo [placeName=" + placeName + ", placeReview=" + placeReview + "]";
	}
	
}
