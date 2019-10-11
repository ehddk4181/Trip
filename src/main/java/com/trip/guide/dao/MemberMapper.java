package com.trip.guide.dao;

import com.trip.guide.vo.MemberVO;

public interface MemberMapper {
	public int signup(MemberVO vo); 
	public MemberVO selectOne(MemberVO vo); 
	public MemberVO login(MemberVO vo);
	public MemberVO checkId(MemberVO vo);
	public MemberVO updateInfo(MemberVO vo);
	public MemberVO idfind(MemberVO vo);
	public int deleteId(MemberVO vo);
	public int updateId(MemberVO vo);
	public MemberVO checkidEmail(MemberVO vo);
	}
