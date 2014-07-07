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
    	retriveTableData();
    }
</script> 
<script type="text/javascript">    
	function getUserInfo(userId) {
	    var url = '/photome/business/money/collect/UserDetailInfo.action?userId=' + userId;
	    var windowName = 'sysAdmin/framework/UserDetailInfo';
	    var win = openPopupForm(url, windowName, '720', '540');
	}
    function viewGroupInfo(groupId) {
        var url = '/photome/business/money/collect/GroupInfo.action?groupId=' + groupId;
        var windowName = 'business/resmanage/group/GroupInfo';
        var win = openPopupForm(url, windowName, '720', '520');
    } 
    function viewBoothInfo(boothId) {
        var url = '/photome/business/money/collect/BoothInfo.action?boothId=' + boothId;
        var windowName = 'business/resmanage/booth/BoothInfo';
        var win = openPopupForm(url, windowName, '780', '560');
    } 
     function viewCollectInfo(collectId) {
         var url = '/photome/business/money/collect/MoneyCollectInfo.action?collectId=' + collectId;
         var windowName = 'business/money/collect/MoneyCollectInfo';
         var win = openPopupForm(url, windowName, '740', '540');
     }
     
    function makeMoneyCollect() {
         var url = '/photome/business/money/collect/MoneyCollectRegistForm.action';
         var windowName = 'business/money/collect/MoneyCollectRegistForm';
         var win = openPopupForm(url, windowName, '740', '450');
    }     
 </script>   
