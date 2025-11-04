package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.CustomerDao;
import dao.EmpDao;
import dto.Customer;
import dto.Emp;

@WebServlet("/out/login")
public class LoginController extends HttpServlet {

    // 로그인 폼
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response);
    }

    // 로그인 처리
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        String customerOrEmpSel = request.getParameter("customerOrEmpSel"); // "customer" or "emp"

        HttpSession session = request.getSession();
        
        try {
        	CustomerDao customerDao = new CustomerDao();
			EmpDao empDao = new EmpDao();
			
        	Customer customer = null;
			Emp emp = null;

			try {
				Customer c = new Customer();
				c.setCustomerId(id);
				c.setCustomerPw(pw);
				customer = customerDao.selectCustomerByLogin(c);
			} catch (Exception e) {
				e.printStackTrace();
			}

			try {
				Emp e = new Emp();
				e.setEmpId(id);
				e.setEmpPw(pw);
				emp = empDao.selectEmpByLogin(e);
			} catch (Exception e) {
				e.printStackTrace();
			}

			// 이제 조건 체크
			if ("customer".equals(customerOrEmpSel)) {
				if (customer != null && emp == null) {
					session.setAttribute("loginCustomer", customer);
					response.sendRedirect(request.getContextPath() + "/customer/customerIndex");
				} else {
					request.setAttribute("errorMsg", "고객 계정으로만 로그인할 수 있습니다.");
					request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response);
				}

			} else if ("emp".equals(customerOrEmpSel)) {
				if (emp != null && customer == null) {
					session.setAttribute("loginEmp", emp);
					response.sendRedirect(request.getContextPath() + "/emp/empIndex");
				} else {
					request.setAttribute("errorMsg", "직원 계정으로만 로그인할 수 있습니다.");
					request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response);
				}

			} else {
				request.setAttribute("errorMsg", "로그인 유형을 선택하세요.");
				request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMsg", "로그인 처리 중 오류 발생");
			request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response);
		}
	}
}
