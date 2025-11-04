package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.EmpDao;
import dto.Emp;


@WebServlet("/emp/modifyEmpActive")
public class modifyEmpActiveController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int empCode = Integer.parseInt(request.getParameter("empCode"));
		int currentActive = Integer.parseInt(request.getParameter("currentActive"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));

		int newActive = (currentActive == 1) ? 0 : 1;
		
		Emp emp = new Emp();
		emp.setActive(newActive);
		emp.setEmpCode(empCode);
		
		EmpDao empDao = new EmpDao();
		try {
			empDao.updateEmpActive(emp);
			response.sendRedirect(request.getContextPath()+"/emp/empList?currentPage=" + currentPage);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
