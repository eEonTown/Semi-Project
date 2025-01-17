package com.jj.community.model.service;

import static com.jj.common.JDBCTemplate.close;
import static com.jj.common.JDBCTemplate.commit;
import static com.jj.common.JDBCTemplate.getConnection;
import static com.jj.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import com.jj.common.model.vo.PageInfo;
import com.jj.community.model.dao.CommunityDao;
import com.jj.community.model.vo.Category;
import com.jj.community.model.vo.Community;
import com.jj.community.model.vo.Reply;

public class CommunityService {
	
	public int selectListCount(int category) {
		Connection conn = getConnection();
		int listCount = new CommunityDao().selectListCount(conn, category);
		close(conn);
		return listCount;
	}

	public ArrayList<Community> selectList(PageInfo pi, int category) {
		Connection conn = getConnection();
		ArrayList<Community> list = new CommunityDao().selectList(conn, pi, category);
		close(conn);
		return list;
	}
	
	public ArrayList<Category> selectCategoryList() {
		Connection conn = getConnection();
		ArrayList<Category> list = new CommunityDao().selectCategoryList(conn);
		close(conn);
		return list;
	}
	
	public int insertCommunity(Community c) {
		Connection conn = getConnection();
		int result = new CommunityDao().insertCommunity(conn, c);

		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		return result;
	}
	
	// 게시물 조회수 증가 메서드
	public int increaseCount(int contentNo) {
		Connection conn = getConnection();
		int result = new CommunityDao().increaseCount(conn, contentNo);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		return result;
	}
	
	// 게시물 조회 메서드
	public Community selectCommunity(int contentNo) {
		Connection conn = getConnection();
		Community c = new CommunityDao().selectCommunity(conn, contentNo);
		close(conn);
		return c;
	}
	
	// 게시물 제목, 내용 수정 메서드
	public int updateCommunity(Community c) {
		Connection conn = getConnection();
		int result = new CommunityDao().updateCommunity(conn, c);
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	public int deleteCommunity(int contentNo) {
		Connection conn = getConnection();
		int result = new CommunityDao().deleteCommunity(conn, contentNo);
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	public ArrayList<Reply> selectReplyList(int contentNo) {
		Connection conn = getConnection();
		ArrayList<Reply> list = new CommunityDao().selectReplyList(conn, contentNo);
		close(conn);
		return list;
		
	}
	
	public int insertReply(Reply r) {
		Connection conn = getConnection();
		int result = new CommunityDao().insertReply(conn, r);
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	public ArrayList<Community> selectListByLike(PageInfo pi, int category) {
		Connection conn = getConnection();
		ArrayList<Community> list = new CommunityDao().selectListByLike(conn, pi, category);
		close(conn);
		return list;
	}
	
	public ArrayList<Community> selectListByCount(PageInfo pi, int category) {
		Connection conn = getConnection();
		ArrayList<Community> list = new CommunityDao().selectListByCount(conn, pi, category);
		close(conn);
		return list;	
	}
	
	public int searchListCount(int category, String keyword) {
		Connection conn = getConnection();
		int searchListCount = new CommunityDao().searchListCount(conn, category, keyword);
		close(conn);
		return searchListCount;
	}
	
	public ArrayList<Community> searchList(int category, String keyword){
		Connection conn = getConnection();
		ArrayList<Community> searchList = new CommunityDao().searchList(conn, category, keyword);
		close(conn);
		return searchList;
	}
	
	/**
	 * 메인페이지에 출력할 커뮤니티 게시글 리스트 조회 요청 처리를 해주는 메소드
	 * @return 커뮤니티 게시글 리스트
	 * @author youngheonchoi 
	 */
	public ArrayList<Community> selectCommunityAllList(){
		Connection conn = getConnection();
		ArrayList<Community> list = new CommunityDao().selectCommunityAllList(conn);
		close(conn);
		return list;
	}
	
	public int selectLike(int userNo, int commNo) {
		Connection conn = getConnection();
		int likeCheck = new CommunityDao().selectLike(conn, userNo, commNo);
		close(conn);
		return likeCheck;
	}
	
	public int insertLike(int userNo, int commNo) {
		Connection conn = getConnection();
		int result = new CommunityDao().insertLike(conn, userNo, commNo);
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		return result;
	}
	
	public int deleteLike(int userNo, int commNo) {
		Connection conn = getConnection();
		int result = new CommunityDao().deleteLike(conn, userNo, commNo);
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		return result;
	}
	
	public int selectLikeCount(int commNo) {
		Connection conn = getConnection();
		int likeCount = new CommunityDao().selectLikeCount(conn, commNo);
		close(conn);
		return likeCount;
	}
}
