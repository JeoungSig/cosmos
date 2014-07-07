<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script language="javascript">
    window.focus();
</script>

<script type="text/javascript">
    $(document).ready(function() {
    	searchList();
    });  
</script>
<script type="text/javascript">
    function loadPage() {
    }
</script>
<script type="text/javascript">
    function modify() {
    	document.location.href = "/photome/business/resmanage/mybooth/BoothInfoUpdateForm.action?boothId=" + <c:out value="${boothDto.boothId}" />;
    }
</script>

<script type="text/javascript">
	function searchList() {
		var boothId = '<c:out value="${boothDto.boothId}" />';
	    $.ajax({
	        url : "/photome/business/resmanage/mybooth/MoneyCollectAndServiceRequestList.action",
            data : {
                boothId   : boothId
            },	        
	        success : callbackMoneyCollectList,
	    });
	    
	}
	function callbackMoneyCollectList(data) {
		var json = data.moneyCollectJsonList;
	    var dataCnt = json.length;
	
	    var arrayData = null;
	    var element = null;
	    
	    if (dataCnt > 0) {
	        
	        arrayData = new Array();
	        $.each(json, function(i, obj) {
	            element = new Array();
	            element[0] = obj.collectDate.substr(0,10);
	            element[1] = addCommas(obj.collectRealIncome);
	            element[2] = addCommas(obj.bankAmount);
	            element[3] = addCommas(obj.coinMtrIncome);
	            element[4] = obj.bankDt;
	            element[5] = obj.createDt.substr(0,16);
	            element[6] = obj.collectId;
	            arrayData[i] = element; 
	        });
	    }       
	    
	    var obj = {title: "<b>Money Collect</b> List",numberCell: false, editable: false,  freezeCols: 2, resizable:false, columnBorders: true, flexHeight:false};
	    obj.width = "750";
	    obj.height = 170;
	    obj.colModel = [
	        {title:"<b>Collect Date</b>", width:130, dataType:"string",align: "center"},
            {title:"<b>$ Collect</b>",width:110, dataType:"float", align: "right",
                render: function (ui) {
                    var rowData = ui.rowData;
                    return '<font color="#8000FF"><b>' + rowData[1] + '</b></font>';
                }               
            },
            {title:"<b>$ Bank amt.</b>",width:110, dataType:"float", align: "right",
                render: function (ui) {
                    var rowData = ui.rowData;
                    return '<font color="#0080C0"><b>' + rowData[2] + '</b></font>';
                }               
            },	        
            {title:"<b>Coin mtr inc.</b>", width:120, dataType:"integer", align: "right",
                render: function (ui) {
                    var rowData = ui.rowData;
                    if (rowData[3] < 0 ) {
                      return "<img src='/photome/resources/images/common/arrow-down.gif'/>&nbsp;" + rowData[3];
                    } else if (rowData[3] == 0 ) {
                      return rowData[3];
                    } else {
                         return "<img src='/photome/resources/images/common/arrow-up.gif'/>&nbsp;" + rowData[3];
                    }
                }               },
            {title:"<b>Banking Date</b>", width:110, dataType:"string", align: "center"},
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
	    obj.scrollModel = {horizontal: true};
	    $("#grid_panel_collect").pqGrid(obj);        
	
	    selectSvcReqList(data);
	}
    function selectSvcReqList(data) {
        var json = data.svcReqJsonList;
        var dataCnt = json.length;

        var arrayData = null;
        var element = null;
        
        if (dataCnt > 0) {
            
            arrayData = new Array();
            $.each(json, function(i, obj) {
                element = new Array();
                element[0] = '<font color="#A40000">' + obj.subject + '</font>';  
                element[1] = obj.claimTypeName;
                element[2] = obj.claimStatusName;
                element[3] = obj.creatorName;
                element[4] = obj.createDt.substr(0,10);
                element[5] = obj.updateDt.substr(0,10);
                element[6] = obj.historyId;
                element[7] = obj.claimStatus;
                arrayData[i] = element; 
            });
        }
        
        var obj = {title: "<b>Service Request</b> List", numberCell: false, editable: false,  freezeCols: 1, resizable:false, columnBorders: true, flexHeight:false};
        obj.width = "750";
        obj.height = 170;
        obj.colModel = [
            {title:"<b>Subject</b>", width:240, dataType:"string"},
            {title:'<b>Claim Type</b>', width:150, dataType:"string"},
            {title:"<b>Status</b>", width:100, dataType:"string",
                render: function (ui) {
                    var rowData = ui.rowData;
                    if (rowData[7] == 'ONGOING') {
                      return '<font color="#EA0075">' + rowData[2] + '</font>';
                    } else {
                      return rowData[2];
                    }
              }     
            },
            {title:"<b>Writer</b>", width:150, dataType:"string",
                render: function (ui) {
                      var rowData = ui.rowData;
                      return '<font color="#008200">' + rowData[3] + '</font>';
              }
            },
            {title:"<b>Create Date</b>", width:110, dataType:"string"},
            {title:"<b>Modify Date</b>", width:110, dataType:"string"},
            {title:'Hidden1(ID)', hidden:true},
            {title:'Hidden1(Status)', hidden:true}
            ];        
        
        obj.dataModel = {data:arrayData, sortIndx: 4, sortDir: "down", 
                location: "local",
                sorting: "local",
                paging: "local",
                dataType: "Array",
                curPage: 1,
                rPP: 5,
                rPPOptions: [5] };
        $("#grid_panel_svcreq").pqGrid(obj);    
        
    }	
</script>
</head>
<body>

	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- Form Table -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<div id="detail_panel" class="detail_panel">
		<table id="detail_table" class="detail_table" cellpadding="0" cellspacing="0" style="width: 750px;" >
			<colgroup>
				<col width="170px" />
				<col width="230px" />
				<col width="170px" />
				<col width="*" />
			</colgroup>
			
			<tr>
                   <td class="label">Booth Name</td>
                   <td class="value" colspan="3"><b><c:out value="${boothDto.boothName}" /></b></td>
			</tr>
			<tr>
				<td class="label">Booth Group</td>
				<td class="value" colspan="3"><font color="#D9006C"><c:out value="${boothDto.groupName}" /></font></td>
			</tr>
               <tr>
                   <td class="label">Comment</td> 
                   <td class="value" colspan="3"><c:out value="${boothDto.boothComment}" /></td>
               </tr>
			<tr>
			    <td class="label">Status</td> 
                   <td class="value" colspan="3"><c:out value="${boothDto.statusName}" /></td>
			</tr>
			
			
			<tr><td colspan="4" style="height: 15px;"></td></tr>
			
               <tr>
                   <td class="label">Type</td>
                   <td class="value"><c:out value="${boothDto.typeName}" /></td>
                   <td class="label">Serial No</td>
                   <td class="value"><c:out value="${boothDto.serialNo}" /></td>                    
               </tr>               
			<tr>
				<td class="label">Printer Model</td>
				<td class="value"><c:out value="${boothDto.printerModelName}" /></td>
                   <td class="label">Monitor type</td>
                   <td class="value"><c:out value="${boothDto.monitorTypeName}" /></td>					
			</tr>
<!-- 
			<tr>
                   <td class="label">TAG Due date</td>
                   <td class="value"><c:out value="${boothDto.tagDueDt}" /></td>   
                   <td class="label">Capture Type</td>
                   <td class="value"><c:out value="${boothDto.captureTypeName}" /></td>
			</tr>
			<tr>
				<td class="label">Pad Lock</td>
				<td class="value"><c:out value="${boothDto.padLock}" /></td>
				<td class="label">Inside Lock</td>
				<td class="value"><c:out value="${boothDto.insideLock}" /></td>
			</tr>
 -->
            <tr>
                <td class="label">Quality Result</td>
                <td class="value"><c:out value="${boothDto.qualityTestResultName}" /></td>
                <td class="label">Test Date</td>
                <td class="value"><c:out value="${boothDto.qualityTestDt}" /></td>
            </tr> 
            <tr><td colspan="4" style="height: 15px;"></td></tr>             
            
                              
			<tr>
				<td class="label">Rent fee type</td>
				<td class="value"><c:out value="${boothDto.rentFeeTypeName}" /></td>
                <td class="label">Pay on-site</td>
                <td class="value">
                   <c:choose>
                       <c:when test="${boothDto.payOnsite == 'Y'}">Yes</c:when>
                       <c:when test="${boothDto.payOnsite == 'N'}">No</c:when>
                       <c:otherwise>-</c:otherwise>
                   </c:choose>
                 </td>				
			</tr>
			<tr><td colspan="4" style="height: 15px;"></td></tr>  


			<tr>
				<td class="label">Zip Code</td>
				<td class="value"><c:out value="${boothDto.locPostcd}" /></td>
				<td class="label">State</td>
				<td class="value"><c:out value="${boothDto.locState}" /></td>
			</tr>
			<tr>
				<td class="label">No/Street</td>
				<td class="value" colspan="3"><c:out value="${boothDto.locStreetNo}" /></td>
			</tr>
			<tr>
				<td class="label">Suburb</td>
				<td class="value" colspan="3"><c:out value="${boothDto.locSuburb}" /></td>
			</tr>
			<!-- <tr>
				<td class="label">Location detail</td>
				<td class="value" colspan="3"><c:out value="${boothDto.locDetail}" /></td>
			</tr> -->
            <tr><td colspan="4" style="height: 15px;"></td></tr>  

            <tr>
                <!-- <td class="label">Manager</td>
                <td class="value"><c:out value="${boothDto.managerName}" /></td> -->
                <td class="label">Technician</td>
                <td class="value" nowrap colspan="3"><c:out value="${boothDto.technicianName}" /></td>
            </tr>

		</table>
	</div>

	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- Subaction buttons bar & Pagging -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<div id="main_control" class="main_control">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="*" align="right">
					<button class="word4" onclick="modify();">modify</button>
				</td>
				<td width="20"></td>
			</tr>
		</table>
	</div>
    <br/>
    <br/>
    
    <div class="grid_panel_collect" id="grid_panel_collect"></div>
    <br/>
    <br/>
    <div class="grid_panel_svcreq" id="grid_panel_svcreq"></div>
    <br/>
    <br/>

</body>
</html>