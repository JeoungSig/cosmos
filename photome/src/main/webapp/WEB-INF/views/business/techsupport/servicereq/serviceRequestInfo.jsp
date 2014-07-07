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
    function loadPage() {
    }
</script>
<script type="text/javascript">
    $(document).ready(function() {
    	var claimType = '<c:out value="${historyDto.claimType}" />';

    	if(claimType == 'REQ_PART'){
            $('#tbl_postalAddr').css('display', 'block');
        } else {
            $('#tbl_postalAddr').css('display', 'none');

        }
    	
        if(claimType == 'RPT_BROKEN'){
            $('#tbl_boothStatus').css('display', 'inline');
        } else {
            $('#tbl_boothStatus').css('display', 'none');
        }
    });    
</script>
<script type="text/javascript">
    function modify() {
        document.location.href = "/photome/business/techsupport/servicereq/ServiceRequestModifyForm.action?historyId=" + <c:out value="${historyDto.historyId}" />;
    }
    function active(historyId){
        $.ajax({
            url : "/photome/business/techsupport/servicereq/ServiceRequestModify.action",
            data : {
            	historyId : historyId,
            	claimStatus : 'ONGOING'
            },
            success : callbackAfterChange,
        });
    }
    function closing(historyId){
        $.ajax({
            url : "/photome/business/techsupport/servicereq/ServiceRequestModify.action",
            data : {
                historyId : historyId,
            	claimStatus : 'CLOSED'
            },
            success : callbackAfterChange,
        });
    }
    function callbackAfterChange(data) {
        var returnValue = {
                message : "New code information modified"
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
            <tr>
                <td class="label"></td>
                <td class="value" colspan="3">
                   <table id="tbl_postalAddr" style="display: none;">
                        <tr>
                            <td class="label" style="border-bottom-width: 0px; background-color: #FFF7F2;">Postal Zip Code :</td>
                            <td class="value" style="border-bottom-width: 0px;"><c:out value="${historyDto.pstPostcd }" /></td>
                            <td class="label" style="border-bottom-width: 0px; background-color: #FFF7F2;">Postal State :</td>
                            <td class="value" style="border-bottom-width: 0px;"><c:out value="${historyDto.pstState }" /></td>
                        </tr>
                        <tr>
                            <td class="label" style="border-bottom-width: 0px; background-color: #FFF7F2;">Postal Suburb :</td>
                            <td class="value"  style="border-bottom-width: 0px;" colspan="3"><c:out value="${historyDto.pstSuburb }" /></td>
                        </tr>
                        <tr>
                            <td class="label" style="border-bottom-width: 0px; background-color: #FFF7F2;">Postal No/Street :</td>
                            <td class="value"  style="border-bottom-width: 0px;" colspan="3"><c:out value="${historyDto.pstStreetNo }" /></td>
                        </tr>
                   </table>
                   
                   <table id="tbl_boothStatus" style="display: none; width: 100%;">
                        <tr>
                            <td class="label" style="border-bottom-width: 0px; width: 150px; background-color: #FFF7F2;">Booth Status :</td>
                            <td class="value" colspan="3" style="border-bottom-width: 0px;"><c:out value="${historyDto.boothStatusName}" /></td>
                        </tr>
                   </table>
                   <br/>
                </td>
            </tr> 			
            
            <tr>
                <td class="label">Group :</td>
                <td class="value" colspan="3"><c:out value="${historyDto.groupName }" /></td>
            </tr>    
            <tr>
                <td class="label">Booth :</td>
                <td class="value" colspan="3"><c:out value="${historyDto.boothName }" /></td>
            </tr>
        
            <tr>
                <td class="label">Subject :</td>
                <td class="value" colspan="3"><b><c:out value="${historyDto.subject }" /></b></td>
            </tr> 
            <tr>
                <td class="label">Contents :</td> 
                <td class="value" colspan="3"><br /><c:out value="${historyDto.contents }" /></td>
            </tr>

			<c:if test="${!empty attachFileDto.fileName }">
	            <tr> 
	                 <td class="label">Attach File :</td>
	                 <td class="value" colspan="3">
	                     <a href="/photome/download/${attachFileDto.fullPath }">${attachFileDto.fileName }</a>
	                 </td>
	            </tr>
			</c:if>

            <tr>
                <td class="label">Claim Status :</td>
                <td class="value" colspan="3"><c:out value="${historyDto.claimStatusName }" /></td>
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
				<td align="right">
				    <c:if test="${sessionUserId == 'admin' || sessionUserId == historyDto.creator}" >
						<c:if test="${historyDto.claimStatus == 'CLOSED'  }" ><button class="word10" onclick="active('<c:out value="${historyDto.historyId }" />');">activate claim</button></c:if>
						<c:if test="${historyDto.claimStatus == 'ONGOING'  }" ><button class="word5" onclick="closing('<c:out value="${historyDto.historyId }" />');">close claim</button></c:if>
					    <button class="word3" onclick="modify();">modify</button>
				    </c:if>
				</td>
				<td width="80px">&nbsp;</td> 
			</tr>
		</table>
	</div>


</body>
</html>