    package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Customer;
import dto.Outid;
import dao.DBConnection;

public class CustomerDao {
	//고객 로그인
	public Customer selectCustomerByLogin(Customer c) throws Exception {
		Customer loginCustomer = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "select customer_code, customer_id, customer_pw, customer_name, point"
				+ " from customer"
				+ " where customer_id=? and customer_pw=?";
		
		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, c.getCustomerId());
		stmt.setString(2, c.getCustomerPw());
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			loginCustomer = new Customer();
			loginCustomer.setCustomerCode(rs.getInt("customer_code"));
			loginCustomer.setCustomerId(rs.getString("customer_id"));
			loginCustomer.setCustomerPw(rs.getString("customer_pw"));
			loginCustomer.setCustomerName(rs.getString("customer_name"));
			loginCustomer.setPoint(rs.getInt("point"));
		}
		
		rs.close();
	    stmt.close();
	    conn.close();
		return loginCustomer;
		
	}
	
	//회원가입
	public int insertCustomer(Customer c) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		
		String sql = "INSERT INTO customer "
		           + "(customer_code, customer_id, customer_pw, customer_name, customer_phone, point, createdate) "
		           + "VALUES (seq_customer.nextval, ?, ?, ?, ?, ?, sysdate)";
		
		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, c.getCustomerId());
		stmt.setString(2, c.getCustomerPw());
		stmt.setString(3, c.getCustomerName());
		stmt.setString(4, c.getCustomerPhone());
		stmt.setInt(5, c.getPoint());
		row = stmt.executeUpdate();

	    stmt.close();
	    conn.close();
		return row;
		
	}
	
	//아이디 사용 가능 여부
	//return : null -> 사용가능, 아니면 사용불가
	public String selectCustomerIdCheck(String id) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = """
				select t.id
				from(
					select customer_id id from customer
					union all
					select emp_id id from emp
					union all
					select id from outid
				) t
				where t.id = ?
			""";
		
		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		rs = stmt.executeQuery();
		
		String resultId = null;
		if(rs.next()) {
			resultId = rs.getString("id");
		}
		
		rs.close();
	    stmt.close();
	    conn.close();
		return resultId;
	}
	
	//emp 로그인 시 전체 고객 리스트 확인
	public List<Customer> selectCustomerList(int startRow, int rowPerPage) throws Exception {
		List<Customer> customerList = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String sql = """
					select
					customer_code customerCode, customer_id customerId, customer_name customerName,
					customer_phone customerPhone, point, createdate
					from customer
					order by customer_code
					offset ? rows fetch next ? rows only
				""";

		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();

		customerList = new ArrayList<>();
		while (rs.next()) {
			Customer c = new Customer();
			c.setCustomerCode(rs.getInt("customerCode"));
			c.setCustomerId(rs.getString("customerId"));
			c.setCustomerName(rs.getString("customerName"));
			c.setCustomerPhone(rs.getString("customerPhone"));
			c.setPoint(rs.getInt("point"));
			c.setCreatedate(rs.getString("createdate"));
			customerList.add(c);
		}

		rs.close();
		stmt.close();
		conn.close();
		return customerList;
	}

	public int selectCustomerCount() throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String sql = "select count(*) from customer";

		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		int count = 0;
		if (rs.next()) {
			count = rs.getInt(1);
		}

		rs.close();
		stmt.close();
		conn.close();
		return count;
	}
	
	//직원에 의해 강제 탈퇴
	public void deleteCustomerByEmp(Outid oi) {
		Connection conn = null;
		PreparedStatement psmtCustomer = null;
		PreparedStatement psmtOutId = null;
		String sqlCustomer = """
					delete from customer where customer_id=?
				""";
		String sqlOutId = """
					insert into outid(id, memo, createdate)
					values(?,?,sysdate)
				""";

		// JDBC Connection의 기본 Commit설정값은 auto commit = true -> false 변경 후 transaction
		// 적용
		try {
			conn = DBConnection.getConn();

			conn.setAutoCommit(false); // 개발자가 commit, rollback 직접 구현 필요
			psmtCustomer = conn.prepareStatement(sqlCustomer);
			psmtCustomer.setString(1, oi.getId());
			int row = psmtCustomer.executeUpdate(); // 삭제

			if (row == 1) {
				psmtOutId = conn.prepareStatement(sqlOutId);
				psmtOutId.setString(1, oi.getId());
				psmtOutId.setString(2, oi.getMemo());
				psmtOutId.executeUpdate(); // 입력

			} else {
				throw new SQLException();
			}

			conn.commit();

		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {

			try {
				psmtOutId.close();
				psmtCustomer.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	//emp 로그인 시 탈퇴ID관리 list
	public List<Outid> selectOutidList(String memo, int startRow, int rowPerPage) throws Exception {
		List<Outid> outidList = new ArrayList<>();
		Connection conn = DBConnection.getConn();
		;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		if (memo != null && !memo.isEmpty()) {
			String sql = """
					    SELECT id, memo, createdate
					    FROM outid
					    WHERE memo = ?
					    ORDER BY createdate DESC
					    OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
					""";

			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memo);
			stmt.setInt(2, startRow);
			stmt.setInt(3, rowPerPage);

		} else {
			String sql = """
					    SELECT id, memo, createdate
					    FROM outid
					    ORDER BY createdate DESC
					    OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
					""";

			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
		}
		rs = stmt.executeQuery();

		while (rs.next()) {
			Outid o = new Outid();
			o.setId(rs.getString("id"));
			o.setMemo(rs.getString("memo"));
			o.setCreatedate(rs.getString("createdate"));
			outidList.add(o);
		}

		rs.close();
		stmt.close();
		conn.close();
		return outidList;
	}

	public int selectOutidCount(String memo) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String sql = "select count(*) from outid";
		if (memo != null && !memo.isEmpty()) {
			sql += " where memo = ?";
		}

		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);

		if (memo != null && !memo.isEmpty()) {
			stmt.setString(1, memo);
		}
		rs = stmt.executeQuery();

		int count = 0;
		if (rs.next()) {
			count = rs.getInt(1);
		}

		rs.close();
		stmt.close();
		conn.close();
		return count;
	}
		
}
	

