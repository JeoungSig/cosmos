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
	    
    });  
</script>
<script type="text/javascript">
    function loadPage() {
    }
</script>
<script type="text/javascript">
    function modify() {
    	document.location.href = "/photome/business/techsupport/servicereq/BoothInfoUpdateForm.action?boothId=" + <c:out value="${boothDto.boothId}" />;
    }
</script>

<script type="text/javascript">
    function setBoothUseYN(useYn) {
        var boothId  = '<c:out value="${boothDto.boothId}" />';
        var useYn    = useYn;
        
        $.ajax({
            url : "/photome/business/resmanage/booth/SetBoothUseYN.action",
            data : {
                boothId  : boothId,
                useYn    : useYn       },
            success : callbackSetBoothUseYN
        });

    }
    function callbackSetBoothUseYN(data) {
    	pageLog("Information updated");
        
        var returnValue = {
                groupId : '<c:out value="${boothDto.groupId}" />'
        };
        setOpenerDataset(returnValue);
    }
    function deleteBoothInfo() {
        
        if(!confirm('Are you sure delete ?\n In case of delete, it can make problem when it is refered.')){
            return;
        }
        var boothId  = '<c:out value="${boothDto.boothId}" />';
        
        $.ajax({
            url : "/photome/business/resmanage/booth/BoothInfoDelete.action",
            data : "boothId=" + boothId,
            success : callbackDeleteInfo
        });

    }
    function callbackDeleteInfo(data) {
        var returnValue = {
                groupId : '<c:out value="${groupDto.groupId}" />'
        };
        setOpenerDataset(returnValue);
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


</body>
</html>