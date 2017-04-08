<%@page import="java.net.InetAddress"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String srch1=request.getParameter("srch");
    String srch=srch1.toLowerCase();
    InitialContext ctx=new InitialContext();
    DataSource ds=(DataSource)ctx.lookup("jdbc/my");
    Connection con=ds.getConnection();
    PreparedStatement pst=con.prepareStatement("select * from imagefile where lower(filename) like ? or lower(category) like ? ");
    pst.setString(1,"%"+srch+"%");
    pst.setString(2, "%"+srch+"%");
    ResultSet rs=pst.executeQuery();
    %>
<html>
    <head>
        <style>
            div #more{
                text-decoration:none;
                color: #428bca;
                cursor: pointer;
                transition:all 0.5s;
            }
            div #more:hover{
                text-decoration:underline;
                font-size: 24px;
                color:#f4511e;
            }
            .hidden{
                width:440px;
                height:70px;
                border:1px solid black;
                margin-top:5px;
                margin-left:5px;
                display:none;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Image</title>
        <script>
            function showandhide()
            {
                var div=document.getElementsByClassName('hidden');
                for(var i=0;i<div.length;i++){
                    div[i].style.display="block";
                }
                //document.getElementById('more').style.display='none';
                document.getElementById('more1').style.display='none';
                
                    
            }
        </script>
    </head>
    <body>
        <%
        int i=1;
        int count=1;
        InetAddress address=InetAddress.getLocalHost();
                String ip=address.getHostAddress();
        while(count<5&&rs.next()){
            count++;
            String filename=rs.getString(1);
            String category=rs.getString(3);
%>
      <div style="width:420px;height:70px;border:1px solid black;margin-top:5px;margin-left:5px;">
          <div>
              <img src="http://<%=ip%>:47719/GoogleImage/Image1.jsp?im=<%=i++ %>&srch=<%=srch%>" alt="Image Not Found"\ style="height:60px;width:60px;border:1px solid black;margin-top:3px;margin-left:3px;float:left;" />
             <span style="font-family: thaoma;font-size: 18px;font-weight:bold;margin-left:30px;display: inline-block;margin-top:8px;">Category: <%= category %></span><br/>
             <span style="font-family: thaoma;font-size: 18px;font-weight:bold;margin-left: 30px;display: inline-block;margin-top:8px;"> Name: <%= filename %></span>
          </div>
      </div>
      <% 
        }
        if(rs.next()){ %>
            <div style="font-family: consolas;font-size: 21px;font-weight: bold;text-align: right;" id="more1"><span id="more" onclick="showandhide()">View More&gt;&gt;</span></div>
      <%
      do{ 
         String filename=rs.getString(1);
            String category=rs.getString(3);
      %>
        <div class="hidden">
          <div>
              <img src="http://<%=ip%>:47719/GoogleImage/Image1.jsp?im=<%=i++ %>&srch=<%=srch%>" alt="Image Not Found"\ style="height:60px;width:60px;border:1px solid black;margin-top:3px;margin-left:3px;float:left;" />
             <span style="font-family: thaoma;font-size: 18px;font-weight:bold;margin-left:30px;display: inline-block;margin-top:8px;">Category: <%= category %></span><br/>
             <span style="font-family: thaoma;font-size: 18px;font-weight:bold;margin-left: 30px;display: inline-block;margin-top:8px;"> Name: <%= filename %></span>
          </div>
      </div>            
                <% 
      }while(rs.next());
                        }
     if(i==1)
   {out.println("No Result Found");}              
    rs.close();
     pst.close();
      con.close();
%>
    </body>
</html>