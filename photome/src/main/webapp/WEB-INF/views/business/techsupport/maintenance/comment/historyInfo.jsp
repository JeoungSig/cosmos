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
    $(document).ready(function() {
    	var claimType = '<c:out value="${historyDto.claimType}" />';

    	if(claimType == 'REQ_PART'){
            $('#tr_postalAddr1').css('display', 'block');
            $('#tr_postalAddr2').css('display', 'block');
            $('#tr_postalAddr3').css('display', 'block');
            $('#tr_postalAddr4').css('display', 'block');
            $('#tr_postalAddr5').css('display', 'block');
        } else {
            $('#tr_postalAddr1').css('display', 'none');
            $('#tr_postalAddr2').css('display', 'none');
            $('#tr_postalAddr3').css('display', 'none');
            $('#tr_postalAddr4').css('display', 'none');
            $('#tr_postalAddr5').css('display', 'none');

        }
    	
        if(claimType == 'RPT_BROKEN'){
            $('#tr_boothStatus1').css('display', 'block');
            $('#tr_boothStatus2').css('display', 'block');
            $('#tr_boothStatus3').css('display', 'block');
        } else {
            $('#tr_boothStatus1').css('display', 'none');
            $('#tr_boothStatus2').css('display', 'none');
            $('#tr_boothStatus3').css('display', 'none');
        }
    });    
</script>
</head>
<body>

	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- Form Table -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<div id="detail_panel" class="detail_panel">
		<table id="detail_table" class="detail_table" cellpadding="0" cellspacing="0" style="width: 700px;" border="0">
			<colgroup>
				<col width="150 px" />
				<col width="200 px" />
				<col width="150 px" />
				<col width="200 px" />
			</colgroup>

			<tr>
				<td colspan="4"><br />
				<h2 class="ckbox"> Claim detail Information</h2></td>
			</tr>
			<tr>
				<td class="label" style="width: 150px;" >Claim Type :</td>
				<td class="value" colspan="3" style="width: 550px;"><c:out value="${historyDto.claimTypeName}" /></td>
			</tr>
			
			<tr id="tr_boothStatus1"><td colspan="4">&nbsp;</td></tr> 
            <tr id="tr_boothStatus2" style="display: none;">
                <td class="label">Booth Status :</td>
                <td class="value" colspan="3"><c:out value="${historyDto.boothStatusName}" /></td>
            </tr>
			<tr id="tr_boothStatus3"><td colspan="4">&nbsp;</td></tr> 
            
            <tr>
                <td class="label">Group :</td>
                <td class="value" colspan="3"><c:out value="${historyDto.groupName }" /></td>
            </tr>    
            <tr>
                <td class="label">Booth :</td>
                <td class="value" colspan="3"><c:out value="${historyDto.boothName }" /></td>
            </tr>
        
            <tr id="tr_postalAddr1"><td colspan="4">&nbsp;</td></tr> 
            <tr id="tr_postalAddr2">
                <td class="label">Postal Zip Code :</td>
                <td class="value"><c:out value="${historyDto.pstPostcd }" /></td>
                <td class="label">Postal State :</td>
                <td class="value"><c:out value="${historyDto.pstState }" /></td>
            </tr>
            <tr id="tr_postalAddr3">
                <td class="label">Postal Suburb :</td>
                <td class="value" colspan="3"><c:out value="${historyDto.pstSuburb }" /> </td>
            </tr>
            <tr id="tr_postalAddr4">
                <td class="label">Postal No/Street :</td>
                <td class="value" colspan="3"><c:out value="${historyDto.pstStreetNo }" /></td>
            </tr>
            <tr id="tr_postalAddr5"><td colspan="4">&nbsp;</td></tr>
             
            <tr>
                <td class="label">Subject :</td>
                <td class="value" colspan="3"><b><c:out value="${historyDto.subject }" /></b></td>
            </tr> 
            <tr>
                <td class="label">Contents :</td> 
                <td class="value" colspan="3"><br /><c:out value="${historyDto.contents }" /></td>
            </tr>

			<c:if test="${!empty attachFileDto.fileName }">
	            <tr><td colspan="4"></td></tr>
	            <tr> 
	                 <td class="label">Attach File :</td>
	                 <td class="value" colspan="3">
	                     <a href="/photome/download/${attachFileDto.fullPath }">${attachFileDto.fileName }</a>
	                 </td>
	            </tr>
	            <tr><td colspan="4">&nbsp;</td></tr> 			 
			</c:if>

            <tr>
                <td class="label">Claim Status :</td>
                <td class="value" colspan="3"><c:out value="${historyDto.claimStatusName }" /></td>
            </tr>
            <tr><td colspan="4">&nbsp;</td></tr> 
               
		</table>
	</div>

	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- Subaction buttons bar & Pagging -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<div id="main_control" class="main_control">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="55%"></td>
				<td width="*" align="left">
				</td>
			</tr>
		</table>
	</div>


</body>
</html>