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
        $('#refundAmount').autoNumeric('init', {aSign :  '$ ',vMin : '0.00', vMax : '9999999.99'});
        
        // Datepicker 설정
        $(function() {
            var option = {
                  changeMonth: true,
                  dateFormat: 'dd/mm/yy',
                  yearRange:'1940:+0',
                  changeYear: true
                };
            $("#reqDt").datepicker(option);
            $("#refundDt").datepicker(option);
        });
        
        // 생년월일 항목 설정
        var t = new Date();
        var tDate = t.getDate();
        var tMonth = (t.getMonth()+1);
        if(tMonth < 10) tMonth = '0' + tMonth;
        var tYear = t.getFullYear();
        $('#reqDt').val(tDate + '/' + tMonth + '/' + tYear); 
    });  
</script>
<script type="text/javascript">    
    function selectAddress() {
        var url = '/photome/business/money/refund/SelectAddressFrom.action';
        var windowName = 'business/money/refund/SelectAddressFrom';
        var win = openPopupForm(url, windowName, '600', '470');
    }
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
        
        var boothId          = $('#boothId').val();
        var reqDt            = $('#reqDt').val();
        var reqLastname      = $('#reqLastname').val();
        var reqFirstname     = $('#reqFirstname').val();
        var reqContactInfo   = $('#reqContactInfo').val();
        var reqPostcd        = $('#reqPostcd').val();
        var reqState         = $('#reqState').val();
        var reqStreetNo      = $('#reqStreetNo').val();
        var reqSuburb        = $('#reqSuburb').val();
        var refundStatus     = $('#refundStatus').val();
        var refundDt         = $('#refundDt').val();
        var refundAmount     = $('#refundAmount').autoNumeric('get');
        var refundReason     = $('#refundReason').val();
        
        if(refundStatus == 'REFUND'){
            if(refundAmount == '' || refundAmount == null || refundDt == '' || refundDt == null){
                alert('You have to fill in the Refund date and Refund Amount');
                return;
            }
        }
        
        $.ajax({
            url : "/photome/business/money/refund/MoneyRefundRegist.action",
            data : {
            	boothId        : boothId ,
                reqDt          : reqDt   ,
                reqLastname    : reqLastname    ,
                reqFirstname   : reqFirstname   ,
                reqContactInfo : reqContactInfo ,
                reqPostcd      : reqPostcd      ,
                reqState       : reqState       ,
                reqStreetNo    : reqStreetNo    ,
                reqSuburb      : reqSuburb      ,
                refundStatus   : refundStatus   ,
                refundDt       : refundDt       ,
                refundAmount   : refundAmount   ,
                refundReason   : refundReason       },
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
    function setAddress(object){
        var addrZipcd = $('#reqPostcd').val();
        if(!isNumeric(addrZipcd)) {
            alert('Zip code must be numeric code.');
            return;
        }
        
        $.ajax({
            url : "/photome/common/common/PostalAddress.action",
            data : "addrZipcd=" + addrZipcd,
            success : callbackSetAddress,
        });
    }

    function callbackSetAddress(data) {
        $('#reqState').val('');
        $('#reqSuburb').empty();
        
        var script_template = '<option value=\"{locality}\">{locality}</option>';
        
        var state = data.state;
        var json = data.postAddrList;
        
        $('#reqState').val(state);
        
        var option = null;
        $.each(json, function(i, obj) {
            option = script_template.interpolate({
                locality : obj.locality
            });
            $(option).appendTo('#reqSuburb');
        });
    }   
</script> 
<script type="text/javascript">
    function setBooth() {
        var url = '/photome/business/money/refund/SelectBooth.action';
        var windowName = 'business/money/refund/SelectBooth';
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
                    <td class="label"><span class="required">*</span>Booth :</td>
                    <td class="value" colspan="3">
                        <input type="text" id="boothName" name="boothName" style="width: 350px; background-color: #E5E5E5;" readonly="readonly" mandatory="true" />
                        <input type="hidden" id="boothId" name="boothId"/>                    
                        <img src="/photome/resources/images/common/i_3.gif" onclick="setBooth();" style="cursor:hand; height: 13px; vertical-align: bottom;" />
                    </td>
                </tr>
                <tr>
                    <td class="label"><span class="required">*</span>Req. Date :</td>
                    <td class="value" colspan="3"><input id="reqDt" name="reqDt" style="width: 150px;background-color: #E5E5E5;" readonly="readonly"  mandatory="true" /></td>
                </tr>
                <tr style="height: 15px;"><td colspan="4"></td></tr>
                                
                <tr>
                    <td class="label"><span class="required">*</span>Last Name :</td>
                    <td class="value"><input type="text" id="reqLastname" name="reqLastname" style="width: 150px;" maxlength="25" mandatory="true"/></td>
                    <td class="label"><span class="required">*</span>First Name :</td>
                    <td class="value"><input type="text" id="reqFirstname" name="reqFirstname" style="width: 150px;"  maxlength="25"  mandatory="true"/></td>
                </tr>
                <tr>
                    <td class="label"><span class="required">*</span>Contact info. :</td>
                    <td class="value" colspan="3"><input type="text" id="reqContactInfo" name="reqContactInfo" style="width: 380px;" mandatory="true"/></td>
                </tr>
                <tr style="height: 15px;"><td colspan="4"></td></tr>
                
                <tr>
                    <td class="label"><span class="required">*</span>Zip Code :</td>
                    <td class="value">
                        <input type="text" id="reqPostcd" name="reqPostcd" style="width: 100px;;background-color: #DFEFFF;" mandatory="true" onblur="setAddress(this);" />
                        <img src="/photome/resources/images/common/i_3.gif" onclick="selectAddress();" style="cursor:hand; height: 13px; vertical-align: bottom;" />
                    </td>
                    <td class="label"><span class="required">*</span>State :</td>
                    <td class="value"><input type="text" id="reqState" name="reqState" style="width: 150px; background-color: #E5E5E5;" mandatory="true" readonly="readonly" /></td>
                </tr>
                <tr>
                    <td class="label"><span class="required">*</span>No/Street :</td>
                    <td class="value" colspan="3"><input type="text" id="reqStreetNo" name="reqStreetNo" style="width: 380px;" mandatory="true" /></td>
                </tr>
                <tr>
                    <td class="label"><span class="required">*</span>Suburb :</td>
                    <td class="value" colspan="3"><select name="reqSuburb" id="reqSuburb" style="width: 150px;" mandatory="true"></select></td>
                </tr>
                <tr style="height: 15px;"><td colspan="4"></td></tr>
                
                <tr>
                    <td class="label"><span class="required">*</span>Status :</td>
                    <td class="value"><select name="refundStatus" id="refundStatus" style="width: 150px" mandatory="true" ><c:out value="${refundStatusListOptions}" escapeXml="false" /></select></td>
                    <td class="label">Refund Date :</td>
                    <td class="value"><input id="refundDt" name="refundDt" style="width: 150px;background-color: #E5E5E5;" readonly="readonly" /></td>
                </tr>
                                
                <tr>
                    <td class="label">Refund Amount :</td>
                    <td class="value" colspan="3"><input type="text" id="refundAmount" name="refundAmount" style="width: 200px;" /></td>
                </tr>                
                <tr>
                    <td class="label"><span class="required">*</span>Reason :</td> 
                    <td class="value" colspan="3"><input id="refundReason" name="refundReason" style="width: 500px;" maxlength="300" mandatory="true"/></td>
                </tr>
                <tr style="height: 15px;"><td colspan="4"></td></tr>
                
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
                    <button class="word3" onclick="save()">save</button>
                </td>
            </tr>
        </table>
    </div>


</body>
</html>