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
    function viewBoothInfo(boothId) {
        var url = '/photome/business/resmanage/booth/BoothInfo.action?boothId=' + boothId;
        var windowName = 'business/resmanage/booth/BoothInfo';
        var win = openPopupForm(url, windowName, '780', '670');
    }
    function getUserInfo(userId) {
    	if(userId == '' || userId == '-' || userId == null){
    		return;
    	}
        var url = '/photome/business/resmanage/booth/UserDetailInfo.action?userId=' + userId;
        var windowName = 'sysAdmin/framework/UserDetailInfo';
        var win = openPopupForm(url, windowName, '720', '540');
    }
    function viewGroupInfo(groupId) {
        var url = '/photome/business/resmanage/group/GroupInfo.action?groupId=' + groupId;
        var windowName = 'business/resmanage/group/GroupInfo';
        var win = openPopupForm(url, windowName, '720', '680');
    } 
    function addBoothInfo() {
        var url = '/photome/business/resmanage/booth/BoothInfoRegistForm.action';
        var windowName = 'business/resmanage/booth/BoothInfoRegistForm';
        var win = openPopupForm(url, windowName, '780', '670');
    }     
</script>   
<script type="text/javascript">
    function search() {
        var groupId             = $('#groupId').val();
        var boothName           = $('#boothName').val();
        var status              = $('#status').val();
        var captureType         = $('#captureType').val();
        var type                = $('#type').val();
        var qualityTestResult   = $('#qualityTestResult').val();
        var locState            = $('#locState').val();
        var monitorType         = $('#monitorType').val();
        var printerModel        = $('#printerModel').val();
        var technicianName      = $('#technicianName').val();
        var useYn               = $('#useYn').val();
        
        $.ajax({
            url : "/photome/business/resmanage/booth/BoothInfoList.action",
            data : {
            	groupId      : groupId,
            	boothName    : boothName,
            	status       : status,
            	captureType  : captureType,
            	type         : type,
            	qualityTestResult : qualityTestResult,
            	locState     : locState,
            	monitorType  : monitorType,
            	printerModel : printerModel,
            	technicianName   : technicianName,
            	useYn   : useYn
            },
            success : callbackSearch,
        });
        
        pageLog('data retirive complete','info');
    }

    function callbackSearch(data) {
        var table_template = '<table id="table_data" class="dataTable">'
            + '<thead>'
            + '    <tr>'
            + '        <th width="100px">Group</th>'
            + '        <th width="350px">Booth Name</th>'
            + '        <th width="100px">Technician</th>'
            + '        <th width="100px">State</th>'
            + '        <th width="200px">Status</th>'
            + '        <th width="100px">Printer</th>'
            + '        <th width="70px">Monitor</th>'
            + '        <th width="100px">Type</th>'
            + '        <th width="*" align="left">Serial</th>'
            + '    </tr>'
            + '</thead>'
            + '<tfoot>'
            + '    <tr>'
            + '        <th style="text-align:right" colspan="9"></th>'
            + '    </tr>'
            + '</tfoot>';            
            
        $('#grid_array').html(table_template);    	

        var json = data.list;
        var dataCnt = json.length;

        // 테이블의 타이틀 설정
        var colM = [ { title: "Group", width: 150, dataType: "string" },
                     { title: "Booth Name", width: 350, dataType: "string" },
                     { title: "Technician", width: 100, dataType: "string" },
                     { title: "State", width: 100, dataType: "string", align: "right" },
                     { title: "Status", width: 150, dataType: "string", align: "right"},
                     { title: "Printer", width: 100, dataType: "string", align: "right" },
                     { title: "Monitor", width: 70, dataType: "string", align: "left" }, 
                     { title: "Type", width: 100, dataType: "string", align: "right"},
                     { title: "Serial",dataType: "string", align: "right"}
                  ]; 
        
        // 테이블 데이터 설정
        var statusColor = "#008040";
        if (dataCnt > 0) {
            var data = new Array();
            var element = null;
            $.each(json, function(i, obj) { 
                 element = new Array();
                 element[0] = ('<a href=\"javascript:viewGroupInfo(\''+ obj.groupId + '\')" style="text-decoration: none;">' + obj.groupName + '</a>');
                 element[1] = ('<a href=\"javascript:viewBoothInfo(\''+ obj.boothId + '\')" style="text-decoration: none;">' + obj.boothName + '</a>');
                 element[2] = ('<a href=\"javascript:getUserInfo(\''+ decode(obj.technician, "-") + '\')" style="text-decoration: none;">' + decode(obj.technicianName, "-") + '</a>');
                 element[3] = obj.locState;
                 
                 if(obj.status == 'NORMAL') {
                	 statusColor = "#008040";
                 } else if(obj.status == 'CLOSURE') {
                	 statusColor = "#A7A7A7";
                 } else {
                	 statusColor = "#D70000";
                 }
                 element[4] = '<font color="' + statusColor + '">' + obj.statusName + '</font>';
                 element[5] = obj.printerModel;
                 element[6] = obj.monitorType;
                 element[7] = decode(obj.type, '');
                 element[8] = obj.serialNo;
                 data[i] = element;
            }); 
        } 
        
        $('#table_data').dataTable( {
            "aaData": data, 
            "aoColumns" : colM,
            "sPaginationType": "full_numbers"
            });
    }
    
    
