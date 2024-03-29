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
	function addCodeInfo() {
		if (checkMandatory() == false)
			return;
		var systemCd = $('#systemCd').val();
		var categoryCd = $('#categoryCd').val();
		var codeValue = $('#codeValue').val();
		$.ajax({
			url : "/cosmos/framework/codemanager/ExistCodeInfo.action",
			data : {
				systemCd : systemCd,
				categoryCd : categoryCd,
				codeValue : codeValue
			},
			success : callbackAddCodeInfo,
		});
	}
	function callbackAddCodeInfo(data) {
		var json = data.message;
		var dataExist = json;

		if (dataExist == true) {
			pageLog('저장하려는 데이터가 이미 존재합니다.', 'warn');
			return;
		}

		// 데이터 저장
		saveCodeInfo();
	}

	// 데이터를 실제로 저장한다.
	function saveCodeInfo() {
		var systemCd = $('#systemCd').val();
		var categoryCd = $('#categoryCd').val();
		var codeValue = $('#codeValue').val();
		var codeName = $('#codeName').val();
		var descript = $('#descript').val();
		var useYn = $('#useYn').val();
		var codeLvl = $('#codeLvl').val();

		$.ajax({
			url : "/cosmos/framework/codemanager/CodeRegist.action",
			data : {
				systemCd : systemCd,
				categoryCd : categoryCd,
				codeValue : codeValue,
				codeName : codeName,
				descript : descript,
				useYn : useYn,
				codeLvl : codeLvl
			},
			success : callbackSaveCodeInfo
		});

	}
	function callbackSaveCodeInfo(data) {
		pageLog("New code information registed");
		
		// 오픈너에게 데이터셋(JSON)을 넘기고 창을 닫는다. : 오프너에게 setReturnValue(data)함수가 구현되어 있어야 한다.
		// 필요한 값만 넘겨준다.
        var returnValue = {
        		systemCd : $('#systemCd').val(),
        		categoryCd : $('#categoryCd').val()
        }
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
				<col width="25%" />
				<col width="25%" />
				<col width="15%" />
				<col width="*" />
			</colgroup>
			<tr>
				<td class="label"><span class="required">*</span>System Code :</td>
				<td class="value" colspan="3"><input type="text" id="systemCd" name="systemCd" style="width: 100px;" mandatory="true" /></td>
			</tr>
			<tr>
				<td class="label"><span class="required">*</span>Category Code :</td>
				<td class="value" colspan="3"><input type="text" id="categoryCd" name="categoryCd" style="width: 150px;" mandatory="true" /></td>
			</tr>
			<tr>
				<td class="label"><span class="required">*</span>Code Value :</td>
				<td class="value" colspan="3"><input type="text" id="codeValue" name="codeValue" style="width: 250px;" mandatory="true" /></td>
			</tr>
			<tr>
				<td class="label"><span class="required">*</span>Code Name :</td>
				<td class="value" colspan="3"><input type="text" id="codeName" name="codeName" style="width: 415px;" mandatory="true" /></td>
			</tr>
			<tr>
				<td class="label">Code description :</td>
				<td class="value" colspan="3"><input type="text" id="descript" name="descript" style="width: 305px;" mandatory="false" /></td>
			</tr>
			<tr>
				<td class="label">Is Active :</td>
				<td class="value"><select id="useYn" name="useYn" style="width: 100px"><option value="Y" selected>Active</option>
						<option value="N">Disable</option></select></td>
				<td class="label">Code Level :</td>
				<td class="value"><select id="codeLvl" name="codeLvl" style="width: 100px">
						<option value="1" selected>1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
				</select></td>
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
					<button class="word3" onclick="addCodeInfo();">add</button>
				</td>
			</tr>
		</table>
	</div>


</body>
</html>