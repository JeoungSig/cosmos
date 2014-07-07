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

function addRoleInfo() {
    if (checkMandatory() == false)  return; 
    
    var roleName = $('#roleName').val();
    var roleDesc = $('#roleDesc').val();
    var useYn = $('#useYn').val();
        
	$.ajax({
		url : "/photome/framework/rolemanager/RoleRegist.action",
		data : {
			roleName : roleName,
			roleDesc : roleDesc,
			useYn : useYn
		},
		success : callbackAddRoleInfo
	});
}
    
function callbackAddRoleInfo(data) {
	pageLog("New code information registed");
		
    var returnValue = {
      		roleName : $('#roleName').val()
    }
	setOpenerDataset(returnValue);
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
				<td class="label"><span class="required">*</span>Role Name :</td>
				<td class="value"><input type="text" id="roleName" name="roleName" style="width: 200px;" mandatory=true></td>
			</tr>
			<tr>
				<td class="label"><span class="required">*</span>Role Description :</td>
				<td class="value"><input type="text" id="roleDesc" name=""roleDesc"" style="width: 350px;" mandatory=true></td>
			</tr>
			<tr>
				<td class="label">Is Active :</td>
				<td class="value"><select id="useYn" name="useYn" style="width: 100px"><option value="Y" selected>Active</option>
                        <option value="N">Disable</option></select></td>
			</tr>
		</table>
	</div>

	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- Subaction buttons bar & Pagging -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<div id="main_control" class="main_control">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="85%"></td>
				<td width="*" align="left">
					<button class="word3" onclick="addRoleInfo();">add</button>
				</td>
			</tr>
		</table>
	</div>


</body>
</html>