<script type="text/javascript">
	function retriveTableData() {
        var groupId       = $('#groupId').val();
        var collectYear   = $('#collectYear').val();
        
       /*if(groupId == '' || groupId == null){
            alert('You have to chose Group for search condition.');
            $('#groupId').focus();
            return;
        } */
        if(collectYear == '' || collectYear == null){
            alert('You have to chose Collect Year for search condition.');
            $('#collectYear').focus();
            return;
        }
        //search(groupId, collectYear);
        search(collectYear);
        
	}

    function search(collectYear) {

    	var groupId       = $('#groupId').val();
        var boothId       = $('#boothId').val();
        var collectStatus = $('#collectStatus').val();
        var collectMonth = $('#collectMonth').val();
        
        $.ajax({
            url : "/photome/business/money/collect/MoneyCollectList.action",
            data : {
                groupId  : groupId,
                collectYear  : collectYear,
                collectMonth  : collectMonth,
                boothId  : boothId,
                collectStatus : collectStatus
            },
            success : callbackSearch,
        });
        
        pageLog('data retirive complete','info');
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
                element[0] = obj.collectId;
                element[1] = obj.groupName;
                element[2] = obj.boothName;
                element[3] = obj.collectStatusName;
                element[4] = addCommas(obj.collectRealIncome);
                element[5] = addCommas(obj.bankAmount);
                element[6] = addCommas(obj.coinMtrNow);
                element[7] = addCommas(obj.coinMtrBfr);                
                element[8] = addCommas(obj.coinMtrIncome);                
                element[9] = addCommas(obj.collectAmtDiff);                
                element[10] = obj.collectDate.substr(0,10);
                element[11] = obj.bankDt;
                element[12] = obj.createDt.substr(0,16);
                element[13] = obj.collectStatus;
                arrayData[i] = element; 
            });
        }       
        
        var obj = {title: "<b>Money Collect</b> List", numberCell: false, editable: false,  freezeCols: 6, resizable:false, columnBorders: true, flexHeight:true}; 
        obj.width = "98%";
        obj.height = 500;
        obj.colModel = [
            {title:"<b>Id</b>",width:60, dataType:"integer", align: "center"}, 
            {title:'<b>Group</b>', width:110, dataType:"string"},
            {title:"<b>Booth</b>", width:200, dataType:"string",},
            {title:"<b>Status</b>", width:150, dataType:"string",
            	render: function (ui) {
                    var rowData = ui.rowData;
                    if (rowData[13] == 'COLLECTING') {
                      return '<font color="#FF0080">' + rowData[3] + '</font>';
                    } else if (rowData[13] == 'COLLECT_FINISH') {
                      return '<font color="#0000FF">' + rowData[3] + '</font>';
                    } else {
                      return rowData[4];
                    }
              } 	
            },
            {title:"<b>$ Collect</b>", width:120, dataType:"float", align: "right",
                render: function (ui) {
                    var rowData = ui.rowData;
                    return '<font color="#8000FF"><b>' + rowData[4] + '</b></font>';
                }
            }, 
            {title:"<b>$ Bank amt.</b>",width:100, dataType:"float", align: "right",
                render: function (ui) {
                    var rowData = ui.rowData;
                    return '<font color="#0080C0"><b>' + rowData[5] + '</b></font>';
                }
            }, 
            {title:"<b>Coin mtr</b>", width:120, dataType:"integer", align: "right"},
            {title:"<b>Coin mtr(bfr)</b>", width:120, dataType:"integer", align: "right"},
            {title:"<b>Coin mtr inc.</b>", width:120, dataType:"integer", align: "right",
                render: function (ui) {
                    var rowData = ui.rowData;
                    if (rowData[8] < 0 ) {
                      return "<img src='/photome/resources/images/common/arrow-down.gif'/>&nbsp;" + rowData[8];
                    } else if (rowData[8] == 0 ) {
                      return rowData[8];
                    } else {
                    	 return "<img src='/photome/resources/images/common/arrow-up.gif'/>&nbsp;" + rowData[8];
                    }
                }               },
            {title:"<b>Collect loss</b>", width:100, dataType:"integer", align: "right",
                    render: function (ui) {
                        var rowData = ui.rowData;
                        return '<font color="#9F0000">' + rowData[9] + '</font>';
                    }                	
            },
            {title:"<b>Collect Date</b>", width:100, dataType:"string",align: "center"},
            {title:"<b>Banking Date</b>", width:100, dataType:"string", align: "center"},
            {title:"<b>Write Date</b>", width:120, dataType:"string"},
            {title:'Hidden1(Status)', hidden:true},
            ];        
        
        obj.dataModel = {data:arrayData, sortIndx: 0, sortDir: "down", 
                location: "local",
                sorting: "local",
                paging: "local",
                dataType: "Array",
                curPage: 1,
                rPP: 15,
                rPPOptions: [10, 20, 30, 50] };
        obj.rowClick = function( event, ui ) {
            var rowData = ui.dataModel;
            var collectId = rowData.data[ui.rowIndx][0];
            viewCollectInfo(collectId);
        };

        $("#grid_panel").pqGrid(obj);        

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
            url : "/photome/business/money/collect/BoothListOfGroup.action",
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
                <td class="label"><span class="required">*</span>Status </td>
                <td><select name="collectStatus" id="collectStatus" style="width: 170px"><c:out value="${collectStatusOptions}" escapeXml="false"/></select></td>
                <td rowspan="2" style="text-align: right;vertical-align: bottom;"><button class="search" onclick="retriveTableData();">Find</button></td>
            </tr>
            <tr>
                <td class="label">Collect Year </td> 
                <td><select name="collectYear" id="collectYear" style="width: 100px"><c:out value="${yearOptions}" escapeXml="false" /></select></td>
                <td class="label">Month </td>
                <td colspan="3"><select name="collectMonth" id="collectMonth" style="width: 70px"><c:out value="${monthOptions}" escapeXml="false" /></select></td>
            </tr>
        </table>
    </div>
   <div class="grid_panel" id="grid_panel"></div>

    <div class="main_control">
        <table border="0" cellpadding="0" cellspacing="0" style="width: 98%;">
            <tr>
                <td style="text-align: right;">
                    <button class="word8" onclick="makeMoneyCollect();">Money Collect</button>
                </td>
            </tr>
        </table>
    </div>
       

</body>
</html>