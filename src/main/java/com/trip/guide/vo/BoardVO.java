package com.trip.guide.vo;

import lombok.Data;

@Data
public class BoardVO {
	
	private String boardNum; //게시글 번호
	private String memberId; //유저아이디
	private String boardDeleted; //게시글 삭제여부
	private String boardType; //게시글 종류(호텔, 식당, 즐길거리)
	private String boardDate; //게시글 작성일
	private String boardTitle; //게시글 제목
	private String boardView; //게시글 내용
	private String boardLocation; //게시글 작성 위치
	
}
