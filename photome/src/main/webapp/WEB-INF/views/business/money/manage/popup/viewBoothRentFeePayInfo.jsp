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
        $('#rentFee').autoNumeric('init', {aSign : '$ ', vMin : '0.00', vMax : '9999999.99'});
        $('#rentFee').autoNumeric('set', '<c:out value="${boothRentFeePayDto.rentFee}" />');
	});  
</script>
<script type="text/javascript">
    function loadPage() {}
    
    function modify() {
    	var groupId = '<c:out value="${boothRentFeePayDto.groupId}" />';
    	var year = '<c:out value="${boothRentFeePayDto.year}" />';
    	var month = '<c:out value="${boothRentFeePayDto.month}" />';
    	document.location.href="/photome/business/money/manage/boothrentfeepay/BoothRentFeePayModifyForm.action?groupId=" + groupId + '&year=' + year + '&month=' + month;
    }
</script>

<script type="text/javascript">
    function deleteRentFeePayInfo() {
        
        var groupId = '<c:out value="${boothRentFeePayDto.groupId}" />';
        var year = '<c:out value="${boothRentFeePayDto.year}" />';
        var month = '<c:out value="${boothRentFeePayDto.month}" />';

        $.ajax({
                url : "/photome/business/money/manage/boothrentfeepay/BoothRentFeePayFeeDelete.action",
                data : {
                    groupId  : groupId,
                    year  : year,
                    month  : month                	
                },
                success : callbackDelete
        });

    }
    function callbackDelete(data) {
        var returnValue = {
            message : 'Delete pay rent info : <c:out value="${boothRentFeePayDto.groupName}" />'
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
	<form id="saveForm" name="saveForm" method="post" enctype="multipart/form-data">
		<div id="detail_panel" class="detail_panel">
			<table id="detail_table" class="detail_table" cellpadding="0" cellspacing="0">
				<colgroup>
					<col width="100px" />
					<col width="230px" />
					<col width="100px" />
					<col width="*" />
				</colgroup>

				<tr>
					<td colspan="4"><br />
					<h2 class="ckbox">Rent Fee</h2></td>
				</tr>
	            <tr>
	                <td class="label" style="width: 100px">Group :</td> 
	                <td class="value"><b><c:out value="${boothRentFeePayDto.groupName}" /></b></td>
                    <td class="label" style="width: 100px">Year/Month :</td>
	                <td class="value"><c:out value="${boothRentFeePayDto.year}" /> / <c:out value="${boothRentFeePayDto.month}" /></td>
	            </tr>
	            <tr>
                    <td class="label">Status :</td>
                    <td class="value" colspan="3">
                        <c:if test="${boothRentFeePayDto.status == 'NO_PAID' }"><font color="#FF00800"></c:if>
                        <c:if test="${boothRentFeePayDto.status == 'PAID' }"><font color="#008000"></c:if>
                        <c:out value="${boothRentFeePayDto.statusName}" /></font>
                    </td>	                
	            </tr>
                <tr>
                    <td class="label">Rent Fee :</td>
                    <td class="value"><p id="rentFee" /></td>
                    <td class="label">Pay Date :</td>
                    <td class="value"><c:out value="${boothRentFeePayDto.payDt}" /></td>
                </tr>                
                <tr>
                    <td class="label">Comment :</td>
                    <td class="value" colspan="3"><c:out value="${boothRentFeePayDto.rentComment}" /></td>
                </tr> 
			</table>
		</div>
	</form>

	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- Subaction buttons bar & Pagging -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<div id="main_control" class="main_control">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="75%"></td>
				<td width="*" align="left">
					<button class="word3" onclick="deleteRentFeePayInfo()">delete</button>
					<button class="word3" onclick="modify()">modify</button>
				</td>
			</tr>
		</table>
	</div>


</body>
</html>