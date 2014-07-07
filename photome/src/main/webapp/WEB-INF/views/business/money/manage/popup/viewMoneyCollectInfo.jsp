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
		 $('#filmMtrNow').autoNumeric('init', {vMin : '0', vMax : '9999999'});
		 $('#filmMtrNow').autoNumeric('set', '<c:out value="${moneyCollectDto.filmMtrNow}" />');
		 
		 $('#coinMtrNow').autoNumeric('init', {vMin : '0', vMax : '9999999'});
		 $('#coinMtrNow').autoNumeric('set', '<c:out value="${moneyCollectDto.coinMtrNow}" />');
		 $('#coinMtrBfr').autoNumeric('init', {vMin : '0', vMax : '9999999'});
		 $('#coinMtrBfr').autoNumeric('set', '<c:out value="${moneyCollectDto.coinMtrBfr}" />');
		 
		 $('#cashMtr').autoNumeric('init', {vMin : '0', vMax : '9999999'});
		 $('#cashMtr').autoNumeric('set', '<c:out value="${moneyCollectDto.cashMtr}" />');
		 
		 $('#collectRealIncome').autoNumeric('init', {aSign : '$ ', vMin : '0.00', vMax : '9999999.99'});
		 $('#collectRealIncome').autoNumeric('set', '<c:out value="${moneyCollectDto.collectRealIncome}" />');
		 
		 $('#bankAmount').autoNumeric('init', {aSign : '$ ',vMin : '0.00', vMax : '9999999.99'});
		 $('#bankAmount').autoNumeric('set', '<c:out value="${moneyCollectDto.bankAmount}" />');
		 
		 $('#onsitePayAmount').autoNumeric('init', {aSign : '$ ', vMin : '0.00', vMax : '9999999.99'});
		 $('#onsitePayAmount').autoNumeric('set', '<c:out value="${moneyCollectDto.onsitePayAmount}" />');
		 		
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
        
        
        var payOnsite = '<c:out value="${moneyCollectDto.payOnsite}" />';
        if (payOnsite == 'Y'){
            $('#tbl_onsitepay').css('display', 'block');
        } else {
            $('#tbl_onsitepay').css('display', 'none');
        }
        
	});  
</script>

<script type="text/javascript">
    function loadPage() {}
</script>

<script type="text/javascript">
    function viewCollectInfo(collectId) {
    	document.location.href = '/photome/business/money/manage/MoneyCollectInfo.action?collectId=' + collectId;
    }
</script>
<script type="text/javascript">
    function modifyCollectStatus(collectStatus) {
        var collectId  = '<c:out value="${moneyCollectDto.collectId}" />';
        var collectStatus    = collectStatus;
        
        $.ajax({
            url : "/photome/business/money/manage/ChangeCollectStatus.action",
            data : {
            	collectId  : collectId,
                collectStatus    : collectStatus       },
            success : callbackModifyCollectStatus
        });

    }
    function callbackModifyCollectStatus(data) {
    	pageLog("Information updated");
        
        var returnValue = {
                groupId : '<c:out value="${moneyCollectDto.groupId}" />'
        };
        setOpenerDataset(returnValue);
    }
