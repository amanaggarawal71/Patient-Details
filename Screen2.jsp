<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","Saksham","9027904442");
    PreparedStatement pst=con.prepareStatement("select * from patient_details");
    ResultSet rs=pst.executeQuery();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            table{
                margin:0px auto;
            }
            .patient{
                text-align:center;
                border:2px solid black;
                margin-top:20px;
            }
        </style>
        <script src="jquery-latest.js"></script>
        <script>
            $(document).ready(function(){
        $("#btn").click(function(){
             $.post('Search.jsp?srch='+$("#patient-name").val(),
             function(result){
                $("#result").html(result); 
             });
     });
    });
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Patient Directory</title>
    </head>
    <body>
        <table>
            <tr>
                <td>Search Directory:</td>
                <td><input type="text" name="txt1" size="60" id="patient-name"></td>
                <td><input type="button" value="Serach" name="btn" id="btn"></td>
            </tr>
        </table>
        <hr width="100%" size="4" color="#777"/>
        <div id="result">
        <%
            while(rs.next()){
        %>
        <div class="patient">
            <div>Patient name: <%=rs.getString(1)+" "+rs.getString(2)%></div>
            <div>Patient number: <%=rs.getString(6)%></div>
        </div>
        <%
    }        
        %>
        </div>
    </body>
</html>
