<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ page import="com.cosmos.framework.role.RoleDto"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script language="javascript">
    window.focus();
</script>
<script type="text/javascript">
	function loadPage() {
		$('#useYn > option[value=<c:out value="${roleDto.useYn}"/>]').attr("selected", "true")
	}
</script>
<script type="text/javascript">

	// 데이터를  수정한다.
	function modifyRoleInfo() {
		
        if (checkMandatory() == false)
            return;
        
		var roleId = $('#roleId').val();
		var roleName = $('#roleName').val();
		var roleDesc = $('#roleDesc').val();
		var useYn = $('#useYn').val();

		$.ajax({
			url : "/photome/framework/rolemanager/RoleModify.action",
			data : {
				roleId : roleId,
				roleName : roleName,
				roleDesc : roleDesc,
				useYn : useYn
			},
			success : callbackModifyRoleInfo
		});

	}
	function callbackModifyRoleInfo(data) {
		pageLog("Role information is modified");
		
		// 오픈너에게 데이터셋(JSON)을 넘기고 창을 닫는다. : 오프너에게 setReturnValue(data)함수가 구현되어 있어야 한다.
		// 필요한 값만 넘겨준다.
        var returnValue = {
        		roleName : $('#roleName').val()
        }
		setOpenerDataset(returnValue);
	}
	
    // 데이터를  삭제한다.
    function deleteRoleInfo() {
        
        if (checkMandatory() == false)
            return;
        
        var roleId = $('#roleId').val();

        $.ajax({
            url : "/photome/framework/rolemanager/RoleDelete.action",
            data : {
                roleId : roleId
            },
            success : callbackDeleteRoleInfo
        });

    }
    function callbackDeleteRoleInfo(data) {
    	pageLog("Role information is deleted");
        
        // 오픈너에게 데이터셋(JSON)을 넘기고 창을 닫는다. : 오프너에게 setReturnValue(data)함수가 구현되어 있어야 한다.
        // 필요한 값만 넘겨준다.
        var returnValue = {
                roleName : ""
        }
        setOpenerDataset(returnValue);
    }
    function serviceMapping(roleId) {
        var url = '/photome/framework/rolemanager/RoleServiceMapping.action?roleId='+ roleId;
        var windowName = 'sysAdmin/framework/RoleServiceMapping';
        var win = openPopupForm(url, windowName, '900', '600');
        window.close();
    }    
</script>


</head>
<body>

	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- Form Table -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="detail_panel" class="detail_panel">
        <table id="detail_table" class="detail_table" cellpadding="0" cellspacing="0">
            <colgroup>
                <col width="30%" />
                <col width="*" />
            </colgroup>
            <tr>
                <td class="label"><span class="required">*</span>Role ID :</td>
                <td class="value"><c:out value="${roleDto.roleId}"/></td>
            </tr>
            <tr>
                <td class="label"><span class="required">*</span>Role Name :</td>
                <td class="value"><input type="text" id="roleName" name="roleName" style="width: 200px;" mandatory=true value="<c:out value="${roleDto.roleName}"/>"></td>
            </tr>
            <tr>
                <td class="label"><span class="required">*</span>Role Description :</td>
                <td class="value"><input type="text" id="roleDesc" name=""roleDesc"" style="width: 350px;" mandatory=true value="<c:out value="${roleDto.roleDesc}"/>"></td>
            </tr>
            <tr>
                <td class="label">Is Active :</td>
                <td class="value"><select id="useYn" name="useYn" style="width: 100px"><option value="Y" selected>Active</option>
                        <option value="N">Disable</option></select></td>
            </tr>
        </table>
        <input name="roleId" id="roleId" value="<c:out value="${roleDto.roleId}"/>" type="hidden"/>
    </div>	
	

	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- Subaction buttons bar & Pagging -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<div id="main_control" class="main_control">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right">
					<button class="word3" onclick="deleteRoleInfo();">delete</button>
					<button class="word3" onclick="modifyRoleInfo();">modify</button>
					<button class="word10" onclick="serviceMapping('<c:out value="${roleDto.roleId}"/>')">service mapping</button>
				</td>
			</tr>
		</table>
	</div>


</body>
</html>