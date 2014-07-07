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
	    var win = openPopupForm(url, windowName, '780', '700');
	} 
    function registBoothRentFee() {
        var url = '/photome/business/resmanage/booth/rentfee/BoothRentFeeRegistForm.action';
        var windowName = 'business/resmanage/booth/rentfee/BoothRentFeeRegistForm';
        var win = openPopupForm(url, windowName, '520', '270');
    }     
    function registGroupRentFee() {
        var url = '/photome/business/resmanage/booth/rentfee/GroupRentFeeRegistForm.action';
        var windowName = 'business/resmanage/booth/rentfee/GroupRentFeeRegistForm';
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
        var grpContractUnit    = $('#grpContractUnit').val();
        var groupId    = $('#groupId').val();
        var boothId    = $('#boothId').val();
        var rentYear   = $('#rentYear').val();
        var rentMonth  = $('#rentMonth').val();
        var rentFeeType   = $('#rentFeeType').val();
        var payOnsite  = $('#payOnsite').val();
        
        if(grpContractUnit == '' || grpContractUnit == null){
        	alert('You have to choose one of the Contract Unit.');
        	$('#grpContractUnit').focus();
        	return;
        }
        
        $.ajax({
            url : "/photome/business/resmanage/booth/rentfee/BoothRentFeeList.action",
            data : {
            	groupId    : groupId,
            	boothId    : boothId,
            	rentYear   : rentYear,
            	rentMonth  : rentMonth,
            	rentFeeType   : rentFeeType,
            	payOnsite  : payOnsite,
            	grpContractUnit  : grpContractUnit
            },
            success : function(data){
            	if(grpContractUnit == 'BOOTH'){
            		callbackSearch(data);
            	} else if(grpContractUnit == 'GROUP') {
            		callbackSearchGrp(data);
            	}
            }
        });
        
        pageLog('data retirive complete','info');
    }

    function callbackSearch(data) {
    	
    	var table_template = '<table id="table_data" class="dataTable">'
            + '<thead>'
            + '    <tr>'
            + '        <th width="20px">Del</th>'            
            + '        <th width="150px">Group</th>'
            + '        <th width="250px">Booth Name</th>'
            + '        <th width="100px">Year/Month</th>'
            + '        <th width="200px">Rent Type</th>'
            + '        <th width="130px">Pay onsite</th>'
            + '        <th width="100px">Rent Amount</th>'
            + '        <th width="*" align="left">Modify date</th>'
            + '        <th>hidden1</th>'
            + '        <th>hidden2</th>'
            + '    </tr>'
            + '</thead>'
            + '<tfoot>'
            + '    <tr>'
            + '        <th style="text-align:right" colspan="6">Total:</th>'
            + '        <th></th>'
            + '        <th></th>'
            + '        <th></th>'
            + '        <th></th>' 
            + '    </tr>'
            + '</tfoot>';
            
        $('#grid_array').html(table_template);
            
        var json = data.jsonList;
        var dataCnt = json.length;

        // 테이블의 타이틀 설정
        var colM = [ { title: "Del", width: 20, dataType: "string", align: "center" }, 
                     { title: "Group", width: 100, dataType: "string" },
                     { title: "Booth Name", width: 200, dataType: "string" },
                     { title: "Rent Year/Month", width: 800, dataType: "string" },
                     { title: "Rent Type", width: 80, dataType: "string", align: "right" },
                     { title: "Pay onsite", width: 50, dataType: "float", align: "right"},
                     { title: "Rent Amount", width: 100, dataType: "string", align: "right" },
                     { title: "Modify date", width: 100, dataType: "string", align: "left" }, 
                     { title: "hiden1",dataType: "float", align: "right"},
                     { title: "hiden2",dataType: "string", align: "right"}
                  ];        
        
        // 테이블 데이터 설정
        if (dataCnt > 0) {
            var data = new Array();
            var element = null;
            $.each(json, function(i, obj) { 
                 element = new Array();
                 element[0] = ('<a href=\"javascript:deleteBoothRentFeeInfo(\''+ obj.boothId + '\',\'' + obj.rentYear  + '\', \'' + obj.rentMonth + '\')\"> <img src="/photome/resources/images/common/icon_del_on.gif" border=0/> </a>');
                 element[1] = ('<a href=\"javascript:viewGroupInfo(\''+ obj.groupId + '\')\">' + obj.groupName + '</a>');
                 element[2] = ('<a href=\"javascript:viewBoothInfo(\''+ obj.boothId + '\')\">' + obj.boothName + '</a>');
                 element[3] = obj.rentYear + '/' + obj.rentMonth ;
                 element[4] = obj.rentFeeTypeName;
                 element[5] = (obj.payOnsite == 'N' ? 'No':'Pay onsite');
                 
                 if(obj.rentFeeType == 'PERCENT'){
                     element[6] = obj.rentPercent + '%';
                 }else if(obj.rentFeeType == 'FIXED_MONEY'){
                     element[6] = toCurrency(obj.rentAmount);
                 }else{
                     element[6] = '0';
                 }                 
                 element[7] = obj.modifyDt.substr(0,10); 
                 element[8] = obj.rentAmount;
                 element[9] = obj.rentFeeType;
                 data[i] = element;
            }); 
        } 
        
        $('#table_data').dataTable( {
            "aaData": data, 
            "aoColumns" : colM,
            "sPaginationType": "full_numbers",
            "fnFooterCallback": function ( nRow, aaData, iStart, iEnd, aiDisplay ) {
                var iTotal = 0;
                for ( var i=0 ; i<aaData.length ; i++ )
                {
                	// 렌트비 지급형태가 고정된 금액인경우만 합산한다.
                	if(aaData[i][9] == 'FIXED_MONEY'){
                	   iTotal += aaData[i][8]*1;
                	}
                }
                
                var nCells = nRow.getElementsByTagName('th');
                nCells[1].innerHTML  =  toCurrency(parseFloat(iTotal));
            },
            "aoColumnDefs": [ { "sClass":  "string", "aTargets": [7] },
                              { "bVisible": false, "aTargets": [8] },
                              { "bVisible": false, "aTargets": [9] } ]
            });
    }
    
    function callbackSearchGrp(data) {
        var table_template = '<table id="table_data" class="dataTable">'
            + '<thead>'
            + '    <tr>'
            + '        <th width="30px">Info</th>'            
            + '        <th width="150px">Group</th>'
            + '        <th width="100px">Year/Month</th>'
            + '        <th width="100px">Rent Amount</th>'
            + '        <th width="*" align="left">Modify date</th>'
            + '        <th>hidden1</th>'
            + '    </tr>'
            + '</thead>'
            + '<tfoot>'
            + '    <tr>'
            + '        <th style="text-align:right" colspan="3">Total:</th>'
            + '        <th></th>'
            + '        <th></th>' 
            + '        <th></th>' 
            + '    </tr>'
            + '</tfoot>';
            
        $('#grid_array').html(table_template);
            
        var json = data.jsonList;
        var dataCnt = json.length;

        // 테이블의 타이틀 설정
        var colM = [ { title: "Info", width: 80, dataType: "string", align: "left" }, 
                     { title: "Group", width: 100, dataType: "string" },
                     { title: "Rent Year/Month", width: 800, dataType: "string" },
                     { title: "Rent Amount", width: 100, dataType: "string", align: "right" },
                     { title: "Modify date", width: 100, dataType: "string", align: "left" }, 
                     { title: "hiden1",dataType: "float", align: "right"}
                  ];        
        
        // 테이블 데이터 설정
        if (dataCnt > 0) {
            var data = new Array();
            var element = null;
            $.each(json, function(i, obj) {
                 element = new Array();
                 element[0] = ('<a href=\"javascript:deleteGroupRentFeeInfo(\''+ obj.groupId + '\',\'' + obj.rentYear  + '\', \'' + obj.rentMonth + '\')\"> <img src="/photome/resources/images/common/icon_del_on.gif" border=0/> </a>');
                 element[1] = ('<a href=\"javascript:viewGroupInfo(\''+ obj.groupId + '\')\">' + obj.groupName + '</a>');
                 element[2] = obj.rentYear + '/' + obj.rentMonth ;
                 element[3] = toCurrency(obj.rentAmount);
                 element[4] = obj.modifyDt.substr(0,10); 
                 element[5] = obj.rentAmount;
                 data[i] = element;
            }); 
        } 
        
        $('#table_data').dataTable( {
            "aaData": data, 
            "aoColumns" : colM,
            "sPaginationType": "full_numbers",
            "fnFooterCallback": function ( nRow, aaData, iStart, iEnd, aiDisplay ) {
                var iTotal = 0;
                for ( var i=0 ; i<aaData.length ; i++ )
                {
                    iTotal += aaData[i][5]*1;
                }
                
                var nCells = nRow.getElementsByTagName('th');
                nCells[1].innerHTML  =  toCurrency(parseFloat(iTotal));
            },
            "aoColumnDefs": [ { "bVisible": false, "aTargets": [5] } ]
            });
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
                <td><select name="rentYear" id="rentYear" style="width: 100px"><c:out value="${yearOptions}" escapeXml="false"/></select>&nbsp;<select name="rentMonth" id="rentMonth" style="width: 60px"><c:out value="${monthOptions}" escapeXml="false"/></select></td>
                <td class="label">Rent Type </td>
                <td><select name="rentFeeType" id="rentFeeType" style="width: 100px"><c:out value="${rentFeeTypeOptions}" escapeXml="false"/></select></td>
                <td class="label">Onsite Pay :</td> 
                <td><select name="payOnsite" id="payOnsite" style="width: 100px"><option></option><option value="N">No</option><option value="Y">Yes</option></select></td> 
                <td class="label">Contract Unit :</td> 
                <td><select name="grpContractUnit" id="grpContractUnit" style="width: 200px"><c:out value="${grpContractUnitListOptions}" escapeXml="false"/></select></td> 
                <td style="text-align: right;"><button class="search" onclick="search();">Find</button></td>
            </tr>            
        </table>
    </div>
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
                    <button class="word10" onclick="registBoothRentFee();">+ Booth Rent Fee</button>
                    <button class="word10" onclick="registGroupRentFee();">+ Group Rent Fee</button>
                </td>
            </tr>
        </table>
    </div>


</body>
</html>