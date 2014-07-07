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
        var url = '/photome/business/money/manage/UserDetailInfo.action?userId=' + userId;
        var windowName = 'sysAdmin/framework/UserDetailInfo';
        var win = openPopupForm(url, windowName, '720', '540');
    }
    function viewGroupInfo(groupId) {
        var url = '/photome/business/money/manage/GroupInfo.action?groupId=' + groupId;
        var windowName = 'business/resmanage/group/GroupInfo';
        var win = openPopupForm(url, windowName, '720', '680');
    } 
    function viewBoothInfo(boothId) {
        var url = '/photome/business/money/manage/BoothInfo.action?boothId=' + boothId;
        var windowName = 'business/resmanage/booth/BoothInfo';
        var win = openPopupForm(url, windowName, '780', '670');
    } 
     function viewCollectInfo(collectId) {
         var url = '/photome/business/money/manage/MoneyCollectInfo.action?collectId=' + collectId;
         var windowName = 'business/money/manage/MoneyCollectInfo';
         var win = openPopupForm(url, windowName, '740', '540');
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
        var collectCollector = $('#collectCollector').val();
        
        $.ajax({
            url : "/photome/business/money/manage/MoneyCollectList.action",
            data : {
                groupId  : groupId,
                collectYear  : collectYear,
                collectMonth  : collectMonth,
                collectCollector  : collectCollector,
                boothId  : boothId,
                collectStatus : collectStatus
            },
            success : callbackSearch,
        });
        
        pageLog('data retirive complete','info');
    }

    function callbackSearch(data) {
    	
        var table_template = '<table id="table_data" class="dataTable">'
            + '<thead>'
            + '    <tr>'
            + '        <th width="30px">Info</th>'
            + '        <th width="100px">Group</th>'
            + '        <th width="150px">Booth</th>'
            + '        <th width="130px">Status</th>'
            + '        <th width="100px">Collect</th>'
            + '        <th width="100px">Bank</th>'
            + '        <th width="100px">Collect Dt</th>'
            + '        <th width="100px">Deposit Dt</th>'
            + '        <th width="100px">Collector</th>'
            + '        <th width="100px">Coin</th>'
            + '        <th width="100px">Coin(bfr)</th>'
            + '        <th width="100px">Coin income</th>'
            + '        <th width="100px">Diff</th>'
            + '        <th width="*">Onsite pay</th>'
            + '        <th>hidden1</th>'
            + '        <th>hidden2</th>'
            + '    </tr>'
            + '</thead>'
            + '<tfoot>'
            + '    <tr>'
            + '        <th style="text-align:right" colspan="3">Total:</th>'
            + '        <th></th>'
            + '        <th></th>'
            + '        <th colspan="10"></th>'
            + '    </tr>'
            + '</tfoot>';
            
    	$('#grid_array').html(table_template);
        
    	 var json = data.jsonList;
         var dataCnt = json.length;
         
         // 테이블의 타이틀 설정
         var colM = [ { title: "Info", width: 100, dataType: "string", align: "left" }, 
                      { title: "Group", width: 100, dataType: "string" },
                      { title: "Booth", width: 200, dataType: "string" },
                      { title: "Status", width: 150, dataType: "string", align: "right" },
                      { title: "Collect Amount", width: 100, dataType: "float", align: "right"},
                      { title: "Bank Deposit", width: 150, dataType: "date", align: "right" },
                      { title: "Collect Date", width: 100, dataType: "string", align: "right" }, 
                      { title: "Deposit Date", width: 100, dataType: "string", align: "right" },
                      { title: "Collector", width: 150, dataType: "string", align: "right" },
                      { title: "Coin meter", width: 150, dataType: "string", align: "right" },
                      { title: "Coin meter before", width: 150, dataType: "string", align: "right" },
                      { title: "Coin meter income", width: 150, dataType: "string", align: "right" },
                      { title: "Income diff", width: 150, dataType: "string", align: "right" },
                      { title: "Is onsite pay", width: 150, dataType: "string", align: "right" },
                      { title: "hiden1",dataType: "float", align: "right"},
                      { title: "hiden2",dataType: "float", align: "right"}
                   ];

         // 테이블 데이터 설정
         if (dataCnt > 0) {
             var data = new Array();
             var element = null;
             $.each(json, function(i, obj) {
                  element = new Array();
                  element[0] = ('<a href=\"javascript:viewCollectInfo(\''+ obj.collectId + '\')\"> <img src="/photome/resources/images/common/question.gif" border=0/> </a>');
                  element[1] = ('<a href=\"javascript:viewGroupInfo(\''+ obj.groupId + '\')\">' + obj.groupName + '</a>');
                  element[2] = ('<a href=\"javascript:viewBoothInfo(\''+ obj.boothId + '\')\">' + obj.boothName + '</a>');
                  var color = "#595959";
                  if(obj.collectStatus == 'COLLECTING'){
                	  color = "#CE0000";
                  } else if(obj.collectStatus == 'COLLECT_FINISH'){
                	  color = "#008000";
                  }
                  element[3] = ('<font color=\"' + color + '\">' + obj.collectStatusName + '</font>');
                  element[4] = toCurrency(obj.collectRealIncome);
                  element[5] = toCurrency(obj.bankAmount);
                  element[6] = obj.collectDate.substr(0,10);
                  element[7] = obj.bankDt;
                  element[8] = ('<a href=\"javascript:getUserInfo(\''+ obj.collectCollector + '\')\">' + obj.collectCollectorName + '</a>');
                  element[9] = obj.coinMtrNow;
                  element[10] = obj.coinMtrBfr;
                  element[11] = obj.coinMtrIncome;
                  element[12] = obj.collectAmtDiff;
                  element[13] = obj.payOnsite;
                  element[14] = obj.collectRealIncome;
                  element[15] = obj.bankAmount;
                  data[i] = element;
             }); 
         } 
         
         $('#table_data').dataTable( {
        	        "sScrollX": "90%",
        	        "sScrollXInner": "150%",
        	        "bScrollCollapse": true,
	        	    "aaData": data, 
	        	    "aoColumns" : colM,
	        	    "sPaginationType": "full_numbers",
                    "fnFooterCallback": function ( nRow, aaData, iStart, iEnd, aiDisplay ) {
                        var iTotalCollect = 0;
                        var iTotalDeposit = 0;
                        for ( var i=0 ; i<aaData.length ; i++ )
                        {
                            iTotalCollect += aaData[i][14]*1;
                            iTotalDeposit += aaData[i][15]*1;
                        }
                        
                        var nCells = nRow.getElementsByTagName('th');
                        nCells[1].innerHTML  =  toCurrency(parseFloat(iTotalCollect));
                        nCells[2].innerHTML  =  toCurrency(parseFloat(iTotalDeposit));
                    },
                    "aoColumnDefs": [ { "sClass":  "left", "aTargets": [2] },
                                      { "sClass":  "right",  "aTargets": [3] },
                                      { "sClass":  "right",  "aTargets": [4] },
                                      { "sClass":  "right", "aTargets": [5] },
                                      { "sClass":  "left", "aTargets": [7] },
                                      { "bVisible": false, "aTargets": [14] },
                                      { "bVisible": false, "aTargets": [15] } ]
         });
    }
    
</script>

<script type="text/javascript">
    function setReturnValue(returnValue) {
    	pageLog("Updated", "info");
        $('#svcName').val(returnValue.svcName);
        search();
    }
</script>
<script type="text/javascript">
    function setBooth(group){
        var groupId = group.value;
        $.ajax({
            url : "/photome/business/money/manage/BoothListOfGroup.action",
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
                <td class="label"><span class="required">*</span>Collect Year </td> 
                <td><select name="collectYear" id="collectYear" style="width: 100px"><c:out value="${yearOptions}" escapeXml="false" /></select></td>
                <td class="label">Money Collector </td>
                <td><select name="collectCollector" id="collectCollector" style="width: 170px"><c:out value="${collectCollectorOptions}" escapeXml="false" /></select></td>
                <td class="label">Month </td>
                <td><select name="collectMonth" id="collectMonth" style="width: 70px"><c:out value="${monthOptions}" escapeXml="false" /></select></td>
            </tr>
        </table>
    </div>
    <div id="grid_array"></div>
    <br/>
    <br/>

</body>
</html>