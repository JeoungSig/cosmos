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
    function viewDepositInfo(depositId) {
        var url = "/photome/business/money/manage/deposit/BankDepositInfo.action?depositId=" + depositId;
        var windowName = 'business/money/manage/deposit/BankDepositInfo';
        var win = openPopupForm(url, windowName, '910', '500');
    }
</script> 

<script type="text/javascript">
    
    function search() {
    	
        var bankYear = $('#bankYear').val();
        var bankMonth = $('#bankMonth').val();
        var status = $('#status').val();
        var creator = $('#creator').val();

        
        $.ajax({
            url : "/photome/business/money/manage/deposit/DepositList.action",
            data : {
            	bankYear  : bankYear,
            	bankMonth  : bankMonth,
            	status  : status,
            	creator  : creator
            },
            success : callbackSearch,
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
                element[0] = obj.bankDt;
                element[1] = addCommas(obj.bankTotalAmount);
                element[2] = obj.statusName;
                element[3] = obj.creatorName;
                element[4] = obj.comment;
                element[5] = obj.depositId;
                element[6] = obj.status;
                arrayData[i] = element; 
            });
        }       
        
        var obj = {title: "<b>Bank Deposit</b> List", numberCell: false, editable: false,  freezeCols: 3, resizable:false, columnBorders: true, flexHeight:true};
        obj.width = "1200";
        obj.height = 500;
        obj.colModel = [
            {title:'<b>Deposit Date</b>', width:150, dataType:"string"},
            {title:"<b>Deposit Amount</b>", width:200, dataType:"float", align: "right"},
            {title:"<b>Status</b>", width:150, dataType:"string",align: "center",
                render: function (ui) {
                    var rowData = ui.rowData;
                    if (rowData[6] == 'COLLECTING') {
                      return '<font color="#FF0080">' + rowData[2] + '</font>';
                    } else if (rowData[6] == 'COLLECT_FINISH') {
                      return '<font color="#0000FF">' + rowData[2] + '</font>';
                    } else {
                      return rowData[2];
                    }
              }     
           	},
            {title:"<b>Person</b>", width:150, dataType:"string",align: "left"},
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
                rPP: 15,
                rPPOptions: [10, 15, 20] }; 
        obj.rowClick = function( event, ui ) {
            var rowData = ui.dataModel;
            var depositId = rowData.data[ui.rowIndx][5];
            viewDepositInfo(depositId);
        };
        obj.scrollModel = {horizontal: false};
        $("#grid_panel").pqGrid(obj);        

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

     <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Search -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="search">
        <table class="search_table" border="0"> 
            <tr>
                <td class="label">Year </td> 
                <td><select name="bankYear" id="bankYear" style="width: 80px" ><c:out value="${yearOptions}" escapeXml="false" /></select></td>
                <td class="label">Month </td>
                <td><select name="bankMonth" id="bankMonth" style="width: 80px"><c:out value="${monthOptions}" escapeXml="false"/></select></td>
                <td class="label">Status </td>
                <td><select name="status" id="status" style="width: 200px"><c:out value="${statusOptions}" escapeXml="false"/></select></td>
                <td class="label">Person </td>
                <td><select name="creator" id="creator" style="width: 200px"><c:out value="${cretorOptions}" escapeXml="false"/></select></td>
                <td style="text-align: right;vertical-align: bottom;"><button class="search" onclick="search();">Find</button></td>
            </tr>
        </table>
    </div>
   <div class="grid_panel" id="grid_panel"></div>
   <br/><br/>
    
   <br/>
</body>
</html>