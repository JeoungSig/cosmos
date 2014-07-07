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
    function loadPage() {}
    
    $(document).ready(function() {
        $('#refundAmount').autoNumeric('init', {aSign : '$ ', vMin : '0.00', vMax : '9999999.99'});
        $('#refundAmount').autoNumeric('set', '<c:out value="${refundDto.refundAmount}" />');
    });  
</script>

<script type="text/javascript">
    function modify() {
    	document.location.href="/photome/business/money/refund/MoneyRefundModifyForm.action?refundId=" + <c:out value="${refundDto.refundId }" />;
    }
    function deleteRefundInfo() {
        
        var refundId  = '<c:out value="${refundDto.refundId}" />';
        
        $.ajax({
            url : "/photome/business/money/refund/DeleteRefundInfo.action",
            data : "refundId=" + refundId,
            success : callbackDeleteInfo
        });

    }
    function callbackDeleteInfo(data) {
        var returnValue = {
                message : 'Deleted Refund Information : <c:out value="${refundDto.refundId}" />'
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
                    <col width="170px" />
                    <col width="230px" />
                    <col width="170px" />
                    <col width="*" />
                </colgroup>

                <tr><td colspan="4" style="height: 15px;"></td></tr>
                <tr>
                    <td class="label">Booth :</td>
                    <td class="value" colspan="3"><c:out value="${refundDto.boothName }" /></td>
                </tr>
                <tr>
                    <td class="label">Req. Date :</td>
                    <td class="value" colspan="3"><c:out value="${refundDto.reqDt }" /></td>
                </tr>
                <tr><td colspan="4" style="height: 15px;"></td></tr>
                                
                <tr>
                    <td class="label">Last Name :</td>
                    <td class="value"><c:out value="${refundDto.reqLastname }" /></td>
                    <td class="label">First Name :</td>
                    <td class="value"><c:out value="${refundDto.reqFirstname }" /></td>
                </tr>
                <tr>
                    <td class="label">Contact info. :</td>
                    <td class="value" colspan="3"><c:out value="${refundDto.reqContactInfo }" /></td>
                </tr>
                <tr><td colspan="4" style="height: 15px;"></td></tr>
                
                <tr>
                    <td class="label">Zip Code :</td>
                    <td class="value"><c:out value="${refundDto.reqPostcd }" /></td>
                    <td class="label">State :</td>
                    <td class="value"><c:out value="${refundDto.reqState }" /></td>
                </tr>
                <tr>
                    <td class="label">No/Street :</td>
                    <td class="value" colspan="3"><c:out value="${refundDto.reqStreetNo }" /></td>
                </tr>
                <tr>
                    <td class="label">Suburb :</td>
                    <td class="value" colspan="3"><c:out value="${refundDto.reqSuburb }" /></td>
                </tr>
                <tr><td colspan="4" style="height: 15px;"></td></tr>
                
                <tr>
                    <td class="label">Status :</td>
                    <td class="value"><c:out value="${refundDto.refundStatusName }" /></td>
                    <td class="label">Refund Date :</td>
                    <td class="value"><c:out value="${refundDto.refundDt }" /></td>
                </tr>
                                
                <tr>
                    <td class="label">Refund Amount :</td>
                    <td class="value" colspan="3"><p id="refundAmount" /></td>
                </tr>                
                <tr>
                    <td class="label">Reason :</td> 
                    <td class="value" colspan="3"><c:out value="${refundDto.refundReason }" /></td>
                </tr>
                <tr><td colspan="4" style="height: 15px;"></td></tr>
                
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
                    <button class="word3" onclick="modify()">modify</button>
                    <button class="word3" onclick="deleteRefundInfo()">delete</button>
                </td>
            </tr>
        </table>
    </div>


</body>
</html>