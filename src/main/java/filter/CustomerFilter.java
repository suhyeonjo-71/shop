package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import java.io.IOException;


@WebFilter("/customer/*")
public class CustomerFilter extends HttpFilter implements Filter {
	
	@Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
    	HttpServletRequest req = (HttpServletRequest)request;
    	HttpServletResponse res = (HttpServletResponse) response;
    	HttpSession session = req.getSession();
    	
//		if(session.getAttribute("loginCustomer") == null) {
//			res.sendRedirect(req.getContextPath()+"/out/login");
//			return;
//    	}
			
    	System.out.println(req.getRequestURI() + "<--------- CustomerFilter 선행필터 작동");
    	chain.doFilter(request, response);
    }
}
