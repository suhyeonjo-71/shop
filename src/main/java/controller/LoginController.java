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
	//form
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response);
	}
	
	//action
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
        String pw = request.getParameter("pw");
		String customerOrEmpSel = request.getParameter("customerOrEmpSel");
		
		HttpSession session = request.getSession();
		
		try {
            if (customerOrEmpSel.equals("customer")) {
                Customer c = new Customer();
                c.setCustomerId(id);
                c.setCustomerPw(pw);
                Customer loginCustomer = new CustomerDao().selectCustomerByLogin(c);
                if (loginCustomer != null) session.setAttribute("loginCustomer", loginCustomer);
                response.sendRedirect(request.getContextPath() + "/customer/customerIndex");

            } else if (customerOrEmpSel.equals("emp")) {
                Emp e = new Emp();
                e.setEmpId(id);
                e.setEmpPw(pw);
                Emp loginEmp = new EmpDao().selectEmpByLogin(e);
                if (loginEmp != null) session.setAttribute("loginEmp", loginEmp);
                response.sendRedirect(request.getContextPath() + "/emp/empIndex");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/out/login");
        }
	}

}
