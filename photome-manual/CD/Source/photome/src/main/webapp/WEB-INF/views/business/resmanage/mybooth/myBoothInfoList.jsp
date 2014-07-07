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
    function viewBoothInfo(boothId) {
        var url = '/photome/business/resmanage/mybooth/BoothInfo.action?boothId=' + boothId;
        var windowName = 'business/resmanage/booth/BoothInfo';
        var win = openPopupForm(url, windowName, '780', '560');
    }
</script>   

<script type="text/javascript">
    function search() {
        var technician = $('#technician').val();
        
        $.ajax({
            url : "/photome/business/resmanage/mybooth/BoothInfoList.action",
            data : {
            	technician   : technician
            },
            success : callbackSearch,
        });
        pageLog('data retirive complete','info');
    }

    function callbackSearch(data) {
    	
        var json = data.list;
        var dataCnt = json.length;

        var arrayData = null;
        var element = null;

        if (dataCnt > 0) {
            arrayData = new Array();
            $.each(json, function(i, obj) {
                element = new Array();
                element[0] = obj.groupName;
                element[1] = obj.boothName;
                element[2] = obj.technicianName;
                element[3] = obj.locState;
                element[4] = obj.locSuburb;
                element[5] = obj.statusName;
                element[6] = obj.printerModel;
                element[7] = obj.monitorType;
                element[8] = decode(obj.type, '');
                element[9] = obj.serialNo;
                element[10] = obj.qualityTestResultName;
                element[11] = obj.rentFeeTypeName;
                element[12] = decode(obj.payOnsite, 'Y', 'Yes', 'N', 'No', '-');
                element[13] = obj.boothId;
                element[14] = obj.status;
                element[15] = obj.qualityTestResult;
                element[16] = obj.rentFeeType;
                arrayData[i] = element; 
            });
        }       
        var obj = {title: "<b>Booth</b> List", numberCell: false, editable: false,  freezeCols: 3, resizable:false, columnBorders: true, flexHeight:true};
        obj.width = "98%";
        obj.height = 500;
        obj.colModel = [
            {title:'<b>Group</b>', width:150, dataType:"string"},
            {title:"<b>Booth</b>", width:200, dataType:"string"},
            {title:"<b>Technician</b>", width:150, dataType:"string"},
            {title:"<b>State</b>", width:80, dataType:"string"},
            {title:"<b>Suburb</b>", width:180, dataType:"string"},
            {title:"<b>Status</b>", width:250, dataType:"string",
                render: function (ui) {
                    var rowData = ui.rowData;
                    if (rowData[14] == 'BROKEN_ICK') {
                        return '<font color="#FF0080">' + rowData[5] + '</font>';
                    } else if (rowData[14] == 'BROKEN_OOO') {
                        return '<font color="#FF0000">' + rowData[5] + '</font>';
                    } else if (rowData[14] == 'BROKEN_WRK') {
                    	return '<font color="#FF80FF">' + rowData[5] + '</font>';
                    } else if (rowData[14] == 'CLOSURE') {
                    	return '<font color="#A7A7A7">' + rowData[5] + '</font>';
                    } else {
                    	return '<font color="#008040">' + rowData[5] + '</font>';
                    }
              }     
            },
            {title:"<b>Printer</b>", width:100, dataType:"string"},
            {title:"<b>Monitor</b>", width:100, dataType:"string"},
            {title:"<b>Type</b>", width:100, dataType:"string"},
            {title:"<b>Serial</b>", width:100, dataType:"string"},
            {title:"<b>Qty Test</b>", width:100, dataType:"string",
                render: function (ui) {
                    var rowData = ui.rowData;
                    if (rowData[15] == 'FAILURE') {
                      return '<font color="#FF0080">' + rowData[10] + '</font>';
                    } else if (rowData[15] == 'PASS') {
                      return '<font color="#FF0000">' + rowData[10] + '</font>';
                    } else if (rowData[15] == 'N/A') {
                        return '<font color="#FF80FF">' + rowData[10] + '</font>';
                    }else{
                        return rowData[10];
                    }
                }                 	
           	},
            {title:"<b>Rent Fee Type</b>", width:200, dataType:"string",
                render: function (ui) {
                    var rowData = ui.rowData;
                    if (rowData[16] == 'FIXED_MONEY') {
                      return '<font color="#800040">' + rowData[11] + '</font>';
                    } else if (rowData[16] == 'PERCENT') {
                      return '<font color="#0080C0">' + rowData[11] + '</font>';
                    }
                }                 	
           	},
            {title:"<b>Pay on site</b>", width:100, dataType:"string"},
            {title:'Hidden1(boothId)', hidden:true},
            {title:'Hidden2(status)', hidden:true},
            {title:'Hidden3(qualityTestResult)', hidden:true},
            {title:'Hidden4(rentFeeType)', hidden:true}
            ];        
        
        obj.dataModel = {data:arrayData, sortIndx: 0, sortDir: "up", 
                location: "local",
                sorting: "local",
                paging: "local",
                dataType: "Array",
                curPage: 1,
                rPP: 10,
                rPPOptions: [10, 20, 30, 50] };
        obj.rowClick = function( event, ui ) {
            var rowData = ui.dataModel;
            var boothId = rowData.data[ui.rowIndx][13];
            viewBoothInfo(boothId);
        };
        

        $("#grid_panel").pqGrid(obj);        
    }
    
    
</script>

<script type="text/javascript">
	function setReturnValue(returnValue) {
		pageLog(returnValue.message, "info");
	    $('#groupId').val(returnValue.message);
	    search();
	}
</script>

</head>
<body>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Search -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="search" >
        <table class="search_table" border="0"> 
            <tr>
                <td class="label">Technician </td>
                <td><select name="technician" id="technician" style="width: 200px"><c:out value="${technicianOptions}" escapeXml="false"/></select></td>
                <td rowspan="3" style="text-align: right;vertical-align: bottom;"><button class="search" onclick="search();">Find</button></td>
            </tr>
        </table>
    </div>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Table List -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div class="grid_panel" id="grid_panel"></div>

</body>
</html>