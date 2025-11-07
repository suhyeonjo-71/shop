package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.CustomerDao;
import dao.NoticeDao;
import dto.Notice;


@WebServlet("/emp/addNotice")
public class AddNoticeController extends HttpServlet {
	private NoticeDao noticeDao;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/view/emp/addNotice.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String empCodeParam = request.getParameter("empCode");
		
		int empCode = 0;
		if (empCodeParam != null && !empCodeParam.equals("")) {
		    empCode = Integer.parseInt(empCodeParam);
		}
		System.out.println("title=" + title);
		System.out.println("content=" + content);
		System.out.println("empCode=" + empCode);
		Notice n = new Notice();
		n.setNoticeTitle(title);
		n.setNoticeContent(content);
		n.setEmpCode(empCode);
		
		noticeDao = new NoticeDao();
		try {
			noticeDao.insertNotice(n);
			response.sendRedirect(request.getContextPath()+"/emp/noticeList");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath()+"/emp/addNotice");
		}
	}
}
