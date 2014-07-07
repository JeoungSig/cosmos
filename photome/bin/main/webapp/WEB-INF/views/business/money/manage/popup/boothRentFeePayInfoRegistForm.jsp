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
		$('#rentFee').autoNumeric('init', {aSign :  '$ ',vMin : '0.00', vMax : '9999999.99'});

		// Datepicker 설정
        $(function() {
            var option = {
                  changeMonth: true,
                  dateFormat: 'dd/mm/yy',
                  yearRange:'1940:+0',
                  changeYear: true
                };
            $("#payDt").datepicker(option);
        });
        
        // 생년월일 항목 설정
        var t = new Date();
        var tDate = t.getDate();
        var tMonth = (t.getMonth()+1);
        if(tMonth < 10) tMonth = '0' + tMonth;
        var tYear = t.getFullYear();
        $('#payDt').val(tDate + '/' + tMonth + '/' + tYear); 
	});  
</script>
<script type="text/javascript">
    function loadPage() {}
    
    function checkDuplication() {
        if (checkMandatory() == false)  return;
        
        var groupId      = $('#groupId').val();
        var year         = $('#year').val();
        var month        = $('#month').val();
    	
        $.ajax({
            url : "/photome/business/money/manage/boothrentfeepay/ExistBoothRentFeePayHistory.action",
            data : {
                groupId      : groupId ,
                year         : year    ,
                month        : month      },
            success : callbackCheckDuplication
        });
    }
    function callbackCheckDuplication(data) {
    	pageLog("New collect information registed");
        
        if(data.message == 'YES') {
        	alert('Information already exist !!');
        	return;
        } else {
        	save();
        }
    }    
</script>

<script type="text/javascript">
    function save() {
        //if (checkMandatory() == false)  return;
        
        var groupId      = $('#groupId').val();
        var year         = $('#year').val();
        var month        = $('#month').val();
        var status       = $('#status').val();
        var rentFee      = $('#rentFee').autoNumeric('get');
        var payDt        = $('#payDt').val();
        var rentComment  = $('#rentComment').val();
        
        $.ajax({
            url : "/photome/business/money/manage/boothrentfeepay/BoothRentFeePayRegist.action",
            data : {
            	groupId      : groupId ,
            	year         : year    ,
            	month        : month   ,
            	status       : status  ,
            	rentFee      : rentFee ,
            	payDt        : payDt   ,
            	rentComment  : rentComment      },
            success : callbackSave
        });

    }
    function callbackSave(data) {
    	pageLog("New collect information registed");
        
        var returnValue = {
        		message : $('#groupId').val()
        };
        setOpenerDataset(returnValue);
    }
</script>
<script type="text/javascript">
    function setRentFee(){
        var groupId    = $('#groupId').val();
        var year       = $('#year').val();
        var month      = $('#month').val();
        if(groupId == '' || groupId == null ||  year == null ||  year == '' ||  month == null ||  month == '' ){
        	$('#rentFee').autoNumeric('set', '0.00');
        }
        
        $.ajax({
            url : "/photome/business/money/manage/boothrentfeepay/RentFee.action",
            data : {
            	groupId : groupId,
            	year : year,
            	month : month
            },
            success : callbackSetBooth,
        });     
    }
    function callbackSetBooth(data) {
    	$('#rentFee').autoNumeric('set', data.rentAmount);
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
					<h2 class="ckbox">Money Collection</h2></td>
				</tr>
	            <tr>
	                <td class="label" style="width: 100px"><span class="required">*</span>Group :</td> 
	                <td>&nbsp;<select name="groupId" id="groupId" style="width: 150px" mandatory="true" onchange="setRentFee()"><c:out value="${groupListOptions}" escapeXml="false" /></select></td>
                    <td class="label" style="width: 100px"><span class="required">*</span>Year/Month :</td>
	                <td>&nbsp;
	                    <select name="year" id="year" style="width: 100px" mandatory="true" onchange="setRentFee()"><c:out value="${yearOptions}" escapeXml="false"/></select>
	                    <select name="month" id="month" style="width: 100px" mandatory="true" onchange="setRentFee()"><c:out value="${monthOptions}" escapeXml="false"/></select>
	                </td>
	            </tr>
	            <tr>
                    <td class="label"><span class="required">*</span>Status :</td>
                    <td colspan="3">&nbsp;<select name="status" id="status" style="width: 150px" mandatory="true"><c:out value="${payRentStatusOptions}" escapeXml="false"/></select></td>	                
	            </tr>
                <tr>
                    <td class="label"><span class="required">*</span>Rent Fee :</td>
                    <td class="value"><input id="rentFee" name="rentFee" style="width: 200px;"  mandatory="true" value="0"/></td>
                    <td class="label">Pay Date :</td>
                    <td class="value"><input id="payDt" name="payDt" style="width: 150px;background-color: #E5E5E5;"  readonly="readonly" /></td>
                </tr>                
                <tr>
                    <td class="label">Comment :</td>
                    <td class="value" colspan="3"><input id="rentComment" name="rentComment" style="width: 490px;"/></td>
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
					<button class="word3" onclick="checkDuplication()">save</button>
				</td>
			</tr>
		</table>
	</div>


</body>
</html>