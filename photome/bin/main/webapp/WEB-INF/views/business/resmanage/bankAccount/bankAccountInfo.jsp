<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<script type="text/javascript">
    function loadPage() {
    }
</script>
<script type="text/javascript">
    function modify() {
        document.location.href = "/photome/business/resmanage/bankAccount/BankAccountInfoUpdateForm.action?acctId=" + <c:out value="${bankAcctInfoDto.acctId}" />;
    }
</script>

<script type="text/javascript">
    function deleteAccount() {
    	
        var acctId = '<c:out value="${bankAcctInfoDto.acctId}" />';

        $.ajax({
                url : "/photome/business/resmanage/bankAccount/BankAccountInfoDelete.action",
                data : "acctId=" + acctId,
                success : callbackDeleteAccount
        });

    }
    function callbackDeleteAccount(data) {
    	pageLog("Deleted Account Information");

        var returnValue = {
            bankName : $('#bankName').val()
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
                    <col width="120px" />
                    <col width="*" />
                </colgroup>

                <tr>
                    <td class="label">Bank :</td>
                    <td class="value"><c:out value="${bankAcctInfoDto.bankNameName}" /></td>
                </tr>
                <tr>
                    <td class="label">Account Name :</td>
                    <td class="value"><b><c:out value="${bankAcctInfoDto.acctName}" /></b></td>
                </tr>
                <tr>
                    <td class="label">BSB no. :</td>
                    <td class="value"><c:out value="${bankAcctInfoDto.bankBsb}" /></td>
                </tr>
                <tr>
                    <td class="label">Account No. :</td>
                    <td class="value"><c:out value="${bankAcctInfoDto.bankAcctNo}" /></td>
                </tr>
                <tr>
                    <td class="label">Account Holder Name :</td>
                    <td class="value"><c:out value="${bankAcctInfoDto.bankAcctHolderName}" /></td>
                </tr>

                <tr><td colspan="2">&nbsp;</td></tr>

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
                <td width="65%"></td>
                <td width="*" align="left">
                    <button class="word3" onclick="deleteAccount();">delete</button>
                    <button class="word3" onclick="modify();">modify</button>
                </td>
            </tr>
        </table>
    </div>


</body>
</html>