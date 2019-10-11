package com.trip.guide.vo;

public class YahooMapVo {
	private String route,walkTime,carTime;
	private double walkLength,carLength,point;

	public YahooMapVo(String route, double walkLength, String walkTime, double carLength, String carTime,double point) {
		super();
		this.route = route;
		this.walkLength = walkLength;
		this.walkTime = walkTime;
		this.carLength = carLength;
		this.carTime = carTime;
		this.point = point;
	}

	public YahooMapVo() {
		super();
	}

	public String getRoute() {
		return route;
	}
	public double getPoint() {
		return point;
	}
	
	public void setPoint(double point) {
		this.point = point;
	}

	public void setRoute(String route) {
		this.route = route;
	}

	public double getWalkLength() {
		return walkLength;
	}

	public void setWalkLength(double walkLength) {
		this.walkLength = walkLength;
	}

	public String getWalkTime() {
		return walkTime;
	}

	public void setWalkTime(String walkTime) {
		this.walkTime = walkTime;
	}

	public double getCarLength() {
		return carLength;
	}

	public void setCarLength(double carLength) {
		this.carLength = carLength;
	}

	public String getCarTime() {
		return carTime;
	}

	public void setCarTime(String carTime) {
		this.carTime = carTime;
	}

	@Override
	public String toString() {
		return "YahooMapVo [route=" + route + ", walkTime=" + walkTime + ", carTime=" + carTime + ", walkLength="
				+ walkLength + ", carLength=" + carLength + ", point=" + point + "]";
	}

	

	
}
