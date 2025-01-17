package com.jj.faq.model.dao;

import static com.jj.common.JDBCTemplate.*;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.jj.faq.model.vo.PageInfoFaq;
import com.jj.faq.model.vo.Faq;
import com.jj.faq.model.vo.MTM;

public class FaqDao {
	
	private Properties prop = new Properties();
		
	public FaqDao() {
		try {
			prop.loadFromXML(new FileInputStream(FaqDao.class.getResource("/db/sql/faq-mapper.xml").getPath()));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public ArrayList<Faq> selectFaqList(Connection conn, PageInfoFaq pi, String searchWord){
		// select문 => result set에 담김 (여러행조회) => ArrayList<Faq>에 담음
		ArrayList<Faq> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectFaqList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, '%'+ searchWord + '%');
			pstmt.setString(2, '%'+ searchWord + '%');
			
			int startRow = (pi.getCurrentPage() - 1) * pi.getFaqLimit() + 1;
			int endRow = startRow + pi.getFaqLimit() - 1;
			pstmt.setInt(3, startRow);
			pstmt.setInt(4, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new Faq(rset.getInt("faq_no"),
								 rset.getString("user_id"),
								 rset.getString("faq_title"),
								 rset.getString("faq_answer"),
								 rset.getInt("faq_count")
						));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}
	
	public int insertMTM(Connection conn, MTM m) {
		// insert문 => 처리된 행수
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertMTM");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, m.getUserNo());
			pstmt.setString(2, m.getMtmTitle());
			pstmt.setString(3, m.getMtmContent());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	
	
	public int increaseCount(Connection conn, int faqNo) {
		// Update문 => 처리된 행수
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("increaseCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, faqNo);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	
	public Faq selectFaq(Connection conn, int faqNo) {
		// select문 => ResultSet(한행) => Faq담음
		Faq fq = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectFaq");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, faqNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				
				fq = new Faq(rset.getInt("faq_no"),
						     rset.getString("faq_title"),
						     rset.getString("faq_answer"),
							 rset.getString("user_id"),
							 rset.getDate("faq_enrolldate")
						);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return fq;
	}

	
	public ArrayList<Faq> selectCountFaqList(Connection conn, PageInfoFaq pi, String searchWord){
		// select문 => result set에 담김 (여러행조회) => ArrayList<Faq>에 담음
		ArrayList<Faq> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectCountFaqList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, '%' + searchWord + '%');
			pstmt.setString(2, '%' + searchWord + '%');
			
			int startRow = (pi.getCurrentPage() - 1) * pi.getFaqLimit() + 1;
			int endRow = startRow + pi.getFaqLimit() - 1;
			pstmt.setInt(3, startRow);
			pstmt.setInt(4, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new Faq(rset.getInt("faq_no"),
								 rset.getString("faq_title"),
								 rset.getInt("faq_count")
						));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}
	
	public int selectListCount(Connection conn, String searchWord) {
		// select문 => ResultSet 한행 조회
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectListCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, '%' + searchWord + '%');
			pstmt.setString(2, '%' + searchWord + '%');
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				listCount = rset.getInt("COUNT");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return listCount;
	}
	
	public ArrayList<Faq> selectSearchFaq(Connection conn, String searchWord){
		// select문 => resultset 여러행 => ArrayList반환
		ArrayList<Faq> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectSearchFaq");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, '%'+ searchWord + '%');
			pstmt.setString(2, '%' + searchWord + '%');
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new Faq(rset.getInt("faq_no"),
								 rset.getString("faq_title")
						));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return list;		
	}
}
