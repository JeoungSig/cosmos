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
        $('#bankTotalAmount').autoNumeric('init', {aSign :  '$ ',vMin : '0.00', vMax : '9999999.99'});
        
        // Datepicker 설정
        $(function() {
            var option = {
                  changeMonth: true,
                  dateFormat: 'dd/mm/yy',
                  yearRange:'1940:+0',
                  changeYear: true
                };
            $("#bankDt").datepicker(option);
        });
        
        // 생년월일 항목 설정
        var t = new Date();
        var tDate = t.getDate();
        var tMonth = (t.getMonth()+1);
        if(tMonth < 10) tMonth = '0' + tMonth;
        var tYear = t.getFullYear();
        $('#bankDt').val(tDate + '/' + tMonth + '/' + tYear); 
    });  
</script>
<script type="text/javascript"> 
    function loadPage() {
    	search();
    }
    function search() {
    	searchCollectList();
    }
</script> 
 
<script type="text/javascript">
    function searchCollectList() {
        $.ajax({
            url : "/photome/business/money/deposit/CollectListForDeposit.action",
            success : callbackSearchCollectList,
        });
        
    }
    
    function callbackSearchCollectList(data) {

    	 $('#grid_table tbody').empty();
         
         var script_template = '<tr>'
             + '    <td align="center"> <input type="checkbox" name="depositCheck" value="{collectId}" onclick="checkAllDeposit()" style="border: 0px;"></td>'
             + '    <td> {groupName}</td>'
             + '    <td> {boothName}</td>'
             + '    <td> {collectDate}</td>'
             + '    <td align="right"><font color="#0080FF"><b> {collectRealIncome} </b></font></td> '
             + '    <td> <input type="text" style="width: 100px;text-align: right;" maxlength="8" id="depositAmt_{collectId}" name="depositAmt_{collectId}" onblur="round(this, 2)" onkeydown="digitchk(this)" value="{bankAmount}"></td> '
                                                                    + '</tr>';

         var json = data.jsonList;
         var dataCnt = json.length;
         
         var trObj = null;
         var cnt = 0;
         if (dataCnt > 0) {
             $.each(json, function(i, obj) {
            	 cnt++;
                 trObj = script_template.interpolate({
                	 cnt : cnt,
                	 groupName   : obj.groupName,
                	 boothName   : obj.boothName,
                	 bankAmount   : obj.bankAmount,
                	 collectId : obj.collectId,
                	 collectDate : obj.collectDate,
                	 collectRealIncome : addCommas(obj.collectRealIncome)
                 });
                 $(trObj).appendTo('#grid_table tbody');
             });
         } else {
             $('<tr><td colspan="4"><br/>No registed information<br/><br/></td></tr>').appendTo('#grid_table tbody');
         }
    }
    
</script>
<script type="text/javascript">

    function checkAllDeposit() {
    	var checkCollectId = "";
    	var totalAmt = "0.00";
    	var depositAmt = "0.00";
    	var depositAmtId = null;
    	
    	var allDepositRows = "";
    	$('input:checkbox[name="depositCheck"]').each(function(){
    		if(this.checked){
	    		checkCollectId = this.value;     
	    		depositAmtId = "depositAmt_" + checkCollectId;
	    		depositAmt = $('input:text[id="'+ depositAmtId +'"]').val();
	    		if(depositAmt == '' || depositAmt == null){
	    			alert('You must be fill in the deposit amount for the check item');
	    			$('input:text[id="'+ depositAmtId +'"]').focus();
	    			return;
	    		}
	    		
	    		totalAmt = parseFloat(totalAmt) + parseFloat(depositAmt); 
	    		
	    		allDepositRows = allDepositRows + checkCollectId + ":" + depositAmt + "|";
    		}
    	});
    	
    	if(totalAmt == '0.00' || totalAmt == null || totalAmt == ''){
    	}else{
	  		$('#bankTotalAmount').autoNumeric('set', totalAmt);
    	}
    	
	    $('#allDepositRows').val(allDepositRows);
    }
    
</script>

<script type="text/javascript">
    function setReturnValue(returnValue) {
        $('#svcName').val(returnValue.svcName);
        search();
    }
</script>
<script type="text/javascript">
	function round(obj, n)  {
	    var retrunValue = "";
	    var input = obj.value;
	    var i = Math.pow(10, n);
	    retrunValue = Math.round(input* i) / i;
	    if(input == '' || input == null) return;
	    if(isNaN(retrunValue)) {
	        obj.value = "";
	    } else if (retrunValue == 0){
	          obj.value = "0";
	    }else{
	        obj.value = retrunValue;
	    }
	    checkAllDeposit();
	    
	} 
	
    function save(status) {
        if (checkMandatory() == false)  return;
        
        checkAllDeposit();
        
        var allDepositRows = $('#allDepositRows').val();
        var bankTotalAmount = $('#bankTotalAmount').autoNumeric('get');
        var bankDt = $('#bankDt').val();
        var comment = $('#comment').val();
        
        if(bankTotalAmount == '' || bankTotalAmount == null || bankDt == '' || bankDt == null ) {
        	alert('Deposit money is empty !!');
        	return;
        }

        $.ajax({
            url : "/photome/business/money/deposit/BankDepositRegist.action",
            data : {
            	status  : status   ,
                allDepositRows  : allDepositRows   ,
                bankTotalAmount : bankTotalAmount  ,
                comment : comment,
                bankDt  : bankDt       },
            success : callbackSave
        });
    }
    
    function callbackSave(data) {
        var returnValue = {
                message : "Money was deposited"
        };
        setOpenerDataset(returnValue);
    }	
</script>

</head>
<body>

    <div id="detail_panel" class="detail_panel">
        <table id="detail_table" class="detail_table" cellpadding="0" cellspacing="0">
            <colgroup>
                <col width="150px" />
                <col width="200px" />
                <col width="150px" />
                <col width="*" />
            </colgroup>

            <tr>
                <td class="label"><span class="required">*</span>Deposit Amount ($)</td>
                <td class="value"><input id="bankTotalAmount" name="bankTotalAmount" style="width: 150px;background-color: #BFFFDF;"  mandatory="true" readonly="readonly" mandatory="true" /></td>
                <td class="label"><span class="required">*</span>Deposit Date</td>
                <td class="value"><input id="bankDt" name="bankDt" style="width: 100px;background-color: #E5E5E5;" readonly="readonly"  mandatory="true" /></td>
            </tr> 
            <tr>
                <td class="label">Comment</td>
                <td class="value" colspan="2"><input id="comment" name="comment" style="width: 350px;" maxlength="50"/></td>
                <td class="value"><button class="word5" onclick="save('COLLECTING')">Save</button> <button class="word5" onclick="save('COLLECT_FINISH')">Submit</button></td>
            </tr> 
        </table>
        <br/>
        <input type="hidden" name="allDepositRows" id="allDepositRows" value="" />
     
        <table id="grid_table" class="grid_table" width="100%" cellspacing="0" cellpadding="0">
            <thead>
                <tr>
                    <th width='50px'></th>
                    <th width='100px'>Group</th>
                    <th width='100px'>Booth</th>
                    <th width='100px'>Collect Date</th>
                    <th width='130px' align="right">($) Collect Amt</th>
                    <th width='100px'>Deposit Amt</th>
                </tr>
            </thead>
            <tbody>
                <tr><td colspan="4"><br/>No registed information<br/><br/></td></tr>
            </tbody>
        </table>
    </div>
    <br/>
    <br/>
    
</body>
</html>