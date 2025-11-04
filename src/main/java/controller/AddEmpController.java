package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.EmpDao;
import dto.Emp;


@WebServlet("/emp/addEmp")
public class AddEmpController extends HttpServlet {
	//폼
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//addEmp.jsp
		request.getRequestDispatcher("/WEB-INF/view/emp/addEmp.jsp").forward(request, response);
	}

	//액션
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String active = request.getParameter("active");
		
		Emp emp = new Emp();
		emp.setEmpId(id);
		emp.setEmpPw(pw);
		emp.setEmpName(name);
		int activeVal = 0;
		if(active != null) {
			activeVal = Integer.parseInt(active);
		}
		emp.setActive(activeVal);
		
		EmpDao empDao = new EmpDao();
		try {
			empDao.insertEmp(emp);
			response.sendRedirect(request.getContextPath()+"/emp/empList");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath()+"/emp/addEmp");
		}
	}

}
