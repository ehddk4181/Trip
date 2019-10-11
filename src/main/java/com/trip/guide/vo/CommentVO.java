package com.trip.guide.vo;

import lombok.Data;

@Data
public class CommentVO {
	private String commentNum;
	private String boardNum;
	private String memberId;
	private String commentId;
	private String commentView;
	private String commentDate;
	private String commentLocation;
	private String commentDeleted;
}
