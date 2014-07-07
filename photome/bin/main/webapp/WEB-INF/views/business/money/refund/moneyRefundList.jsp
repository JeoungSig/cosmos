<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript">
    $(document).ready(function() {

        // Datepicker 설정
        $(function() {
            var option = {
                  changeMonth: true,
                  dateFormat: 'dd/mm/yy',
                  yearRange:'1940:+0',
                  changeYear: true
                };
            $("#fromReqDt").datepicker(option);
            $("#toReqDt").datepicker(option);
        });
        
        setDate();
    });  
</script>

<script type="text/javascript"> 
    function loadPage() { 
    	retriveTableData();
    }
    function setDate() {
        var t = new Date();
        var tDate = t.getDate();
        var tMonth = (t.getMonth()+1);
        if(tMonth < 10) tMonth = '0' + tMonth;
        var tYear = t.getFullYear();
        $('#toReqDt').val(tDate + '/' + tMonth + '/' + tYear);
        
        var f = new Date(Date.parse(t)-30 * 1000 * 60 * 60 * 24);
        var fDate = f.getDate()
        var fMonth = (f.getMonth()+1);
        if(fMonth < 10) fMonth = '0' + fMonth;
        var fYear = f.getFullYear();
         
        $('#fromReqDt').val(fDate + '/' + fMonth + '/' + fYear); 
    }
    
</script> 
<script type="text/javascript">    
    function getUserInfo(userId) {
        var url = '/photome/business/money/manage/UserDetailInfo.action?userId=' + userId;
        var windowName = 'sysAdmin/framework/UserDetailInfo';
        var win = openPopupForm(url, windowName, '720', '540');
    }

    function viewRefundInfo(refundId) {
        var url = '/photome/business/money/refund/MoneyRefundInfo.action?refundId=' + refundId;
        var windowName = 'business/money/refund/MoneyRefundInfo';
        var win = openPopupForm(url, windowName, '740', '540');
    }
    function viewGroupInfo(groupId) {
        var url = '/photome/business/money/refund/GroupInfo.action?groupId=' + groupId;
        var windowName = 'business/resmanage/group/GroupInfo';
        var win = openPopupForm(url, windowName, '720', '680');
    } 
    function viewBoothInfo(boothId) {
        var url = '/photome/business/money/refund/BoothInfo.action?boothId=' + boothId;
        var windowName = 'business/resmanage/booth/BoothInfo';
        var win = openPopupForm(url, windowName, '780', '670');
    } 
    function makeRefund() {
        var url = '/photome/business/money/refund/MoneyRefundRegistForm.action';
        var windowName = 'business/money/refund/MoneyRefundRegistForm';
        var win = openPopupForm(url, windowName, '740', '540');
   }     
 </script>   
