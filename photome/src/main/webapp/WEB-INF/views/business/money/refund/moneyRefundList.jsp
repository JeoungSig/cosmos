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
        var win = openPopupForm(url, windowName, '720', '520');
    } 
    function viewBoothInfo(boothId) {
        var url = '/photome/business/money/refund/BoothInfo.action?boothId=' + boothId;
        var windowName = 'business/resmanage/booth/BoothInfo';
        var win = openPopupForm(url, windowName, '780', '560');
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
        var json = data.jsonList;
        var dataCnt = json.length;

        var arrayData = null;
        var element = null;
        
        if (dataCnt > 0) {
            
            arrayData = new Array();
            $.each(json, function(i, obj) {
                element = new Array();
                element[0] = obj.reqDt;
                element[1] = obj.refundStatusName;
                element[2] = obj.groupName;
                element[3] = obj.boothName;
                element[4] = obj.refundAmount;
                element[5] = obj.refundDt;
                element[6] = obj.reqLastname;
                element[7] = obj.reqFirstname;
                element[8] = obj.reqStreetNo;
                element[9] = obj.reqSuburb;
                element[10] = obj.reqState + '/' + obj.reqPostcd;
                element[11] = obj.refundStatus;
                element[12] = obj.refundId;
                arrayData[i] = element; 
            });
        }

        var summaryData;
        var refundAmtTotal = 0;
        
        function calculateSummary() {
        	var footerSummary;
            var refundAmt = 0;
            
            if (dataCnt > 0) {
	            for (var i = 0; i < arrayData.length; i++) {
	                var row = arrayData[i];
	                refundAmt = parseFloat(row[4].replace(/,/gi, ""));
	                //refundAmtTotal += refundAmt;
	                if(!isNaN(refundAmt)) {
                         var sum1 = refundAmt;
                         var sum2 = refundAmtTotal;
                         var totSum = Number(sum1) + Number(sum2);
                         refundAmtTotal = Math.round(totSum*100)/100;
                    }
	            }
            }
            if(refundAmtTotal == null || refundAmtTotal == '' || isNaN(refundAmtTotal)) refundAmtTotal = '0';
            footerSummary = ["<b>Total</b>","","","<div style=\"text-align: right;\">Total refund :</div>","<font color='#0000FF'><b><div id=\"refundAmtTotal\" style=\"text-align: left;\">$ " + addCommas(refundAmtTotal) + "</div></b></font>","","","","", "",""];
            
            refundAmtTotal = addCommas(refundAmtTotal);
            return footerSummary;
        }
        
        summaryData = calculateSummary();
        

        var obj = {title: "<b>Refund</b> List", numberCell: false, editable: false,  freezeCols: 5, resizable:false, columnBorders: true, flexHeight:true};
        obj.width = "98%";
        obj.height = 500;
        obj.colModel = [
            {title:'<b>Request Date</b>', width:150, dataType:"string"},
            {title:"<b>Status</b>", width:100, dataType:"string",
                render: function (ui) {
                    var rowData = ui.rowData;
                    if (rowData[11] == 'ACCEPT') {
                      return '<font color="#E60073">' + rowData[1] + '</font>';
                    } else if (rowData[11] == 'REFUND') {
                      return '<font color="#008000">' + rowData[1] + '</font>';
                    } else  {
                    	 return rowData[1];
                    }
              }               	
            	},
            {title:"<b>Group</b>", width:150, dataType:"string"},
            {title:"<b>Booth</b>", width:250, dataType:"string"},
            {title:"<b>Refund Amt ($)</b>", width:120, dataType:"integer", align: "right",
                render: function (ui) {
                    var rowData = ui.rowData;
                    return '<font color="#F9007C"><b>' + addCommas(rowData[4]) + '</b></font>';
              }             	
            	},
            {title:"<b>Refund Date</b>", width:150, dataType:"string",align: "center"},
            {title:"<b>Last Name</b>", width:150, dataType:"string"},
            {title:"<b>First Name</b>", width:150, dataType:"string"},
            {title:"<b>Address</b>", width:190, dataType:"string"},
            {title:"<b>Suburb</b>", width:190, dataType:"string"},
            {title:"<b>State/P.C</b>", width:100, dataType:"string"},
            {title:'Hidden1(refundStatus)', hidden:true},
            {title:'Hidden2(refundId)', hidden:true}
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
            var refundId = rowData.data[ui.rowIndx][12];
            viewRefundInfo(refundId);
        };
        
        var $summary = "";
        obj.render = function (evt, ui) {
            $summary = $("<div class='pq-grid-summary'></div>").prependTo($(".pq-grid-bottom", this));
            //calculateSummary();
        }

        obj.cellSave = function (ui) {
            //calculateSummary();
            obj.refresh();
        }
        obj.refresh = function (evt, ui) {
           var footerData = [summaryData];
           var footerObj = { data: footerData, $cont: $summary }
           $grid.pqGrid("createTable", footerObj);
       }
     
       var $grid = $("#grid_panel").pqGrid(obj);
        //$("#grid_panel").pqGrid(obj);
       setTotalValue('refundAmtTotal', '$ ' + refundAmtTotal);
    }
    function setTotalValue(id, value){
        var id = '#' + id;
        $(id).text(value);
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
    
   <div class="grid_panel" id="grid_panel"></div>
   <br/><br/>
   
   <div class="main_control">
        <table border="0" cellpadding="0" cellspacing="0" style="width: 98%;">
            <tr>
                <td style="text-align: right;">
                    <button class="word8" onclick="makeRefund();">Write Refund</button>
                </td>
            </tr>
        </table>
    </div>
    
 
</body>
</html>