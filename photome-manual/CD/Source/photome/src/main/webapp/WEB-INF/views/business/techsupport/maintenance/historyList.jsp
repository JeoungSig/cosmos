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
     function viewHistoryInfo(historyId) {
        var url = '/photome/business/techsupport/maintenance/HistoryInfo.action?historyId=' + historyId;
        var windowName = 'business/techsupport/maintenance/HistoryInfo';
        var win = openPopupForm(url, windowName, '780', '700');
    }
    function getUserInfo(userId) {
        var url = '/photome/business/techsupport/maintenance/UserDetailInfo.action?userId=' + userId;
        var windowName = 'sysAdmin/framework/UserDetailInfo';
        var win = openPopupForm(url, windowName, '720', '540');
    }
    function viewGroupInfo(groupId) {
        var url = '/photome/business/techsupport/maintenance/GroupInfo.action?groupId=' + groupId;
        var windowName = 'business/resmanage/group/GroupInfo';
        var win = openPopupForm(url, windowName, '720', '520');
    } 
    function viewBoothInfo(boothId) {
        var url = '/photome/business/techsupport/maintenance/BoothInfo.action?boothId=' + boothId;
        var windowName = 'business/resmanage/booth/BoothInfo';
        var win = openPopupForm(url, windowName, '780', '560');
    } 
    
    function makeClaim() {
        var url = '/photome/business/techsupport/maintenance/HistoryRegistForm.action';
        var windowName = 'business/techsupport/maintenance/HistoryRegistForm';
        var win = openPopupForm(url, windowName, '780', '700');
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
            url : "/photome/business/techsupport/maintenance/HistoryList.action",
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
        $('#grid_table tbody').empty();
        
        var script_template = '<tr>'
            + '    <td> {claimType}</td>'
            + '    <td> <a href="javascript:viewGroupInfo(\'{groupId}\')" style="text-decoration: none;">{groupName} </a></td>'
            + '    <td> <a href="javascript:viewBoothInfo(\'{boothId}\')" style="text-decoration: none;">{boothName} </a></td>'
            + '    <td class="key"> <a href="javascript:viewHistoryInfo(\'{historyId}\')" style="text-decoration: none;">{subject} </a><img src=\"/photome/resources/images/common/shortcut.png\" onClick="goCommentPage(\'{boothId}\',\'{groupId}\')" style=\"cursor:hand;\"/></td>'
            + '    <td> {claimStatusName}</td>'
            + '    <td> <a href="javascript:getUserInfo(\'{technician}\')" style="text-decoration: none;">{technicianName}</a> </td>'
            + '    <td> {createDt} </td> '
            + '    <td> {updateDt} </td>'
            + '</tr>';

        var json = data.list;
        var dataCnt = json.length;

        var trObj = null;
        if (dataCnt > 0) {
            $.each(json, function(i, obj) {
                trObj = script_template.interpolate({
                	historyId   : obj.historyId,
                	claimType   : obj.claimTypeName,
                	groupName : obj.groupName,
                	groupId : obj.groupId,
                	boothId : obj.boothId,
                	boothName : obj.boothName,
                	subject : obj.subject,
                	claimStatusName : ( obj.claimStatus == 'ONGOING' ? ('<font color=#EA0075>' + obj.claimStatusName + '</font>') : obj.claimStatusName),
                	technician : obj.creator,
                	technicianName : obj.creatorName,
                	createDt   : obj.createDt.substr(0,10),
                	updateDt  : obj.updateDt.substr(0,10)
                });
                $(trObj).appendTo('#grid_table tbody');
            });
        } else {
            $('<tr><td colspan="8"><br/>No registed information<br/><br/></td></tr>').appendTo('#grid_table tbody');
        }
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
            url : "/photome/business/techsupport/maintenance/BoothListOfGroup.action",
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
    <div id="search" style="width: 95%">
        <table class="search_table" style="width: 1100px;" border="0"> 
            <tr>
                <td class="label">Group </td> 
                <td><select name="groupId" id="groupId" style="width: 150px" onChange="setBooth(this)"><c:out value="${groupListOptions}" escapeXml="false" /></select></td>
                <td class="label">Booth </td>
                <td><select name="boothId" id="boothId" style="width: 250px"></select></td>
                <td class="label">Claim Type </td>
                <td><select name="claimType" id="claimType" style="width: 170px"><c:out value="${claimTypeOptions}" escapeXml="false"/></select></td>
                <td rowspan="2" style="text-align: right;vertical-align: bottom;"><button class="search" onclick="search();">Find</button></td>
            </tr>
            <tr>
                <td class="label">Writer </td>
                <td><select name="creator" id="creator" style="width: 200px"><c:out value="${technicianListOptions}" escapeXml="false"/></select></td>
                <td class="label">State </td>
                <td><select name="pstState" id="pstState" style="width: 80px"><c:out value="${stateListOptions}" escapeXml="false"/></select></td>
                <td class="label">Claim Status </td>
                <td style="width: 120px;"><select name="claimStatus" id="claimStatus" style="width: 100px"><c:out value="${claimStatusOptions}" escapeXml="false"/></select></td>
            </tr>
        </table>
    </div>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Table List -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div class="grid_table_panel">
        <table id="grid_table" class="grid_table" width="100%" cellspacing="0" cellpadding="0">
            <thead>
                <tr>
                    <th width='100px'>Claim Type</th>
                    <th width='100px'>Group</th>
                    <th width='100px'>Booth</th>
                    <th width='100px'>Subject</th>
                    <th width='100px'>status</th>
                    <th width='200px'>writer</th>
                    <th class="100px">create date</th>
                    <th class="last">modify date</th>
                </tr>
            </thead>
            <tbody>
                <!-- Code List -->
                <tr><td colspan="10"><br/>No registed information<br/><br/></td></tr>
            </tbody>
        </table>
    </div>

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
                <td width="*" align="left">
                    <button class="word8" onclick="makeClaim();">Make Claim</button>
                </td>
            </tr>
        </table>
    </div>


</body>
</html>