<script type="text/javascript">
	function retriveTableData() {
		setDate();
        search();
	}
    function search() {
        var groupId = $('#groupId').val();
        var boothId = $('#boothId').val();
        var fromReqDt = $('#fromReqDt').val();
        var toReqDt   = $('#toReqDt').val();
        var reqState  = $('#reqState').val();
        var refundStatus  = $('#refundStatus').val();
        
        $.ajax({
            url : "/photome/business/money/refund/RefundList.action",
            data : {
                groupId  : groupId,
                boothId  : boothId,
                fromReqDt  : fromReqDt,
                toReqDt  : toReqDt,
                reqState  : reqState,
                refundStatus  : refundStatus
            },
            success : callbackSearch,
        });
        
        pageLog('data retirive complete','info');
    }

    function callbackSearch(data) {
        
        var table_template = '<table id="table_data" class="dataTable">'
            + '<thead>'
            + '    <tr>'
            + '        <th>Info</th>'
            + '        <th>Date</th>'
            + '        <th>Status</th>'
            + '        <th>Group/booth</th>'
            + '        <th>Last Name</th>'
            + '        <th>First Name</th>'
            + '        <th>Addess</th>'
            + '        <th>Suburb</th>'
            + '        <th>State/P.C</th>'
            + '        <th>Refund Amount</th>'
            + '        <th>Refund Date</th>'
            + '        <th>hidden1</th>'
            + '    </tr>'
            + '</thead>'
            + '<tfoot>'
            + '    <tr>'
            + '        <th style="text-align:right" colspan="8">Total:</th>'
            + '        <th style="text-align:center"></th>'
            + '        <th></th>'
            + '    </tr>'
            + '</tfoot>';
            
        $('#grid_array').html(table_template);
        
         var json = data.jsonList;
         var dataCnt = json.length;
         
         // 테이블의 타이틀 설정
         var colM = [ { title: "Info", width: 30, dataType: "string", align: "center" }, 
                      { title: "Date", width: 90, dataType: "string" },
                      { title: "Status", width: 90, dataType: "string" },
                      { title: "Group/booth", width: 90, dataType: "string" },
                      { title: "Last Name", width: 100, dataType: "string" },
                      { title: "First Name", width: 130, dataType: "string", align: "right" },
                      { title: "Address", width: 150, dataType: "date", align: "right" },
                      { title: "Suburb", width: 150, dataType: "date", align: "right" },
                      { title: "State/P.C", width: 100, dataType: "string", align: "left" },
                      { title: "Refund Amount", width: 100, dataType: "string", align: "right" },
                      { title: "Refund Date", width: 100, dataType: "string", align: "left" },
                      { title: "hidden1", dataType: "string", align: "left" }
                   ];

         // 테이블 데이터 설정
         if (dataCnt > 0) {
             var data = new Array();
             var element = null;
             var statusColor = "#000000";
             $.each(json, function(i, obj) {
            	  if(obj.refundStatus == 'ACCEPT') {
            		 statusColor = "#E60073";
            	  } else  if(obj.refundStatus == 'REFUND') {
            		 statusColor = "#008000";
            	  } else  if(obj.refundStatus == 'REJECT') {
            		  statusColor = "#000000";
            	  }
            	 
                  element = new Array();
                  element[0] = ('<a href=\"javascript:viewRefundInfo(\''+ obj.refundId + '\')\"> <img src="/photome/resources/images/common/question.gif" border=0/> </a>');
                  element[1] = obj.reqDt;
                  element[2] = '<font color=\'' + statusColor + '\'>' + obj.refundStatusName + '</font>';
                  element[3] = '<a href="javascript:viewGroupInfo(\'' + obj.groupId + '\')" style="text-decoration: none;"> <font color=\'#D9006C\'>' + obj.groupName + '</font><a>' 
                      +  '/' + '<a href="javascript:viewBoothInfo(\'' + obj.boothId + '\')" style="text-decoration: none;">' + obj.boothName + ' </a>' ;
                  element[4] = obj.reqLastname;
                  element[5] = obj.reqFirstname;
                  element[6] = obj.reqStreetNo;
                  element[7] = obj.reqSuburb;
                  element[8] = obj.reqState + '/' + obj.reqPostcd;
                  element[9] = toCurrency(obj.refundAmount);
                  element[10] = obj.refundDt;
                  element[11] = obj.refundAmount;
                  data[i] = element;
             }); 
         } 
         
         $('#table_data').dataTable( {
        	 "sScrollX": "90%",
             "sScrollXInner": "100%",
             "bScrollCollapse": true,
             "aaData": data, 
             "aoColumns" : colM,
             "sPaginationType": "full_numbers",
             "fnFooterCallback": function ( nRow, aaData, iStart, iEnd, aiDisplay ) {
                 var iTotalRefund = 0;
                 for ( var i=0 ; i<aaData.length ; i++ )
                 {
                	 if(aaData[i][11] != '' && aaData[i][11] != null){
                		 iTotalRefund += aaData[i][11]*1;
                	 }
                 }
                 
                 var nCells = nRow.getElementsByTagName('th');
                 nCells[1].innerHTML  =  toCurrency(parseFloat(iTotalRefund));
             },             
             "aoColumnDefs": [ { "sClass":  "right",  "aTargets": [9] },
                               { "bVisible": false,   "aTargets": [11] }]
          });
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
        <table class="search_table">
            <tr>
                <td class="label">Group </td> 
                <td><select name="groupId" id="groupId" style="width: 150px" onChange="setBooth(this)"><c:out value="${groupListOptions}" escapeXml="false" /></select></td>
                <td class="label">Booth </td>
                <td><select name="boothId" id="boothId" style="width: 250px"></select></td>
                <td class="label"><span class="required">*</span>Status </td>
                <td><select name="refundStatus" id="refundStatus" style="width: 170px"><c:out value="${refundStatusListOptions}" escapeXml="false"/></select></td>
                <td rowspan="2" style="text-align: right;vertical-align: bottom;"><button class="search" onclick="search();">Find</button></td>
            </tr>
            <tr>
                <td class="label">Date </td> 
                <td>
                    <input id="fromReqDt" name="fromReqDt" style="width: 100px;background-color: #E5E5E5;" readonly="readonly"  mandatory="true" /> ~
                    <input id="toReqDt" name="toReqDt" style="width: 100px;background-color: #E5E5E5;" readonly="readonly"  mandatory="true" /> 
                </td>
                <td class="label">State </td>
                <td colspan="3"><select name="reqState" id="reqState" style="width: 150px" ><c:out value="${stateListOptions}" escapeXml="false" /></select></td>
            </tr>
        </table>
    </div>
    
    <div id="grid_array"></div>
    <br/>
    <br/>
    <div id="main_control" class="main_control">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="*" align="right">
                    <button class="word8" onclick="makeRefund();">Write Refund</button>
                </td>
            </tr>
        </table>
    </div>  
</body>
</html>