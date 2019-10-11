package com.trip.guide.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.trip.guide.vo.BoardVO;
import com.trip.guide.vo.CommentVO;

@Repository
public class BoardDAO {
	
	@Autowired
	private SqlSession sqlSession;

	public int insertBoard(BoardVO board) {
		// TODO Auto-generated method stub
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.insertBoard(board);
	}

	public BoardVO selectBoardByNum(BoardVO boardNum) {
		// TODO Auto-generated method stub
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.selectBoardByNum(boardNum);
	}

	public int updateBoard(BoardVO boardNum) {
		// TODO Auto-generated method stub
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.updateBoard(boardNum);
	}
	
	public int deleteComment(CommentVO boardNum){
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.deleteComment(boardNum);
	}

	public int getTotal(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.getTotal(map);
	}

	public List<BoardVO> selectAll(HashMap<String, String> map, int startRecord, int countPerPage) {
		// TODO Auto-generated method stub
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		return mapper.selectAll(map, rb);
	}
	
	public int addComment(CommentVO comment){
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		System.out.println(comment);
		return mapper.addComment(comment);
	}
	
	public List<CommentVO> commentList(CommentVO comment){
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.commentList(comment);
	}
	
	public List<CommentVO> replyList(CommentVO comment){
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.replyList(comment);
	}
	
	public int deleteBoard(BoardVO boardNum){
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.deleteBoard(boardNum);
	}
}
