<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<style type="text/css"> 
    div.pq-grid-summary{
        height:21px;border-bottom:1px solid #ddd;border-top:1px solid #fff;position:relative;
    }
    div.pq-grid-summary table.pq-grid-table{
        position:absolute;top:0px;
    }
</style>

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
        var win = openPopupForm(url, windowName, '780', '560');
    } 
    
    function viewRentPayInfo(groupId,year,month) {
        var url = '/photome/business/money/manage/boothrentfeepay/BoothRentFeePayInfo.action?groupId=' + groupId + '&year=' + year + '&month=' + month;
        var windowName = 'business/money/manage/boothrentfeepay/BoothRentFeePayInfo';
        var win = openPopupForm(url, windowName, '740', '340');
    }
    function viewGroupInfo(groupId) {
        var url = '/photome/business/money/manage/boothrentfeepay/GroupInfo.action?groupId=' + groupId;
        var windowName = 'business/resmanage/group/GroupInfo';
        var win = openPopupForm(url, windowName, '720', '520');
    } 
    function makeRentFee() {
        var url = '/photome/business/money/manage/boothrentfeepay/BoothRentFeePayRegistForm.action';
        var windowName = 'business/money/manage/boothrentfeepay/BoothRentFeePayRegistForm';
        var win = openPopupForm(url, windowName, '740', '340');
   }     
    function viewPayStatus() {
        var url = '/photome/business/money/manage/boothrentfeepay/RenFeePayStatus.action';
        var windowName = 'business/money/manage/boothrentfeepay/RenFeePayStatus';
        var win = openPopupForm(url, windowName, '1350', '540');
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

    	var json = data.jsonList;
         var dataCnt = json.length;
         
         var arrayData = null;
         var element = null;
         
         if (dataCnt > 0) {
             
             arrayData = new Array();
             $.each(json, function(i, obj) {
                 element = new Array();
                 element[0] = obj.groupName;
                 element[1] = decode(obj.year,'-') + '/' + decode(obj.month,'-');
                 element[2] = addCommas(obj.rentFee);
                 element[3] = obj.statusName;
                 element[4] = (obj.managerName + ' / ' + obj.managerTel + ' / ' + obj.managerMobile + ' / ' + obj.managerEmail);
                 element[5] = obj.status;
                 element[6] = obj.groupId;
                 element[7] = obj.year;
                 element[8] = obj.month;
                 arrayData[i] = element; 
             });
         }

         var summaryData;
         var rentFeeTotal = 0;
         
         function calculateSummary() {
        	 var footerSummary;
        	 var rentFee = 0;
        	 
        	 if (dataCnt > 0) {
	             for (var i = 0; i < arrayData.length; i++) {
	                 var row = arrayData[i];
	                 rentFee = parseFloat(row[2].replace(/,/gi, ""));
	                 //if(!isNaN(rentFee)) rentFeeTotal = parseFloat(rentFeeTotal) + parseFloat(rentFee);
	                 if(!isNaN(rentFee)) {
	                	 var sum1 = rentFee;
	                	 var sum2 = rentFeeTotal;
	                	 var totSum = Number(sum1) + Number(sum2);
	                	 rentFeeTotal = Math.round(totSum*100)/100;
	                 }
	             }
        	 }
             if(rentFeeTotal == null || rentFeeTotal == '' || isNaN(rentFeeTotal)) rentFeeTotal = '0';
             footerSummary = ["<b>Total : </b>","<div style=\"text-align: right;\">Total Rentfee :</div>","<font color='#0000FF'><b><div id=\"rentFeeTotal\" style=\"text-align: left;\">$ " + addCommas(rentFeeTotal) + "</div></b></font>", "",""];
             
             rentFeeTotal = addCommas(rentFeeTotal);
             return footerSummary;
             
         }
         summaryData = calculateSummary();
         
         var obj = {title: "<b>Rent Fee</b> List", numberCell: false, editable: false,  freezeCols: 3, resizable:false, columnBorders: true, flexHeight:true};
         obj.width = "98%";
         obj.height = 500;
         obj.colModel = [
             {title:'<b>Group</b>', width:200, dataType:"string"},
             {title:"<b>Year/Month</b>", width:150, dataType:"string", align: "center"},
             {title:"<b>Rent Fee($)</b>", width:150, dataType:"integer", align: "right",
                 render: function (ui) {
                     var rowData = ui.rowData;
                	 return '<font color="#0080C0"><b>' + rowData[2] + '</b></font>';
               }             	 
             },
             {title:"<b>Status</b>", width:150, dataType:"string",align: "center",
                 render: function (ui) {
                     var rowData = ui.rowData;
                     if (rowData[5] == 'PAID') {
                       return '<font color="#008000">' + rowData[3] + '</font>';
                     } else {
                       return '<font color="#FF00800">' + rowData[3] + '</font>';
                     }
               }     
             },
             {title:"<b>Contact Info</b>", width:450, dataType:"string"},
             {title:'Hidden1(Status)', hidden:true},
             {title:'Hidden2(groupId)', hidden:true},
             {title:'Hidden3(year)', hidden:true},
             {title:'Hidden4(month)', hidden:true}
             ];       

         obj.dataModel = {data:arrayData, sortIndx: 1, sortDir: "down", 
                 location: "local",
                 sorting: "local",
                 paging: "local",
                 dataType: "Array",
                 curPage: 1,
                 rPP: 15,
                 rPPOptions: [10, 20, 30, 50] };
         obj.rowClick = function( event, ui ) {
             var rowData = ui.dataModel;
             var groupId = rowData.data[ui.rowIndx][6];
             var year = rowData.data[ui.rowIndx][7];
             var month = rowData.data[ui.rowIndx][8];
             viewRentPayInfo(groupId,year,month);
         };
         
         var $summary = "";
         obj.render = function (evt, ui) {
             $summary = $("<div class='pq-grid-summary'></div>").prependTo($(".pq-grid-bottom", this));
             //calculateSummary();
         }

         obj.refresh = function (evt, ui) {
            var footerData = [summaryData];
            var footerObj = { data: footerData, $cont: $summary }
            $grid.pqGrid("createTable", footerObj);
        }
      
        var $grid = $("#grid_panel").pqGrid(obj);
         //$("#grid_panel").pqGrid(obj);
         
        setTotalValue('rentFeeTotal', '$ ' + rentFeeTotal);
    }
    function setTotalValue(id, value){
        var id = '#' + id;
        $(id).text(value);
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
    
    <div class="grid_panel" id="grid_panel"></div>
    
    <div class="main_control">
        <table border="0" cellpadding="0" cellspacing="0" style="width: 98%;">
            <tr>
                <td style="text-align: right;">
                    <button class="word8" onclick="makeRentFee();">Pay Rent Fee</button>
                    <button class="word10" onclick="viewPayStatus();">View pay status</button>
                </td>
            </tr>
        </table>
    </div>
        

</body>
</html>