<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript">
	function loadPage() {
	}
	function go(url) {
		document.location.href = url;
	}
</script>
</head>
<body>

	<table>
		<tr>
			<td><img src="/photome/resources/images/common/task.jpg" style="height: 40px;"></td>
			<td style="vertical-align: bottom;"><font size="5px"><b> MY TASK LIST </b></font></td>
		</tr>
	</table> 
	<hr />
	<table id="grid_table" class="grid_table" width="500px" cellspacing="0" cellpadding="0" bgcolor="#E2E2E2">
		<c:forEach var="list" items="${roleServiceMap}" varStatus="num">
			<c:set var="roleKey" value="${list.key}" />
			<c:set var="serviceList" value="${list.value}" />

			<c:set var="roleInfo" value="${roleMap[roleKey]}" />
			<tr>
				<td>
				    <c:if test="${num.first}"><br/></c:if>
					<h2 class="ckbox"><c:out value="${roleInfo.roleName }" /></h2> 
					&nbsp;<c:out value="${roleInfo.roleDesc }" /> &nbsp;&nbsp;
					<br/>  
					 
					    
					<!-- 해당 롤에 해당하는 서비스 목록을 출력한다. --> 
				    <table border="0"> 
							<tr>
								<td style="width: 20px;">&nbsp;</td>
								<td>
									<c:forEach var="serviceInfo" items="${serviceList}" varStatus="cnt">
				                        <c:if test="${!cnt.first}">&nbsp; |&nbsp;</c:if>
				                        <a href="javascript:go('/photome<c:out value="${serviceInfo.svcPrefix }" /><c:out value="${serviceInfo.svcUrl }" />/Main.action');"> <c:out value="${serviceInfo.svcName }" /></a>
	                                    <c:if test="${cnt.last}"><br/><br/>&nbsp;</c:if>								
									</c:forEach>
								</td>
							</tr>
						</table>
				</td>
			</tr>
		</c:forEach>
	</table>
	<br />
	<br />
	<br />

</body>
</html>