<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ page import="com.cosmos.framework.service.ServiceDto"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script language="javascript">
    window.focus();
</script>
<script type="text/javascript">
	function loadPage() {
		$('#useYn > option[value=<c:out value="${service.useYn}"/>]').attr("selected", "true"); // 콤보박스 초기화
		$('#isMenu > option[value=<c:out value="${service.isMenu}"/>]').attr("selected", "true"); // 콤보박스 초기화
		$('#isDummy > option[value=\'<c:out value="${service.isDummy}"/>\']').attr("selected", "true"); // 콤보박스 초기화
		$('#authRequired > radio[value=\'<c:out value="${service.svcPrefix}"/>\']').attr("selected", "true"); // 라디오버튼 초기화
		$('input:radio[name=authRequired]:input[value=\'<c:out value="${service.authRequired}"/>\']').attr("checked", true); // 라디오버튼 초기화
		
		if($('#isDummy').val() == 'Y'){
            $('#svcUrl').attr('disabled' , 'true').removeAttr('mandatory');
            $('#svcPrefix').attr('disabled' , 'true').removeAttr('mandatory');			
		}
	}
</script>
<script type="text/javascript">

	// 데이터를  수정한다.
	function modifyServiceInfo() {
		
        if (checkMandatory() == false)
            return;
        
		var svcId = <c:out value="${service.svcId}"/>;
		var svcName = $('#svcName').val();
		var svcDesc = $('#svcDesc').val();
		var svcPrefix = $('#svcPrefix').val();
		var svcUrl = $('#svcUrl').val();
		var isMenu = $('#isMenu').val();
		var creator = $('#creator').val();
        var authRequired = $('INPUT:RADIO[NAME=authRequired]:checked').val();;
        var useYn = $('#useYn').val();
        var isDummy = $('#isDummy').val();
        var upperSvc = $('#upperSvc').val();

		$.ajax({
			url : "/photome/framework/servicemanager/ServiceModify.action",
			data : {
				svcId : svcId,
				svcName : svcName,
				svcDesc : svcDesc,
                isDummy : isDummy,
                upperSvc : upperSvc,
				svcPrefix : svcPrefix,
				svcUrl : svcUrl,
				isMenu : isMenu,
				upperSvc : upperSvc,
				authRequired : authRequired,
				useYn : useYn
			},
			success : callbackModifyServiceInfo
		});

	}
	function callbackModifyServiceInfo(data) {
		pageLog("Role information is modified");
		
		// 오픈너에게 데이터셋(JSON)을 넘기고 창을 닫는다. : 오프너에게 setReturnValue(data)함수가 구현되어 있어야 한다.
		// 필요한 값만 넘겨준다.
        var returnValue = {
        		svcName : $('#svcName').val()
        }
		setOpenerDataset(returnValue);
	}
	
    // 데이터를  삭제한다.
    function deleteServiceInfo() {
    	var svcId = <c:out value="${service.svcId}"/>;
        $.ajax({
            url : "/photome/framework/servicemanager/ServiceDelete.action",
            data : {
            	svcId : svcId
            },
            success : callbackDeleteServiceInfo
        });

    }
    function callbackDeleteServiceInfo(data) {
    	pageLog("Service information is deleted");
        
        var returnValue = {
        		svcName : ''
        }
        setOpenerDataset(returnValue);
    }	
</script>


