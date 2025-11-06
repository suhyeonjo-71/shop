package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.CustomerDao;
import dto.Outid;


@WebServlet("/customer/removeCustomerByEmp")
public class RemoveCustomerByEmpController extends HttpServlet {
	CustomerDao customerDao = null;
	
	//강제탈퇴 화면
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String customerId = request.getParameter("customerId"); 
	    request.setAttribute("customerId", customerId);
		request.getRequestDispatcher("/WEB-INF/view/customer/removeCustomerByEmp.jsp").forward(request, response);
			
	}
	
	//강제탈퇴 액션
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("customerId");
		String memo = request.getParameter("memo");
		
		Outid oi = new Outid();
		oi.setId(id);
		oi.setMemo(memo);
		
		try {
		    customerDao = new CustomerDao();
		    customerDao.deleteCustomerByEmp(oi);
		    response.sendRedirect(request.getContextPath() + "/customer/customerList");
		    return;
		} catch (Exception e) {
		    e.printStackTrace();
		    request.setAttribute("errorMsg", "삭제 중 오류가 발생했습니다.");
		    request.setAttribute("customerId", id);
		    request.getRequestDispatcher("/WEB-INF/view/customer/removeCustomerByEmp.jsp").forward(request, response);
		}
	}

}
