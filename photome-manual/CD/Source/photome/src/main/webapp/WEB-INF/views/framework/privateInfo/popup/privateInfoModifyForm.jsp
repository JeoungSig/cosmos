<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ page import="com.cosmos.framework.service.ServiceDto"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript">
	function loadPage() {
		$('#useYn > option[value=<c:out value="${userDto.useYn}"/>]').attr("selected", "true"); // 콤보박스 초기화
		$('#userType > option[value=<c:out value="${userDto.userType}"/>]').attr("selected", "true"); // 콤보박스 초기화
		
	      // 생년월일 항목 Datepicker 설정
        $(function() {
            var option = {
                  changeMonth: true,
                  dateFormat: 'dd/mm/yy',
                  yearRange:'1940:+0',
                  changeYear: true
                };
            $("#birthDt").datepicker(option);
        });
        
	}
</script>
<script type="text/javascript">
    function setAddress(object){
        var addrZipcd = $('#addrZipcd').val();
        if(!isNumeric(addrZipcd)) {
            alert('Zip code must be numeric code.');
            return;
        }
        
        $.ajax({
            url : "/photome/common/common/PostalAddress.action",
            data : "addrZipcd=" + addrZipcd,
            success : callbackSetAddress,
        });
    }

    function callbackSetAddress(data) {
        $('#addrState').val('');
        $('#addrSuburb').empty();
        
        var script_template = '<option value=\"{locality}\">{locality}</option>';
        
        var state = data.state;
        var json = data.postAddrList;
        
        $('#addrState').val(state);
        
        var option = null;
        $.each(json, function(i, obj) {
            option = script_template.interpolate({
                locality : obj.locality
            });
            $(option).appendTo('#addrSuburb');
        });
    }   
</script> 
<script type="text/javascript">

    function saveUser() {
        if (checkMandatory() == false){
            return;
        }
        if(!checkPassword()) {
        	pageLog("Check your password.");
            return;
        }
        
        // 파일을 신규로 등록해야 할지 수정해야할지 결정한다.
        // pictureFile : 파일의 ID를 가지고 Controller로 넘어간다.(hidden 값)
        // photoFile : 파일을 지정하는 경우 들어가게될 필드
        var url = "/photome/common/filecontrol/FileModify.action";
        if($('#pictureFile').val() != null && $('#pictureFile').val() != ''){
        	//이미 저장된 파일이 있는 경우
        	url = "/photome/common/filecontrol/FileModify.action";
        }else{
        	//수정을 하고있지만 신규로 사진을 등록해야하는 경우
        	url = "/photome/common/filecontrol/FileUpload.action";
        }
        
        if($('#photoFile').val() != null && $('#photoFile').val() != ''){
             uploadAttatchedFile(url);
        }else{
             modifyDetailUserInfo();
        }
        
    }
    
    function checkPassword(){
        var password1 = $('#passwd').val();
        var password2 = $('#passwdConfirm').val();
        if(password1 != password2) return false;
        return true;
    }
    
    function uploadAttatchedFile(url) {
    	var fileId = $('#pictureFile').val();
        var option = {
                url  : url,
                dataType : 'text',
                data : {
                	info_type : "USER_INFO",
                	fileId : fileId
                	},
                beforeSubmit : function() {
                    $('#fileSaving').css('display','block');
                    $('#fileField').css('display','none');
                },
                success : callbackUploadAttatchedFile
        };
        $('form[name="moidfyForm"]').ajaxSubmit(option);
        
    }
    
    function callbackUploadAttatchedFile(data) {
        $('#fileField').css('display','none');
        $('#fileSaving').css('display','none');
        $('#uploadStatus').html('Photo upload complete');
        
        data = data.replace(/[<][^>]*[>]/gi, '');
        // JSON 객체로 변환
        var jData = JSON.parse(data);
        //$('input:hidden[name=pictureFile]').val(jData.fileName);
        $('#pictureFile').val(jData.fileId);
        
        modifyDetailUserInfo();
    }           

    function modifyDetailUserInfo() {
        var userId      = '<c:out value="${userDto.userId}"/>';
        var userName    = $('#userName').val();
        var passwd      = $('#passwd').val();
        var userType    = $('#userType').val();
        var pictureFile = $('#pictureFile').val();
        var sex         = $('#sex').val();
        var mobilePhone = $('#mobilePhone').val();
        var telephone   = $('#telephone').val();
        var email       = $('#email').val();
        var birthDt     = $('#birthDt').val();
        var addrZipcd   = $('#addrZipcd').val();
        var addrState   = $('#addrState').val();
        var addrStreet  = $('#addrStreet').val();
        var addrSuburb  = $('#addrSuburb').val();
        var useYn       = $('#useYn').val();
        
        $.ajax({
            url : "/photome/framework/privateInfo/PrivateInfoModify.action",
            data : {
                  userId      : userId      ,
                  userName    : userName    ,
                  passwd      : passwd      ,
                  userType    : userType    ,
                  pictureFile : pictureFile ,
                  sex         : sex         ,
                  mobilePhone : mobilePhone ,
                  telephone   : telephone   ,
                  email       : email       ,
                  birthDt     : birthDt     ,
                  addrZipcd   : addrZipcd   ,
                  addrState   : addrState   ,
                  addrStreet  : addrStreet  ,
                  addrSuburb  : addrSuburb  ,
                  useYn       : useYn       },
            success : callbackModifyDetailUserInfo
        });

    }
    function callbackModifyDetailUserInfo(data) {
        alert("Modified private information");
    	document.location.href='/photome/framework/privateInfo/PrivateDetailInfo.action?pupupMode=<c:out value="${pupupMode}"/>&userId=<c:out value="${userDto.userId}"/>';
    }
    
