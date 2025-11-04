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

        request.setAttribute("id", id);
        
        CustomerDao customerDao = new CustomerDao();
        EmpDao empDao = new EmpDao();
        
        Customer customer = null;
        Emp emp = null;

        // 1. 고객/직원 계정 정보 조회 시도
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

        String errorMsg = null;
        boolean loginSuccess = false;

        // 2. 로그인 실패 및 계정 유형 검사
        
        // (A) ID나 비밀번호가 틀린 경우 (어떤 계정으로도 로그인 실패)
        if (customer == null && emp == null) {
            errorMsg = "아이디나 비밀번호가 틀렸습니다."; 
        } 
        // (B) ID/PW는 맞으나 계정 유형 선택이 잘못된 경우
        else {
            if ("customer".equals(customerOrEmpSel)) {
                if (customer != null && emp == null) {
                    // 고객 계정으로 로그인 성공
                    session.setAttribute("loginCustomer", customer);
                    loginSuccess = true;
                } else if (customer == null && emp != null) {
                    // 직원 계정이 고객(customer)선택
                    errorMsg = "고객 계정이 아닙니다."; 
                }

            } else if ("emp".equals(customerOrEmpSel)) {
                if (emp != null && customer == null) {
                    // 직원 계정으로 로그인 성공
                    session.setAttribute("loginEmp", emp);
                    loginSuccess = true;
                } else if (emp == null && customer != null) {
                    // 고객 계정이 직원(emp)선택
                    errorMsg = "직원 계정이 아닙니다."; 
                }
            }
        }
        
        // (C) 로그인 성공/실패에 따른 처리
        if (loginSuccess) {
            if ("customer".equals(customerOrEmpSel)) {
                response.sendRedirect(request.getContextPath() + "/customer/customerIndex");
            } else if ("emp".equals(customerOrEmpSel)) {
                response.sendRedirect(request.getContextPath() + "/emp/empIndex");
            }
            return;
        } 
        
        request.setAttribute("errorMsg", errorMsg); 
        request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response);
    }
}
