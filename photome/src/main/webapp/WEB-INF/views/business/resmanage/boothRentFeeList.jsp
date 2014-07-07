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
	function viewGroupInfo(groupId) {
	    var url = '/photome/business/resmanage/booth/rentfee/GroupInfo.action?groupId=' + groupId;
	    var windowName = 'business/resmanage/group/GroupInfo';
	    var win = openPopupForm(url, windowName, '720', '680');
	} 
	function viewBoothInfo(boothId) {
	    var url = '/photome/business/resmanage/booth/rentfee/BoothInfo.action?boothId=' + boothId;
	    var windowName = 'business/resmanage/booth/BoothInfo';
	    var win = openPopupForm(url, windowName, '780', '560');
	} 
    function registBoothRentFee() {
        var url = '/photome/business/resmanage/booth/rentfee/BoothRentFeeRegistForm.action';
        var windowName = 'business/resmanage/booth/rentfee/BoothRentFeeRegistForm';
        var win = openPopupForm(url, windowName, '520', '270');
    }     
</script>
<script type="text/javascript">
    function deleteBoothRentFeeInfo(boothId, rentYear, rentMonth) {

        $.ajax({
            url : "/photome/business/resmanage/booth/rentfee/BoothRentFeeDelete.action",
            data : {
                boothId    : boothId    ,
                rentYear   : rentYear   ,
                rentMonth  : rentMonth       },
            success : callbackSaveBoothFeeInfo
        });

    }
    function callbackSaveBoothFeeInfo(data) {
    	pageLog('Deleted','info');
    	search();
    }
    function deleteGroupRentFeeInfo(groupId, rentYear, rentMonth) {

        $.ajax({
            url : "/photome/business/resmanage/booth/rentfee/GroupRentFeeDelete.action",
            data : {
                groupId    : groupId    ,
                rentYear   : rentYear   ,
                rentMonth  : rentMonth       },
            success : callbackSaveGroupFeeInfo
        });

    }
    function callbackSaveGroupFeeInfo(data) {
    	pageLog('Deleted','info');
    	search();
    }
