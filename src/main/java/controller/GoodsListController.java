package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import dao.GoodsDao;
import dto.Goods;


@WebServlet("/emp/goodsList")
public class GoodsListController extends HttpServlet {
	private GoodsDao goodsDao;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		int rowPerPage = 10;
		int startRow = (currentPage - 1) * rowPerPage;
		int lastPage = 0;
		int totalRow = 0;
		
		this.goodsDao = new GoodsDao();
		List<Goods> goodsList = null;
		try {
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("/WEB-INF/view/emp/goodsList.jsp").forward(request, response);
	}

}
