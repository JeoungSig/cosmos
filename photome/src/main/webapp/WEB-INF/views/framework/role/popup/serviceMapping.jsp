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
		setServiceTypes();
		search();
	}
</script>
<script type="text/javascript">
	function search() {
		
		var roleId = '<c:out value="${roleDto.roleId}" />';
		var svcName = $('#svcName').val();
		var useYn = $('#useYn').val();
		var svcPrefix = $('#svcPrefix').val();
		var authRequired = $('INPUT:RADIO[NAME=authRequired]:checked').val();

		$.ajax({
			url : "/photome/framework/rolemanager/ServiceListWithNotMapped.action",
			data : {
				roleId : roleId,
				svcName : svcName,
				useYn : decode(useYn, '%'),
				svcPrefix : decode(svcPrefix, '%'),
				authRequired : decode(authRequired, '%')
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
                element[0] = '<input type="checkbox" id="checkbox" svcId="' + obj.svcId + '" />';
                element[1] = obj.svcName;
                element[2] = abbreviate(obj.svcDesc,40);
                element[3] = decode(obj.svcPrefix, '-') + decode(obj.svcUrl, '-');
                element[4] = decode(obj.useYn, 'Y', 'active', 'N', 'disabled','-');
                data[i] = element; 
            });

            var obj = {title : "Service Mapping : <c:out value="${roleDto.roleName}" />",numberCell: false, editable: false,  resizable:false, columnBorders: true, flexHeight:false};
            obj.width = 900;
            obj.height = 200;
            obj.colModel = [
                {title:'', width:30, dataType:"string", resizable: false, hidden: false, sortable:false},
                {title:'<b>Service Name</b>', width:200, dataType:"string", resizable: false, hidden: false, sortable:false},
                {title:"<b>Service Description</b>", width:250, dataType:"string"},
                {title:"<b>Service URL</b>", width:300, dataType:"string"},
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
            obj.scrollModel = {horizontal: false};
            
            $("#grid_panel").pqGrid(obj);  

		}
		
		searchMappedServices();
	}

	function setServiceTypes() {
		$.ajax({
			url : "/photome/framework/servicemanager/ServiceTypes.action",
			success : callbackSetServiceTypes,
		});
	}

	function callbackSetServiceTypes(data) {
		// 카테고리 콤보를 비운다     
		$('#svcPrefix').empty();
		$('<option></option>').appendTo('#svcPrefix');

		var script_template = '<option value=\"{codeValue}\">{codeName}</option>';
		var json = data.urlPrefix;
		var option = null;
		$.each(json, function(i, obj) {
			option = script_template.interpolate({
				codeValue : obj.codeValue,
				codeName : obj.codeName
			});
			$(option).appendTo('#svcPrefix');
		});
	}
</script>
<script type="text/javascript">
	function toggleCheckAll(clickObj) {
		$('#grid_table tbody #checkbox').each(function() {
			$(this).click();
		});
	}

	function save() {
		var isChecked = false;

		var systemCd = null;
		var categoryCd = null;
		var codeValue = null;
		
		var roleId = '<c:out value="${roleDto.roleId}" />';

		// JSON형태로 마라미터를 구성한다.
		var jsonParam = "";
		var cnt = 0;

		var jsonCode = null;
		var isChecked = false;
		$('#grid_panel #checkbox').each(
				function() {
					isChecked = $(this).is(':checked');

					if (isChecked == true) {
						svcId = $(this).attr('svcId');
						roleId = roleId;

						if (cnt != 0) jsonParam = jsonParam + ",";
						jsonParam = jsonParam + "{\"svcId\":\"" + svcId + "\",\"roleId\":\"" + roleId + "\"}";
						cnt++;
					}
				});
		jsonParam = "{ \"list\":[" + jsonParam + "]}";

		if (cnt == 0) {
			pageLog("서비스와 맵핑할 항목이 선택되지 않았습니다.", "warn");
			return;
		} else {
			$.ajax({
				url : "/photome/framework/rolemanager/RoleServiceMappingApply.action",
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
function searchMappedServices() {
    
    var svcName = $('#svcName').val();
    var useYn = $('#useYn').val();
    var svcPrefix = $('#svcPrefix').val();
    var authRequired = $('INPUT:RADIO[NAME=authRequired]:checked').val();

    $.ajax({
        url : "/photome/framework/rolemanager/ServiceListWithMapped.action",
        data : "roleId=" + <c:out value="${roleDto.roleId}" />,
        success : callbackSearchMappedServices
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
            element[0] = '<input type="checkbox" id="checkbox" svcId="' + obj.svcId + '" />';
            element[1] = obj.svcName;
            element[2] = abbreviate(obj.svcDesc,40);
            element[3] = decode(obj.svcPrefix, '-') + decode(obj.svcUrl, '-');
            element[4] = decode(obj.useYn, 'Y', 'active', 'N', 'disabled','-');
            data[i] = element; 
        });
        
        var obj = {numberCell: false, editable: false,  resizable:false, columnBorders: true, flexHeight:false};
        obj.width = 880;
        obj.height = 200;
        obj.colModel = [
            {title:'', width:30, dataType:"string", resizable: false, hidden: false, sortable:false},
            {title:'<b>Service Name</b>', width:200, dataType:"string", resizable: false, hidden: false, sortable:false},
            {title:"<b>Service Description</b>", width:250, dataType:"string"},
            {title:"<b>Service URL</b>", width:300, dataType:"string"},
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
}
</script>
<script type="text/javascript">
    function toggleCheckAll_sub(clickObj) {
        $('#grid_table_sub tbody #checkbox').each(function() {
            $(this).click();
        });
    }

    // JSON 형태로 데이터를 구성하여 AJAX로 요청한다.
    // 서비스아이디(svcId)는 다수개이므로 JSON의 배열형태로 구성하고, roleId는 하나만 넘기면 되기때문에
    // 마지막에 roleID에대한 데이터를 JSON에(jsonParam파라미터)추가한다.
    function mappingRemove() {
        var isChecked = false;

        var systemCd = null;
        var categoryCd = null;
        var codeValue = null;
        
        var roleId = '<c:out value="${roleDto.roleId}" />';

        // JSON형태로 마라미터를 구성한다.
        var jsonParam = "";
        var cnt = 0;

        var jsonCode = null;
        var isChecked = false;
        $('#grid_panel_sub #checkbox').each(
                function() {
                    isChecked = $(this).is(':checked');

                    if (isChecked == true) {
                        svcId = $(this).attr('svcId');
                        
                        if (cnt != 0) jsonParam = jsonParam + ",";
                        jsonParam = jsonParam + "{\"svcId\":\"" + svcId + "\"}";
                        cnt++;
                    }
                });
        jsonParam = "{ \"list\":[" + jsonParam + "],\"roleId\":\"" + roleId + "\"}";

        if (cnt == 0) {
        	pageLog("삭제할 맵핑 서비스 항목이 선택되지 않았습니다.", "warn");
            return;
        } else {
            $.ajax({
                url : "/photome/framework/rolemanager/RoleServiceMappingRemove.action",
                data : "jsonParam=" + jsonParam,
                success : callbackSave
            });
        }
    }
    function callbackMappingRemove(data) {
    	pageLog("선택된 데이터들을 맵핑에서 조회하였습니다.", "warn");
        search();
    }
</script>

</head>
<body>

	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- 등록된 서비스 검색 -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<div id="search" style="width: 655px">
		<table class="search_table" style="width: 655px">
			<tr>
				<td class="label" width="80px">Type :</td>
				<td width="230px"><select name="svcPrefix" id="svcPrefix" style="width: 150px"></select></td>
				<td class="label" width="75px">Name :</td>
				<td width="350px" colspan="2"><input id="svcName" name="svcName" style="width: 150px;"></input></td>
			</tr>
			<tr>
				<td class="label">Authorized :</td>
				<td><input type="radio" id="authRequiredY" name="authRequired" value='Y'>Required &nbsp; <input type="radio" id="authRequiredN" name="authRequired" value='N'>No Required </td>
				<td class="label">Active :</td>
				<td><select id="useYn" name="useYn" style="width: 100px">
						<option selected></option>
						<option value="Y">Active</option>
						<option value="N">Disable</option>
				</select></td>
				<td width="50" align="right"><button class="search" onclick="search();">Find</button></td>
			</tr>
		</table>
		<input type="hidden" name="roleId" name="<c:out value="${roleDto.roleId}"/>">
	</div>


	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- 해당롤에 맵핑되지 않은 서비스목록 -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<div class="grid_panel" id="grid_panel"></div>


	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- Subaction buttons bar & Pagging -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<div id="main_control" class="main_control">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
			    <td style="width: 60%;" >&nbsp;</td>
				<td align="left">
					<button class="word10" onclick="save();">∨ add mapping ∨</button>
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