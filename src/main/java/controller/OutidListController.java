package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import dao.CustomerDao;
import dto.Outid;


@WebServlet("/customer/outidList")
public class OutidListController extends HttpServlet {
    private CustomerDao customerDao = null;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int currentPage = 1;
        if (request.getParameter("currentPage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        }

        int rowPerPage = 10;
        int startRow = (currentPage - 1) * rowPerPage;
        String memo = request.getParameter("memo");
        if (memo == null || memo.trim().equals("")) {
            memo = null; 
        }
        
        customerDao = new CustomerDao();
		List<Outid> outidList = null;
        try {
        	outidList = customerDao.selectOutidList(memo, startRow, rowPerPage);
            int totalRow = customerDao.selectOutidCount(memo);
            int lastPage = totalRow / rowPerPage;
            if(totalRow % rowPerPage != 0) {
				lastPage += 1;
			}

            request.setAttribute("outidList", outidList);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("lastPage", lastPage);
            request.setAttribute("memo", memo);

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/WEB-INF/view/customer/outidList.jsp").forward(request, response);
    }
}