</script>
</head>
<body>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Form Table -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <form id="moidfyForm" name="moidfyForm" method="post" enctype="multipart/form-data">
    <div id="detail_panel" class="detail_panel">
        <table id="detail_table" class="detail_table" cellpadding="0" cellspacing="0">
            <colgroup>
                <col width="150px" />
                <col width="225px" />
                <col width="100px" />
                <col width="225px" />
            </colgroup>
            <tr>
                <td class="label">Uer ID :</td>
                <td class="value"><c:out value="${userDto.userId}"/></td>
                <td class="label" rowspan="4">Photo :</td>
                <td class="value" rowspan="4"> 
                    <div id="fileSaving" style="display: none;"><img src="/photome/resources/images/common/loding_re.gif" /><br/>Saving....</div>
                    <div id="fileField"  style="display: block;">
                        <c:choose>
                            <c:when test="${!empty userProfilePhoto}">
                                <img src="/photome/image?file=${userPhoto}" width="60px" height="60px"/>
                            </c:when>
                        </c:choose>                    
                        <input id="photoFile" type="file" name="file" size="10" /> 
                        <input type="hidden" id="pictureFile" name="pictureFile" value="<c:out value="${userDto.pictureFile}"/>"/>
                    </div>
                    <div id="uploadStatus"></div>
                </td>
            </tr>
            <tr>
                <td class="label"><span class="required">*</span>Name :</td>
                <td class="value"><input type="text" id="userName" name="userName" style="width: 200px;" mandatory="true" value="<c:out value="${userDto.firstName}"/>"/></td>
            </tr>
            <tr>
                <td class="label"><span class="required">*</span>Password :</td>
                <td class="value"><input type="password" id="passwd" name="passwd" style="width: 200px;" mandatory="true" value="<c:out value="${userDto.passwd}"/>" /></td>
            </tr>            
            <tr>
                <td class="label"><span class="required">*</span>Confirm :</td>
                <td class="value"><input type="password" id="passwdConfirm" name="passwdConfirm" style="width: 200px;" mandatory="true"/></td>
            </tr>            
            <tr>
                <td class="label">Birth Date :</td>
                <td class="value"><input id="birthDt" name="birthDt" style="width: 100px;" value="<c:out value="${userDto.birthDt}"/>" readonly="readonly"/></td>
                <td class="label"><span class="required">*</span>Sex :</td>
                <td class="value">
                        <select id="sex" name="sex" style="width: 150px"  mandatory="true">
                            <option></option>
                            <option value="F" <c:if test="${userDto.sex eq 'F' }"> selected </c:if> >Female</option>
                            <option value="M" <c:if test="${userDto.sex eq 'M' }"> selected </c:if> >Male</option>
                        </select>
                </td>
            </tr>            
            <tr>
                <td class="label">Type :</td>
                <td class="value" colspan="3">
                    <select name="userType" id="userType" style="width: 150px" disabled="disabled"><c:out value="${userTypeOptions}"  escapeXml="false" /></select>
                </td>
            </tr>
            
            <tr style="height: 10px;"><td colspan="4">&nbsp;</td></tr>
            
            <tr>
                <td class="label"><span class="required">*</span>Mobile :</td>
                <td class="value"><input type="text" id="mobilePhone" name="mobilePhone" style="width: 200px;" mandatory="true" value="<c:out value="${userDto.mobilePhone}"/>" /></td>
                <td class="label">Tel. :</td>
                <td class="value"><input type="text" id="telephone" name="telephone" style="width: 200px;" value="<c:out value="${userDto.telephone}"/>"/></td>
            </tr>
            <tr>
                <td class="label"><span class="required">*</span>E-Mail :</td>
                <td class="value" colspan="3"><input type="text" id="email" name="email" style="width: 400px;" mandatory="true" value="<c:out value="${userDto.email}"/>"/></td>
            </tr>
            <tr style="height: 10px;"><td colspan="4">&nbsp;</td></tr>
            
            
            <tr>
                <td class="label"><span class="required">*</span>Zip Code :</td>
                <td class="value"><input type="text" id="addrZipcd" name="addrZipcd" style="width: 100px;" mandatory="true" onblur="setAddress(this);" value="<c:out value="${userDto.addrZipcd}"/>"/></td>
                <td class="label">State :</td>
                <td class="value"><input type="text" id="addrState" name="addrState" style="width: 150px; background-color: #E5E5E5;" mandatory="true" readonly="readonly" value="<c:out value="${userDto.addrState}"/>"/></td>
            </tr> 
            <tr>
                <td class="label"><span class="required">*</span>House No/Street :</td>
                <td class="value" colspan="3"><input type="text" id="addrStreet" name="addrStreet" style="width: 400px;" mandatory="true" value="<c:out value="${userDto.addrStreet}"/>"/></td>
            </tr>
            <tr>
                <td class="label">Suburb :</td>
                <td class="value" colspan="3">
                    <select name="addrSuburb" id="addrSuburb" style="width: 150px" onblur="setAddress(this);">
                        <c:forEach var="address" items="${postAddrList}" varStatus="stat">
                             <option value="<c:out value="${address.locality}"/>" <c:if test="${address.locality eq userDto.addrSuburb }"> selected </c:if>><c:out value="${address.locality}"/></option>
                        </c:forEach>
                    </select>
                 </td>
            </tr>
            <tr style="height: 10px;"><td colspan="4">&nbsp;</td></tr>
                                   
            <tr>
                <td class="label">Is Active :</td>
                <td class="value" colspan="3">
                    <select id="useYn" name="useYn" style="width: 100px" disabled="disabled"/>
                            <option selected></option>
                            <option value="Y">Active</option>
                            <option value="N">Disable</option>
                    </select>
                </td>
            </tr>
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
                    <button class="word3" onclick="saveUser();">save</button>
                </td>
            </tr>
        </table>
    </div>

</body>    
</html>