</script>

<script type="text/javascript">
	function setReturnValue(returnValue) {
		pageLog(returnValue.message, "info");
	    $('#groupId').val(returnValue.message);
	    search();
	}
</script>

</head>
<body>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Search -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="search" style="width: 95%">
        <table class="search_table" style="width: 1100px;" border="0"> 
            <tr>
                <td class="label">Group :</td>
                <td><select name="groupId" id="groupId" style="width: 100px"><c:out value="${groupListOptions}" escapeXml="false"/></select></td>
                <td class="label">Booth Name </td>
                <td><input id="boothName" name="boothName" style="width: 200px;" /></td>
                <td class="label">Status :</td>
                <td colspan="3"><select name="status" id="status" style="width: 200px"><c:out value="${boothStatusOptions}" escapeXml="false"/></select></td>
                <td rowspan="3" style="text-align: right;vertical-align: bottom;"><button class="search" onclick="search();">Find</button></td>
            </tr>
            <tr>
                <td class="label">Capture Type </td>
                <td><select name="captureType" id="captureType" style="width: 100px"><c:out value="${captureTypeOptions}" escapeXml="false"/></select></td>
                <td class="label">Type </td>
                <td><select name="type" id="type" style="width: 100px"><c:out value="${boothTypeOptions}" escapeXml="false"/></select></td>
                <td class="label">Quality Test </td>
                <td style="width: 120px;"><select name="qualityTestResult" id="qualityTestResult" style="width: 100px"><c:out value="${qltyResultOptions}" escapeXml="false"/></select></td>
                <td style="width: 50px;" class="label">State </td> 
                <td><select name="locState" id="locState" style="width: 100px"><c:out value="${stateListOptions}" escapeXml="false"/></select></td>                
            </tr>
            <tr>
                <td class="label">Monitor </td>
                <td><select name="monitorType" id="monitorType" style="width: 100px"><c:out value="${monitorTypeOptions}" escapeXml="false"/></select></td>
                <td class="label">Printer </td>
                <td><select name="printerModel" id="printerModel" style="width: 100px"><c:out value="${printerTypeOptions}" escapeXml="false"/></select></td>            
                <td class="label">Technician </td>
                <td><input id="technicianName" name="technicianName" style="width: 150px;" /></td>
                <td class="label">Use Y/N </td>
                <td><select name="useYn" id="useYn" style="width: 100px"><option value='Y' selected>Active</option><option value='N'>Disabled</option></select></td>
            </tr>            
        </table>
    </div>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Table List -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="grid_array"></div>

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
                <td width="*" align="center">
                    <button class="word5" onclick="addBoothInfo();">Add Booth</button>
                </td>
            </tr>
        </table>
    </div>


</body>
</html>