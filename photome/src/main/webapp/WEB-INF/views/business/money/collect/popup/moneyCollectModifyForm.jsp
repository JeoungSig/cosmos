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
		$('#collectRealIncome').autoNumeric('init', {aSign :  '$ ',vMin : '0.00', vMax : '9999999.99'});
		$('#onsitePayAmount').autoNumeric('init', {aSign :  '$ ',vMin : '0.00', vMax : '9999999.99'});
		
        $('#bankAmount').autoNumeric('init', {aSign : '$ ',vMin : '0.00', vMax : '9999999.99'});
        $('#bankAmount').autoNumeric('set', '<c:out value="${moneyCollectDto.bankAmount}" />');
        
		$('#cashMtr').autoNumeric('init', {aSign :  '$ ',vMin : '0.00', vMax : '9999999.99'});
		$('#coinMtrNow').autoNumeric('init', {vMin : '0', vMax : '9999999'});
		
		$('#onsiteIsPaid > option[value=\'<c:out value="${moneyCollectDto.onsiteIsPaid}"/>\']').attr("selected", "true");
		
		
        // Datepicker 설정
        $(function() {
            var option = {
                  changeMonth: true,
                  dateFormat: 'dd/mm/yy',
                  yearRange:'1940:+0',
                  changeYear: true
                };
            $("#collectDate").datepicker(option);
        });
        
        // 생년월일 항목 설정
        var t = new Date();
        var tDate = t.getDate();
        var tMonth = (t.getMonth()+1);
        if(tMonth < 10) tMonth = '0' + tMonth;
        var tYear = t.getFullYear();
        $('#collectDate').val(tDate + '/' + tMonth + '/' + tYear); 
        
        
        var payOnsite = '<c:out value="${moneyCollectDto.payOnsite}" />';
        if (payOnsite == 'Y'){
            $('#tbl_onsitepay').css('display', 'block');
        } else {
            $('#tbl_onsitepay').css('display', 'none');
        }
        
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
    function save() {
        if (checkMandatory() == false)  return;
        
        // 현장에서 렌트비를 지급하는 경우를 체크한다.
        var payOnsite = $('#payOnsite').val();
        if (payOnsite == 'Y'){
            var onsiteIsPaid = $('#onsiteIsPaid').val();
            var onsitePayAmount =  $('#onsitePayAmount').autoNumeric('get');
            if(onsiteIsPaid == 'N' || onsitePayAmount == null || onsitePayAmount == ''){
                alert('You have to check onsite rent fee filds');
                return;
            }
        }
        
        var collectId           = '<c:out value="${moneyCollectDto.collectId }" />';
        var groupId             = $('#groupId').val();
        var collectDate         = $('#collectDate').val();
        var boothId             = $('#boothId').val();
        var coinMtrNow          = $('#coinMtrNow').autoNumeric('get');
        var collectRealIncome   = $('#collectRealIncome').autoNumeric('get');
        var cashMtr             = $('#cashMtr').autoNumeric('get');
        var onsiteIsPaid        = $('#onsiteIsPaid').val();
        var onsitePayAmount     = $('#onsitePayAmount').autoNumeric('get');
        
        var beforeCoinMtr = $('#beforeCoinMtr').text();
        if(coinMtrNow <= beforeCoinMtr){
            alert('Coin meter must be grater than before value.');
            //$('#coinMtrNow').focus();
            return;
        }         
        
        $.ajax({
            url : "/photome/business/money/collect/MoneyCollectModify.action",
            data : {
            	collectId          : collectId      ,
            	groupId            : groupId      ,
            	collectDate        : collectDate  ,
            	boothId            : boothId      ,
            	coinMtrNow         : coinMtrNow   ,
            	cashMtr            : cashMtr   ,
            	collectRealIncome  : collectRealIncome,
            	onsiteIsPaid       : onsiteIsPaid     ,
            	onsitePayAmount    : onsitePayAmount  ,
            	collectStatus      : "<c:out value="${moneyCollectDto.collectStatus }" />"       },
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
    function getBeforeValues(obj){
        var boothId = obj.value;
        if(boothId == '' || boothId == null) {
            $('#beforeCoinMtr').text("0");
            return;
        }        
        
        $.ajax({ url : "/photome/business/money/collect/BeforeMoneyCollectInfo.action",
					data : "boothId=" + boothId,
					success : callbackGetBeforeValues
				});
	}
	function callbackGetBeforeValues(data) {
		var boothDto = data.jsonObject.boothDto;
		var payOnsite = boothDto.payOnsite;
		var rentFeeType = boothDto.rentFeeType;
		var rentAmount = boothDto.rentAmount;
		
		var collectJson = data.jsonObject2;
        if(collectJson != null){
             var collectDto =  collectJson.recentCollectDto;
             var coinMtrNow = collectDto.coinMtrNow;
             
             if(coinMtrNow == '' || coinMtrNow == null){
                 // 최초인 경우 또는 수금정보를 읽었는데 이전 수금 아이디가 없는 경우
                 $('#beforeCoinMtr').text("0");
             }else{
                 // 이전 수금 아이디가 있는 경우 : 수금한
                 $('#beforeCoinMtr').text(coinMtrNow);
             }
        } else {
                 $('#beforeCoinMtr').text("0");
        }		
		
		$('#onsitePayAmount').val(null);
		$('#onsiteIsPaid > option[value=\'\']').attr("selected", "true");

		// 싸이트에서 바로 렌트비를 지급하는 경우
		$('#payOnsite').val(payOnsite);
		$('#rentAmount').val(rentAmount);
		$('#rentFeeType').val(rentFeeType);

		if (payOnsite == 'Y') {
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
    function checkCoinValue(obj){
        var input = $('#coinMtrNow').autoNumeric('get');
        var beforeCoinMtr = $('#beforeCoinMtr').text();
        
        if(input <= beforeCoinMtr){
            alert('Coin meter must be grater than before value.');
            //obj.focus();
            return;
        } 
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
                    <td class="value"><input id="collectDate" name="collectDate" style="width: 100px;background-color: #E5E5E5;" readonly="readonly"  mandatory="true" value="<c:out value="${moneyCollectDto.collectDate }" />" /></td>
	            </tr>
	            <tr>
	                <td class="label"><span class="required">*</span>Booth :</td>
	                <td colspan="3"><select name="boothId" id="boothId" style="width: 350px" onChange="getBeforeValues(this)"  mandatory="true" ><c:out value="${boothListOptions}" escapeXml="false" /></select></td>
	            </tr>
	            <tr>
	                <td class="label">Collector :</td>
	                <td class="value" colspan="3"><c:out value="${sessionUserName}" /></td>
	            </tr>
	            <tr style="height: 10px;"><td colspan="4">&nbsp;</td></tr>

	            <tr>
	                <td class="label"><span class="required">*</span>Coin meter :</td>
	                <td class="value" colspan="3"><input id="coinMtrNow" name="coinMtrNow" style="width: 150px;"  mandatory="true"  onblur="checkCoinValue(this)" value="<c:out value="${moneyCollectDto.coinMtrNow }" />"  /> &nbsp;&nbsp; <font color="#868686">Before : </font><font id="beforeCoinMtr" color="#868686"><c:out value="${moneyCollectDto.coinMtrBfr }" /></font></td>
	            </tr>            
	            <tr>
	                <td class="label"><span class="required">*</span>Collect Amount :</td>
	                <td class="value"><input id="collectRealIncome" name="collectRealIncome" style="width: 200px;"  mandatory="true"  onblur="setOnsiteRentFee(this)" value="<c:out value="${moneyCollectDto.collectRealIncome }" />"   /></td>
                    <td class="label"><span class="required">*</span>Cash meter :</td>
                    <td class="value"><input id="cashMtr" name="cashMtr" style="width: 150px;"  mandatory="true" value="<c:out value="${moneyCollectDto.cashMtr }" />" /></td>
	            </tr>            
                <tr>
                    <td class="label">Deposit :</td>
                    <td class="value"><p id="bankAmount" /><c:out value="${moneyCollectDto.bankAmount }" /></td>
                    <td class="label">Deposit Date :</td>
                    <td class="value"><c:out value="${moneyCollectDto.bankDt }" /></td>
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
			                    <td class="value"><input type="text" id="onsitePayAmount" name="onsitePayAmount" style="width: 150px;" value="<c:out value="${moneyCollectDto.onsitePayAmount }" />" /></td>
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
					<button class="word3" onclick="save()">save</button>
				</td>
			</tr>
		</table>
	</div>


</body>
</html>