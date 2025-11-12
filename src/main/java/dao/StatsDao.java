package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class StatsDao {
	// 11개의 chart 메서드
	
	// 성별 주문수량 : 파이
	public List<Map<String, Object>> selectOrderCntByGender() {
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
			select t.g gender, count(*) cnt
			from
			(select c.gender g, o.order_code oc
			from customer c inner join orders o
			on c.customer_code = o.customer_code) t
			group by t.g
		""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("gender", rs.getString("gender"));
				map.put("cnt", rs.getInt("cnt"));
				list.add(map);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 성별 주문금액 : 파이
		public List<Map<String, Object>> selectOrderPriceByGender() {
			List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			String sql = """
				select t.g gender, sum(t.op) total
				from
				(select c.gender g, o.order_price op
				from customer c inner join orders o
				on c.customer_code = o.customer_code) t
				group by t.g
			""";
			try {
				conn = DBConnection.getConn();
				stmt = conn.prepareStatement(sql);
				rs = stmt.executeQuery();
				while(rs.next()) {
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("gender", rs.getString("gender"));
					map.put("total", rs.getInt("total"));
					list.add(map);
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(rs != null) rs.close();
					if(stmt != null) stmt.close();
					if(conn != null) conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return list;
		}
	
	// 상품별 리뷰평균 : 막대 차트
	public List<Map<String, Object>> selectReviewAvgByGoods() {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
					select o.goods_code goodsCode, avg(r.score) avg
					from orders o inner join review r
					on o.order_code = r.order_code
					group by o.goods_code
					order by avg(r.score) desc
					offset 0 rows fetch next 10 rows only
				""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("goodsCode", rs.getString("goodsCode"));
				map.put("avg", rs.getDouble("avg"));
				list.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 상품별 주문금액 : 막대 차트
	public List<Map<String, Object>> selectOrderPriceByGoods() {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
					select goods_code goodsCode, sum(order_price) total
					from orders
					group by goods_code
					order by sum(order_price) desc
					offset 0 rows fetch next 10 rows only
				""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("goodsCode", rs.getString("goodsCode"));
				map.put("total", rs.getInt("total"));
				list.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 상품별 주문횟수 : 막대 차트
	public List<Map<String, Object>> selectOrderCntByGoods() {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
					select goods_code goodsCode, count(*) cnt
					from orders
					group by goods_code
					order by count(*) desc
					offset 0 rows fetch next 10 rows only
				""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("goodsCode", rs.getString("goodsCode"));
				map.put("cnt", rs.getInt("cnt"));
				list.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 고객별 주문금액 : 막대 차트
	public List<Map<String, Object>> selectOrderPriceByCustomer() {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
					select customer_code customerCode, sum(order_price) total
					from orders
					group by customer_code
					order by sum(order_price) desc
					offset 0 rows fetch next 10 rows only
				""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("customerCode", rs.getString("customerCode"));
				map.put("total", rs.getInt("total"));
				list.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 고객별 주문횟수 : 막대 차트
	public List<Map<String, Object>> selectOrderCntByCustomer() {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
					select customer_code customerCode, count(*) cnt
					from orders 
					group by customer_code
					order by count(*) desc
					offset 0 rows fetch next 10 rows only
				""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("customerCode", rs.getString("customerCode"));
				map.put("cnt", rs.getInt("cnt"));
				list.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 월별 주문금액 : 막대 차트
	public List<Map<String, Object>> selectOrderPriceByYM(String fromYM, String toYM) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
					select to_char(createdate, 'YYYY-MM') ym, sum(order_price) total
					from orders
					where createdate between to_date(?, 'YYYY-MM-DD') 
					                        and to_date(?, 'YYYY-MM-DD')
					group by to_char(createdate, 'YYYY-MM')
					order by to_char(createdate, 'YYYY-MM') asc
				""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, fromYM);
			stmt.setString(2, toYM);
			rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("ym", rs.getString("ym"));
				map.put("total", rs.getInt("total"));
				list.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 월별 주문수량 : 막대 차트
	public List<Map<String, Object>> selectOrderCntByYM(String fromYM, String toYM) {
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
			select to_char(createdate, 'YYYY-MM') ym, count(*) cnt
			from orders
			where createdate between to_date(?, 'YYYY-MM-DD') 
			                     and to_date(?, 'YYYY-MM-DD')
			group by to_char(createdate, 'YYYY-MM')  
			order by to_char(createdate, 'YYYY-MM') asc                      
		""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, fromYM);
			stmt.setString(2, toYM);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("ym", rs.getString("ym"));
				map.put("cnt", rs.getInt("cnt"));
				list.add(map);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 월별 주문횟수(누적) : 선
	public List<Map<String, Object>> selectOrderTotalCntByYM(String fromYM, String toYM) {
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
			select  t.ym ym
					, sum(t.cnt) over(order by t.ym asc) totalOrder
			from 
				  (select to_char(createdate, 'YYYY-MM') ym, count(*) cnt
				  from orders
				  where createdate between to_date(?, 'YYYY-MM-DD') 
                  and to_date(?, 'YYYY-MM-DD')
				  group by to_char(createdate, 'YYYY-MM')) t	
		""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, fromYM);
			stmt.setString(2, toYM);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("ym", rs.getString("ym"));
				map.put("totalOrder", rs.getString("totalOrder"));
				list.add(map);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 월별 주문금액(누적) : 선
	public List<Map<String, Object>> selectOrderTotalPriceByYM(String fromYM, String toYM) {
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
				select  t.ym ym
						, sum(t.total) over(order by t.ym asc) totalPrice
				from 
				    (select to_char(createdate, 'YYYY-MM') ym, sum(order_price) total
				    from orders
				    where createdate between to_date(?, 'YYYY-MM-DD') 
                    and to_date(?, 'YYYY-MM-DD')
				    group by to_char(createdate, 'YYYY-MM')) t
		""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, fromYM);
			stmt.setString(2, toYM);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("ym", rs.getString("ym"));
				map.put("totalPrice", rs.getString("totalPrice"));
				list.add(map);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
}
