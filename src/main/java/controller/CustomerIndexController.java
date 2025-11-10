package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.GoodsDao;

@WebServlet("/customer/customerIndex")
public class CustomerIndexController extends HttpServlet {
	private GoodsDao goodsDao;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		int rowPerPage = 20;
		int startRow = (currentPage - 1) * rowPerPage;
		int lastPage = 0; int startPage = 0; int endPage = 0;
		
		goodsDao = new GoodsDao();
		try {
			request.setAttribute("goodsList", goodsDao.selectGoodsList(startRow, rowPerPage));
			int count = goodsDao.selectGoodsCount();
			lastPage = (count % rowPerPage == 0) ? (count / rowPerPage) : (count / rowPerPage) +1;
			
			startPage = ((currentPage - 1) / 10 * 10) + 1;
			endPage = startPage + 9;
			if(lastPage < endPage) 
				endPage = lastPage;
		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("currentPage", currentPage);
		request.setAttribute("lastPage", lastPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		int totalTd = 20;
		// 만약 페이지(처음 or 마지막)에 출력할 상품이 개면 totalTd = 10
		request.setAttribute("totalTd", totalTd); 
		
		request.setAttribute("bestGoodsList", goodsDao.selectBestGoodsList());
		
		request.getRequestDispatcher("/WEB-INF/view/customer/customerIndex.jsp").forward(request, response);
	}


}
