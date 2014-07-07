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
        search("9999", "9999");
    }
</script> 
<script type="text/javascript">    
    function getUserInfo(userId) {
        var url = '/photome/business/money/manage/UserDetailInfo.action?userId=' + userId;
        var windowName = 'sysAdmin/framework/UserDetailInfo';
        var win = openPopupForm(url, windowName, '720', '540');
    }
    function viewBoothInfo(boothId) {
        var url = '/photome/business/money/manage/BoothInfo.action?boothId=' + boothId;
        var windowName = 'business/resmanage/booth/BoothInfo';
        var win = openPopupForm(url, windowName, '780', '670');
    } 
    
    function viewRentPayInfo(groupId,year,month) {
        var url = '/photome/business/money/manage/boothrentfeepay/BoothRentFeePayInfo.action?groupId=' + groupId + '&year=' + year + '&month=' + month;
        var windowName = 'business/money/manage/boothrentfeepay/BoothRentFeePayInfo';
        var win = openPopupForm(url, windowName, '740', '340');
    }
    function viewGroupInfo(groupId) {
        var url = '/photome/business/money/manage/boothrentfeepay/GroupInfo.action?groupId=' + groupId;
        var windowName = 'business/resmanage/group/GroupInfo';
        var win = openPopupForm(url, windowName, '720', '680');
    } 
    function makeRentFee() {
        var url = '/photome/business/money/manage/boothrentfeepay/BoothRentFeePayRegistForm.action';
        var windowName = 'business/money/manage/boothrentfeepay/BoothRentFeePayRegistForm';
        var win = openPopupForm(url, windowName, '740', '340');
   }     
 </script>   
<script type="text/javascript">
    function search() {
        var groupId = $('#groupId').val();
        var year    = $('#year').val();
        var month   = $('#month').val();
        var status  = $('#status').val();
        
        $.ajax({
            url : "/photome/business/money/manage/boothrentfeepay/BoothRentFeePayFeeList.action",
            data : {
                groupId  : groupId,
                year  : year,
                month  : month,
                status  : status
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
            + '        <th width="150px">Group</th>'
            + '        <th width="350px">Group Contact Info</th>'
            + '        <th width="100px">Year/Month</th>'
            + '        <th width="120px">Rent Fee</th>'
            + '        <th width="*" align="left">Status</th>'
            + '        <th>hidden1</th>'
            + '    </tr>'
            + '</thead>'
            + '<tfoot>'
            + '    <tr>'
            + '        <th style="text-align:right" colspan="3">Total:</th>'
            + '        <th style="text-align:center"></th>'
            + '        <th colspan="3"></th>'
            + '    </tr>'
            + '</tfoot>';
            
        $('#grid_array').html(table_template);
        
         var json = data.jsonList;
         var dataCnt = json.length;
         
         // 테이블의 타이틀 설정
         var colM = [ { title: "Info", width: 30, dataType: "string", align: "center" }, 
                      { title: "Group", width: 150, dataType: "string" },
                      { title: "Group Contact Info", width: 350, dataType: "string" },
                      { title: "Year/month", width: 100, dataType: "string", align: "right" },
                      { title: "Rent Fee", width: 120, dataType: "date", align: "right" },
                      { title: "Status", dataType: "string", align: "left" },
                      { title: "hidden1", dataType: "string", align: "left" }
                   ];

         // 테이블 데이터 설정
         if (dataCnt > 0) {
             var data = new Array();
             var element = null;
             $.each(json, function(i, obj) {
                  element = new Array();
                  element[0] = ('<a href=\"javascript:viewRentPayInfo(\''+ obj.groupId + '\',\'' + obj.year + '\',\'' +  obj.month  + '\')\"> <img src="/photome/resources/images/common/question.gif" border=0/> </a>');
                  element[1] = ('<a href=\"javascript:viewGroupInfo(\''+ obj.groupId + '\')\">' + obj.groupName + '</a>');
                  element[2] = (obj.managerName + '/' + obj.managerTel + '/' + obj.managerMobile + '/' + obj.managerEmail);
                  element[3] = decode(obj.year,'-') + '/' + decode(obj.month,'-');
                  element[4] = toCurrency(obj.rentFee);

                  var statusFont = '';
                  if(obj.status != null && obj.status != ''){
                	  if(obj.status == 'PAID'){
                		  statusFont = '<font color="#008000">' + obj.statusName + '</font>';
                	  }else{
                		  statusFont = '<font color="#FF00800">' + obj.statusName + '</font>';
                	  }
                  }
                  element[5] = statusFont;
                  
                  element[6] = decode(obj.rentFee,0);
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
                 var iTotalFee = 0;
                 for ( var i=0 ; i<aaData.length ; i++ )
                 {
                	 if(aaData[i][6] != '' && aaData[i][6] != null){
                	     iTotalFee += aaData[i][6]*1;
                	 }
                 }
                 
                 var nCells = nRow.getElementsByTagName('th');
                 nCells[1].innerHTML  =  toCurrency(parseFloat(iTotalFee));
             },             
             "aoColumnDefs": [ { "sClass":  "left",  "aTargets": [1] },
                               { "sClass":  "left",  "aTargets": [2] },
                               { "sClass":  "left",  "aTargets": [3] },
                               { "sClass":  "right", "aTargets": [4] },
                               { "sClass":  "left",  "aTargets": [5] },
                               { "bVisible": false,  "aTargets": [6] }]
          });
    }
    
</script>

<script type="text/javascript">
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
                <td class="label">Group :</td>
                <td><select name="groupId" id="groupId" style="width: 100px"><c:out value="${groupListOptions}" escapeXml="false"/></select></td>
                <td class="label">Year/Month :</td>
                <td>
                    <select name="year" id="year" style="width: 100px"><c:out value="${yearOptions}" escapeXml="false"/></select>
                    <select name="month" id="month" style="width: 100px"><c:out value="${monthOptions}" escapeXml="false"/></select>
                </td>
                <td class="label">Status :</td>
                <td><select name="status" id="status" style="width: 100px"><c:out value="${payRentStatusOptions}" escapeXml="false"/></select></td>
                <td style="text-align: right;vertical-align: bottom;"><button class="search" onclick="search();">Find</button></td>
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
                    <button class="word8" onclick="makeRentFee();">Pay Rent Fee</button> 
                </td>
            </tr>
        </table>
    </div>  
</body>
</html>