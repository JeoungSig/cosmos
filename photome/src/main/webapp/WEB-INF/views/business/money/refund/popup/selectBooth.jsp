<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript">
    function loadPage() {  }
</script> 
<script type="text/javascript">    
    function viewBoothInfo(boothId) {
        var url = '/photome/business/money/refund/BoothInfo.action?boothId=' + boothId;
        var windowName = 'business/money/refund/BoothInfo';
        var win = openPopupForm(url, windowName, '780', '560');
    }
    function viewGroupInfo(groupId) {
        var url = '/photome/business/money/refund/GroupInfo.action?groupId=' + groupId;
        var windowName = 'business/money/refund/GroupInfo';
        var win = openPopupForm(url, windowName, '720', '520');
    }     
    function getUserInfo(userId) {
        var url = '/photome/business/money/refund/UserDetailInfo.action?userId=' + userId;
        var windowName = 'business/money/refund/UserDetailInfo';
        var win = openPopupForm(url, windowName, '720', '540');
    }
</script>   
<script type="text/javascript">
    function search() {
        var groupId   = $('#groupId').val();
        var boothId   = $('#boothId').val();
        var locState  = $('#locState').val();
        var serialNo  = $('#serialNo').val();
        
        if( (groupId == '' || groupId == null) &&
        		(boothId == '' || boothId == null) && 
        		(locState == '' || locState == null) &&
        		(serialNo == '' || serialNo == null)) {
        	alert("You need to choose search condition !");
        	return;
        }
        
        $.ajax({
            url : "/photome/business/money/refund/BoothInfoList.action",
            data : {
                groupId  : groupId,
                boothId  : boothId,
                locState : locState,
                serialNo : serialNo
            },
            success : callbackSearch,
        });
        
        pageLog('data retirive complete','info');
    }

    function callbackSearch(data) {
        $('#grid_table tbody').empty();
        
        var script_template = '<tr>'
            + '    <td> <a href="javascript:viewGroupInfo(\'{groupId}\')" style="text-decoration: none;"> <font color=\'#D9006C\'>{groupName}</font><a></td>'
            + '    <td> <a href="javascript:viewBoothInfo(\'{boothId}\')" style="text-decoration: none;">{boothName} </a> /'
            + '         <a href="javascript:getUserInfo(\'{technician}\')" style="text-decoration: none;"><font color=\'#004000\'>{technicianName}</font></a> '
            + '    </td>'
            + '    <td> {locState} / {locSuburb} </td> '
            + '    <td> {serialNo} </td>'
            + '    <td> <button class="word4" onclick="select(\'{boothId}\',\'{boothName}\')">select</button></td>'
            + '</tr>';

        var json = data.list;
        var dataCnt = json.length;

        var trObj = null;
        if (dataCnt > 0) {
            $.each(json, function(i, obj) {
                trObj = script_template.interpolate({
                    groupId   : obj.groupId,
                    groupName : obj.groupName,
                    boothName : obj.boothName,
                    boothId : obj.boothId,
                    technician : obj.technician,
                    technicianName : obj.technicianName,
                    locState   : obj.locState,
                    locSuburb  : obj.locSuburb,
                    serialNo  : obj.serialNo
                });
                $(trObj).appendTo('#grid_table tbody');
            });
        } else {
            $('<tr><td colspan="5"><br/>No information<br/><br/></td></tr>').appendTo('#grid_table tbody');
        }
    }
    function select(bankAccount, bankAccountDisplayName) {
        opener.document.getElementById('boothId').value = bankAccount;
        opener.document.getElementById('boothName').value = bankAccountDisplayName;
        self.close();
    }
</script>
<script type="text/javascript">
	function setBooth(group){
	    var groupId = group.value;
	    $.ajax({
	        url : "/photome/business/money/refund/BoothListOfGroup.action",
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
</script>

</head>
<body>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Search -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="search" style="width: 95%">
        <table class="search_table" border="0"> 
            <tr>
                <td class="label">Group :</td>
                <td><select name="groupId" id="groupId" style="width: 150px" onChange="setBooth(this)"><c:out value="${groupListOptions}" escapeXml="false"/></select></td>
                <td class="label">Booth </td>
                <td><select name="boothId" id="boothId" style="width: 250px"></select></td>
                <td rowspan="2" style="text-align: right;vertical-align: bottom;"><button class="search" onclick="search();">Find</button></td>
            </tr>
            <tr>
                <td class="label">State :</td>
                <td><select name="locState" id="locState" style="width: 150px" ><c:out value="${stateListOptions}" escapeXml="false" /></select></td>
                <td class="label">Serial No </td>
                <td><input id="serialNo" name="serialNo" style="width: 200px;" /></td>
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
                    <th>Group</th>
                    <th>Booth / technician</th>
                    <th>State / suburb</th>
                    <th>Serial</th>
                    <th class="last">&nbsp;</th>
                </tr>
            </thead>
            <tbody>
                <!-- Code List -->
                <tr><td colspan="10"><br/>No registed information<br/><br/></td></tr>
            </tbody>
        </table>
    </div>

</body>
</html>