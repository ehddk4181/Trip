package com.trip.guide.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.trip.guide.vo.BoardVO;
import com.trip.guide.vo.CommentVO;

public interface BoardMapper {
	public int getTotal(HashMap<String, String> map);
	
	public List<BoardVO> selectAll(HashMap<String, String> map, RowBounds rb);
	
	public int insertBoard(BoardVO board);
	
	public BoardVO selectBoardByNum(BoardVO boardNum);
	
	public int updateBoard(BoardVO boardNum);
	
	public int deleteComment(CommentVO boardNum);
	
	public int addComment(CommentVO comment);
	
	public List<CommentVO> commentList(CommentVO comment);
	
	public List<CommentVO> replyList(CommentVO comment);
	
	public int deleteBoard(BoardVO boardNum);
	
}
