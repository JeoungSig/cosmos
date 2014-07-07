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
    });  
</script>

<script type="text/javascript">
    function loadPage() {  }
</script>

<script type="text/javascript">
    function save() {
        if (checkMandatory() == false)  return;
        
        var groupId        = $('#groupId').val();
        var boothId        = $('#boothId').val();
        var rentYear       = $('#rentYear').val();
        var fromRentMonth  = $('#fromRentMonth').val();
        var toRentMonth    = $('#toRentMonth').val();
        var rentFee        = $('#rentFee').autoNumeric('get');

        $.ajax({
            url : "/photome/business/resmanage/booth/rentfee/BoothRentFeeRegist.action",
            data : {
            	groupId        : groupId    ,
            	boothId        : boothId    ,
            	rentYear       : rentYear   ,
            	fromRentMonth  : fromRentMonth ,
            	toRentMonth    : toRentMonth   ,
            	rentFee        : rentFee       },
            success : callbackSaveBoothFeeInfo
        });

    }
    function callbackSaveBoothFeeInfo(data) {
        var returnValue = {
        		message : 'Added a rent fee information'
        };
        setOpenerDataset(returnValue);
    }
</script>
<script type="text/javascript">
    function setBooth(group){
        var groupId = group.value;
        $.ajax({
            url : "/photome/business/resmanage/booth/rentfee/BoothListOfGroup.action",
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
</script>
<script type="text/javascript">
    function getBeforeValues(group){
        var boothId = $('#boothId').val();
        if(boothId == '' || boothId == null) return;
        
        $.ajax({
            url : "/photome/business/resmanage/booth/rentfee/BeforeMoneyCollectInfo.action",
            data : "boothId=" + boothId,
            success : callbackGetBeforeValues,
        });     
    }
    function callbackGetBeforeValues(data) {
        var boothDto =  data.jsonObject.boothDto;
        var rentFeeType = boothDto.rentFeeType;
        
        $('#rentFee').autoNumeric('destroy');
        if(rentFeeType == 'PERCENT'){
        	$('#rentFee').autoNumeric('init', {aSign :  '% ', vMin : '0', vMax : '99'});
        } else {
        	$('#rentFee').autoNumeric('init', {aSign :  '$ ',vMin : '0.00', vMax : '9999999.99'});
        }
    }
</script>
</head>
<body>

	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- Form Table -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<div id="detail_panel" class="detail_panel">
		<table id="detail_table" class="detail_table" cellpadding="0" cellspacing="0">
			<colgroup>
				<col width="170px" />
				<col width="*" />
			</colgroup>

			<tr>
				<td class="label"><span class="required">*</span>Group :</td>
				<td><select name="groupId" id="groupId" style="width: 150px" onChange="setBooth(this)" mandatory="true"><c:out value="${groupListOptions}" escapeXml="false" /></select></td>
			</tr>
			<tr>
				<td class="label"><span class="required">*</span>Booth :</td>
				<td><select name="boothId" id="boothId" style="width: 350px" mandatory="true" onChange="getBeforeValues(this)"></select></td>
			</tr>
			<tr>
				<td class="label"><span class="required">*</span>Term :</td>
				<td><select name="rentYear" id="rentYear" style="width: 100px" mandatory="true"><c:out value="${yearOptions}" escapeXml="false" /></select> 
				    &nbsp;<select name="fromRentMonth" id="fromRentMonth" style="width: 60px" mandatory="true"><c:out value="${monthOptions}" escapeXml="false" /></select>
				    &nbsp;&nbsp; ~ &nbsp;&nbsp; &nbsp;
				    <select name="toRentMonth" id="toRentMonth" style="width: 60px" mandatory="true"><c:out value="${monthOptions}" escapeXml="false" /></select>
				</td>
			</tr>
			<tr>
				<td class="label"><span class="required">*</span>Rent Amount :</td>
				<td><input type="text" id="rentFee" name="rentFee" style="width: 150px;" mandatory="true" /></td>
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
				<td width="85%"></td>
				<td width="*" align="left">
					<button class="word3" onclick="save();">save</button>
				</td>
			</tr>
		</table>
	</div>


</body>
</html>