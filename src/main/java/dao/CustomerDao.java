package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Customer;
import dao.DBConnection;

public class CustomerDao {
	public Customer selectCustomerByLogin(Customer c) throws Exception {
		Customer loginCustomer = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "select customer_code, customer_id, customer_pw"
				+ " from customer"
				+ " where customer_id=? and customer_pw=?";
		
		Class.forName("oracle.jdbc.OracleDriver");
		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, c.getCustomerId());
		stmt.setString(2, c.getCustomerPw());
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			loginCustomer = new Customer();
			loginCustomer.setCustomerId(rs.getString("customer_id"));
			loginCustomer.setCustomerPw(rs.getString("customer_pw"));
		}
		return loginCustomer;
		
	}
	
	public int insertCustomer(Customer c) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		
		String sql = "INSERT INTO customer "
		           + "(customer_code, customer_id, customer_pw, customer_name, customer_phone, point, createdate) "
		           + "VALUES (seq_customer.nextval, ?, ?, ?, ?, ?, sysdate)";
		
		Class.forName("oracle.jdbc.OracleDriver");
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
}
