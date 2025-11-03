package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.CustomerDao;
import dto.Customer;


@WebServlet("/out/addMember")
public class addMemberController extends HttpServlet {
	//폼
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//addMember.jsp
		request.getRequestDispatcher("/WEB-INF/view/out/addMember.jsp").forward(request, response);
	}

	//액션
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// CustomerDao.insertCustomer(Customer)
		String id = request.getParameter("id");
	    String pw = request.getParameter("pw");
	    String name = request.getParameter("name");
	    String phone = request.getParameter("phone");
	    
	    Customer c = new Customer();
	    c.setCustomerId(id);
	    c.setCustomerPw(pw);
	    c.setCustomerName(name);
	    c.setCustomerPhone(phone);
	    c.setPoint(0);
		
	    try {
	        new CustomerDao().insertCustomer(c); // DB에 저장
	        response.sendRedirect(request.getContextPath()+"/out/login"); // 로그인 페이지 이동
	    } catch(Exception e) {
	        e.printStackTrace();
	        response.sendRedirect(request.getContextPath()+"/out/addMember"); // 실패 시 회원가입 페이지
	    }
	}

}
