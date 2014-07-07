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
		$('#collectRealIncome').autoNumeric('init', {aSign :  '$ ',vMin : '0.00', vMax : '9999999.99'});
		$('#onsitePayAmount').autoNumeric('init', {aSign :  '$ ',vMin : '0.00', vMax : '9999999.99'});
		$('#bankAmount').autoNumeric('init', {aSign :  '$ ',vMin : '0.00', vMax : '9999999.99'});
		$('#cashMtr').autoNumeric('init', {aSign :  '$ ',vMin : '0.00', vMax : '9999999.99'});
		$('#filmMtrNow').autoNumeric('init', {vMin : '0', vMax : '9999999'});
		$('#coinMtrNow').autoNumeric('init', {vMin : '0', vMax : '9999999'});
		
		
        // Datepicker 설정
        $(function() {
            var option = {
                  changeMonth: true,
                  dateFormat: 'dd/mm/yy',
                  yearRange:'1940:+0',
                  changeYear: true
                };
            $("#collectDate").datepicker(option);
            $("#bankDt").datepicker(option);
        });
        
        // 생년월일 항목 설정
        var t = new Date();
        var tDate = t.getDate();
        var tMonth = (t.getMonth()+1);
        if(tMonth < 10) tMonth = '0' + tMonth;
        var tYear = t.getFullYear();
        $('#collectDate').val(tDate + '/' + tMonth + '/' + tYear); 
	});  
</script>
<script type="text/javascript">
   /* 수금 금액정보가 존재하는 경우. Booth의 렌트비지급 형태에 따라서 현장에서 지급해야할
        렌트비를 집급해서 설정해준다. */
    function setOnsiteRentFee(obj) {
        
        $('#collectRealIncome').autoNumeric('init', {aSign :  '$ ',vMin : '0.00', vMax : '9999999.99'});
        $('#rentAmount').autoNumeric('init', {aSign :  '$ ',vMin : '0.00', vMax : '9999999.99'});
        
        var collectRealIncome = $('#collectRealIncome').autoNumeric('get');
        var rentAmount = $('#rentAmount').autoNumeric('get');
        
        var payOnsite = $('#payOnsite').val();
        if(payOnsite == '' || payOnsite == null || payOnsite == 'N') return;
        
        var rentFeeType = $('#rentFeeType').val();
        var onsiteRentFee = 0;

        // 수금 금액정보가 존재하는 경우. Booth의 렌트비지급 형태에 따라서 현장에서 지급해야할
        // 렌트비를 집급해서 설정해준다.
        if(collectRealIncome != '' && collectRealIncome != null){
            
            if(rentFeeType == 'PERCENT'){
                onsiteRentFee = collectRealIncome * (rentAmount/100);
            }else if(rentFeeType == 'FIXED_MONEY'){
                onsiteRentFee = rentAmount;
            }
            
            $('#onsitePayAmount').autoNumeric('set', onsiteRentFee);
            
        }
    }
</script>
<script type="text/javascript">
    function loadPage() {}
</script>

