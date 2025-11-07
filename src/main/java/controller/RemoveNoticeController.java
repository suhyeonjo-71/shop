package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.NoticeDao;
import dto.Notice;


@WebServlet("/emp/removeNotice")
public class RemoveNoticeController extends HttpServlet {
	private NoticeDao noticeDao;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String noticeCodeStr = request.getParameter("noticeCode");

	    if (noticeCodeStr == null || noticeCodeStr.isEmpty()) {
	        // noticeCode 없으면 목록 페이지로 이동
	        response.sendRedirect(request.getContextPath() + "/emp/noticeList");
	        return;
	    }

	    int noticeCode = Integer.parseInt(noticeCodeStr);
		
		Notice n = new Notice();
		n.setNoticeCode(noticeCode);
		
		noticeDao = new NoticeDao();
		try {
			noticeDao.deleteNotice(n);
			response.sendRedirect(request.getContextPath()+"/emp/noticeList");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath()+"/emp/noticeOne");
		}
	}

}
