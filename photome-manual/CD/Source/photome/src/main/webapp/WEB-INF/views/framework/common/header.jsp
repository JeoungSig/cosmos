<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript">
    function logout() {
    	document.location.href = "/photome/common/auth/Logout.action";
    }
    function privateInfo(userId) {
        var url = '/photome/framework/privateInfo/PrivateDetailInfo.action?pupupMode=YES&userId=' + userId;
        var windowName = 'framework/privateInfo/privateDetailInfo';
        var win = openPopupForm(url, windowName, '720', '540');
    }
    
    function setReturnValue(returnValue) {
    	pageLog("Personal information was modified.", "info");
        $('#svcName').val(returnValue.svcName);
        search();
    }    
</script>
</head>

<c:set var="sessAttribute" value="<%=com.cosmos.framework.CosmosConstants.LOGIN_USER_SESSION_ATTR%>" />
<c:set var="sessUserInfo" value="${sessionScope[sessAttribute].userInfo}" />

<table style="width: 100%; background-color: #1a1a1a;" cellspacing="0" cellpadding="0">
	<tr>
	    <td width="20px">&nbsp;</td>
		<td width="300px" valign="bottom">
			<!-- 사용자 정보 --> 
			<font color="#b6b6b6"> 
			     <font color="#ffffff">
			         <div onclick="javascript:privateInfo('${sessUserInfo.userId}');" style="cursor: pointer; text-decoration: underline;">${sessUserInfo.firstName}</div>
			     </font> 
			         [${sessUserInfo.userTypeName}]
			     <br/> 
			     Last login : ${sessUserInfo.loginDt}<br/>
			     <div onclick="javascript:logout();" style="cursor: pointer;text-decoration: underline;text-align: "> Logout</div> 
		    </font>
		</td>
	</tr>
</table>
