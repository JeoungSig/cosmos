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
		setUserTypeAndRole();
		search();
	}
</script>	
<script type="text/javascript">
	function search() {
		var firstName = $('#firstName').val();
		var userType = $('#userType').val();
		var roleId = $('#roleId').val();
		var useYn = $('#useYn').val();
		
		$.ajax({
			url : "/photome/framework/usermanager/UserList.action",
			data : {
				firstName : firstName,
				userType : userType,
				roleId : roleId,
				useYn : useYn
			},
			success : callbackSearch,
		});
		
		pageLog('data retirive complete','info');
	}

	function callbackSearch(data) {
		var json = data.list;
		var dataCnt = json.length;

        var data = null;
        var element = null;
        
		if (dataCnt > 0) {
            data = new Array();
            $.each(json, function(i, obj) {
                element = new Array();
                element[0] = obj.userId;
                element[1] = obj.firstName;
                element[2] = decode(obj.userType,null,'',obj.userType);
                element[3] = obj.mobilePhone;
                element[4] = obj.email;
                element[5] = decode(obj.useYn, 'Y', 'active', 'N', 'disabled','-');
                data[i] = element; 
            });			
		}
		
        var obj = {title: "<b>User</b> List", numberCell: false, editable: false,  resizable:false, columnBorders: true, flexHeight:true};
        obj.width = 1200;
        obj.height = 500;
        obj.colModel = [
            {title:'<b>ID</b>', width:100, dataType:"integer", resizable: false, hidden: false, sortable:false},
            {title:"<b>Name</b>", width:150, dataType:"string",
                render: function (ui) {
                      var rowData = ui.rowData;
                      if (rowData[0] == 'admin') {
                        return '<font color="#FF0000">' + rowData[1] + '</font>';
                      } else {
                        return rowData[1];
                      }
                } },
            {title:"<b>User Type</b>", width:150, dataType:"string"},
            {title:"<b>Mobile</b>", width:200, dataType:"string"},
            {title:"<b>Email</b>", width:250, dataType:"string"},
            {title:"<b>Use</b>", width:100, dataType:"string"}
            ];
        
        obj.dataModel = {data:data, sortIndx: 1, sortDir: "up"};
        obj.rowClick = function( event, ui ) {
            var rowData = ui.dataModel;
            var userId = rowData.data[ui.rowIndx][0];
            getUserInfo(userId);
        };
        obj.scrollModel = {horizontal: false};
        
        $("#grid_panel").pqGrid(obj);		
		
	}
	
    function setUserTypeAndRole() {
        $.ajax({
            url : "/photome/framework/usermanager/UserTypeAndRole.action",
            success : callbackSetUserTypes,
        });
    }

    function callbackSetUserTypes(data) {
        // 사용자 Type     
        $('#userType').empty();
        $('<option></option>').appendTo('#userType');
        
        var script_template = '<option value=\"{codeValue}\">{codeName}</option>';
        var json = data.userTypes;
        var option = null;
        $.each(json, function(i, obj) {
            option = script_template.interpolate({
            	codeValue : obj.codeValue,
            	codeName : obj.codeName
            });
            $(option).appendTo('#userType');
        });
        
        // 롤 정보콤보 설정     
        $('#roleId').empty();
        $('<option></option>').appendTo('#roleId');
        
        var script_template = '<option value=\"{roleId}\">{roleName}</option>';
        var json = data.roles;
        var option = null;
        $.each(json, function(i, obj) {
            option = script_template.interpolate({
            	roleId : obj.roleId,
            	roleName : obj.roleName
            });
            $(option).appendTo('#roleId');
        });
    }
    
    
</script>

<script type="text/javascript">
    function addUserInfo() {
        var url = '/photome/framework/usermanager/UserRegistForm.action';
        var windowName = 'sysAdmin/framework/UserRegistForm';
        var win = openPopupForm(url, windowName, '720', '540');
    }
    
    function modifyUserInfo(userId) {
        var url = '/photome/framework/usermanager/UserModifyForm.action?userId=' + userId;
        var windowName = 'sysAdmin/framework/UserModifyForm';
        var win = openPopupForm(url, windowName, '720', '540');
    }
    
    function getUserInfo(userId) {
        var url = '/photome/framework/usermanager/UserDetailInfo.action?userId=' + userId;
        var windowName = 'sysAdmin/framework/UserDetailInfo';
        var win = openPopupForm(url, windowName, '720', '600');
        window.focus();
    }
    
    function viewUserRoles(userId) {
        var url = '/photome/framework/usermanager/UserRole.action?userId=' + userId;
        var windowName = 'sysAdmin/framework/UserDetailInfo';
        var win = openPopupForm(url, windowName, '720', '540');
    }
    
    function setReturnValue(returnValue) {
    	pageLog(returnValue.message, "info");
        search();
    }
</script>



</head>
<body>

	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- Search -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<div id="search">
		<table class="search_table">
			<tr>
				<td class="label">User Type :</td>
				<td><select name="userType" id="userType" style="width: 150px"></select></td>
				<td class="label">User Name :</td>
				<td><input id="firstName" name="firstName" style="width: 250px;" /></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td class="label">Role :</td>
				<td><select name="roleId" id="roleId" style="width: 150px"></select></td>
				<td class="label">Active :</td>
				<td>
				    <select id="useYn" name="useYn" style="width: 100px">
                            <option selected></option>
                            <option value="Y">Active</option>
                            <option value="N">Disable</option>
                    </select>
				</td>
				<td width="50" align="right"><button class="search" onclick="search();">Find</button></td>
			</tr>

		</table>
	</div>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Table List -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div class="grid_panel" id="grid_panel"></div>
    
    <div class="main_control">
        <table border="0" cellpadding="0" cellspacing="0" style="width: 1200px;">
            <tr>
                <td style="text-align: right;">
                    <button class="word3" onclick="addUserInfo();">Add</button>
                </td>
            </tr>
        </table>
    </div>




</body>
</html>