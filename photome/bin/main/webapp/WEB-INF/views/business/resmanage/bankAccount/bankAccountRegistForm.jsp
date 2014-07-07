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
	function save() {
		if (checkMandatory() == false)
			return;

		var bankName = $('#bankName').val();
		var acctName = $('#acctName').val();
		var bankBsb = $('#bankBsb').val();
		var bankAcctNo = $('#bankAcctNo').val();
		var bankAcctHolderName = $('#bankAcctHolderName').val();

		$.ajax({
				url : "/photome/business/resmanage/bankAccount/BankAccountInfoRegist.action",
				data : {
					bankName : bankName,
					acctName : acctName,
					bankBsb : bankBsb,
					bankAcctNo : bankAcctNo,
					bankAcctHolderName : bankAcctHolderName
				},
				success : callbackSave
		});

	}
	function callbackSave(data) {
		pageLog("New Information registed");

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
					<td class="label"><span class="required">*</span>Bank :</td>
					<td class="value"><select name="bankName" id="bankName" style="width: 200px" mandatory="true"><c:out value="${bankList}" escapeXml="false" /></select></td>
				</tr>
				<tr>
					<td class="label"><span class="required">*</span>Account Name :</td>
					<td class="value"><input type="text" id="acctName" name="acctName" style="width: 300px;" mandatory="true" /></td>
				</tr>
				<tr>
					<td class="label"><span class="required">*</span>BSB no. :</td>
					<td class="value"><input type="text" id="bankBsb" name="bankBsb" style="width: 150px;" mandatory="true" maxlength="6"/></td>
				</tr>
				<tr>
					<td class="label"><span class="required">*</span>Account No. :</td>
					<td class="value"><input type="text" id="bankAcctNo" name="bankAcctNo" style="width: 300px;" mandatory="true" /></td>
				</tr>
				<tr>
					<td class="label"><span class="required">*</span>Account Holder Name :</td>
					<td class="value"><input type="text" id="bankAcctHolderName" name="bankAcctHolderName" style="width: 300px;" mandatory="true" /></td>
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
				<td width="85%"></td>
				<td width="*" align="left">
					<button class="word3" onclick="save();">save</button>
				</td>
			</tr>
		</table>
	</div>


</body>
</html>