import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet(name = "RecordServlet", urlPatterns = {"/record"})
public class RecordServlet extends HttpServlet {

    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try{
        String fname=req.getParameter("fname");
        String lname=req.getParameter("lname");
        String age=req.getParameter("age");
        String dob=req.getParameter("dob");
        String gender=req.getParameter("gender");
        String phone=req.getParameter("phone");
        String details=req.getParameter("details");
        Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","Saksham","9027904442");
    PreparedStatement pst=con.prepareStatement("insert into patient_details values(?,?,?,?,?,?,?)");
        pst.setString(1,fname);
        pst.setString(2,lname);
        pst.setString(3,age);
        pst.setString(4,dob);
        pst.setString(5,gender);
        pst.setString(6,phone);
        pst.setString(7,details);
        pst.executeUpdate();
        pst.close();
        con.close();
        }
        catch(Exception e)
        {}
    }
    
}
