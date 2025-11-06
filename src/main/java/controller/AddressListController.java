package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import dao.AddressDao;
import dto.Address;
import dto.Customer;


@WebServlet("/customer/addressList")
public class AddressListController extends HttpServlet {
	private AddressDao addressDao;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        Customer loginCustomer = (Customer) session.getAttribute("loginCustomer");
		
		if (loginCustomer == null) { // 로그인 안 된 상태면
	        response.sendRedirect(request.getContextPath() + "/out/login");
	        return;
	    }
		int customerCode = loginCustomer.getCustomerCode();
		
		this.addressDao = new AddressDao();
		List<Address> addressList = null;
		try {
			addressList = addressDao.selectAddressList(customerCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		request.setAttribute("addressList", addressList);
		request.getRequestDispatcher("/WEB-INF/view/customer/addressList.jsp").forward(request, response);
		
		
	}

}
