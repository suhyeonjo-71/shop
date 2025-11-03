package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dto.Emp;

public class EmpDao {
	public Emp selectEmpByLogin(Emp e) throws Exception {
		Emp loginEmp = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "select emp_code, emp_id, emp_pw"
				+ " from emp"
				+ " where emp_id=? and emp_pw=?";
		
		Class.forName("oracle.jdbc.OracleDriver");
		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, e.getEmpId());
		stmt.setString(2, e.getEmpPw());
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			loginEmp = new Emp();
			loginEmp.setEmpId(rs.getString("emp_id"));
			loginEmp.setEmpPw(rs.getString("emp_pw"));
		}
		return loginEmp;
		
	}
	
}
