package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Address;

public class AddressDao {
	// select : 주소 개수
	// select : 가장 오래된 주소
	// delete : 6개면 삭제
	// insert : 추가
	public void insertAddress(Address address) throws Exception {
		Connection conn = null;
		PreparedStatement stmt1 = null;
		PreparedStatement stmt2 = null;
		PreparedStatement stmt3 = null;
		ResultSet rs1 = null;
		
		String sql = """
					select count(*) from address where customer_code=?
			""";
		
		String sql2 = """
					delete from address 
					where address_code = (selectt min(address_code) from address)
			""";
		
		String sql3 = """
					insert into address(address_code, customer_code, address, createdate)
					values(seq_address.nextval, ?, ? sysdate)
			""";
		
		try {
			conn = DBConnection.getConn();
			conn.setAutoCommit(false);
			stmt1 = conn.prepareStatement(sql);
			rs1 = stmt1.executeQuery();
			rs1.next();
			int cnt = rs1.getInt(1);
			
			// 5개면 가장 오래된 주소 삭제 후 입력 delete
			if(cnt > 4) { 
				stmt2 = conn.prepareStatement(sql2);
				stmt2.executeUpdate();
			}
			
			// 추가 insert 
			stmt3 = conn.prepareStatement(sql3);
			stmt3.setInt(1, address.getCustomerCode());
			stmt3.setString(2, address.getAddress());
			int row = stmt3.executeUpdate();
			
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { // finally 자원해지(close()) 시 null 유무 확인 후 해지
			try {
				if(rs1 != null) rs1.close();
			    if(stmt1 != null) stmt1.close();
			    if(stmt2 != null) stmt2.close();
			    if(stmt3 != null) stmt3.close();
			    if(conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		
		
	}
}
