package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.CustomerDao;
import dto.Outid;


@WebServlet("/customer/removeCustomer")
public class RemoveCustomerController extends HttpServlet {
	CustomerDao customerDao = null;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("customerId");
		
		Outid oi = new Outid();
		oi.setId(id);
		
		customerDao = new CustomerDao();
		try {
			customerDao.deleteCustomer(id);
			// 세션 초기화
			request.getSession().invalidate();
			response.sendRedirect(request.getContextPath() + "/out/login");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
