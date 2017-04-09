<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
    String srch1=request.getParameter("srch");
    String srch=srch1.toLowerCase();
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","Saksham","9027904442");
    PreparedStatement pst=con.prepareStatement("select * from patient_details where lower(fname) like ? or lower(lname) like ? ");
    pst.setString(1,"%"+srch+"%");
    pst.setString(2, "%"+srch+"%");
    ResultSet rs=pst.executeQuery();
    while(rs.next()){
    %>
     <div class="patient">
            <div>Patient name: <%=rs.getString(1)+" "+rs.getString(2)%></div>
            <div>Patient number: <%=rs.getString(6)%></div>
        </div>
    <%
    }    
%>