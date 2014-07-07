<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script language="javascript">
    window.focus();
</script>

<script type="text/javascript">
    $(document).ready(function() {
       // $('#bankTotalAmount').autoNumeric('init', {aSign :  '$ ',vMin : '0.00', vMax : '9999999.99'});
    });  
</script>
<script type="text/javascript"> 
    function loadPage() {
    }
</script> 
 

<script type="text/javascript">
    function depositCancel() {
    	
    	var depositId = '<c:out value="${moneyDepositDto.depositId}"/>';
        
        $.ajax({
            url : "/photome/business/money/deposit/BankDepositCancel.action",
            data : "depositId=" + depositId,
            success : callbackDepositCancel
        });
    }
    
    function callbackDepositCancel(data) {
        var returnValue = {
                message : "Deposit canceled"
        };
        setOpenerDataset(returnValue);
    }   
    
    function depositSubmit() {
        
    	var depositId = '<c:out value="${moneyDepositDto.depositId}"/>';
        $.ajax({
            url : "/photome/business/money/deposit/BankDepositChangeStatus.action",
            data : {
            	depositId : depositId,
            	status : "COLLECT_FINISH"
            },
            success : callbackDepositSubmit
        });
    }
    
    function callbackDepositSubmit(data) {
        var returnValue = {
                message : "Deposit Submited"
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
                <td class="label">Deposit Amount ($)</td>
                <td class="value"><font color="#EC0076"><b><fmt:formatNumber value="${moneyDepositDto.bankTotalAmount}" pattern="#,###.##" /></b></font></td>
                <td class="label">Deposit Date</td>
                <td class="value"><c:out value="${moneyDepositDto.bankDt}"/></td>
                <td class="label">Status</td>
                <td class="value"><font color="#800000"><c:out value="${moneyDepositDto.statusName}"/></font></td>
            </tr>
            <tr>
                <td class="label">Comment</td>
                <td class="value" colspan="5"><c:out value="${moneyDepositDto.comment}"/></td>
            </tr> 
             
            <tr>
                <td class="label">Person of Deposit</td>
                <td class="value"><c:out value="${moneyDepositDto.creatorName}"/></td>
                <td class="value" colspan="4" align="right">
                    <c:choose>
                        <c:when test="${moneyDepositDto.status == 'COLLECTING' }">
                            <button class="word10" onclick="depositCancel()">Cancel Deposit</button>
                            <button class="word7" onclick="depositSubmit()">Submit</button>
                        </c:when>
                    </c:choose>
                </td>
            </tr> 
        </table>
        <br/>
        
        <table id="grid_table" class="grid_table" width="100%" cellspacing="0" cellpadding="0">
            <thead>
                <tr>
                    <th width='100px'>Group</th>
                    <th width='200px'>Booth</th>
                    <th width='100px'>Collect Date</th>
                    <th width='150px' style="text-align: right;">($) Collect Amt &nbsp;</th>
                    <th class="150px"  style="text-align: right;">Deposit Amt &nbsp;</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
	                <c:when test="${empty moneyCollectDtoList}">
	                    <tr><td colspan="5"><br/>No registed information<br/><br/></td></tr>
	                </c:when>
	                <c:otherwise>
	                    <c:forEach var="collectDto" items="${moneyCollectDtoList}" varStatus="stat">
		                    <tr>
		                      <td><c:out value="${collectDto.groupName}"/></td>
		                      <td><c:out value="${collectDto.boothName}"/></td>
		                      <td><c:out value="${collectDto.collectDate}"/></td>
		                      <td align="right"><font color="#0080FF"><b><fmt:formatNumber value="${collectDto.collectRealIncome}" pattern="#,###.##" /> </b></font></td>
		                      <td align="right"><font color="#800000"><b><fmt:formatNumber value="${collectDto.bankAmount}" pattern="#,###.##" /></b></font></td>
		                    </tr>
	                    </c:forEach>
	                </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
    
   <br/>    
   <br/>
   <br/>
    
</body>
</html>