<script type="text/javascript">
	function setDummySvc(dummy){
	    if(dummy.value == 'Y'){
	        $('#svcUrl').attr('disabled' , 'true')
	                    .removeAttr('mandatory');
	        
	        $('#svcPrefix').attr('disabled' , 'true')
	                       .removeAttr('mandatory');
	        
	    }else{
	        $('#svcUrl').attr('disabled','false')
	                    .attr('mandatory','true')
	                    .removeAttr('disabled')
	                    .css('background-color: #ffffff');
	        $('#svcPrefix').attr('disabled','false')
	                    .attr('mandatory','true')
	                    .removeAttr('disabled')
	                    .css('background-color: #ffffff');          
	    }
	}
	
	function setMenuSvc(isMenu){
	    if(isMenu.value == 'N'){
	        $('#upperSvc').val('');
	        $('#upperSvcNm').attr('disabled' , 'true').val('');
	        
	    }else{
	        $('#upperSvcNm').removeAttr('disabled');
	    }
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
                <col width="20%" />
                <col width="35%" />
                <col width="20%" />
                <col width="*" />
            </colgroup>
            <tr>
                <td class="label"><span class="required">*</span>Service Name :</td>
                <td class="value"><input type="text" id="svcName" name="svcName" style="width: 150px;" mandatory=true value="<c:out value="${service.svcName}"/>"/></td>
                <td class="label">Service ID :</td>
                <td class="value"><c:out value="${service.svcId}"/></td>
            </tr>
            <tr>
                <td class="label"><span class="required">*</span>Description :</td>
                <td class="value" colspan="3"><input type="text" id="svcDesc" name="svcDesc" style="width: 350px;" mandatory=true value="<c:out value="${service.svcDesc}"/>"/></td>
            </tr>
            <tr>
                <td class="label">Is Menu :</td>
                <td class="value">
                        <select id="isMenu" name="isMenu" mandatory=true style="width: 100px;" onchange="setMenuSvc(this);">
                                <option value="Y">Yes</option>
                                <option value="N">No</option>
                        </select>
                </td>
                <td class="label">Upper Service :</td>
                <td class="value">
                    <input type="text" id="upperSvc" name="upperSvc" style="width: 150px;" value="<c:out value="${service.upperSvc}"/>"/>
                    <input type="hidden" id="upperSvcNm" name="upperSvcNm" value="<c:out value="${service.upperSvc}"/>"/>
                </td>                
            </tr>           
            <tr>
                <td class="label"><span class="required">*</span>Is dummy :</td>
                <td class="value" colspan="3">
                        <select id="isDummy" name="isDummy" mandatory=true style="width: 100px;" onchange="setDummySvc(this);">
                                <option value="N">No</option>
                                <option value="Y">Yes</option>
                        </select>
                </td>
            </tr>
            <tr>
                <td class="label">Service URL :</td>
                <td class="value" colspan="3">
                     <c:forEach var="prefix" items="${urlPrefix}">
                         <c:if test="${prefix.codeValue == service.svcPrefix}"> <c:out value="${prefix.codeName}"/> - <c:out value="${prefix.codeValue}"/></c:if>
                     </c:forEach>
                     <c:out value="${service.svcUrl}"/>
                     <input type="hidden" id="svcPrefix" name="svcPrefix" value="<c:out value="${service.svcPrefix}"/>"/>
                     <input type="hidden" id="svcUrl" name="svcUrl" value="<c:out value="${service.svcUrl}"/>"/>
                </td>
            </tr>
            <tr>
                <td class="label"><span class="required">*</span>Authorized :</td>
                <td class="value">
                    <input type="radio" id="authRequiredY" name="authRequired" mandatory="true" value='Y'/>  Required<br/>
                    <input type="radio" id="authRequiredN" name="authRequired" mandatory="true" value='N'/>  No Required 
                </td>
                <td class="label"><span class="required">*</span>Is Active :</td>
                <td class="value">
                    <select id="useYn" name="useYn" style="width: 100px"  mandatory=true>
                            <option selected></option>
                            <option value="Y">Active</option>
                            <option value="N">Disable</option>
                    </select>
                </td>
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
				<td width="65%"></td>
				<td width="*" align="left">
					<button class="word3" onclick="deleteServiceInfo();">delete</button>
					<button class="word3" onclick="modifyServiceInfo();">modify</button>
				</td>
			</tr>
		</table>
	</div>


</body>
</html>