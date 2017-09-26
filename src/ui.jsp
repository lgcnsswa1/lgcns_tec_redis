<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.lgcns.tec.cache.redis.*" %>
<%@ page import="redis.clients.jedis.Jedis" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Dashboard Template for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="./css/dashboard.css" rel="stylesheet">
    


  </head>
  <body>
  	

  	
 <%
    String req_command = request.getParameter("command");
    
    if ( "shutdown".equals(req_command) == true ) {
        String serverip = request.getParameter("serverip");
        String serverport = request.getParameter("serverport");
    
        Jedis jedisInst = Redis.getInstance( serverip, Integer.parseInt( serverport ) );
        
        jedisInst.shutdown();
        
        jedisInst.close();
        Redis.releasePool();
        req_command = "";
        serverip = "";
        serverport= "";
        
    }
 %>

        <main class="col-sm-9 ml-sm-auto col-md-10 pt-3" role="main">
          <h4>Dashboard</h4>
       
<%
    	ArrayList<String> serverList = new ArrayList<String>();
    	
    	serverList.add("10.77.241.173:10001");
    	serverList.add("10.77.241.173:20001");
      serverList.add("10.77.241.173:30001");
    	
    	int serverCnt = serverList.size();
    	
    	String serverIPPort;
    	String[] serverInfo = new String[2];
    	
%>
       	
          <section class="row text-center placeholders">

<%
      String statinfo = "";
      String uptime = "";
      String process_id = "";
      

      
      for( int idx = 0; idx < serverCnt; idx ++ )
      {
           process_id = "";
           serverIPPort = (String)serverList.get( idx );
    		   serverInfo = serverIPPort.split(":");
    		   
    		   try {
    		       Jedis jedisInst = Redis.getInstance( serverInfo[0], Integer.parseInt( serverInfo[1] ) );
    		       statinfo = MonitorUtil.getInfoBySection( jedisInst, "stats");
    		       
    		       uptime = "Uptime : " + MonitorUtil.getInfoByParam( jedisInst, "uptime_in_seconds" ) + "(sec)" ;     		      
               process_id = MonitorUtil.getInfoByParam( jedisInst, "process_id" );
               
    		       if( jedisInst != null ) jedisInst.close();
               jedisInst = null;
               Redis.releasePool();
    		   } catch (Exception e) {   Redis.releasePool();  e.printStackTrace(); }
    		   
    		   if ( process_id != null && ! "".equals(process_id)) {
%>         

	            <div class="col-6 col-sm-3 placeholder">
	              <img src="data:image/gif;base64,R0lGODlhAQABAIABAAJ12AAAACwAAAAAAQABAAACAkQBADs=" width="100" height="100" class="img-fluid rounded-circle" alt="Generic placeholder thumbnail" data-toggle="popover" title="<% out.println(serverIPPort); %>" data-content="<% out.println( uptime ); %>" >
	              <h6><% out.println(serverInfo[0] + ":" + serverInfo[1]); %>(OK)</h6>
	              <div class="text-muted">[Process ID] <%= process_id %> </div>
	              <div class="text-muted">
	              	 <form action="/ui.jsp" method="GET">
	              	 	  <input type="hidden" name="command" value="shutdown">
	              	 	  <input type="hidden" name="serverip" value="<%=serverInfo[0]%>">
	              	 	  <input type="hidden" name="serverport" value="<%=serverInfo[1]%>">
                      <input type="submit" value="종료"/>
                   </form>
                </div>
	            </div>
            
            
<%            
          }  else {

%>
	            <div class="col-6 col-sm-3 placeholder">
	              <img src="data:image/gif;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8DwEwAE/wH6XqDoCwAAAABJRU5ErkJggg==" width="100" height="100" class="img-fluid rounded-circle" alt="Generic placeholder thumbnail" data-toggle="popover" title="Server is not ok" data-content="Please Check Redis Server Status">
	              <h6><% out.println(serverInfo[0] + ":" + serverInfo[1]); %> (Not OK)</h6>
	              <div class="text-muted">[pid] unknown </div>
	            </div>
<%          	
          }
%>

<% // end of for loop          

       }
%>
          </section>


          <h6>Redis 기본 정보</h6>
          <div class="card-group">
          	
         	

