package com.trip.guide.vo;

import lombok.Data;

@Data
public class MemberVO {
	private String memberId;
	private String memberPassword;
	private String memberName;
	private String memberPhone;
	private String memberEmail;
	private String memberBirth;
	private String memberGrade;
	private String memberDeleted;
	private String memberSigndate; 	
}
