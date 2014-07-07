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
	// 데이터를 실제로 저장한다.
	function addServiceInfo() {
        if (checkMandatory() == false)
            return;
        
	    var svcPrefix = $('#svcPrefix').val();
	    var svcUrl = $('#svcUrl').val();
	    
	    $.ajax({
	        url : "/photome/framework/servicemanager/ExistServiceByUrl.action",
	        data : {
	            svcPrefix : svcPrefix,
	            svcUrl : svcUrl
	        },
	        success : callbackCheckExistService
	    });
	}
	function callbackCheckExistService(data) {
	
	    if(data.status == 'true'){
	    	pageLog(data.message, "warn");
	        return;
	    }else{
	    	addServiceInfo2();
	    }
	}

    function addServiceInfo2() {
        var svcName = $('#svcName').val();
        var svcDesc = $('#svcDesc').val();
        var svcPrefix = $('#svcPrefix').val();
        var svcUrl = $('#svcUrl').val();
        var isMenu = $('#isMenu').val();
        var authRequired = $('INPUT:RADIO[NAME=authRequired]:checked').val();;
        var useYn = $('#useYn').val();
        var isDummy = $('#isDummy').val();
        var upperSvc = $('#upperSvc').val();
        
        if(isDummy == 'Y') {
        	svcPrefix = '';
        	svcUrl = '';
        }
        

        $.ajax({
            url : "/photome/framework/servicemanager/ServiceRegist.action",
            data : {
            	svcName : svcName,
            	svcDesc : svcDesc,
            	isDummy : isDummy,
            	upperSvc : upperSvc,
            	svcPrefix : svcPrefix,
            	svcUrl : svcUrl,
            	isMenu : isMenu,
            	upperSvc : upperSvc,
            	authRequired : decode(authRequired,'Y'),
                useYn : useYn
            },
            success : callbackAddServiceInfo
        });

    }
    function callbackAddServiceInfo(data) {
    	pageLog("New code information registed");
        
        var returnValue = {
        		svcName : $('#svcName').val()
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
                <td class="value" colspan="3"><input type="text" id="svcName" name="svcName" style="width: 150px;" mandatory="true" /></td>
            </tr>
            <tr>
                <td class="label"><span class="required">*</span>Description :</td>
                <td class="value" colspan="3"><input type="text" id="svcDesc" name="svcDesc" style="width: 350px;" mandatory="true" /></td>
            </tr>
            <tr>
                <td class="label">Is Menu :</td>
                <td class="value">
                        <select id="isMenu" name="isMenu" mandatory="true"  style="width: 100px;" onchange="setMenuSvc(this);">
                                <option value="Y" selected>Yes</option>
                                <option value="N">No</option>
                        </select>
                </td>
                <td class="label">Upper Service :</td>
                <td class="value">
                    <input type="text" id="upperSvcNm" name="upperSvcNm" style="width: 150px;"/>
                    <input type="hidden" id="upperSvc" name="upperSvc"/>
                </td>
            </tr>
            <tr>
                <td class="label"><span class="required">*</span>Is dummy :</td>
                <td class="value" colspan="3">
                        <select id="isDummy" name="isDummy" mandatory="true"  style="width: 100px;" onchange="setDummySvc(this);">
                                <option value="N" selected>No</option>
                                <option value="Y">Yes</option>
                        </select>
                </td>
            </tr>
            <tr>
                <td class="label"><span class="required">*</span>Service URL :</td>
                <td class="value" colspan="3" style="height: 50px">
                Prefix :
		                <select id="svcPrefix" name="svcPrefix" mandatory="true" >
		                        <option selected></option>
		                        <c:forEach var="prefix" items="${urlPrefix}">
		                              <option value="<c:out value="${prefix.codeValue}"/>"> <c:out value="${prefix.codeName}"/> - <c:out value="${prefix.codeValue}"/></option>
		                        </c:forEach>
		                </select>
                        <input type="text" id="svcUrl" name="svcUrl" style="width: 100%" mandatory="true" />
                </td>
            </tr>
            <tr>
                <td class="label"><span class="required">*</span>Authorized :</td>
                <td class="value">
                    <input type="radio" id="authRequiredY" name="authRequired" mandatory="true" value='Y' />  Required<br/>
                    <input type="radio" id="authRequiredN" name="authRequired" mandatory="true" value='N' />  No Required 
                </td>
				<td class="label"><span class="required">*</span>Is Active :</td>
				<td class="value">
					<select id="useYn" name="useYn" style="width: 100px"  mandatory="true" >
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
                <td width="85%"></td>
                <td width="*" align="left">
                    <button class="word3" onclick="addServiceInfo();">add</button>
                </td>
            </tr>
        </table>
    </div>


</body>
</html>