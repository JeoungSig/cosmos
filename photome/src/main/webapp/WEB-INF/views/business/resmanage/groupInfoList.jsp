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
</script>	
<script type="text/javascript">
	function search() {
		var groupName  = $('#groupName').val();
		var useYn  = $('#useYn').val();
	    document.location.href = "/photome/business/resmanage/group/Main.action?groupName=" + groupName + "&useYn=" + useYn;
	}
    function addGroupInfo() {
        var url = '/photome/business/resmanage/group/GroupInfoRegistForm.action';
        var windowName = 'business/resmanage/group/GroupInfoRegistFor';
        var win = openPopupForm(url, windowName, '720', '520'); 
    } 
    function viewGroupInfo(groupId) {
        var url = '/photome/business/resmanage/group/GroupInfo.action?groupId=' + groupId;
        var windowName = 'business/resmanage/group/GroupInfo';
        var win = openPopupForm(url, windowName, '720', '520');
    }
    function viewBoothInfo(boothId) {
        var url = '/photome/business/resmanage/booth/BoothInfo.action?boothId=' + boothId;
        var windowName = 'business/resmanage/booth/BoothInfo';
        var win = openPopupForm(url, windowName, '780', '560');
    }      
</script>
<script type="text/javascript">
	function setReturnValue(returnValue) {
		document.location.href = "/photome/business/resmanage/group/Main.action";
	}    
</script>	

</head>
<body>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Search -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="search" style="width: 95%">
        <table class="search_table">
            <tr>
                <td class="label">Group :</td>
                <td><input id="groupName" name="groupName"  value="<c:out value="${groupName}"/>" style="width: 200px;" /></td>
                <td class="label" style="width: 150px;">Use Y/N </td>
                <td>
                    <select name="useYn" id="useYn" style="width: 100px">
                        <c:choose>
                            <c:when test="${useYn == 'N' }">
                                <option value='Y'>Active</option>
                                <option value='N' selected>Disabled</option>
                            </c:when>
	                        <c:otherwise>
	                            <option value='Y' selected>Active</option>
	                            <option value='N'>Disabled</option>                        
	                        </c:otherwise>
                        </c:choose>
                    </select>
                </td>
                <td style="text-align: right;vertical-align: bottom;"><button class="search" onclick="search();">Find</button></td>
            </tr>
        </table>
    </div>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Table List -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div class="grid_table_panel">
        <table id="grid_table" class="grid_table" width="100%" cellspacing="0" cellpadding="0">
            <thead>
                <tr>
                    <th width='300px'>GROUP</th>
                    <th class="last">BOOTH</th>
                </tr>
            </thead>
            <tbody>
                <!-- List -->
                <c:choose>
                    <c:when test="${groupMap != null}">
			                <c:forEach var="groupDto" items="${groupMap}" varStatus="outStatus">
			                <tr>
			                    <td>
			                        <a href="javascript:viewGroupInfo('<c:out value="${groupDto.value.groupId}"/>')" style="font-size: 15px;font-weight: bold;color: #B00058;text-decoration: none;"><c:out value="${groupDto.value.groupName}"/> </a><br/>
			                        <c:if test="${!empty groupDto.value.groupDescript }">
			                            <font color="#800000"><c:out value="${groupDto.value.groupDescript}"/></font><br/>
			                        </c:if>
			                        <c:if test="${!empty groupDto.value.managerName }">&nbsp;&nbsp;<c:out value="${groupDto.value.managerName}"/><br/></c:if>
			                        &nbsp;&nbsp;
			                        <c:if test="${!empty groupDto.value.managerTel }"><c:out value="${groupDto.value.managerTel}"/> /</c:if>
			                        <c:if test="${!empty groupDto.value.managerMobile }"><c:out value="${groupDto.value.managerMobile}"/> /</c:if>
			                        <c:if test="${!empty groupDto.value.managerEmail }"><c:out value="${groupDto.value.managerEmail}"/></c:if>
			                        <br/>
			                        <br/>
			                    </td>  
			                    <td style="vertical-align: top;"> 
			                          <c:set var="boothList" value="${groupBoothMap[groupDto.key]}" />
			                          <c:forEach var="boothDto" items="${boothList}" varStatus="inStatus">
			                             <font style="font-size: 15px;color: #C400C4; font-weight: bold;"><a href="javascript:viewBoothInfo('<c:out value="${boothDto.boothId}"/>');"><c:out value="${boothDto.boothName}"/></a></font>
			                             <font style="font-size: 12px;">
			                             ( <c:out value="${boothDto.locState}"/>,<c:out value="${boothDto.locSuburb}"/>)
			                             </font> 
			                              |
			                          </c:forEach>
			                    </td>
			                </tr>
			                </c:forEach>                    
                    </c:when>
                    <c:otherwise>
                        <tr style="height: 50px;">
                            <td colspan="2" style="vertical-align: middle;text-align: center;"> No record </td>
                        </tr>    
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Subaction buttons bar & Pagging -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="main_control" class="main_control">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="80%">
                    <!-- Paging -->
                    <div class="paging"></div>
                </td>
                <td width="*" align="left">
                    <button class="word8" onclick="addGroupInfo();">Add Group</button>
                </td>
            </tr>
        </table>
    </div>

</body>
</html>