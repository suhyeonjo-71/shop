package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dto.Goods;
import dto.GoodsImg;

public class GoodsDao {
	// customer/goodsOne 상품리스트 > 상품상세보기
	public Map<String, Object> selectGoodsOne(int goodsCode) {
		Map<String, Object> m = new HashMap<String, Object>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = """
				select 
					gi.filename filename
					, g.goods_code goodsCode
					, g.goods_name goodsName
					, g.goods_price goodsPrice
					, nvl(g.soldout, ' ') soldout
					, g.point_rate pointRate
				from goods g inner join goods_img gi
				on g.goods_code = gi.goods_code
				where g.goods_code=?
			""";
		
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsCode);
			rs = stmt.executeQuery();
			while(rs.next()) {
				m.put("filename", rs.getString("filename"));
				m.put("goodsCode", rs.getInt("goodsCode"));
				m.put("goodsName", rs.getString("goodsName"));
				m.put("goodsPrice", rs.getInt("goodsPrice"));
				m.put("soldout", rs.getString("soldout"));
				m.put("pointRate", rs.getDouble("pointRate"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return m;
	}
	
	// customer 로그인 시 상품 리스트
	public List<Map<String, Object>> selectBestGoodsList() {
		List<Map<String, Object>> goodsList = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = """
				select 
			        gi.filename filename
			        , g.goods_code goodsCode
			        , g.goods_name goodsName
			        , g.goods_price goodsPrice
				from
				goods g inner join goods_img gi
				on g.goods_code = gi.goods_code
				    inner join(select goods_code, count(*) from orders
				                        group by goods_code
				                        order by count(*) desc
				                        offset 0 rows fetch next 5 rows only) t
				    on g.goods_code = t.goods_code
				""";
		
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> m = new HashMap<String, Object>();
				m.put("filename", rs.getString("filename"));
				m.put("goodsCode", rs.getString("goodsCode"));
				m.put("goodsName", rs.getString("goodsName"));
				m.put("goodsPrice", rs.getInt("goodsPrice"));
				goodsList.add(m);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		return goodsList;
	}
	
	// rowPerPage : goodsList(10개), customerIndex(20개)
	public List<Map<String, Object>> selectGoodsList(int startRow, int rowPerPage) throws Exception {
		List<Map<String, Object>> goodsList = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = """
				select 
					gi.filename filename
					, g.goods_code goodsCode
					, g.goods_name goodsName
					, g.goods_price goodsPrice
				from goods g inner join goods_img gi
				on g.goods_code = gi.goods_code
				where g.soldout is null
				order by g.goods_code desc
				offset ? rows fetch next ? rows only
		""";
		
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> m = new HashMap<String, Object>();
				m.put("filename", rs.getString("filename"));
				m.put("goodsCode", rs.getString("goodsCode"));
				m.put("goodsName", rs.getString("goodsName"));
				m.put("goodsPrice", rs.getString("goodsPrice"));
				goodsList.add(m);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return goodsList;
	}
	
	// emp 로그인 시 상품 리스트
		public List<Goods> selectGoodsListByEmp(int startRow, int rowPerPage) throws Exception {
			List<Goods> goodsList = new ArrayList<>();
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			String sql = """
						select goods_code goodsCode, goods_name goodsName, goods_price goodsPrice,
						       soldout, emp_code empCode, point_rate pointRate, createdate
						from goods
						order by goods_code
						offset ? rows fetch next ? rows only
				""";
			
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Goods g = new Goods();
				g.setGoodsCode(rs.getInt("goodsCode"));
				g.setGoodsName(rs.getString("goodsName"));
				g.setGoodsPrice(rs.getInt("goodsPrice"));
				g.setSoldout(rs.getString("soldout"));
				g.setEmpCode(rs.getInt("empCode"));
				g.setPointRate(rs.getInt("pointRate"));
				g.setCreatedate(rs.getString("createdate"));
				goodsList.add(g);
			}
			
			rs.close();
		    stmt.close();
		    conn.close();
			return goodsList;
		}
	
	public int selectGoodsCount() throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "select count(*) from goods";
		
		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		int count = 0;
		if(rs.next()) {
			count = rs.getInt(1);
		}
		rs.close();
		stmt.close();
		conn.close();
		return count;
	}
	
	// 상품등록 + 이미지 등록
	// 반환값은 실패시 false
	public boolean insertGoodsAndImg(Goods goods, GoodsImg goodsImg) throws Exception {
		boolean result = false;
		Connection conn = null;
		PreparedStatement stmtSeq = null; // select
		PreparedStatement stmtGoods = null; // insert
		PreparedStatement stmtImg = null; // insert
		ResultSet rs = null;
		
		String sqlSeq = """
			select seq_goods.nextval from dual
		""";
		
		String sqlGoods = """
			insert into goods(goods_code, goods_name, goods_price, emp_code, point_rate, soldout, createdate)
			values(?, ?, ?, ?, ?, null, sysdate)	
		""";
		
		String sqlImg = """
			insert into goods_img(goods_code, filename, origin_name, content_type, filesize, createdate)
			values(?, ?, ?, ?, ?, sysdate)
		""";
		
		try {
			conn = DBConnection.getConn();
			conn.setAutoCommit(false); // 단일 트랜잭션안에서 시퀀스 생성 -> 상품입력 -> 이미지입력
			
			// 1) seq_goods.nextval값을 먼저 생성 후 사용
			stmtSeq = conn.prepareStatement(sqlSeq);
			rs = stmtSeq.executeQuery();
			rs.next();
			int goodsCode = rs.getInt(1);
			
			// 2) goods 입력
			stmtGoods = conn.prepareStatement(sqlGoods);
			stmtGoods.setInt(1, goodsCode);
			stmtGoods.setString(2, goods.getGoodsName());
			stmtGoods.setInt(3, goods.getGoodsPrice());
			stmtGoods.setInt(4, goods.getEmpCode());
			stmtGoods.setDouble(5, goods.getPointRate());
			int row1 = stmtGoods.executeUpdate();
			// 상품입력에 실패하면
			if(row1 != 1) {
				conn.rollback(); 
				return result;
			}
			// 3) // 상품입력에 성공하면 img 입력
			stmtImg = conn.prepareStatement(sqlImg);
			stmtImg.setInt(1, goodsCode);
			stmtImg.setString(2, goodsImg.getFilename());
			stmtImg.setString(3, goodsImg.getOriginName());
			stmtImg.setString(4, goodsImg.getContentType());
			stmtImg.setLong(5, goodsImg.getFilesize());
			int row2 = stmtImg.executeUpdate();
			if(row2 != 1) {
				conn.rollback(); 
				return result;
				// throw new SQLException();
			}
			result = true; // 상품 & 이미지 입력성공
			conn.commit();
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
}