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
		search();
	}
</script>
<script type="text/javascript">

    // 아직 맵핑이되지 않는 롤 목록을 보여준다.
	function search() {
		
		var userId = '<c:out value="${userDto.userId}" />';
		$.ajax({
			url : "/photome/framework/usermanager/UserRoleMapping.action",
			data : {
				userId : userId,
				mapped : "N"
			},
			success : callbackSearch,
		});

		pageLog('data retirive complete', 'info');
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
                element[0] = '<input type="checkbox" id="checkbox" roleId="' + obj.roleId + '" />';
                element[1] = obj.roleName;
                element[2] = abbreviate(obj.roleDesc,50);
                element[3] = decode(obj.useYn, 'Y', 'active', 'N', 'disabled','-');
                data[i] = element; 
            });
		}
            
        var obj = {numberCell: false, editable: false,  resizable:false, columnBorders: true, flexHeight:false};
        obj.width = 685; 
        obj.height = 200;
        obj.colModel = [
            {title:'', width:30, dataType:"string", resizable: false, hidden: false, sortable:false},
            {title:'<b>Role Name</b>', width:200, dataType:"string", resizable: false, hidden: false, sortable:false},
            {title:"<b>Role Description</b>", width:300, dataType:"string"},
            {title:"<b>Use</b>", width:80, dataType:"string"}
            ];
        
        obj.dataModel = {data:data, sortIndx: 1, sortDir: "up",
            location: "local",
            sorting: "local",
            paging: "local",
            dataType: "Array",
            curPage: 1,
            rPP: 5,
            rPPOptions: [5, 10, 20, 30]};
        obj.topVisible = false;
        obj.scrollModel = {horizontal: false};
        
        $("#grid_panel").pqGrid(obj);              
			
		searchMappedRoles();
	}
</script>
<script type="text/javascript">
    // 이미 맵핑된 롤 목록을 보여준다.
    function searchMappedRoles() {
        
        var userId = '<c:out value="${userDto.userId}" />';
        $.ajax({
            url : "/photome/framework/usermanager/UserRoleMapping.action",
            data : {
                userId : userId,
                mapped : "Y"
            },
            success : callbackSearchMappedServices,
        });
    
        pageLog('data retirive complete', 'info');
    }
    
    function callbackSearchMappedServices(data) {
   
        var json = data.list;
        var dataCnt = json.length;
    
        var data = null;
        var element = null;
        
        if (dataCnt > 0) {
            data = new Array();
            $.each(json, function(i, obj) {
                element = new Array();
                element[0] = '<input type="checkbox" id="checkbox" roleId="' + obj.roleId + '" />';
                element[1] = obj.roleName;
                element[2] = abbreviate(obj.roleDesc,50);
                element[3] = decode(obj.useYn, 'Y', 'active', 'N', 'disabled','-');
                data[i] = element; 
            });
        }
            
       var obj = {numberCell: false, editable: false,  resizable:false, columnBorders: true, flexHeight:false};
       obj.width = 685;
       obj.height = 200;
       obj.colModel = [
           {title:'', width:30, dataType:"string", resizable: false, hidden: false, sortable:false},
           {title:'<b>Role Name</b>', width:200, dataType:"string", resizable: false, hidden: false, sortable:false},
           {title:"<b>Role Description</b>", width:300, dataType:"string"},
           {title:"<b>Use</b>", width:80, dataType:"string"}
           ];
       
       obj.dataModel = {data:data, sortIndx: 1, sortDir: "up",
           location: "local",
           sorting: "local",
           paging: "local",
           dataType: "Array",
           curPage: 1,
           rPP: 5,
           rPPOptions: [5, 10, 20, 30]};
       obj.topVisible = false;
       obj.scrollModel = {horizontal: false};
       
       $("#grid_panel_sub").pqGrid(obj); 
    }
</script>

<script type="text/javascript">
	function toggleCheckAll(clickObj) {
		$('#grid_table tbody #checkbox').each(function() {
			$(this).click();
		});
	}
    function toggleCheckAll_sub(clickObj) {
        $('#grid_table_sub tbody #checkbox').each(function() {
            $(this).click();
        });
    }
</script>

