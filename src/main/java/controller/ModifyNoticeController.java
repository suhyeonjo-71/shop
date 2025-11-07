package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.NoticeDao;
import dto.Notice;

@WebServlet("/emp/modifyNotice")
public class ModifyNoticeController extends HttpServlet {
	private NoticeDao noticeDao;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String noticeCodeStr = request.getParameter("noticeCode");

		if (noticeCodeStr == null || noticeCodeStr.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/emp/noticeList");
			return;
		}

		int noticeCode = Integer.parseInt(noticeCodeStr);

		noticeDao = new NoticeDao();
		Notice notice = noticeDao.selectNoticeOne(noticeCode);

		request.setAttribute("notice", notice);
		request.getRequestDispatcher("/WEB-INF/view/emp/modifyNotice.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String noticeTitle = request.getParameter("noticeTitle");
		String noticeContent = request.getParameter("noticeContent");
		String noticeCodeStr = request.getParameter("noticeCode");

		if (noticeCodeStr == null || noticeCodeStr.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/emp/noticeList");
			return;
		}

		int noticeCode = Integer.parseInt(noticeCodeStr);

		Notice notice = new Notice();
		notice.setNoticeCode(noticeCode);
		notice.setNoticeTitle(noticeTitle);
		notice.setNoticeContent(noticeContent);

		noticeDao = new NoticeDao();
		int row = noticeDao.updateNotice(notice);

		if (row == 1) {
			// 수정 성공 시 상세페이지로 이동
			response.sendRedirect(request.getContextPath() + "/emp/noticeOne?noticeCode=" + noticeCode);
		} else {
			// 실패 시 다시 수정 페이지로
			response.sendRedirect(request.getContextPath() + "/emp/modifyNotice?noticeCode=" + noticeCode);
		}
	}
}
