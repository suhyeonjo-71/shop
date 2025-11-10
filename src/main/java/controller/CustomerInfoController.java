package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.CustomerDao;
import dto.Customer;


@WebServlet("/customer/customerInfo")
public class CustomerInfoController extends HttpServlet {
	private CustomerDao customerDao;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Customer loginCustomer = (Customer) request.getSession().getAttribute("loginCustomer");
		if(loginCustomer == null) {
			response.sendRedirect(request.getContextPath()+"/out/login");
			return;
		}
		
		customerDao = new CustomerDao();
		try {
			Customer customer = customerDao.selectCustomerCode(loginCustomer.getCustomerCode());
			request.setAttribute("customer", customer);
			request.getRequestDispatcher("/WEB-INF/view/customer/customerInfo.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