<script type="text/javascript">
    function save(SAVE_DIV) {
        if (checkMandatory() == false)  return;
        
        var collectStatus = "COLLECTING";
        
        // 등록모드가 'SUBMIT'인경우 모든 항목들의 유효성을 검증하여 저장한다.
        if(SAVE_DIV == 'SUBMIT'){
        	collectStatus = "COLLECT_FINISH";
        	
        	// 현장에서 렌트비를 지급하는 경우를 체크한다.
            var payOnsite = $('#payOnsite').val();
        	
            if (payOnsite == 'Y'){
            	var onsiteIsPaid = $('#onsiteIsPaid').val();
            	var onsitePayAmount =  $('#onsitePayAmount').autoNumeric('get');
            	if(onsiteIsPaid == 'N' || onsiteIsPaid == ''  || onsiteIsPaid == null || onsitePayAmount == null || onsitePayAmount == '' ){
            		// 현장에서 렌트비를 지급하는 경우 현장에서 지급된 레트비 정보를 입력해야한다.
            		alert('You have to check onsite rent fee filds');
            		return;
            	}
            	
            }
            
            //은행 입금정보란을 확인한다.
            var bankAccount = $('#bankAccount').val();
            var bankAmount = $('#bankAmount').autoNumeric('get');
            var bankDt     = $('#bankDt').val();
            if(bankAccount == '' || bankAccount == null 
            		|| bankAmount == '' || bankAmount == null
            		|| bankDt == '' || bankDt == null
            		){
                alert('For submit money collect information, you have to fill in deposit information filds.');
                return;
            }
            
        }else if(SAVE_DIV == 'SAVE'){
        	collectStatus = "COLLECTING";
        }
        
        var groupId             = $('#groupId').val();
        var collectDate         = $('#collectDate').val();
        var boothId             = $('#boothId').val();
        var filmMtrNow          = $('#filmMtrNow').autoNumeric('get');
        var coinMtrNow          = $('#coinMtrNow').autoNumeric('get');
        var collectRealIncome   = $('#collectRealIncome').autoNumeric('get');
        var bankAccount         = $('#bankAccount').val();
        var cashMtr             = $('#cashMtr').autoNumeric('get');
        var bankAmount          = $('#bankAmount').autoNumeric('get');
        var bankDt              = $('#bankDt').val();
        var onsiteIsPaid        = $('#onsiteIsPaid').val();
        var onsitePayAmount     = $('#onsitePayAmount').autoNumeric('get');
        
        $.ajax({
            url : "/photome/business/money/collect/MoneyCollectRegist.action",
            data : {
            	groupId            : groupId      ,
            	collectDate        : collectDate  ,
            	boothId            : boothId      ,
            	filmMtrNow         : filmMtrNow   ,
            	coinMtrNow         : coinMtrNow   ,
            	cashMtr            : cashMtr   ,
            	collectRealIncome  : collectRealIncome,
            	bankAccount        : bankAccount       ,
            	bankAmount         : bankAmount       ,
            	bankDt             : bankDt           ,
            	onsiteIsPaid       : onsiteIsPaid     ,
            	onsitePayAmount    : onsitePayAmount  ,
            	collectStatus      : collectStatus       },
            success : callbackSaveCollectInfo
        });

    }
    function callbackSaveCollectInfo(data) {
    	pageLog("New collect information registed");
        
        var returnValue = {
        		groupId : $('#groupId').val()
        };
        setOpenerDataset(returnValue);
    }
</script>
<script type="text/javascript">
    function setBooth(group){
        var groupId = group.value;
        $.ajax({
            url : "/photome/business/money/collect/BoothListOfGroup.action",
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
            url : "/photome/business/money/collect/BeforeMoneyCollectInfo.action",
            data : "boothId=" + boothId,
            success : callbackGetBeforeValues,
        });     
    }
    function callbackGetBeforeValues(data) {
        var boothDto =  data.jsonObject.boothDto;
        var payOnsite = boothDto.payOnsite;
        var rentFeeType = boothDto.rentFeeType;
        var rentAmount = boothDto.rentAmount;
        
       	$('#onsitePayAmount').val(null);
       	$('#onsiteIsPaid > option[value=\'\']').attr("selected", "true");
       	
        // 싸이트에서 바로 렌트비를 지급하는 경우
        // (싸이트에서 직접지불 하면서 그룹단위로 계약하는 경우는 없다고 가정한다.)
       	$('#payOnsite').val(payOnsite);
       	$('#rentAmount').val(rentAmount);
       	$('#rentFeeType').val(rentFeeType);

       	if (payOnsite == 'Y'){
        	$('#tbl_onsitepay').css('display', 'block');
        } else {
            $('#tbl_onsitepay').css('display', 'none');
        }
    }
