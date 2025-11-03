package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import java.io.IOException;

/**
 * Servlet Filter implementation class CustomerFilter
 */
@WebFilter("/CustomerFilter")
public class CustomerFilter extends HttpFilter implements Filter {

    public CustomerFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	
}
