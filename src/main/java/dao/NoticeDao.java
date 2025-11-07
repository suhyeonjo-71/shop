package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.Notice;

public class NoticeDao {
	// /emp/noticeList
	public List<Notice> selectNoticeList(int startRow, int rowPerPage) {
		List<Notice> noticeList = new ArrayList<Notice>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
					SELECT
						notice_code noticeCode
						, notice_title noticeTitle
						, createdate
					FROM notice
					ORDER BY notice_code DESC
					OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
				""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while (rs.next()) {
				Notice n = new Notice();
				n.setNoticeCode(rs.getInt("noticeCode"));
				n.setNoticeTitle(rs.getString("noticeTitle"));
				n.setCreatedate(rs.getString("createdate"));
				noticeList.add(n);
			}
		} catch (Exception e1) {
			// conn.rollback();
			e1.printStackTrace(); // 콘솔에 예외메세지 출력
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return noticeList;
	}

	public int selectNoticeCount() {
		int count = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
					select count(*) from notice
				""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e1) {
			// conn.rollback();
			e1.printStackTrace(); // 콘솔에 예외메세지 출력
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return count;
	}
	
	// /emp/insertNotice
	public int insertNotice(Notice n) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = """
					insert into notice(notice_code, notice_title, notice_content, emp_code, createdate)
					values(seq_notice.nextval, ?, ?, ?, sysdate)
				""";
		
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, n.getNoticeTitle());
			stmt.setString(2, n.getNoticeContent());
			stmt.setInt(3, n.getEmpCode());
			row  = stmt.executeUpdate();
		} catch (Exception e1) {
			e1.printStackTrace();
		} finally {
			try {
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return row;
	}
	
	// /emp/noticeOne
	public Notice selectNoticeOne(int noticeCode) {
		Notice resultNotice = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = """
					select notice_title noticeTitle, notice_content noticeContent, emp_code empCode
					from notice
					where notice_code=?
				""";
		
		try {  
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeCode);
			rs = stmt.executeQuery();
			while(rs.next()) {
				resultNotice = new Notice();
	            resultNotice.setNoticeCode(noticeCode);
	            resultNotice.setNoticeTitle(rs.getString("noticeTitle"));
	            resultNotice.setNoticeContent(rs.getString("noticeContent"));
	            resultNotice.setEmpCode(rs.getInt("empCode"));
			}
		} catch (Exception e1) {
			e1.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return resultNotice;
	}
	
	// /emp/removeNotice
	public int deleteNotice(Notice n) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = """
					delete from notice where notice_code=?
				""";
		
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, n.getNoticeCode());
			row = stmt.executeUpdate();
		} catch (Exception e1) {
			e1.printStackTrace();
		} finally {
			try {
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return row;
	}
	
	// /emp/modifyNotice
	public int updateNotice(Notice n) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = """
					update notice set notice_title=?, notice_content=? where notice_code=?
				""";
		
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, n.getNoticeTitle());
			stmt.setString(2, n.getNoticeContent());
			stmt.setInt(3, n.getNoticeCode());
			row = stmt.executeUpdate();
		} catch (Exception e1) {
			e1.printStackTrace();
		} finally {
			try {
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return row;
	}
}
