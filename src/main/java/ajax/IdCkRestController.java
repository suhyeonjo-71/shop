package ajax;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.google.gson.Gson;

import dao.CustomerDao;


@WebServlet("/IdCk")
public class IdCkRestController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		
		String id = request.getParameter("id");
		String resultId = null;
		
		boolean isDuplicate = false;
		
		try {
			CustomerDao customerDao = new CustomerDao();
			resultId = customerDao.selectCustomerIdCheck(id);
			
			if(resultId != null) {
				isDuplicate = true; //null이 아니면 중복
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//out타입은 json문자열(gson라이브러리 사용)
		Gson gson = new Gson();
		String jsonResponse = gson.toJson(isDuplicate);
		
		response.getWriter().print(jsonResponse);
	}


}
