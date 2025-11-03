package listener;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class DBDriverLodadContextListener implements ServletContextListener {

    public void contextInitialized(ServletContextEvent sce)  { 
         try {
        	 Class.forName("oracle.jdbc.driver.OracleDriver");
        	 System.out.println("오라클 DB Driver Load 성공");
         }catch (ClassNotFoundException e) {
        	 System.out.println("오라클 DB Driver Load 성공");
        	 e.printStackTrace();
         }
    }

	
}
