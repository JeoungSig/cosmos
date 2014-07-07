<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="admin" value="<%=com.cosmos.framework.CosmosContext.SYSTEM_ADMINISTRATOR%>" />

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

	<table id="grid_table" class="grid_table" style="width: 90%;" cellspacing="0" cellpadding="0" align="center" border="0"> 
		<tr>
			<td width="100px"><img src="/photome/resources/images/common/expired.jpg" style="height: 120px;"></td> 
			<td>
			     <font color="#0063C6"><b>This system is Evaluation version. You have to make formal contract to use without limitation</b></font>
			     <br/><br/>
			     <font color="#8B8B8B">
			     [ <c:out value="${admin.firstName }" />, (tel)<c:out value="${admin.telephone }" />, (mobile)<c:out value="${admin.mobilePhone }" />, (email)<c:out value="${admin.email }" /> ]
			     </font>
			</td>
		</tr>
	</table>
	
	<br />
	<br />
	<br />

</body>
</html>