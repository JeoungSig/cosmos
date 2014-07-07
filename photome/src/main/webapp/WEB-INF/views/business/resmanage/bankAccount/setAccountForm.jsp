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
    	search();
    }
</script>   
<script type="text/javascript">
    function search() {
    	var bankName             = $('#bankName').val();
        
        $.ajax({
            url : "/photome/business/money/collect/SetBankAccountList.action",
            data : "bankName=" + bankName,
            success : callbackSearch,
        });
        pageLog('data retirive complete','info');
    }

    function callbackSearch(data) {
        $('#grid_table tbody').empty();

        var script_template = '<tr>'
            + '    <td class="key"> {acctName} </td> '
            + '    <td> {bankNameName} </td> '
            + '    <td> {bankBsb} </td>'
            + '    <td> {bankAcctNo} </td>'
            + '    <td> {bankAcctHolderName} </td>'
            + '    <td> <button class="word6" onclick="select(\'{acctId}\',\'{acctName}\')">select</button></td>'
            + '</tr>';

        var json = data.list;
        var dataCnt = json.length;

        var trObj = null;
        if (dataCnt > 0) {
            $.each(json, function(i, obj) {
                trObj = script_template.interpolate({
                    acctId   : obj.acctId,
                    acctName : obj.acctName,
                    bankNameName : obj.bankNameName,
                    bankBsb : obj.bankBsb,
                    bankAcctNo : obj.bankAcctNo,
                    bankAcctHolderName : obj.bankAcctHolderName
                });
                $(trObj).appendTo('#grid_table tbody');
            });
        } else {
            $('<tr><td colspan="5"><br/>No registed information<br/><br/></td></tr>').appendTo('#grid_table tbody');
        }
    }
</script>

<script type="text/javascript">
	function select(bankAccount, bankAccountDisplayName) {
	    opener.document.getElementById('bankAccount').value = bankAccount;
	    opener.document.getElementById('bankAccountDisplayName').value = bankAccountDisplayName;
        self.close();
	}
</script>


</head>
<body>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Search -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="search" style="width: 95%">
        <table class="search_table" border="0"> 
            <tr>
                <td class="label">Bank :</td>
                <td><select name="bankName" id="bankName" style="width: 200px"><c:out value="${bankList}" escapeXml="false"/></select></td>
                <td><button class="search" onclick="search();">Find</button></td>
            </tr>
        </table>
    </div>


    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Table List -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div class="grid_table_panel">
        <table id="grid_table" class="grid_table" width="100%" cellspacing="0" cellpadding="0">
            <thead>
                <tr>
                    <th width='200px'>Account name</th>
                    <th width='100px'>Bank</th>
                    <th width='100px'>BSB</th>
                    <th width='100px'>Account no.</th>
                    <th width='100px'>Holder name</th>
                    <th class="last">&nbsp;</th>
                </tr>
            </thead>
            <tbody>
                <!-- Code List -->
                <tr><td colspan="6"><br/>No information<br/><br/></td></tr>
            </tbody>
        </table>
    </div>

    <br/>
    <br/>

</body>
</html>