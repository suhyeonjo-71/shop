package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import dao.CustomerDao;
import dto.Customer;


@WebServlet("/customer/customerList")
public class CustomerListController extends HttpServlet {
	private CustomerDao customerDao;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//request
		int currentPage = 1;
		int startRow = 0;
		int rowPerPage = 10;
		
		//CustomerDao customerDao = new CustomerDao();
		this.customerDao = new CustomerDao();
		List<Customer> customerList = null;
		try {
			customerList = customerDao.selectCustomerList(startRow, rowPerPage);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		request.getRequestDispatcher("/WEB-INF/view/customer/customerList.jsp").forward(request, response);
 	}


}
