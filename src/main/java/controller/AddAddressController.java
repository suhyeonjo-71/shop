package controller;

import java.io.IOException;

import dao.AddressDao;
import dto.Address;
import dto.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/customer/addAddress")
public class AddAddressController extends HttpServlet {
	private AddressDao addressDao;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/view/customer/addAddress.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Customer loginCustomer = (Customer) session.getAttribute("loginCustomer");
		
		if (loginCustomer == null) {
			response.sendRedirect(request.getContextPath() + "/out/login");
			return;
		}
		int customerCode = loginCustomer.getCustomerCode();
		
		String[] addressArr = request.getParameterValues("address");
		String addressStr = String.join(" ", addressArr);
		System.out.println("address: " + addressStr);
		
		Address address = new Address();
		address.setCustomerCode(customerCode);
		address.setAddress(addressStr);
		
		this.addressDao = new AddressDao();
		try {
			addressDao.insertAddress(address);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		response.sendRedirect(request.getContextPath()+"/customer/addressList");
	}

}