</script>
<script type="text/javascript">
    function setAccount() {
        var url = '/photome/business/money/collect/SetBankAccountForm.action';
        var windowName = 'business/money/collect/SetBankAccountForm';
        var win = openPopupForm(url, windowName, '750', '550');
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
					<col width="170px" />
					<col width="230px" />
					<col width="170px" />
					<col width="*" />
				</colgroup>

				<tr>
					<td colspan="4"><br />
					<h2 class="ckbox">Money Collection</h2></td>
				</tr>
	            <tr>
	                <td class="label"><span class="required">*</span>Group :</td> 
	                <td><select name="groupId" id="groupId" style="width: 150px" onChange="setBooth(this)"  mandatory="true" ><c:out value="${groupListOptions}" escapeXml="false" /></select></td>
                    <td class="label"><span class="required">*</span>Collect Date :</td>
                    <td class="value"><input id="collectDate" name="collectDate" style="width: 100px;background-color: #E5E5E5;" readonly="readonly"  mandatory="true" /></td>
	            </tr>
	            <tr>
	                <td class="label"><span class="required">*</span>Booth :</td>
	                <td colspan="3"><select name="boothId" id="boothId" style="width: 350px" onChange="getBeforeValues(this)"  mandatory="true" ></select></td>
	            </tr>
	            <tr>
	                <td class="label">Collector :</td>
	                <td class="value" colspan="3"><c:out value="${sessionUserName}" /></td>
	            </tr>
	            <tr style="height: 10px;"><td colspan="4">&nbsp;</td></tr>

	            <tr>
	                <td class="label"><span class="required">*</span>Film meter :</td>
	                <td class="value"><input id=filmMtrNow name="filmMtrNow" style="width: 200px;"  mandatory="true" /></td>
	                <td class="label"><span class="required">*</span>Coin meter :</td>
	                <td class="value"><input id="coinMtrNow" name="coinMtrNow" style="width: 150px;"  mandatory="true" /></td>
	            </tr>            
	            <tr>
	            </tr>            
	            <tr>
	                <td class="label"><span class="required">*</span>Cash meter :</td>
	                <td class="value"><input id="cashMtr" name="cashMtr" style="width: 150px;"  mandatory="true" /></td>
	                <td class="label"><span class="required">*</span>Collect Amount :</td>
	                <td class="value"><input id="collectRealIncome" name="collectRealIncome" style="width: 200px;"  mandatory="true"  onblur="setOnsiteRentFee(this)"/></td>
	            </tr>            
	            <tr style="height: 10px;"><td colspan="4">&nbsp;</td></tr>
	            
	            
                <tr>
                    <td class="label">Bank Account :</td>
                    <td class="value" nowrap colspan="3">
                        <input type="text" id="bankAccountDisplayName" name="bankAccountDisplayName" style="width: 350px; background-color: #E5E5E5;" readonly="readonly" />
                        <input type="hidden" id="bankAccount" name="bankAccount"/>
                        <img src="/photome/resources/images/common/account1.png" onclick="setAccount();" style="cursor:hand; height: 20px; vertical-align: bottom;" />
                    </td>                    
                </tr>
                <tr>
                    <td class="label">Deposit :</td>
                    <td class="value"><input type="text" id="bankAmount" name="bankAmount" style="width: 150px;"/>  </td>
                    <td class="label">Deposit Date :</td>
                    <td class="value"><input id="bankDt" name="bankDt" style="width: 150px;background-color: #E5E5E5;"  readonly="readonly" /></td>
                </tr>

                <tr>
                    <td colspan="4" style="width: 170px;">
                        <table id="tbl_onsitepay" style="display: none; width: 100%;">
                             <tr style="height: 10px;"><td colspan="4">&nbsp;</td></tr>
                             <tr>
			                    <td class="label">Is paid on site :</td>
			                    <td class="value">
			                         <select id="onsiteIsPaid" name="onsiteIsPaid" style="width: 150px;">
			                             <option></option>
			                             <option value="N" selected>No Paid</option>
			                             <option value="Y">Paid</option>
			                         </select>
			                    </td>
			                    <td class="label">Rent fee on site :</td>
			                    <td class="value"><input type="text" id="onsitePayAmount" name="onsitePayAmount" style="width: 150px;" /></td>
			                </tr>
			                <tr style="height: 10px;"><td colspan="4">&nbsp;</td></tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="value" colspan="4"><font color="#858585"><font color="#FF8000"><b>In Money Collecting</b></font> --> Finished Money Collect  --> Finished</font></td>
                </tr>                
			</table>
		</div>
		<input type="hidden" id="payOnsite" name="payOnsite" value="" />
		<input type="hidden" id="rentFeeType" name="rentFeeType" value="" />
		<input type="hidden" id="rentAmount" name="rentAmount" value="" />
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
					<button class="word3" onclick="save('SUBMIT')">submit</button>
					<button class="word3" onclick="save('SAVE')">save</button>
				</td>
			</tr>
		</table>
	</div>


</body>
</html>