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
		//setSystemCombo();
		search();
	}
</script>	
<script type="text/javascript">
	function search() {
		var roleName = $('#roleName').val();

		$.ajax({
			url : "/photome/framework/rolemanager/RoleList.action",
			data : {
				roleName : roleName
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
                element[0] = obj.roleId;
                element[1] = '<font color="#696934"><b>' + obj.roleName + "</b></font>";
                element[2] = obj.roleDesc;
                element[3] = decode(obj.useYn, 'Y', 'active', 'N', 'disabled','-');
                element[4] = obj.createDt.substr(0,10);
                data[i] = element; 
            });                 
        }        
        
        var obj = {title: "<b>Role</b> List", numberCell: false, editable: false,  resizable:false, columnBorders: true, flexHeight:false};
        obj.width = 1200;
        obj.height = 300;
        obj.colModel = [
            {title:'<b>ID</b>', width:50, dataType:"string", resizable: false, hidden: false, sortable:false},
            {title:'<b>Role Name</b>', width:250, dataType:"string", resizable: false, hidden: false, sortable:false},
            {title:"<b>Role Description</b>", width:300, dataType:"string"},
            {title:"<b>Use</b>", width:100, dataType:"string"},
            {title:"<b>Create Dt</b>", width:150, dataType:"string"}
            ];
        
        obj.dataModel = {data:data, sortIndx: 1, sortDir: "up",
            location: "local",
            sorting: "local",
            paging: "local",
            dataType: "Array",
            curPage: 1,
            rPP: 10,
            rPPOptions: [5, 10, 20, 30]};
        obj.rowClick = function( event, ui ) {
            var rowData = ui.dataModel;
            var roleId = rowData.data[ui.rowIndx][0];
            modifyRoleInfo(roleId);
        };
        obj.scrollModel = {horizontal: false};
        
        $("#grid_panel").pqGrid(obj);  
        
	}
</script>

<script type="text/javascript">
    function addRoleInfo() {
        var url = '/photome/framework/rolemanager/RoleRegistForm.action';
        var windowName = 'sysAdmin/framework/RoleRegistForm';
        var win = openPopupForm(url, windowName, '500', '250');
    }
    
    function modifyRoleInfo(roleId) {
        var url = '/photome/framework/rolemanager/RoleModifyForm.action?roleId=' + roleId;
        var windowName = 'sysAdmin/framework/RoleModifyForm';
        var win = openPopupForm(url, windowName, '600', '250');
        window.focus();
    }
    
    function setReturnValue(returnValue) {
    	pageLog("하나의 정보가 추가되었습니다.", "info");
        $('#roleName').val(returnValue.roleName);
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
				<td class="label"><span class="required">*</span>Role Name : <input id="roleName" name="roleName" style="width: 150px;" ></td>
				<td width="50" align="right">
					<button class="search" onclick="search();">Find</button>
				</td>
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
                    <button class="word7" onclick="addRoleInfo();">Add role</button>
                </td>
            </tr>
        </table>
    </div>


</body>
</html>