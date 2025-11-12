package controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import dao.OrdersDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/emp/ordersList")
public class OrdersListController extends HttpServlet {
	private OrdersDao ordersDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int currentPage = 1;
		int rowPerPage = 10;
		int startRow = (currentPage - 1) * rowPerPage;
		
		ordersDao = new OrdersDao();
		List<Map<String, Object>> list = null;
		int count = 0;
		try {
			list = ordersDao.selectOrdersList(startRow, rowPerPage);
			count = ordersDao.selectOrdersCount();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int lastPage = (count % rowPerPage == 0) ? (count/rowPerPage) : (count/rowPerPage)+1;
		
		int startPage = ((currentPage-1) /10 * 10) +1;
		int endPage = startPage + 9;
		if(lastPage < endPage) endPage = lastPage;
		
		request.setAttribute("list", list);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("lastPage", lastPage);
		
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		
		request.getRequestDispatcher("/WEB-INF/view/emp/orderList.jsp").forward(request, response);
		
	}

}