<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<style type="text/css">
	TABLE, A {
	  font-size: 12px;
	}
    a{
       text-decoration: none;
    }
    
</style>

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
        var win = openPopupForm(url, windowName, '720', '520');
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
    	document.location.reload();
    	pageLog(returnValue.message, "info");
    }    
</script>
</head>
<body>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Search -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="search">
        <table class="search_table">
            <tr>
                <td class="label">Year :</td>
                <td><select name="year" id="year" style="width: 100px" onchange="search()"><c:out value="${yearOptions}" escapeXml="false"/></select></td>
                <td style="text-align: right;vertical-align: bottom;"><button class="search" onclick="search();">Find</button></td>
            </tr>
        </table>
    </div>

    <div id="detail_panel" class="detail_panel" style="border-bottom-width: 0px;"> 
        <table id="detail_table" class="detail_table" cellspacing="3" cellpadding="5" style="font-size: small; background-color: #8080C0;" border="1">
            <tr style="height: 10px;background-color: #E2E2E2;vertical-align: bottom;"> 
                 <td style="border-right-style: hidden;">&nbsp;</td>
                 <td style="text-align: right;">Jan</td>
                 <td style="text-align: right;">Feb</td>
                 <td style="text-align: right;">Mar</td>
                 <td style="text-align: right;">Apr</td>
                 <td style="text-align: right;">May</td>
                 <td style="text-align: right;">Jun</td>
                 <td style="text-align: right;">Jul</td>
                 <td style="text-align: right;">Aug</td>
                 <td style="text-align: right;">Sep</td>
                 <td style="text-align: right;">Oct</td>
                 <td style="text-align: right;">Nov</td>
                 <td style="text-align: right;">Dec</td>
                 <td style="text-align: right;"></td>
            </tr>
            <tr style="background-color: #000000;height: 20px;">
                <td width="150px"></td>
                <td width="80px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_01 }" /></font></b></td>
                <td width="80px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_02 }" /></font></b></td>
                <td width="80px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_03 }" /></font></b></td>
                <td width="80px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_04 }" /></font></b></td>
                <td width="80px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_05 }" /></font></b></td>
                <td width="80px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_06 }" /></font></b></td>
                <td width="80px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_07 }" /></font></b></td>
                <td width="80px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_08 }" /></font></b></td>
                <td width="80px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_09 }" /></font></b></td>
                <td width="80px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_10 }" /></font></b></td>
                <td width="80px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_11 }" /></font></b></td>
                <td width="80px" align="right"><b><font color="#DBDBDB"><c:out value="${rentFeeTableFoot.month_12 }" /></font></b></td>
                <td width="100px" align="right"><b><font color="#F20079"><c:out value="${rentFeeTableFoot.month_total }" /></font></b></td>
            </tr>            
            <c:forEach var="statusDto" items="${boothRentFeeStatusList}" varStatus="stat">
                <tr style="height: 20px;background-color: #FFFFFF;">
                    <td style="background-color: #FFFFE6;"><font color="#006A35"><b><a href="javascript:viewGroupInfo('<c:out value="${statusDto.groupId }" />')"><c:out value="${statusDto.boothGroup.groupName }" /></a></b></font></td>
                    <td align="right">
                        <c:if test="${statusDto.month_01 != '-'}">
	                        <c:choose>
	                            <c:when test="${statusDto.month_01_status == 'NO_PAID' }"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','01')"><font color="#FF0000"><c:out value="${statusDto.month_01 }" /></font></a></c:when>
	                            <c:otherwise><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','01')"><c:out value="${statusDto.month_01 }" /></a></c:otherwise>
	                        </c:choose>
                        </c:if>
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_02 != '-'}">
                            <c:choose>
                                <c:when test="${statusDto.month_02_status == 'NO_PAID' }"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','02')"><font color="#FF0000"><c:out value="${statusDto.month_02 }" /></font></a></c:when>
                                <c:otherwise><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','02')"><c:out value="${statusDto.month_02 }" /></a></c:otherwise>
                            </c:choose>
                        </c:if>                    
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_03 != '-'}">
                            <c:choose>
                                <c:when test="${statusDto.month_03_status == 'NO_PAID' }"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','03')"><font color="#FF0000"><c:out value="${statusDto.month_03 }" /></font></a></c:when>
                                <c:otherwise><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','03')"><c:out value="${statusDto.month_03 }" /></a></c:otherwise>
                            </c:choose>
                        </c:if>
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_04 != '-'}">
                            <c:choose>
                                <c:when test="${statusDto.month_04_status == 'NO_PAID' }"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','04')"><font color="#FF0000"><c:out value="${statusDto.month_04 }" /></font></a></c:when>
                                <c:otherwise><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','04')"><c:out value="${statusDto.month_04 }" /></a></c:otherwise>
                            </c:choose>
                        </c:if>                    
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_05 != '-'}">
                            <c:choose>
                                <c:when test="${statusDto.month_05_status == 'NO_PAID' }"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','05')"><font color="#FF0000"><c:out value="${statusDto.month_05 }" /></font></a></c:when>
                                <c:otherwise><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','05')"><c:out value="${statusDto.month_05 }" /></a></c:otherwise>
                            </c:choose>
                        </c:if> 
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_06 != '-'}">
                            <c:choose>
                                <c:when test="${statusDto.month_06_status == 'NO_PAID' }"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','06')"><font color="#FF0000"><c:out value="${statusDto.month_06 }" /></font></a></c:when>
                                <c:otherwise><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','06')"><c:out value="${statusDto.month_06 }" /></a></c:otherwise>
                            </c:choose>
                        </c:if> 
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_07 != '-'}">
                            <c:choose>
                                <c:when test="${statusDto.month_07_status == 'NO_PAID' }"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','07')"><font color="#FF0000"><c:out value="${statusDto.month_07 }" /></font></a></c:when>
                                <c:otherwise><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','07')"><c:out value="${statusDto.month_07 }" /></a></c:otherwise>
                            </c:choose>
                        </c:if> 
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_08 != '-'}">
                            <c:choose>
                                <c:when test="${statusDto.month_08_status == 'NO_PAID' }"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','08')"><font color="#FF0000"><c:out value="${statusDto.month_08 }" /></font></a></c:when>
                                <c:otherwise><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','08')"><c:out value="${statusDto.month_08 }" /></a></c:otherwise>
                            </c:choose>
                        </c:if> 
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_09 != '-'}">
                            <c:choose>
                                <c:when test="${statusDto.month_09_status == 'NO_PAID' }"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','09')"><font color="#FF0000"><c:out value="${statusDto.month_09 }" /></font></a></c:when>
                                <c:otherwise><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','09')"><c:out value="${statusDto.month_09 }" /></a></c:otherwise>
                            </c:choose>
                        </c:if> 
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_10 != '-'}">
                            <c:choose>
                                <c:when test="${statusDto.month_10_status == 'NO_PAID' }"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','10')"><font color="#FF0000"><c:out value="${statusDto.month_10 }" /></font></a></c:when>
                                <c:otherwise><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','10')"><c:out value="${statusDto.month_10 }" /></a></c:otherwise>
                            </c:choose>
                        </c:if> 
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_11 != '-'}">
                            <c:choose>
                                <c:when test="${statusDto.month_11_status == 'NO_PAID' }"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','11')"><font color="#FF0000"><c:out value="${statusDto.month_11 }" /></font></a></c:when>
                                <c:otherwise><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','11')"><c:out value="${statusDto.month_11 }" /></a></c:otherwise>
                            </c:choose>
                        </c:if> 
                    </td>
                    <td align="right">
                        <c:if test="${statusDto.month_12 != '-'}">
                            <c:choose>
                                <c:when test="${statusDto.month_12_status == 'NO_PAID' }"><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','12')"><font color="#FF0000"><c:out value="${statusDto.month_12 }" /></font></a></c:when>
                                <c:otherwise><a href="javascript:viewRentPayInfo('<c:out value="${statusDto.groupId }" />','<c:out value="${year }" />','12')"><c:out value="${statusDto.month_12 }" /></a></c:otherwise>
                            </c:choose>
                        </c:if> 
                    </td>
                    <td  align="right" style="background-color: #E2E2E2;"><b><font color="#0000AA"><c:out value="${statusDto.month_total }" /></font></b></td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <br/>
    <br/>
    <br/>


</body>
</html>