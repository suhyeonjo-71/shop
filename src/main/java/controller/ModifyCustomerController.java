package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.CustomerDao;
import dto.Customer;


@WebServlet("/customer/modifyCustomer")
public class ModifyCustomerController extends HttpServlet {
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
			request.getRequestDispatcher("/WEB-INF/view/customer/modifyCustomer.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Customer loginCustomer = (Customer) request.getSession().getAttribute("loginCustomer");
		if(loginCustomer == null) {
			response.sendRedirect(request.getContextPath()+"/out/login");
			return;
		}
		
		String customerPw = request.getParameter("customerPw");
		String customerPhone = request.getParameter("customerPhone");
		
		Customer c = new Customer();
		c.setCustomerCode(loginCustomer.getCustomerCode());
		c.setCustomerPw(customerPw);
		c.setCustomerPhone(customerPhone);
		
		try {
			int row = customerDao.updateCustomer(c);
			if(row == 1) {
				response.sendRedirect(request.getContextPath()+"/customer/customerInfo");
			} else {
				response.sendRedirect(request.getContextPath()+"/customer/modifyCustomer");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