</script> 
<script type="text/javascript">
    function search() {
        var groupId    = $('#groupId').val();
        var boothId    = $('#boothId').val();
        var rentYear   = $('#rentYear').val();
        var rentMonth  = $('#rentMonth').val();
        var rentFeeType   = $('#rentFeeType').val();
        var payOnsite  = $('#payOnsite').val();
        
        $.ajax({
            url : "/photome/business/resmanage/booth/rentfee/BoothRentFeeList.action",
            data : {
            	groupId    : groupId,
            	boothId    : boothId,
            	rentYear   : rentYear,
            	rentMonth  : rentMonth,
            	rentFeeType   : rentFeeType,
            	payOnsite  : payOnsite
            },
            success : callbackSearch
        });
    }

    function callbackSearch(data) {
    	
        var json = data.jsonList;
        var dataCnt = json.length;
        var arrayData = null;
        var element = null;

        if (dataCnt > 0) {
            arrayData = new Array();
            $.each(json, function(i, obj) {
                element = new Array();
                element[0] = '<img src="/photome/resources/images/common/icon_del_on.gif" border=0/>';
                element[1] = obj.groupName;
                element[2] = obj.boothName;
                element[3] = obj.rentYear + '/' + obj.rentMonth;
                if(obj.rentFeeType == 'PERCENT'){
                    element[4] = '<font color="#0000A0"><b>' + obj.rentPercent + '</b></font>' + '%';
                }else if(obj.rentFeeType == 'FIXED_MONEY'){
                    element[4] = '<font color="#0000A0"><b>' + toCurrency(obj.rentAmount) + '</b></font>';
                }else{
                    element[4] = '0';
                }
                element[5] = obj.rentFeeTypeName;
                element[6] = decode(obj.payOnsite, 'N', 'No','Pay onsite');
                element[7] = obj.modifyDt.substr(0,10); 
                element[8] = obj.rentFeeType;
                element[9] = obj.boothId;
                element[10] = obj.rentYear;
                element[11] = obj.rentMonth;
                arrayData[i] = element; 
            });
        }       
        var obj = {title: "<b>Booth Rent Fee</b> List", numberCell: false, editable: false,  freezeCols: 5, resizable:false, columnBorders: true, flexHeight:true};
        obj.width = "98%";
        obj.height = 500;
        obj.colModel = [
            {title:'', width:50, dataType:"string", align: "center", sortable:false },
            {title:'<b>Group</b>', width:150, dataType:"string"},
            {title:"<b>Booth</b>", width:200, dataType:"string"},
            {title:"<b>Year/Month</b>", width:130, dataType:"string"},
            {title:"<b>Rent Amt</b>", width:150, dataType:"string", sortable:false},
            {title:"<b>Rent Type</b>", width:150, dataType:"string"},
            {title:"<b>Pay onsite</b>", width:180, dataType:"string"},
            {title:"<b>Modify Date</b>", width:180, dataType:"string"},
            {title:'Hidden1(rentFeeType)', hidden:true},
            {title:'Hidden1(boothId)', hidden:true},
            {title:'Hidden1(rentYear)', hidden:true},
            {title:'Hidden1(rentMonth)', hidden:true}
            ];    
        
        obj.dataModel = {data:arrayData, sortIndx: 1, sortDir: "up", 
                location: "local",
                sorting: "local",
                paging: "local",
                dataType: "Array",
                curPage: 1,
                rPP: 10,
                rPPOptions: [10, 20, 30, 50] };

        obj.selectionModel = { type: 'cell', mode: 'block' };
        obj.cellClick = function (evt, ui) {
        	var column = ui.column;
        	var rowData = ui.dataModel;
        	
            var boothId = rowData.data[ui.rowIndx][9];
            var rentYear = rowData.data[ui.rowIndx][10];
            var rentMonth = rowData.data[ui.rowIndx][11];
        	
             if (column && column.dataIndx == 0) {
            	 deleteBoothRentFeeInfo(boothId, rentYear, rentMonth);
             }
        };
        $("#grid_panel").pqGrid(obj);   
    }
</script>

<script type="text/javascript">
	function setReturnValue(returnValue) {
		pageLog(returnValue.message, "info");
	    search();
	}
</script>
<script type="text/javascript">
    function setBooth(group){
        var groupId = group.value;
        $.ajax({
            url : "/photome/business/resmanage/booth/rentfee/BoothListOfGroup.action",
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
    <div id="search"  style="width: 1200px;"> 
        <table class="search_table" border="0" style="width: 1200px;"> 
            <tr>
                <td class="label">Group :</td>
                <td><select name="groupId" id="groupId" style="width: 200px" onChange="setBooth(this)" ><c:out value="${groupListOptions}" escapeXml="false"/></select></td>
                <td class="label">Booth :</td>
                <td colspan="5"><select name="boothId" id="boothId" style="width: 357px"></select></td>
            </tr>
            <tr>
                <td class="label">Year/Month </td>
                <td><select name="rentYear" id="rentYear" style="width: 100px"><c:out value="${yearOptions}" escapeXml="false"/></select>&nbsp;<select name="rentMonth" id="rentMonth" style="width: 100px"><c:out value="${monthOptions}" escapeXml="false"/></select></td>
                <td class="label">Rent Type </td>
                <td><select name="rentFeeType" id="rentFeeType" style="width: 200px"><c:out value="${rentFeeTypeOptions}" escapeXml="false"/></select></td>
                <td class="label">Onsite Pay :</td> 
                <td><select name="payOnsite" id="payOnsite" style="width: 100px"><option></option><option value="N">No</option><option value="Y">Yes</option></select></td> 
                <td style="text-align: right;"><button class="search" onclick="search();">Find</button></td>
            </tr>            
        </table>
    </div>
    <div class="grid_panel" id="grid_panel"></div>

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
                    <button class="word10" onclick="registBoothRentFee();">+ Booth Rent Fee</button>
                </td>
            </tr>
        </table>
    </div>


</body>
</html>