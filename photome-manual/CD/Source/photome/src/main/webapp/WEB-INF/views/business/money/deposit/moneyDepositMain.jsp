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
    function search() {
    	searchCollectList();
    	searchDepositList();
    }
</script> 
 
 <script type="text/javascript">    
    function depositMoney() {
        var url = "/photome/business/money/deposit/BankDeposit.action";
        var windowName = 'business/money/deposit/BankDeposit';
        var win = openPopupForm(url, windowName, '910', '500');
    }
    function viewDepositInfo(depositId) {
        var url = "/photome/business/money/deposit/BankDepositInfo.action?depositId=" + depositId;
        var windowName = 'business/money/deposit/BankDepositInfo';
        var win = openPopupForm(url, windowName, '910', '500');
    }
</script> 

<script type="text/javascript">
    function searchCollectList() {
        $.ajax({
            url : "/photome/business/money/deposit/CollectListForDeposit.action",
            success : callbackSearchCollectList,
        });
        
    }
    
    function callbackSearchCollectList(data) {
    	
        var json = data.jsonList;
        var dataCnt = json.length;

        var arrayData = null;
        var element = null;
        
        if (dataCnt > 0) {
            
        	arrayData = new Array();
            $.each(json, function(i, obj) {
                element = new Array();
                element[0] = obj.groupName;
                element[1] = obj.boothName;
                element[2] = obj.collectDate.substr(0,10);
                element[3] = addCommas(obj.collectRealIncome);
                element[4] = addCommas(obj.coinMtrIncome);
                element[5] = obj.createDt.substr(0,16);
                element[6] = obj.collectId;
                arrayData[i] = element; 
            });
        }       
        
        var obj = {numberCell: false, editable: false,  freezeCols: 3, resizable:false, columnBorders: true, flexHeight:false};
        obj.width = "900";
        obj.height = 170;
        obj.colModel = [
            {title:'<b>Group</b>', width:150, dataType:"string"},
            {title:"<b>Booth</b>", width:200, dataType:"string",},
            {title:"<b>Collect Date</b>", width:150, dataType:"string",align: "center"},
            {title:"<b>$ Collect Amt</b>", width:120, dataType:"float", align: "right"}, 
            {title:"<b>Coin Mtr Income</b>", width:130, dataType:"integer", align: "right"},
            {title:"<b>Write Date</b>", width:180, dataType:"string"},
            {title:'Hidden1(ID)', hidden:true}
            ];        
        
        obj.dataModel = {data:arrayData, sortIndx: 2, sortDir: "down", 
                location: "local",
                sorting: "local",
                paging: "local",
                dataType: "Array",
                curPage: 1,
                rPP: 5,
                rPPOptions: [5] };
        obj.rowClick = function( event, ui ) {
            var rowData = ui.dataModel;
            var collectId = rowData.data[ui.rowIndx][6];
            //viewCollectInfo(collectId);
        };
        obj.topVisible = false;
        obj.scrollModel = {horizontal: false};
        $("#grid_panel").pqGrid(obj);        

    }
    
    function searchDepositList() {
        $.ajax({
            url : "/photome/business/money/deposit/DepositList.action",
            success : callbackSearchDepositList,
        });
    }
    function callbackSearchDepositList(data) {
        
        var json = data.jsonList;
        var dataCnt = json.length;

        var arrayData = null;
        var element = null;
        
        if (dataCnt > 0) {
            
            arrayData = new Array();
            $.each(json, function(i, obj) {
                element = new Array();
                element[0] = obj.bankDt;
                element[1] = addCommas(obj.bankTotalAmount);
                element[2] = obj.statusName;
                element[3] = obj.comment;
                element[4] = obj.depositId;
                element[5] = obj.status;
                arrayData[i] = element; 
            });
        }       
        
        var obj = {title: "<b>Bank Deposit</b> List", numberCell: false, editable: false,  freezeCols: 3, resizable:false, columnBorders: true, flexHeight:true};
        obj.width = "900";
        obj.height = 500;
        obj.colModel = [
            {title:'<b>Deposit Date</b>', width:150, dataType:"string"},
            {title:"<b>Deposit Amount</b>", width:200, dataType:"float", align: "right"},
            {title:"<b>Status</b>", width:150, dataType:"string",align: "center",
                render: function (ui) {
                    var rowData = ui.rowData;
                    if (rowData[5] == 'COLLECTING') {
                      return '<font color="#FF0080">' + rowData[2] + '</font>';
                    } else if (rowData[5] == 'COLLECT_FINISH') {
                      return '<font color="#0000FF">' + rowData[2] + '</font>';
                    } else {
                      return rowData[2];
                    }
              }     
           	},
            {title:"<b>Comment</b>", width:250, dataType:"string",align: "left"},
            {title:'Hidden1(ID)', hidden:true},
            {title:'Hidden1(Status)', hidden:true}
            ];        
        
        obj.dataModel = {data:arrayData, sortIndx: 0, sortDir: "up", 
                location: "local",
                sorting: "local",
                paging: "local",
                dataType: "Array",
                curPage: 1,
                rPP: 5,
                rPPOptions: [5, 10, 20] };
        obj.rowClick = function( event, ui ) {
            var rowData = ui.dataModel;
            var depositId = rowData.data[ui.rowIndx][4];
            viewDepositInfo(depositId);
        };
        $("#grid_panel_sub").pqGrid(obj);        

    }    
    
</script>

<script type="text/javascript">
    function setReturnValue(returnValue) {
        $('#svcName').val(returnValue.svcName);
        search();
    }
</script>

</head>
<body>

   <h2 class="ckbox"><font color='#0000FF'><b>Money Collect</b> List</font></h2>
   <div class="grid_panel" id="grid_panel" style="border-color: #800000;"></div>
   
   <div class="main_control">
        <table border="0" cellpadding="0" cellspacing="0" style="width: 900px;">
            <tr>
                <td style="text-align: right;">
                    <button class="word8" onclick="depositMoney();">Deposit Money</button>
                </td>
            </tr>
        </table>
   </div>
    
   <div class="grid_panel" id="grid_panel_sub"></div>       
   <br/>
</body>
</html>