<script type="text/javascript">

	function mappingAdd() {
		var isChecked = false;

		var systemCd = null;
		var categoryCd = null;
		var codeValue = null;
		
		var userId = '<c:out value="${userDto.userId}" />';

		// JSON형태로 마라미터를 구성한다.
		var jsonParam = "";
		var cnt = 0;

		var jsonCode = null;
		var isChecked = false;
		$('#grid_panel #checkbox').each(
				function() {
					isChecked = $(this).is(':checked');

					if (isChecked == true) {
						roleId = $(this).attr('roleId');

						if (cnt != 0) jsonParam = jsonParam + ",";
						jsonParam = jsonParam + "{\"userId\":\"" + userId + "\",\"roleId\":\"" + roleId + "\"}";
						cnt++;
					}
				});
		jsonParam = "{ \"list\":[" + jsonParam + "]}";

		if (cnt == 0) {
			pageLog("서비스와 맵핑할 항목이 선택되지 않았습니다.", "warn");
			return;
		} else {
			$.ajax({
				url : "/photome/framework/usermanager/UserRoleMappingApply.action",
				data : "jsonParam=" + jsonParam,
				success : callbackSave
			});
		}
	}
	function callbackSave(data) {
		pageLog("선택된 데이터들을 서비스에 맵핑 하였습니다.", "warn");
		search();
	}
</script>


<script type="text/javascript">

    // JSON 형태로 데이터를 구성하여 AJAX로 요청한다.
    // 서비스아이디(svcId)는 다수개이므로 JSON의 배열형태로 구성하고, roleId는 하나만 넘기면 되기때문에
    // 마지막에 roleID에대한 데이터를 JSON에(jsonParam파라미터)추가한다.
    function mappingRemove() {
        var isChecked = false;

        var systemCd = null;
        var categoryCd = null;
        var codeValue = null;
        
        var userId = '<c:out value="${userDto.userId}" />';

        // JSON형태로 마라미터를 구성한다.
        var jsonParam = "";
        var cnt = 0;

        var jsonCode = null;
        var isChecked = false;
        $('#grid_panel_sub #checkbox').each(
                function() {
                    isChecked = $(this).is(':checked');

                    if (isChecked == true) {
                        roleId = $(this).attr('roleId');
                        
                        if (cnt != 0) jsonParam = jsonParam + ",";
                        jsonParam = jsonParam + "{\"roleId\":\"" + roleId + "\"}";
                        cnt++;
                    }
                });
        jsonParam = "{ \"list\":[" + jsonParam + "],\"userId\":\"" + userId + "\"}";

        if (cnt == 0) {
        	pageLog("삭제할 맵핑 서비스 항목이 선택되지 않았습니다.", "warn");
            return;
        } else {
            $.ajax({
                url : "/photome/framework/usermanager/UserRoleMappingRemove.action",
                data : "jsonParam=" + jsonParam,
                success : callbackSave
            });
        }
    }
    function callbackMappingRemove(data) {
    	pageLog("선택된 데이터들을 맵핑에서 조외하였습니다.", "warn");
        search();
    }
</script>

</head>
<body>

	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- 등록된 롤 검색 -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<div id="search" style="width: 655px;margin-bottom: 3px;background-color: #F1E4E4; border-top: 4px solid #0080C0;">
	   <table style="width: 665px;">
	       <tr>
	           <td>
	               User ID :<font style="font-weight: bold;font-size: 15px; color: #002F5E;"><c:out value="${userDto.userId}" /></font>,
	               &nbsp;&nbsp;&nbsp;
	               User Name :<font style="font-weight: bold;font-size: 15px; color: #002F5E;"><c:out value="${userDto.firstName}" /></font>
	           </td>
	       </tr>
	   </table>
	</div>

	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- 맵핑되지 않은 롤목록 -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<div class="grid_panel" id="grid_panel"></div>


	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- Subaction buttons bar & Pagging -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="main_control" class="main_control">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 55%;" >&nbsp;</td>
                <td align="left">
                    <button class="word10" onclick="mappingAdd();">∨ add mapping ∨</button>
                    <button class="word10" onclick="mappingRemove();">∧ remove  mapping ∧</button>
                </td>
            </tr>
        </table>
    </div>
    

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- 롤에 맵핑된 서비스목록 -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div class="grid_panel" id="grid_panel_sub"></div>
    <br/>
    <br/>


</body>
</html>