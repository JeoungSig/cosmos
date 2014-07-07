<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ page import="com.cosmos.framework.service.ServiceDto"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript">
	function loadPage() {
	}
</script>

<script type="text/javascript">

    function modifyUser() {
    	document.location.href = '/photome/framework/privateInfo/PrivateInfoModifyForm.action?pupupMode=<c:out value="${pupupMode}"/>&userId=<c:out value="${userDto.userId}"/>';
    }
    
</script>
</head>
<body>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Form Table -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <form id="moidfyForm" name="moidfyForm" method="post" enctype="multipart/form-data">
    <div id="detail_panel" class="detail_panel">
        <table id="detail_table" class="detail_table" cellpadding="0" cellspacing="0">
            <colgroup>
                <col width="150px" />
                <col width="225px" />
                <col width="100px" />
                <col width="225px" />
            </colgroup>
            <tr>
                <td class="label">Uer ID :</td>
                <td class="value"><b><c:out value="${userDto.userId}"/></b></td>
                <td class="label" rowspan="4">Photo :</td>
                <td class="value" rowspan="4"> 
                    <div id="fileSaving" style="display: none;"><img src="/photome/resources/images/common/loding_re.gif" /><br/>Saving....</div>
                    <div id="fileField"  style="display: block;">
                        <c:choose>
                            <c:when test="${!empty userPhoto}">
                                <img src="/photome/image?file=${userPhoto}" width="90px" height="90px"/>
                            </c:when>
                            <c:otherwise>
                                <img src="/photome/resources/images/common/photo_samplebg.gif" width="90px" height="95px"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="label">Name :</td>
                <td class="value"><b><c:out value="${userDto.firstName}"/></b></td>
            </tr>
            <tr>
                <td class="label">Birth Date :</td>
                <td class="value"><c:out value="${userDto.birthDt}"/></td>
            </tr>
            <tr>
                <td class="label">Sex :</td>
                <td class="value">
                    <c:choose>
                        <c:when test="${userDto.sex eq 'F' }">Female</c:when>
                        <c:when test="${userDto.sex eq 'M' }">Male</c:when>
                    </c:choose>
                </td>
            </tr>
            
            <tr>
                <td class="label">Type :</td>
                <td class="value" colspan="3"><b><c:out value="${userDto.userTypeName}"/></b></td>
            </tr>
            
            <tr style="height: 10px;"><td colspan="4">&nbsp;</td></tr>
            
            <tr>
                <td class="label">Mobile :</td>
                <td class="value"><b><c:out value="${userDto.mobilePhone}"/></b></td>
                <td class="label">Tel. :</td>
                <td class="value"><c:out value="${userDto.telephone}"/></td>
            </tr>
            <tr>
                <td class="label">E-Mail :</td>
                <td class="value" colspan="3"><b><c:out value="${userDto.email}"/></b></td>
            </tr>
            <tr style="height: 10px;"><td colspan="4">&nbsp;</td></tr>
            
            
            <tr>
                <td class="label">Zip Code :</td>
                <td class="value"><c:out value="${userDto.addrZipcd}"/></td>
                <td class="label">State :</td>
                <td class="value"><c:out value="${userDto.addrState}"/></td>
            </tr> 
            <tr>
                <td class="label">House No/Street :</td>
                <td class="value" colspan="3"><c:out value="${userDto.addrStreet}"/></td>
            </tr>
            <tr>
                <td class="label">Suburb :</td>
                <td class="value" colspan="3"><c:out value="${userDto.addrSuburb}"/></td>
            </tr>
            <tr style="height: 10px;"><td colspan="4">&nbsp;</td></tr>
                                   
            <tr>
                <td class="label">Is Active :</td>
                <td class="value" colspan="3">
                    <c:choose>
                        <c:when test="${userDto.useYn eq 'Y' }">Active</c:when>
                        <c:when test="${userDto.useYn eq 'N' }">Disable</c:when>
                    </c:choose>
                </td>
            </tr>
        </table>
    </div>
    </form>
    
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Subaction buttons bar & Pagging -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="main_control" class="main_control">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="35%"></td>
                <td width="*" align="right">
                    <button class="word3" onclick="modifyUser();">modify</button>
                </td>
            </tr>
        </table>
    </div>

</body>    
</html>