<%
      String redis_version = "";
      String arc_bits = "";
      String connected_clients = "";
      String total_system_memory = "";

      
      String used_cpu_sys = "";
      String used_cpu_user = "";

      String used_cpu_sys_children = "";
      String used_cpu_user_children = "";
      
      String used_memory = "";
      String used_memory_peak = "";
      
      String loading = "";
      String aof_enable = "";
      String aof_current_size = "";
      

      
      String keyspace = "";
      String keyspace_hists = "";
      String keyspace_misses = "";
      String expired_keys = "";
      String evicted_keys = "";
      String cluster_enabled = "";
      String cluster_slot_assigned = "";
      
      String master_host = "";
      String master_port = "";
      String aof_enabled = "";
      
      for( int idx = 0; idx < serverCnt; idx ++ )
      {
           redis_version = "";
           arc_bits = "";
           connected_clients = "";
           total_system_memory = "";
           
           
           used_cpu_sys = "";
           used_cpu_user = "";
           
           used_cpu_sys_children = "";
           used_cpu_user_children = "";
           
           used_memory = "";
           used_memory_peak = "";
           
           loading = "";
           aof_enable = "";
           aof_current_size = "";
           
           
           process_id = "";
           keyspace = "";
           keyspace_hists = "";
           keyspace_misses = "";
           expired_keys = "";
           evicted_keys = "";
           cluster_enabled = "";
           cluster_slot_assigned = "";
           
           master_host = "";
           master_port = "";
           
           aof_enabled = "";
           
           serverIPPort = (String)serverList.get( idx );
    		   serverInfo = serverIPPort.split(":");
    		   
    		   try {
    		       Jedis jedisInst = Redis.getInstance( serverInfo[0], Integer.parseInt( serverInfo[1] ) );
    		       statinfo = MonitorUtil.getInfoBySection( jedisInst, "stats");
    		       
    		       uptime = "Uptime : " + MonitorUtil.getInfoByParam( jedisInst, "uptime_in_seconds" ) + "(sec)" ;     		      
               process_id = MonitorUtil.getInfoByParam( jedisInst, "process_id" );
               
               redis_version = MonitorUtil.getInfoByParam( jedisInst, "redis_version" );
               connected_clients = MonitorUtil.getInfoByParam( jedisInst, "connected_clients" );
               total_system_memory = MonitorUtil.getInfoByParam( jedisInst, "total_system_memory" );

               
               used_cpu_sys = MonitorUtil.getInfoByParam( jedisInst, "used_cpu_sys" );
               used_cpu_user = MonitorUtil.getInfoByParam( jedisInst, "used_cpu_user" );
               used_memory = MonitorUtil.getInfoByParam( jedisInst, "used_memory" );
               used_memory_peak = MonitorUtil.getInfoByParam( jedisInst, "used_memory_peak" );
               keyspace = MonitorUtil.getInfoByParam( jedisInst, "Keyspace" );
               keyspace_hists = MonitorUtil.getInfoByParam( jedisInst, "keyspace_hists" );
               keyspace_misses = MonitorUtil.getInfoByParam( jedisInst, "keyspace_misses" );
               expired_keys = MonitorUtil.getInfoByParam( jedisInst, "expired_keys" );
               cluster_enabled = MonitorUtil.getInfoByParam( jedisInst, "cluster_enabled" );
               aof_enabled = MonitorUtil.getInfoByParam( jedisInst, "aof_enabled" );
               
    		       if( jedisInst != null ) jedisInst.close();
               jedisInst = null;
               Redis.releasePool();
    		   } catch (Exception e) {   Redis.releasePool();  e.printStackTrace(); }
    		   
    		   if ( process_id != null && ! "".equals(process_id)) {
%>                   	
	            <div class="card border-primary mb-3" style="max-width: 25rem;">
							  <div class="card-header"><B><%=serverIPPort%></B></div>
							  <div class="card-body text-primary">
							    <b>Redis 버전 : </b> <%=redis_version%> </br>
							    <b>AOF사용여부 : </b> <%=aof_enabled %>  </br> 
							    <b>Client수 : </b> <%=connected_clients %>  </br> 
							    <b>시스템 Memory : </b> <%=total_system_memory %>  </br> 
							    <b>CPU 사용율(sys) : </b> <%=used_cpu_sys %>  </br> 
							    <b>CPU 사용율(user) : </b> <%=used_cpu_user %>  </br> 
							    <b>메모리 사용량 : </b> <%=used_memory %>  </br> 
							    <b>최대 메모리 사용량 : </b> <%=used_memory_peak %>  </br> 
							    <b>Keyspace : </b> <%=keyspace %>  </br> 
							    <b>Hit : </b> <%=keyspace_hists %>  </br> 
							    <b>Miss : </b> <%=keyspace_misses %>  </br> 
							    <b>Expired Key 개수 : </b> <%=expired_keys %>  </br> 
							    <b>Evicted Key 개수 : </b> <%=evicted_keys %>  </br> 
							    <b>Cluster 여부 : </b> <%=cluster_enabled %>  </br> 
							    	
							  </div>
							</div>
						
<%
          } else {
%>
	            <div class="card border-primary mb-3" style="max-width: 25rem;">
							  <div class="card-header"><B><%=serverIPPort%> (Not OK)</B></div>
							  <div class="card-body text-primary">
							    <b>N/A</b>  </br>
							  </div>
							</div>
						
<%
          }
%>
						
						
<% 

// end of for loop          

       }
%>
						
          </div>



    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
    <script>
      $(function () {
          $('[data-toggle="popover"]').popover()
      })	
    </script>
  </body>


</html>