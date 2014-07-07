<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="com.cosmos.framework.auth.CosmosSessionUserInfo" %>
<%@ page import="com.cosmos.framework.CosmosConstants" %>
<%@ page import="com.cosmos.framework.role.RoleDto" %>
<%@ page import="com.cosmos.framework.service.ServiceDto" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>

<c:set var="sessAttribute" value="<%=CosmosConstants.LOGIN_USER_SESSION_ATTR%>" />
<c:set var="sessUserInfo" value="${sessionScope[sessAttribute].userInfo}" />
<%
	CosmosSessionUserInfo  sessionUser = (CosmosSessionUserInfo)session.getAttribute(CosmosConstants.LOGIN_USER_SESSION_ATTR);
	HashMap<String, RoleDto> roleMap = sessionUser.getRoleMap();
	Iterator roleIter = roleMap.keySet().iterator();
	
	HashMap<String, List<ServiceDto>> roleServiceMap = sessionUser.getRoleServiceMap();
	Iterator roleServiceIter = roleServiceMap.keySet().iterator();
	
	String selectedRroleId = (String)session.getAttribute(CosmosConstants.SELECT_MENUE_ROLEID);
	String selectedServiceId = (String)session.getAttribute(CosmosConstants.SELECT_MENUE_SERVICEID);
%>

<c:set var="roles" value="${roleIter}" />

<!-- 사용자 권한에 따른 메뉴부분 컬러 설정 -->
<c:choose>
	<c:when test="${sessUserInfo.userType == 'SUPER_ADMIN' }">
		<c:set var="mainMenuFontColor" value="#BAD80A" scope="request" />
		<c:set var="subMenuBgColor" value="#004E9B" scope="request" />
		<c:set var="subMenuFontColor" value="#FFFFEC" scope="request" />
	</c:when>

	<c:when test="${sessUserInfo.userType == 'ADMIN' }">
		<c:set var="mainMenuFontColor" value="#E1E1F0" scope="request" />
		<c:set var="subMenuBgColor" value="#808000" scope="request" />
		<c:set var="subMenuFontColor" value="#FFFFEC" scope="request" />
	</c:when>

	<c:when test="${sessUserInfo.userType == 'BUSINESS' }">
		<c:set var="mainMenuFontColor" value="#FFFFFF" scope="request" />
		<c:set var="subMenuBgColor" value="#004F75" scope="request" />
		<c:set var="subMenuFontColor" value="#FFFFB0" scope="request" />
	</c:when>

	<c:otherwise>
		<c:set var="mainMenuFontColor" value="#BAD80A" scope="request" />
		<c:set var="subMenuBgColor" value="#004E9B" scope="request" />
		<c:set var="subMenuFontColor" value="#FFFFEC" scope="request" />
	</c:otherwise>
</c:choose>

<style type="text/css">
    DIV.subMenu A:link, DIV.subMenu A:visited { color: <c:out value="${subMenuFontColor}" />; text-decoration: none; }
    DIV.subMenu A:hover { color: <c:out value="${subMenuFontColor}" />; text-decoration: underline;}
</style>

<script type="text/javascript">
	function mainClick(roleId) {
		
		 $('#initDisplay').empty();
		
		$('div[id^="sub_"]').css('display','none');
		$('div[id=sub_' + roleId + ']').css('display','block');
		
		$('a[id^=main_]').css('font-size','12px').css('text-decoration','none');
		$('a[id=main_' + roleId + ']').css('font-size','15px').css('text-decoration','underline');
		
		$('#selectedRroleId').val(roleId);
		setMenu('');
	}
	function subClick(serviceId, serviceUrl) {
		$('#selectedServiceId').val(serviceId);
		setMenu(serviceUrl);
	}
</script>
<script type="text/javascript">
    function setMenu(serviceUrl) {
        var selectedRroleId = $('#selectedRroleId').val();
        var selectedServiceId = $('#selectedServiceId').val();
        $.ajax({
            url : "/photome/common/auth/SelectMenu.action",
            data : {
            	selectedRroleId : selectedRroleId,
            	selectedServiceId : selectedServiceId,
            	serviceUrl : serviceUrl
            },
            success : callbackSetMenu
        });
    }
    function callbackSetMenu(data) {
    	if(data.serviceUrl != '' && data.serviceUrl != null){
            document.location.href = data.serviceUrl;
    	}
    }
  
</script>
<script type="text/javascript">
    $(document).ready(function() {
    	$('a[id=main_<%=selectedRroleId%>]').css('font-size','15px').css('text-decoration','underline');
    	$('div[id=sub_<%=selectedRroleId%>]').css('display','block');
    	$('a[id=service_<%=selectedServiceId%>]').css('text-decoration','underline');
    });    
</script>

<input type="hidden" id="selectedRroleId" name="selectedRroleId" value="" />
<input type="hidden" id="selectedServiceId" name="selectedServiceId" value="" />

<table style="width: 100%; background-color: #1A1A1A;" cellspacing="1" cellpadding="0" >
	<tr style="background-color: #1a1a1a;">
		<td colspan="2">
			<!-- 1차 메뉴 -->
			<div id="mainMenu" class="mainMenu">
				<font color="<c:out value="${mainMenuFontColor}" />">
				<%
				 while(roleIter.hasNext()){
					 String roleKey = (String)roleIter.next();
					 out.print("<a id=\"main_" + roleKey + "\" onClick=\"mainClick('" + roleKey + "')\"  style=\"cursor:hand;\" >" );
					 out.print(((RoleDto)roleMap.get(roleKey)).getRoleName()  );
					 out.print("</a>"); 
					 out.print("&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;");
				 }
				%>
			    </font>
			</div>
		</td>
	</tr>
	<tr>
		<td width="20px" style="background-color: #1A1A1A;">&nbsp;</td>
		<td style="background-color: #A0A0A0; text-indent: 10px; padding-top: 0px; border-top-color: #D7D7D7; ">
			<table style="width: 100%" >
				<tr>
					<td style="background-color: <c:out value="${subMenuBgColor}" />">
					
						<!-- 2차 메뉴 --> 
						<div id="subMenu" class="subMenu" style="height: 16px;"> 
						<div id="initDisplay">
						    <%
						       if(selectedServiceId == null || selectedServiceId.equals("")){
						    	   out.println("<font color=\"#808080\">Click main menu - Cosmos webapplication framework</font>");
						       }
						    %>
						</div>
						    <font color="<c:out value="${subMenuFontColor}" />">  
						    <%
						         // if(selectedServiceId == null){ out.print("<div id=\"sub_0\">......</div>");}
				                 while(roleServiceIter.hasNext()){
				                     String roleKey = (String)roleServiceIter.next();
				                     
				                     if(roleKey == selectedRroleId){
					                     out.println("<div id='sub_" + roleKey + "' style='display:block;'>");
				                     }else{
					                     out.println("<div id='sub_" + roleKey + "' style='display:none;'>");
				                     }
				                     
				                     List<ServiceDto> svcList = (List<ServiceDto>)roleServiceMap.get(roleKey);
				                     for(ServiceDto svcDto:svcList){
				                    	 out.print("<a id=\"service_" + svcDto.getSvcId() + "\" onClick=\"subClick('" + svcDto.getSvcId() + "', '/photome" + svcDto.getSvcPrefix() + svcDto.getSvcUrl() + "/Main.action')\" style=\"cursor:hand;\">" + svcDto.getSvcName() + "</a>");
				                    	 out.print(" | ");
				                     }
				                     out.println("</div>");
				                 }
				             %>
						    </font>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
