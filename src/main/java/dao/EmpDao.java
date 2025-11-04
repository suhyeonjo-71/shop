package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Emp;

public class EmpDao {
	//사원 로그인
	public Emp selectEmpByLogin(Emp e) throws Exception {
		Emp loginEmp = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "select emp_code, emp_id, emp_pw, emp_name"
				+ " from emp"
				+ " where emp_id=? and emp_pw=? and active > 0";
		
		Class.forName("oracle.jdbc.OracleDriver");
		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, e.getEmpId());
		stmt.setString(2, e.getEmpPw());
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			loginEmp = new Emp();
			loginEmp.setEmpCode(rs.getInt("emp_code"));
			loginEmp.setEmpId(rs.getString("emp_id"));
			loginEmp.setEmpPw(rs.getString("emp_pw"));
			loginEmp.setEmpName(rs.getString("emp_name"));
			loginEmp.setEmpName(rs.getString("emp_name"));
		}
		
		rs.close();
	    stmt.close();
	    conn.close();
	    
		return loginEmp;
		
	}
	
	//사원 목록
	public List<Emp> selectEmpListByPage(int startRow, int rowPerPage) throws Exception {
		List<Emp> empList = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = """
					select emp_code empCode, emp_id empId, emp_name empName, active, createdate
					from emp
					order by emp_code
					offset ? rows fetch next ? rows only
			""";
		//offset 10 rows fetch next 10 rows only : 10행다음부터 10개의행을 가져옴
		
		Class.forName("oracle.jdbc.OracleDriver");
		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		
		empList = new ArrayList<>();
		while(rs.next()) {
			Emp e = new Emp();
			e.setEmpCode(rs.getInt("empCode"));
			e.setEmpId(rs.getString("empId"));
			e.setEmpName(rs.getString("empName"));
			e.setActive(rs.getInt("active"));
			e.setCreatedate(rs.getString("createdate"));
			empList.add(e);
		}
		
		rs.close();
	    stmt.close();
	    conn.close();
	    
		return empList;
	}
	
	public int selectEmpCount() throws Exception {
	    int count = 0;
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    
	    String sql = "SELECT COUNT(*) FROM emp";
	    
	    Class.forName("oracle.jdbc.OracleDriver");
		conn = DBConnection.getConn();
	    stmt = conn.prepareStatement(sql);
	    rs = stmt.executeQuery();
	    if(rs.next()) {
	        count = rs.getInt(1);
	    }
	    
	    conn.close();
	    return count;
	}
	
	//사원추가
	public int insertEmp(Emp e) throws Exception {
		Connection conn = null;
	    PreparedStatement stmt = null;
	    
	    String sql = """
	    		insert into emp(emp_code, emp_id, emp_pw, emp_name, active, createdate)
	    			values(seq_emp.nextval, ?, ?, ?, ?, sysdate)
	    		""";
	    Class.forName("oracle.jdbc.OracleDriver");
		conn = DBConnection.getConn();
	    stmt = conn.prepareStatement(sql);
	    stmt.setString(1, e.getEmpId());
	    stmt.setString(2, e.getEmpPw());
	    stmt.setString(3, e.getEmpName());
	    stmt.setInt(4, e.getActive());
	    int row = stmt.executeUpdate();
	    
		return row;
	}
	
	//활성화 수정
	public int updateEmpActive(Emp e) throws Exception {
		Connection conn = null;
	    PreparedStatement stmt = null;
	    
	    String sql = """
	    		update emp set active=? where emp_code=?
	    	""";
	    Class.forName("oracle.jdbc.OracleDriver");
		conn = DBConnection.getConn();
	    stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, e.getActive());
	    stmt.setInt(2, e.getEmpCode());
	    int row = stmt.executeUpdate();
	    
	    return row;
	}
	
}
