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
		var svcName = $('#svcName').val();
		var useYn = $('#useYn').val();
		var svcPrefix = $('#svcPrefix').val();
		var authRequired = $('INPUT:RADIO[NAME=authRequired]:checked').val();
		
		$.ajax({
			url : "/photome/framework/servicemanager/ServiceList.action",
			data : {
				svcName : svcName,
				useYn : useYn,
				svcPrefix : svcPrefix,
				authRequired : authRequired
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
                element[0] = obj.svcId;
                if(obj.svcPrefix == '/framework'){
	                element[1] = '<font color="#FF0000">' + obj.svcName + '</font>';
                }else{
	                element[1] = obj.svcName;
                }
                
                element[2] = obj.svcDesc;
                element[3] = decode(obj.svcPrefix,'-') + decode(obj.svcUrl,'-');
                element[4] = decode(obj.authRequired, 'Y', 'require', 'N', 'no required', '');
                element[5] = decode(obj.useYn, 'Y', 'active', 'N', 'disabled','-');
                data[i] = element; 
            });     			
		}
		
        var obj = {title: "<b>Service</b> List", numberCell: false, editable: false,  resizable:false, columnBorders: true, flexHeight:false};
        obj.width = 1200;
        obj.height = 500;
        obj.colModel = [
            {title:'<b>ID</b>', width:50, dataType:"string", resizable: false, hidden: false, sortable:false},
            {title:'<b>Service Name</b>', width:250, dataType:"string", resizable: false, hidden: false, sortable:false},
            {title:"<b>Service Description</b>", width:300, dataType:"string"},
            {title:"<b>Service URL</b>", width:300, dataType:"string"},
            {title:"<b>Authorize</b>", width:100, dataType:"string"},
            {title:"<b>Use</b>", width:100, dataType:"string"}
            ];
        
        obj.dataModel = {data:data, sortIndx: 1, sortDir: "up",
        	location: "local",
            sorting: "local",
            paging: "local",
            dataType: "Array",
            curPage: 1,
            rPP: 15,
            rPPOptions: [15, 20, 30, 50]};
        obj.rowClick = function( event, ui ) {
            var rowData = ui.dataModel;
            var userId = rowData.data[ui.rowIndx][0];
            modifyServiceInfo(userId);
        };
        obj.scrollModel = {horizontal: false};
        
        $("#grid_panel").pqGrid(obj);   
        
        
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
    function addServiceInfo() {
        var url = '/photome/framework/servicemanager/ServiceRegistForm.action';
        var windowName = 'sysAdmin/framework/ServiceRegistForm';
        var win = openPopupForm(url, windowName, '700', '340');
    }
    
    function modifyServiceInfo(svcId) {
        var url = '/photome/framework/servicemanager/ServiceModifyForm.action?svcId=' + svcId;
        var windowName = 'sysAdmin/framework/ServiceModifyForm';
        var win = openPopupForm(url, windowName, '700', '340');
        window.focus();
    }
    
    function setReturnValue(returnValue) {
    	pageLog("하나의 정보가 추가되었습니다.", "info");
        $('#svcName').val(returnValue.svcName);
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
				<td class="label">Service Type :</td>
				<td><select name="svcPrefix" id="svcPrefix" style="width: 150px"></select></td>
				<td class="label">Service Name :</td>
				<td><input id="svcName" name="svcName" style="width: 250px;" /></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td class="label">Authorized :</td>
				<td>
				    <input type="radio" id="authRequiredY" name="authRequired" value='Y'/>  Required &nbsp;&nbsp;&nbsp;
                    <input type="radio" id="authRequiredN" name="authRequired" value='N'/>  No Required 
				</td>
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
                    <button class="word3" onclick="addServiceInfo();">Add</button>
                </td>
            </tr>
        </table>
    </div>


</body>
</html>