<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<script type="text/javascript">
	function loadPage() {
	}
</script>
<script type="text/javascript">
	function execute() {
		var form = document.queryForm;
		form.action = "/cosmos/framework/query/Main.action";
		form.method = "POST";
		form.submit();
	}
</script>

</head>
<body>

	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- Form Table -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<form method="post" name="queryForm">
		<div id="detail_panel" class="detail_panel">
			<table id="detail_table" class="detail_table" cellpadding="0" cellspacing="0">
				<tr>
				    <td class="label">Messge</td>
					<td class="value" style="background-color: #EEEEEE;" colspan="2"><font color="#800000"><c:out value="${message}" escapeXml="false" /></font></td>
				</tr>
				<tr>
					<td class="value" style="background-color: #FFFFFF;height: 5px" colspan="3">&nbsp;</td>
				</tr>
				<tr>
					<td class="label" style="width: 100px;">SQL</td>
					<td class="value" style="width: 800px;"><textarea rows="50" cols="80" name="sql" id="sql" style="height: 150px;"><c:out value="${sql}" /></textarea></td>
					<td class="value">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2" class="value">
						<div id="main_control" class="main_control">
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td align="right">
										<button class="word10" onclick="execute();">Execure SQL</button>
									</td>
								</tr>
							</table>
						</div>
					</td>
					<td class="value">&nbsp;</td>
				</tr>
			</table>
		</div>
	</form>
<% 
	List<Map> contents = (List<Map>)request.getAttribute("resultList");
%>
    <%
    if(contents != null && contents.size() > 0 ){
      out.println("<font color=\"#5E0000\">&nbsp;&nbsp; Total : <b>" + contents.size() + " </b> record</font>");	
    }else{
      out.println("<font color=\"#5E0000\">&nbsp;&nbsp; Total : <b> 0 </b>record");	
    }
    %>
    <div class="grid_table_panel">
    <table id="grid_table" class="grid_table" width="100%" cellspacing="0" cellpadding="0">
	<%
		int cnt = 0;
	    if(contents != null && contents.size() > 0 ){ 
			for(Map map:contents){
			    Iterator header = map.keySet().iterator();
			    if(cnt == 0) {
			    	Iterator title = map.keySet().iterator();
                	out.println("<thead><tr><th>SEQ</th>");
	                while(title.hasNext()){
	                    String colName = (String)title.next();
	                    out.print("<th>" + colName + "</th>");
	                }
                	out.println("</tr></thead>");
                	
                	out.println("<tbody>");
                	out.println("<tr><td>" + (cnt+1) + "</td>");
                    while(header.hasNext()){
                        String colName = (String)header.next();
                        out.print("<td>" + map.get(colName) + "</td>");
                    }
                    out.println("</tr>");                	
			    }else{
                	out.println("<tr><td>" + (cnt+1) + "</td>");
				    while(header.hasNext()){
			            String colName = (String)header.next();
			            out.print("<td>" + map.get(colName) + "</td>");
			        }
                	out.println("</tr>");
			    }
		        cnt++;
		    }
			out.println("</tbody>"); 
	    } else {  
	    	out.println("<tbody><tr><td align=\"center\"><br><br>No record<br><br></td></tr></tbody>");
	    }
	%>
	   </table>
	</div>


</body>
</html>