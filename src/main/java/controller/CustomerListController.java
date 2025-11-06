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
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		int rowPerPage = 10;
		int startRow = (currentPage - 1) * rowPerPage;
		int lastPage = 0; int totalRow = 0;
		
		this.customerDao = new CustomerDao();
		List<Customer> customerList = null;
		try {
			customerList = customerDao.selectCustomerList(startRow, rowPerPage);
			totalRow = customerDao.selectCustomerCount();
			lastPage = totalRow / rowPerPage;
			if(totalRow % rowPerPage != 0) {
				lastPage += 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("lastPage", lastPage);
		request.setAttribute("customerList", customerList);
		request.getRequestDispatcher("/WEB-INF/view/customer/customerList.jsp").forward(request, response);
 	}
}
