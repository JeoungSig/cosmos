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
    function serviceRequestInfo(historyId) {
        var url = '/photome/business/techsupport/servicereq/ServiceRequestInfo.action?historyId=' + historyId;
        var windowName = 'business/techsupport/maintenance/HistoryInfo';
        var win = openPopupForm(url, windowName, '780', '550');
    }
    function serviceRequestThread(historyId) {
        var url = '/photome/business/techsupport/servicereq/ServiceRequestThread.action?historyId=' + historyId;
        var windowName = 'business/techsupport/servicereq/ServiceRequestThread';
        var win = openPopupForm(url, windowName, '780', '550');
    }
    function viewBoothInfo(boothId) {
        var url = '/photome/business/techsupport/servicereq/BoothInfo.action?boothId=' + boothId;
        var windowName = 'business/resmanage/servicereq/BoothInfo';
        var win = openPopupForm(url, windowName, '780', '560');
    } 
    
    function makeServiceReq() {
        var url = '/photome/business/techsupport/servicereq/ServiceRequestRegistForm.action';
        var windowName = 'business/techsupport/servicereq/ServiceRequestRegistForm';
        var win = openPopupForm(url, windowName, '780', '550');
    }     
 </script>   
<script type="text/javascript">
    function search() {
        var groupId       = $('#groupId').val();
        var boothId       = $('#boothId').val();
        var pstState      = $('#pstState').val();
        var creator       = $('#creator').val();
        var claimType     = $('#claimType').val();
        var claimStatus   = $('#claimStatus').val();
        
        $.ajax({
            url : "/photome/business/techsupport/servicereq/ServiceRequestList.action",
            data : {
            	groupId  : groupId,
            	boothId  : boothId,
            	pstState : pstState,
            	creator  : creator,
            	claimType   : claimType,
            	claimStatus : claimStatus
            },
            success : callbackSearch,
        });
        
        pageLog('data retirive complete','info');
    }

    function callbackSearch(data) {
        var json = data.list;
        var dataCnt = json.length;

        var arrayData = null;
        var element = null;
        
        if (dataCnt > 0) {
            
            arrayData = new Array();
            $.each(json, function(i, obj) {
                element = new Array();
                element[0] = obj.claimTypeName;
                element[1] = obj.groupName;
                element[2] = '<a href="javascript:viewBoothInfo(\'' + obj.boothId + '\')"><font color="#0070A6">' + obj.boothName + '</font></a>';
                element[3] = obj.claimStatusName;
                element[4] = '<a href="javascript:serviceRequestInfo(\'' + obj.historyId + '\')"><font color="#A40000">' + obj.subject + '</font></a>';  
                element[5] = '<a href="javascript:serviceRequestThread(\'' + obj.historyId + '\')">' + '<img src="/photome/resources/images/common/tools_comments.gif" border="0"></a>'; 
                element[6] = obj.creatorName;
                element[7] = obj.createDt.substr(0,10);
                element[8] = obj.updateDt.substr(0,10);
                element[9] = obj.historyId;
                element[10] = obj.claimStatus;
                arrayData[i] = element; 
            });
        }
        
        var obj = {title: "<b>Service Request</b> List", numberCell: false, editable: false,  freezeCols: 4, resizable:false, columnBorders: true, flexHeight:true};
        obj.width = "98%";
        obj.height = 500;
        obj.colModel = [
            {title:'<b>Claim Type</b>', width:150, dataType:"string"},
            {title:'<b>Group</b>', width:150, dataType:"string"},
            {title:"<b>Booth</b>", width:200, dataType:"string"},
            {title:"<b>Status</b>", width:100, dataType:"string",
                render: function (ui) {
                    var rowData = ui.rowData;
                    if (rowData[10] == 'ONGOING') {
                      return '<font color="#EA0075">' + rowData[3] + '</font>';
                    } else {
                      return rowData[3];
                    }
              }     
            },
            {title:"<b>Subject</b>", width:350, dataType:"string"},
            {title:"<b>Threads</b>", width:70, dataType:"string", align:"center", sortable:false},
            {title:"<b>Writer</b>", width:150, dataType:"string",
            	render: function (ui) {
            		  var rowData = ui.rowData;
                      return '<font color="#008200">' + rowData[6] + '</font>';
              }
            },
            {title:"<b>Create Date</b>", width:110, dataType:"string"},
            {title:"<b>Modify Date</b>", width:110, dataType:"string"},
            {title:'Hidden1(ID)', hidden:true},
            {title:'Hidden1(Status)', hidden:true}
            ];        
        
        obj.dataModel = {data:arrayData, sortIndx: 3, sortDir: "down", 
                location: "local",
                sorting: "local",
                paging: "local",
                dataType: "Array",
                curPage: 1,
                rPP: 15,
                rPPOptions: [15, 20, 30, 50] };
        $("#grid_panel").pqGrid(obj);    
        
    }
    function goCommentPage(boothId, groupId){
    	document.location.href="/photome/business/techsupport/maintenance/comment/Main.action?boothId=" + boothId + "&groupId=" + groupId;
    }
</script>

<script type="text/javascript">
	function setReturnValue(returnValue) {
		pageLog("하나의 정보가 추가되었습니다.", "info");
	    $('#svcName').val(returnValue.svcName);
	    search();
	}
</script>
<script type="text/javascript">
	function setBooth(group){
		var groupId = group.value;
        $.ajax({
            url : "/photome/business/techsupport/servicereq/BoothListOfGroup.action",
            data : "groupId=" + groupId,
            success : callbackSetBooth,
        });		
	}
    function callbackSetBooth(data) {
    	var boothList =  data.boothList;
        $('#boothId').empty();
        var options = "<option></option>";
        for(var i = 0; i < boothList.length; i++){
        	options = options + "<option value='" + boothList[i].boothId + "'>" + boothList[i].boothName + "</option>\n" ;
        }
        $('#boothId').html(options);
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
        <table class="search_table"" border="0"> 
            <tr>
                <td class="label">Group </td> 
                <td><select name="groupId" id="groupId" style="width: 200px" onChange="setBooth(this)"><c:out value="${groupListOptions}" escapeXml="false" /></select></td>
                <td class="label">Booth </td>
                <td><select name="boothId" id="boothId" style="width: 250px"></select></td>
                <td class="label">Claim Type </td>
                <td><select name="claimType" id="claimType" style="width: 170px"><c:out value="${claimTypeOptions}" escapeXml="false"/></select></td>
                <td rowspan="2" style="text-align: right;vertical-align: bottom;"><button class="search" onclick="search();">Find</button></td>
            </tr>
            <tr>
                <td class="label">Writer </td>
                <td><select name="creator" id="creator" style="width: 200px;" ><c:out value="${technicianListOptions}" escapeXml="false"/></select></td>
                <td class="label">State </td>
                <td><select name="pstState" id="pstState" style="width: 140px"><c:out value="${stateListOptions}" escapeXml="false"/></select></td>
                <td class="label">Claim Status </td>
                <td style="width: 120px;"><select name="claimStatus" id="claimStatus" style="width: 170px"><c:out value="${claimStatusOptions}" escapeXml="false"/></select></td> 
            </tr>
        </table>
    </div>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Table List -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
   <div class="grid_panel" id="grid_panel"></div>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Subaction buttons bar & Pagging -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="main_control" class="main_control">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="*" align="right">
                    <button class="word10" onclick="makeServiceReq();">Service Request</button>
                </td>
                <td width="50px">&nbsp;</td>
            </tr>
        </table>
    </div>


</body>
</html>