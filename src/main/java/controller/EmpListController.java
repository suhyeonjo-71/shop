package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.EmpDao;
import dto.Emp;


@WebServlet("/emp/empList")
public class EmpListController extends HttpServlet {
	private EmpDao empDao;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		int rowPerPage = 10;
		int startRow = (currentPage - 1) * rowPerPage;

		
		this.empDao = new EmpDao();
		List<Emp> empList = null;
		int totalRow = 0;;
		try {
			empList = empDao.selectEmpListByPage(startRow, rowPerPage);
			totalRow = empDao.selectEmpCount();
		} catch (Exception e) {
			e.printStackTrace();
		}
		int lastPage = (totalRow % rowPerPage == 0) ? (totalRow/rowPerPage) : (totalRow/rowPerPage)+1;

		int startPage = ((currentPage-1) / 10 * 10) + 1;
		int endPage = startPage + 9;
		if(lastPage < endPage) endPage = lastPage;
		
		//모델 속성
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("lastPage", lastPage);
		request.setAttribute("empList", empList);
		
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		
		request.getRequestDispatcher("/WEB-INF/view/emp/empList.jsp").forward(request, response);
	
	}


}
