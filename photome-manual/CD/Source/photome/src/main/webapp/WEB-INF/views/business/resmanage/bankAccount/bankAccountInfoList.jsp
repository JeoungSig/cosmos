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
    function addAccount() {
        var url = '/photome/business/resmanage/bankAccount/BankAccountInfoRegistForm.action';
        var windowName = 'business/resmanage/bankAccount/BankAccountInfoRegistForm';
        var win = openPopupForm(url, windowName, '500', '300');
    }     
    function viewAccountInfo(acctId) {
        var url = '/photome/business/resmanage/bankAccount/BankAccountInfo.action?acctId=' + acctId;
        var windowName = 'business/resmanage/bankAccount/BankAccountInfo';
        var win = openPopupForm(url, windowName, '500', '300');
    }
/*     
    function getUserInfo(userId) {
        var url = '/photome/business/resmanage/booth/UserDetailInfo.action?userId=' + userId;
        var windowName = 'sysAdmin/framework/UserDetailInfo';
        var win = openPopupForm(url, windowName, '720', '540');
    }
    function viewGroupInfo(groupId) {
        var url = '/photome/business/resmanage/group/GroupInfo.action?groupId=' + groupId;
        var windowName = 'business/resmanage/group/GroupInfo';
        var win = openPopupForm(url, windowName, '720', '520');
    } 
     */
    
</script>   
<script type="text/javascript">
    function search() {
        var bankName             = $('#bankName').val();
        
        $.ajax({
            url : "/photome/business/resmanage/bankAccount/BankAccountList.action",
            data : "bankName=" + bankName,
            success : callbackSearch,
        });
        
        pageLog('data retirive complete','info');
    }

    function callbackSearch(data) {

        var table_template = '<table id="table_data" class="dataTable">'
            + '<thead>'
            + '    <tr>'
            + '        <th width="200px">Account name</th>'
            + '        <th width="100px">Bank</th>'
            + '        <th width="100px">BSB</th>'
            + '        <th width="100px">Account no.</th>'
            + '        <th width="100px">Holder name</th>'
            + '        <th width="*" align="left">Update date</th>'
            + '    </tr>'
            + '</thead>'
            + '<tfoot>'
            + '    <tr>'
            + '        <th style="text-align:right" colspan="6"></th>'
            + '    </tr>'
            + '</tfoot>';  
            
            $('#grid_array').html(table_template); 
            
            var json = data.list;
            var dataCnt = json.length;
            
            // 테이블의 타이틀 설정
            var colM = [ { title: "Account name", dataType: "string" },
                         { title: "Bank", dataType: "string" },
                         { title: "BSB", dataType: "string" },
                         { title: "Account no.", dataType: "string", align: "right" },
                         { title: "Holder name", dataType: "string", align: "right"},
                         { title: "Update date", dataType: "string", align: "right" }
                      ]; 
            
            if (dataCnt > 0) {
                var data = new Array();
                var element = null;
                $.each(json, function(i, obj) { 
                     element = new Array();
                     element[0] = ('<a href=\"javascript:viewAccountInfo(\''+ obj.acctId + '\')" style="text-decoration: none;">' + obj.acctName + '</a>');
                     element[1] = obj.bankNameName;
                     element[2] = obj.bankBsb;
                     element[3] = obj.bankAcctNo;
                     element[4] = obj.bankAcctHolderName;
                     element[5] = obj.updateDt.substr(0,10);
                     data[i] = element;
                }); 
            } 
            
            $('#table_data').dataTable( {
                "aaData": data, 
                "aoColumns" : colM,
                "sPaginationType": "full_numbers"
                });
    }
    
    
</script>

<script type="text/javascript">
	function setReturnValue(returnValue) {
		pageLog("하나의 정보가 추가되었습니다.", "info");
	    $('#bankName').val(returnValue.message);
	    search();
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
    <div id="grid_array"></div>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Subaction buttons bar & Pagging -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="main_control" class="main_control">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="80%">
                    <!-- Paging -->
                    <div class="paging"></div>
                </td>
                <td width="*" align="left">
                    <button class="word7" onclick="addAccount();">Add Account</button>
                </td>
            </tr>
        </table>
    </div>


</body>
</html>