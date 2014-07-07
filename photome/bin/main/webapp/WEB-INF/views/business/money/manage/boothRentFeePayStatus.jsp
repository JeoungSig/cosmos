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
    	$('#year').focus();
    }
</script> 
<script type="text/javascript">    
    function search() {
    	var year    = $('#year').val();
        var url = '/photome/business/money/manage/boothrentfeepay/status/Main.action?year=' + year;
    	document.location.href = url;
    }
    function viewGroupInfo(groupId) {
        var url = '/photome/business/money/manage/boothrentfeepay/GroupInfo.action?groupId=' + groupId;
        var windowName = 'business/resmanage/group/GroupInfo';
        var win = openPopupForm(url, windowName, '720', '680');
    }
    function viewRentPayInfo(groupId,year,month) {
    	if(groupId == '' || groupId == null ||year == '' || year == null ||month == '' || month == null){
    		alert('No information for display');
    		return;
    	}
    	
        var url = '/photome/business/money/manage/boothrentfeepay/BoothRentFeePayInfo.action?groupId=' + groupId + '&year=' + year + '&month=' + month;
        var windowName = 'business/money/manage/boothrentfeepay/BoothRentFeePayInfo';
        var win = openPopupForm(url, windowName, '740', '340');
    }    
 
 </script>   
<script type="text/javascript">
    function setReturnValue(returnValue) {
    	pageLog(returnValue.message, "info");
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
        <table class="search_table">
            <tr>
                <td class="label">Year :</td>
                <td><select name="year" id="year" style="width: 100px" onchange="search()"><c:out value="${yearOptions}" escapeXml="false"/></select></td>
                <td style="text-align: right;vertical-align: bottom;"><button class="search" onclick="search();">Find</button></td>
            </tr>
        </table>
    </div>

    <div class="grid_table_panel" style="border-bottom-width: 0px; width: 95%;">
        <table id="grid_table" class="grid_table" cellspacing="0" cellpadding="0" style="border-bottom-width: 0px;">
            <thead>
                <tr>
                    <th>Group Name</th>
                    <th>Jan</th>
                    <th>Feb</th>
                    <th>Mar</th>
                    <th>Apr</th>
                    <th>May</th>
                    <th>Jun</th>
                    <th>Jul</th>
                    <th>Aug</th>
                    <th>Sep</th>
                    <th>Oct</th>
                    <th>Nov</th>
                    <th>Dev</th>
                    <th>Total</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
            <tr style="background-color: #000000;">
                <td width="150px"></td>
                <td width="100px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_01 }" /></font></b></td>
                <td width="100px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_02 }" /></font></b></td>
                <td width="100px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_03 }" /></font></b></td>
                <td width="100px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_04 }" /></font></b></td>
                <td width="100px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_05 }" /></font></b></td>
                <td width="100px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_06 }" /></font></b></td>
                <td width="100px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_07 }" /></font></b></td>
                <td width="100px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_08 }" /></font></b></td>
                <td width="100px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_09 }" /></font></b></td>
                <td width="100px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_10 }" /></font></b></td>
                <td width="100px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_11 }" /></font></b></td>
                <td width="100px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_12 }" /></font></b></td>
                <td width="100px" align="right"><b><font color="#F20079"><c:out value="${rentFeeTableFoot.month_total }" /></font></b></td>
                <td width="5px"></td>
            </tr>            
            <c:forEach var="statusDto" items="${boothRentFeeStatusList}" varStatus="stat">
                <tr style="height: 35px">
                    <td style="background-color: #FFFFE6;"><font color="#006A35"><b><a href="javascript:viewGroupInfo('<c:out value="${statusDto.groupId }" />')"><c:out value="${statusDto.boothGroup.groupName }" /></a></b></font></td>
                    <td align="right">
                        <c:if test="${statusDto.month_01_status == 'NO_PAID' }"><img src="/photome/resources/images/common/check_img1.gif"/></c:if>
                        <c:if test="${statusDto.month_01 != '-'}"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','01')"><c:out value="${statusDto.month_01 }" /></a></c:if>
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_02_status == 'NO_PAID' }"><img src="/photome/resources/images/common/check_img1.gif"/></c:if>
                        <c:if test="${statusDto.month_02 != '-'}"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','02')"><c:out value="${statusDto.month_02 }" /></a></c:if>
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_03_status == 'NO_PAID' }"><img src="/photome/resources/images/common/check_img1.gif"/></c:if>
                        <c:if test="${statusDto.month_03 != '-'}"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','03')"><c:out value="${statusDto.month_03 }" /></a></c:if>
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_04_status == 'NO_PAID' }"><img src="/photome/resources/images/common/check_img1.gif"/></c:if>
                        <c:if test="${statusDto.month_04 != '-'}"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','04')"><c:out value="${statusDto.month_04 }" /></a></c:if>
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_05_status == 'NO_PAID' }"><img src="/photome/resources/images/common/check_img1.gif"/></c:if>
                        <c:if test="${statusDto.month_05 != '-'}"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','05')"><c:out value="${statusDto.month_05 }" /></a></c:if>
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_06_status == 'NO_PAID' }"><img src="/photome/resources/images/common/check_img1.gif"/></c:if>
                        <c:if test="${statusDto.month_06 != '-'}"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','06')"><c:out value="${statusDto.month_06 }" /></a></c:if>
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_07_status == 'NO_PAID' }"><img src="/photome/resources/images/common/check_img1.gif"/></c:if>
                        <c:if test="${statusDto.month_07 != '-'}"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','07')"><c:out value="${statusDto.month_07 }" /></a></c:if>
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_08_status == 'NO_PAID' }"><img src="/photome/resources/images/common/check_img1.gif"/></c:if>
                        <c:if test="${statusDto.month_08 != '-'}"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','08')"><c:out value="${statusDto.month_08 }" /></a></c:if>
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_09_status == 'NO_PAID' }"><img src="/photome/resources/images/common/check_img1.gif"/></c:if>
                        <c:if test="${statusDto.month_09 != '-'}"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','09')"><c:out value="${statusDto.month_09 }" /></a></c:if>
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_10_status == 'NO_PAID' }"><img src="/photome/resources/images/common/check_img1.gif"/></c:if>
                        <c:if test="${statusDto.month_10 != '-'}"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','10')"><c:out value="${statusDto.month_10 }" /></a></c:if>
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_11_status == 'NO_PAID' }"><img src="/photome/resources/images/common/check_img1.gif"/></c:if>
                        <c:if test="${statusDto.month_11 != '-'}"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','11')"><c:out value="${statusDto.month_11 }" /></a></c:if>
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_12_status == 'NO_PAID' }"><img src="/photome/resources/images/common/check_img1.gif"/></c:if>
                        <c:if test="${statusDto.month_12 != '-'}"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','12')"><c:out value="${statusDto.month_12 }" /></a></c:if>
                    </td>
                    <td  align="right" style="background-color: #E2E2E2;"><b><font color="#0000AA"><c:out value="${statusDto.month_total }" /></font></b></td>
                    <td></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <br/>
    <br/>
    <br/>


</body>
</html>