</script>
<script type="text/javascript">
    function deleteCollectInfo(collectId) {
        
        $.ajax({
                url : "/photome/business/money/collect/MoneyCollectDelete.action",
                data : "collectId=" + collectId,
                success : callbackDelete
        });

    }
    function callbackDelete(data) {
        var returnValue = {
            message : 'Deleted money collect info'
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
                <td class="label">Group :</td> 
                <td><c:out value="${moneyCollectDto.groupName }" /></td>
                   <td class="label">Collect Date :</td>
                   <td class="value"><c:out value="${moneyCollectDto.collectDate }" /></td>
            </tr>
            <tr>
                <td class="label">Booth :</td>
                <td colspan="3"><c:out value="${moneyCollectDto.boothName }" /></td>
            </tr>
            <tr>
                <td class="label">Collector :</td>
                <td class="value" colspan="3"><c:out value="${moneyCollectDto.collectCollectorName }" /></td>
            </tr>
            <tr style="height: 10px;"><td colspan="4">&nbsp;</td></tr>

            <tr>
                <td class="label">Coin meter :</td>
                <td class="value"><p id="coinMtrNow"/></td> 
				<td class="label">Coin meter(bfr) :</td>
				<td class="value"><p id="coinMtrBfr" /></td>
            </tr>            
            <tr>
            </tr>
			<tr>
				<td class="label">Collect Amount :</td>
				<td class="value"><p id="collectRealIncome" /></td>
				<td class="label">Cash meter :</td>
                <td class="value"><p id="cashMtr" /></td> 
				
			</tr>
			<tr>
				<td class="label">Deposit :</td>
				<td class="value"><p id="bankAmount" /></td>
				<td class="label">Deposit Date :</td>
				<td class="value"><c:out value="${moneyCollectDto.bankDt }" /></td>
			</tr>

			<tr>
				<td colspan="4" style="width: 170px;">
					<table id="tbl_onsitepay" style="display: none; width: 100%;">
						<tr style="height: 10px;">
							<td colspan="4">&nbsp;</td>
						</tr>
						<tr>
							<td class="label" style="width: 170px;">Is paid on site :</td>
							<td class="value" style="width: 230px;"><c:choose>
									<c:when test="${moneyCollectDto.onsiteIsPaid == 'Y' }">Already paid</c:when>
									<c:when test="${moneyCollectDto.onsiteIsPaid == 'N' }">Before paid</c:when>
									<c:otherwise>-</c:otherwise>
								</c:choose></td>
							<td class="label" style="width: 170px;">Rent fee on site :</td>
							<td class="value" style="width: *;"><p id="onsitePayAmount" /></td>
						</tr>
						<tr style="height: 10px;">
							<td colspan="4">&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="value" colspan="4"><font color="#858585"> <c:choose>
							<c:when test="${moneyCollectDto.collectStatus ==  'COLLECTING'}">
								<font color="#FF8000"><b>In Money Collecting</b></font>
							</c:when>
							<c:otherwise>In Money Collecting</c:otherwise>
						</c:choose>
						 --> 
						<c:choose>
							<c:when test="${moneyCollectDto.collectStatus ==  'COLLECT_FINISH'}">
								<font color="#FF8000"><b>Finished Money Collect</b></font>
							</c:when>
							<c:otherwise>Finished Money Collect</c:otherwise>
						</c:choose>
						 --> 
						<c:choose>
							<c:when test="${moneyCollectDto.collectStatus ==  'FINALCHK_FINISH'}">
								<font color="#FF8000"><b>Finished</b></font>
							</c:when>
							<c:otherwise>Finished</c:otherwise>
						</c:choose>
				</font></td>
			</tr>
		</table>
	</div>
	<input type="hidden" id="payOnsite" name="payOnsite" value="" />
	<input type="hidden" id="rentFeeType" name="rentFeeType" value="" />
	<input type="hidden" id="rentAmount" name="rentAmount" value="" />

	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- Subaction buttons bar & Pagging -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<div id="main_control" class="main_control">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td align="right">
                    <c:if test="${moneyCollectDto.collectStatus == 'COLLECT_FINISH' ||   moneyCollectDto.collectStatus == 'FINALCHK_FINISH'}">
                         <button class="word6" onclick="modifyCollectStatus('COLLECTING')">Initialize</button>
                    </c:if>
                    <c:if test="${moneyCollectDto.collectStatus == 'COLLECT_FINISH'}">
                         <button class="word6" onclick="modifyCollectStatus('FINALCHK_FINISH')">Finalize</button>
                    </c:if>
                    <button class="word3" onclick="deleteCollectInfo('<c:out value="${moneyCollectDto.collectId }" />')">delete</button>
                </td>
                <td width="40"> &nbsp;</td>
            </tr>		
			<%-- 			<tr>
				<td width="75%"></td>
				<td width="*" align="right">
				    <c:if test="${moneyCollectDto.preCollectId != null }">
				        <a href="javascript:viewCollectInfo('<c:out value="${moneyCollectDto.preCollectId }" />')"> <img src="/photome/resources/images/common/page-prev-gray.gif" border="0" alt="View before collection information"/></a>
				    </c:if>
				    <c:if test="${moneyCollectDto.nextCollectId != null }">
				        <a href="javascript:viewCollectInfo('<c:out value="${moneyCollectDto.nextCollectId }" />')"> <img src="/photome/resources/images/common/page-next-gray.gif" border="0" alt="View next collection information"/></a>
				    </c:if>
				</td>
			</tr> --%>
		</table>
	</div>

</body>
</html>