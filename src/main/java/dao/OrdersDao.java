package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class OrdersDao {
	public List<Map<String, Object>> selectOrdersList() throws Exception {
		List<Map<String, Object>> ordersList = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = """
				select o.order_code orderCode, o.goods_code goodsCode, o.customer_code customerCode
				, o.address_code addressCode, o.order_quantity orderQuantity
			        , o.order_state orderState, o.createdate
			        , g.goods_name goodsName, g.goods_price goodsPrice
			        , c.customer_name customerName, c.customer_phone customerPhone
			        , a.address addressm 
				from orders o inner join goods g
				on o.goods_code = g.goods_code
				    inner join customer c
				    on o.customer_code = c.customer_code
				        inner join address a
				        on o.address_code = a.address_code
				order by o.order_code desc;	
			""";
		
		return ordersList;
	}
}
