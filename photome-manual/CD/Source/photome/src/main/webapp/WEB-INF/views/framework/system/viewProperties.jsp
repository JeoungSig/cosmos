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
    function setReturnValue(returnValue) {
        alert(returnValue.message);
        pageReload();
    }    
</script>

<script type="text/javascript">
	function pageReload() {
	    document.location.href = '/photome/framework/sysproperty/Main.action';
	}
	function modifyBasicInfo() {
	    var url = '/photome/framework/sysproperty/BasicInfoModifyForm.action';
	    var windowName = 'framework/sysproperty/basicInfoModifyForm';
	    var win = openPopupForm(url, windowName, '700', '500'); 
	}
	function modifyAdmin() {
	    var url = '/photome/framework/sysproperty/AdministratorModifyForm.action';
	    var windowName = 'framework/sysproperty/administratorModifyForm';
	    var win = openPopupForm(url, windowName, '700', '500');
	}
	function modifyExceptionUrl() {
	    var url = '/photome/framework/sysproperty/AccessCheckExceptUrlModifyForm.action';
	    var windowName = 'framework/sysproperty/accessCheckExceptUrlModifyForm';
	    var win = openPopupForm(url, windowName, '700', '500');
	}
	function modifyDataUploadRootpath() {
	    var url = '/photome/framework/sysproperty/DataUploadRootPathModifyForm.action';
	    var windowName = 'framework/sysproperty/dataUploadRootPathModifyForm';
	    var win = openPopupForm(url, windowName, '700', '250');
	}
    
</script>
</head>
<body>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Form Table -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <h2 class="ckbox">System basic information</h2>
    <div id="detail_panel" class="detail_panel" style="width: 900px">
        <table id="detail_table" class="detail_table" cellpadding="0" cellspacing="0">
            <colgroup>
                <col width="150px" />
                <col width="225px" />
                <col width="100px" />
                <col width="225px" />
            </colgroup>
            <tr>
                <td class="label">System Name:</td>
                <td class="value" colspan="3"><b><c:out value="${propertyDto.sysName}"/></b></td>
            </tr>
            <tr>
                <td class="label">Description  :</td>
                <td class="value" colspan="3"><c:out value="${propertyDto.sysDescript}"/></td>
            </tr>
            <tr>
                <td class="label">Copyright :</td>
                <td class="value" colspan="3"><c:out value="${propertyDto.copyright}" escapeXml="false"/></td>
            </tr>
            <tr>
                <td class="label">Logo image :</td>
                <td class="value" colspan="3">
                    <img src="/photome/image?file=${fileDto.savedName}" width="90px" height="90px"/>
                </td>
            </tr>
             <tr><td colspan="4" align="right" style="border-bottom-width: 0px;"><button class="word6" onclick="modifyBasicInfo()">modify</button></td></tr>
            
            
            
            <tr style="height: 40px;"><td colspan="4" style="vertical-align: bottom;"><h2 class="ckbox">Administrator information</h2></td></tr>
            <tr>
                <td class="label">Name :</td>
                <td class="value" colspan="3"><b><c:out value="${userDto.firstName}"/></b></td>
            </tr>
            <tr>
                <td class="label">Email :</td>
                <td class="value"><c:out value="${userDto.email}"/></td>
                <td class="label">Mobile :</td>
                <td class="value"><c:out value="${userDto.mobilePhone}"/></td>
            </tr>
            <tr><td colspan="4" align="right" style="border-bottom-width: 0px;"><button class="word6" onclick="modifyAdmin()">modify</button></td></tr>
            
            
            <tr style="height: 40px;"><td colspan="4" style="vertical-align: bottom;"><h2 class="ckbox">Data Upload Roothpath</h2></td></tr>
            <tr>
                <td class="label">Rootpath :</td>
                <td class="value" colspan="3"><pre><c:out value="${propertyDto.dataUploadRootpath}" escapeXml="false"/></pre></td>
            </tr>
            <tr><td colspan="4" align="right" style="border-bottom-width: 0px;"><button class="word6" onclick="modifyDataUploadRootpath()">modify</button></td></tr>            
            
            
            <tr style="height: 40px;"><td colspan="4" style="vertical-align: bottom;"><h2 class="ckbox">Access check exception URLs</h2></td></tr>
            <tr>
                <td class="label">URLs :</td>
                <td class="value" colspan="3"><pre><c:out value="${propertyDto.acessChkExceptUrl}" escapeXml="false"/></pre></td>
            </tr>
            <tr><td colspan="4" align="right" style="border-bottom-width: 0px;"><button class="word6" onclick="modifyExceptionUrl()">modify</button></td></tr>
                        
        </table>
    </div>
	<br />
	<br />
	<br />

</body>    
</html>