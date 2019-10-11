package com.trip.guide.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.trip.guide.service.BoardService;
import com.trip.guide.util.PageNavigator;
import com.trip.guide.vo.BoardVO;
import com.trip.guide.vo.CommentVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService service;
	
	//수정 페이지 이동
	@RequestMapping(value = "/updateForm", method={RequestMethod.GET, RequestMethod.POST})
	public String updateForm(BoardVO board, BoardVO boardNum, Model model, HttpSession session, HttpServletRequest request){
		
		String num = request.getParameter("boardNum");
		
		board.setBoardNum(num);
		
		BoardVO result = service.selectBoardByNum(boardNum);
		
		model.addAttribute("result", result);
		
		return "/board/boardEdit";
		
	}
	
	@RequestMapping(value = "/imageUpload", method = RequestMethod.POST)
    public void communityImageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) {
 
        OutputStream out = null;
        PrintWriter printWriter = null;
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
 
        try{
 
            String fileName = upload.getOriginalFilename();
            byte[] bytes = upload.getBytes();
            String uploadPath = "C:/test2/" + fileName;//저장경로
 
            out = new FileOutputStream(new File(uploadPath));
            out.write(bytes);
            String callback = request.getParameter("CKEditorFuncNum");
 
            printWriter = response.getWriter();
            String fileUrl = request.getContextPath()+ "/images/" + fileName;//url경로
  
            printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
            
            printWriter.flush();
 
        }catch(IOException e){
            e.printStackTrace();
        } finally {
            try {
                if (out != null) {
                    out.close();
                }
                if (printWriter != null) {
                    printWriter.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
 
        return;
    }
	//메인 게시판 이동
	@RequestMapping(value="/boardList" ,method = {RequestMethod.GET,RequestMethod.POST})
	public String boardList(
			Model model,
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			@RequestParam(value="searchItem", defaultValue="boardTitle") String searchItem,
			@RequestParam(value="searchKeyword", defaultValue="") String searchKeyword
			) {
		System.out.println("옴?");
		PageNavigator navi = service.getNavi(currentPage, searchItem, searchKeyword);
		List<BoardVO>list = service.selectAll(searchItem, searchKeyword, navi);
		
		model.addAttribute("list", list);
		model.addAttribute("navi", navi);
		model.addAttribute("searchItem", searchItem);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "board/boardList";
	}
	
	//게시글 등록 페이지 이동
	@RequestMapping(value="/boardEdit")
    public String writeBoardForm() throws Exception{
        
        return "board/boardEdit";
    }
	
	//게시글 등록
	@RequestMapping(value="/insertBoard", method={RequestMethod.GET, RequestMethod.POST})
	public String insertBoard(BoardVO board, HttpSession session){
		
		if(service.insertBoard(board, session) != 0){
			System.out.println("등록 성공");
		}
		
		return "redirect:/board/boardList";
	}
	
	//게시글 뷰단 페이지 이동
	@RequestMapping(value="/boardView", method={RequestMethod.GET, RequestMethod.POST})
	public String viewForm(BoardVO board, BoardVO boardNum, Model model, HttpSession session, HttpServletRequest request){
		
		String num = request.getParameter("boardNum");
		
		board.setBoardNum(num);
		
		BoardVO result = service.selectBoardByNum(boardNum);
		
		model.addAttribute("result", result);
		
		return "board/boardView";
	}
	
	
	//게시글 수정
	@RequestMapping(value="/updateBoard", method={RequestMethod.GET, RequestMethod.POST})
	public String updateBoard(BoardVO boardNum, HttpSession session){
		
		if(service.updateBoard(boardNum, session) != 0){
			System.out.println("수정 성공");
		}
		
		return "redirect:/board/boardList";
	}
	
	//댓글 삭제
	@RequestMapping(value="/deleteComment", method={RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody void deleteComment(CommentVO boardNum){
		if(service.deleteComment(boardNum)!=0){
			System.out.println("수정 생공");
		}
	}
	
	//게시글 삭제
	@RequestMapping(value="/deleteBoard", method={RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody void deleteBoard(BoardVO boardNum){
		System.out.println(boardNum);
		if(service.deleteBoard(boardNum) != 0){
			System.out.println("삭제 성공");
		}
	}
	
	//댓글 입력
	@RequestMapping(value="/addComment", method={RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody String addComment(CommentVO comment, HttpServletRequest request){
		
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId"); //게시판 찾을 멤버 ID 등록
		comment.setMemberId(memberId);
		String commentId = (String) session.getAttribute("memberId"); //댓글 : 세션에서 멤버ID 가져오기
		comment.setCommentId(commentId);
		System.out.println(comment);
		
		int result = service.addComment(comment);
		
		if(result != 0){
			return "success";
		}else {
			return "false";
		}
	}
	
	//댓글 리스트 출력
	@RequestMapping(value="/commentList", produces="application/json; charset=utf8")
	@ResponseBody
	 public ResponseEntity commentList(@ModelAttribute("comment") CommentVO comment, HttpServletRequest request){
		
		HttpHeaders responseHeaders = new HttpHeaders();
        ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
        
        // 해당 게시물 댓글
        List<CommentVO> clist = service.commentList(comment);
        
        if(clist.size() > 0){
            for(int i=0; i<clist.size(); i++){
                HashMap hm = new HashMap();
                hm.put("commentNum", clist.get(i).getCommentNum());
                hm.put("boardNum", clist.get(i).getBoardNum());
                hm.put("commentView", clist.get(i).getCommentView());
                hm.put("commentDate", clist.get(i).getCommentDate());
                hm.put("commentId", clist.get(i).getCommentId());
                hm.put("commentLocation", clist.get(i).getCommentLocation());
                
                hmlist.add(hm);
            }
            
        }
        
        JSONArray json = new JSONArray(hmlist);        
        return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
        
    }
	
	@RequestMapping(value="/replyList", produces="application/json; charset=utf8")
	@ResponseBody
	 public ResponseEntity replyList(@ModelAttribute("comment") CommentVO comment, HttpServletRequest request){
		
		HttpHeaders responseHeaders = new HttpHeaders();
        ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
        
        List<CommentVO>rlist = service.replyList(comment);
        System.out.println(rlist);
        
        if(rlist.size() > 0){
        	for(int i=0; i<rlist.size(); i++){
        		HashMap hm = new HashMap();
        		hm.put("commentNum", rlist.get(i).getCommentNum());
                hm.put("boardNum", rlist.get(i).getBoardNum());
        		hm.put("commentId", rlist.get(i).getCommentId());
        		hm.put("commentView", rlist.get(i).getCommentView());
        		hm.put("commentDate", rlist.get(i).getCommentDate());
        		
        		hmlist.add(hm);
        	}
        }
        
        JSONArray json = new JSONArray(hmlist);        
        return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
	}
}
