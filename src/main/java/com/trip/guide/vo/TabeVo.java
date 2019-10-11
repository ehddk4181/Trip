package com.trip.guide.vo;

import java.util.List;

public class TabeVo {
	private String marketName;
	private int marketDayPrice,marketNightPrice;
	private double marketPoint;
	private List<String> menu;
	public TabeVo(String marketName, int marketDayPrice, int marketNightPrice, double marketPoint, List<String> menu) {
		super();
		this.marketName = marketName;
		this.marketDayPrice = marketDayPrice;
		this.marketNightPrice = marketNightPrice;
		this.marketPoint = marketPoint;
		this.menu = menu;
	}
	public TabeVo() {
		super();
	}
	public String getMarketName() {
		return marketName;
	}
	public void setMarketName(String marketName) {
		this.marketName = marketName;
	}
	public int getMarketDayPrice() {
		return marketDayPrice;
	}
	public void setMarketDayPrice(int marketDayPrice) {
		this.marketDayPrice = marketDayPrice;
	}
	public int getMarketNightPrice() {
		return marketNightPrice;
	}
	public void setMarketNightPrice(int marketNightPrice) {
		this.marketNightPrice = marketNightPrice;
	}
	public double getMarketPoint() {
		return marketPoint;
	}
	public void setMarketPoint(double marketPoint) {
		this.marketPoint = marketPoint;
	}
	public List<String> getMenu() {
		return menu;
	}
	public void setMenu(List<String> menu) {
		this.menu = menu;
	}
	@Override
	public String toString() {
		return "TabeVo [marketName=" + marketName + ", marketDayPrice=" + marketDayPrice + ", marketNightPrice="
				+ marketNightPrice + ", marketPoint=" + marketPoint + ", menu=" + menu + "]";
	}
	
	

}
