package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.NoticeDao;
import dto.Notice;


@WebServlet("/emp/noticeOne")
public class NoticeOneController extends HttpServlet {
	private NoticeDao noticeDao;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String noticeCodeStr = request.getParameter("noticeCode");
		if (noticeCodeStr == null || noticeCodeStr.isEmpty()) {
		    // noticeCode가 없으면 목록 페이지로 이동시키거나 오류 처리
		    response.sendRedirect(request.getContextPath() + "/emp/noticeList");
		    return;
		}

		int noticeCode = Integer.parseInt(noticeCodeStr);
		
		noticeDao = new NoticeDao();
		Notice notice = noticeDao.selectNoticeOne(noticeCode);
		if (notice == null) {
		    response.sendRedirect(request.getContextPath() + "/emp/noticeList");
		    return;
		}
		
		request.setAttribute("notice", notice);
		
		request.getRequestDispatcher("/WEB-INF/view/emp/noticeOne.jsp").forward(request, response);
	}

}
