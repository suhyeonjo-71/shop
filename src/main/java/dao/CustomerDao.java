    package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
	
	//직원 로그인 시 전체 고객 리스트 확인
	public List<Customer> selectCustomerList(int startRow, int rowPerPage) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "select * from goods";
		
		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			
		}
		return null;
	}
	
	//직원에 의해 강제 탈퇴
	public void deleteCustomerByEmp(Outid oi) {
		Connection conn = null;
		PreparedStatement psmtCustomer= null;
		PreparedStatement psmtOutId = null;
		String sqlCustomer = """
					delet from customer where customer_id=?
				""";
		String sqlOutId = """
					insert into outid(id, memo, createdate)
					values(?,?,?)
				""";
		
		//JDBC Connection의 기본 Commit설정값은 auto commit = true -> false 변경 후 transaction 적용
		try {
			conn = DBConnection.getConn();
			conn.setAutoCommit(false); //개발자가 commit, rollback 직접 구현 필요
			psmtCustomer = conn.prepareStatement(sqlCustomer);
			
			// ? oi.getId()
			
			int row = psmtCustomer.executeUpdate(); //삭제
			if(row == 1) {
				psmtOutId = conn.prepareStatement(sqlOutId);
				psmtOutId.executeUpdate(); //입력
				
				//?,?,? oi.getId(), oi.getMemo(), sysdate
				
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
}
