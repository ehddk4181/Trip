package com.trip.guide.vo;

public class HotelVo {
	private String hotelName;
	private int hotelStar;
	private double hotelPoint;
	public HotelVo(String hotelName, int hotelStar, double hotelPoint) {
		super();
		this.hotelName = hotelName;
		this.hotelStar = hotelStar;
		this.hotelPoint = hotelPoint;
	}
	public HotelVo() {
		super();
	}
	public String getHotelName() {
		return hotelName;
	}
	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}
	public int getHotelStar() {
		return hotelStar;
	}
	public void setHotelStar(int hotelStar) {
		this.hotelStar = hotelStar;
	}
	public double getHotelPoint() {
		return hotelPoint;
	}
	public void setHotelPoint(double hotelPoint) {
		this.hotelPoint = hotelPoint;
	}
	@Override
	public String toString() {
		return "HotelVo [hotelName=" + hotelName + ", hotelStar=" + hotelStar + ", hotelPoint=" + hotelPoint + "]";
	}
	
}
