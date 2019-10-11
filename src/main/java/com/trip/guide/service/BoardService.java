package com.trip.guide.service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trip.guide.dao.BoardDAO;
import com.trip.guide.util.PageNavigator;
import com.trip.guide.vo.BoardVO;
import com.trip.guide.vo.CommentVO;

@Service
public class BoardService {
	
	@Autowired
	private BoardDAO dao;
	private final int countPerPage = 10;
	private final int pagePerGroup = 5;
	

	public PageNavigator getNavi(int currentPage, String searchItem, String searchKeyword) {
		HashMap<String, String> map = new HashMap<>();
		map.put("searchItem", searchItem);
		map.put("searchKeyword", searchKeyword);
		int totalRecordsCount = dao.getTotal(map);
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, currentPage, totalRecordsCount);
		return navi;
	}
	
	public List<BoardVO> selectAll(String searchItem, String searchKeyword, PageNavigator navi){
		HashMap<String, String> map = new HashMap<>();
		map.put("searchItem", searchItem);
		map.put("searchKeyword", searchKeyword);
		return dao.selectAll(map, navi.getStartRecord(), navi.getCountPerPage());
	}
	
	public int insertBoard(BoardVO board, HttpSession session) {
		String memberId = (String) session.getAttribute("memberId");
		board.setMemberId(memberId);
		return dao.insertBoard(board);
	}
	
	public BoardVO selectBoardByNum(BoardVO boardNum) {
		return dao.selectBoardByNum(boardNum);
	}
	
	public int updateBoard(BoardVO boardNum,  HttpSession session){
		String memberId = (String) session.getAttribute("memberId");
		boardNum.setMemberId(memberId);
		return dao.updateBoard(boardNum);
	}
	
	public int deleteComment(CommentVO boardNum){
		return dao.deleteComment(boardNum);
	}
	
	public int deleteBoard(BoardVO boardNum){
		return dao.deleteBoard(boardNum);
	}
	
	public int addComment(CommentVO comment){
		return dao.addComment(comment);
	}
	
	public List<CommentVO> commentList(CommentVO comment){
		
		//기존
		List<CommentVO> list = dao.commentList(comment);
		//부모
		List<CommentVO> plist = new ArrayList<CommentVO>();
		//자식
		List<CommentVO> clist = new ArrayList<CommentVO>();
		//통합
		List<CommentVO> nlist = new ArrayList<CommentVO>();
		
		//1.부모와 자식 분리
		for(CommentVO reply: list){
			if(reply.getCommentLocation().equals("0")){
				plist.add(reply);
			}else{
				clist.add(reply);
			}
		}
		
		//2. 부모를 돌린다
		for(CommentVO p: plist){
			//2-1. 부모는 무조건 넣는다
			nlist.add(p);
			//3. 자식을 돌린다
			for(CommentVO c: clist){
				//3-1. 부모가 자식인 것들만 넣는다
				if(p.getCommentNum().equals(c.getCommentNum())){
					nlist.add(c);
				}
			}
		}
		return nlist;
	}
	
	public List<CommentVO> replyList(CommentVO comment){
		//기존
				List<CommentVO> list = dao.commentList(comment);
				//부모
				List<CommentVO> plist = new ArrayList<CommentVO>();
				//자식
				List<CommentVO> clist = new ArrayList<CommentVO>();
				//통합
				List<CommentVO> nlist = new ArrayList<CommentVO>();
				
				//1.부모와 자식 분리
				for(CommentVO reply: list){
					if(reply.getCommentLocation().equals("1")){
						plist.add(reply);
					}else{
						clist.add(reply);
					}
				}
				
				//2. 부모를 돌린다
				for(CommentVO p: plist){
					//2-1. 부모는 무조건 넣는다
					nlist.add(p);
					//3. 자식을 돌린다
					for(CommentVO c: clist){
						//3-1. 부모가 자식인 것들만 넣는다
						if(p.getCommentNum().equals(c.getCommentNum())){
							nlist.add(c);
						}
					}
				}
				return nlist;
			}
}
