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
        
        // 생년월일 항목 설정
        var t = new Date();
        var tDate = t.getDate();
        var tMonth = (t.getMonth()+1);
        if(tMonth < 10) tMonth = '0' + tMonth;
        var tYear = t.getFullYear();
        $('#birthDt').val(tDate + '/' + tMonth + '/' + tYear);
    }


</script>
<script type="text/javascript">
    function addUser() {
        checkUserId();
        
        if (checkMandatory() == false)
            return;
        if(!checkPassword()) {
        	pageLog("Check your password.");
            return;
        }
        
        if($('#photoFile').val() != null && $('#photoFile').val() != ''){
        	  alert('File upload....');
              uploadAttatchedFile();
        }else{
             saveDetailUserInfo();
        }
    }
    
    function checkPassword(){
        var password1 = $('#passwd').val();
        var password2 = $('#passwdConfirm').val();
        if(password1 != password2) return false;
        return true;
    }
    
    function uploadAttatchedFile() {
        var option = {
                url  : "/photome/common/filecontrol/FileUpload.action",
                dataType : 'text',
                data : {info_type : "USER_INFO"},
                beforeSubmit : function() {
                    $('#fileSaving').css('display','block');
                    $('#fileField').css('display','none');
                },
                success : callbackUploadAttatchedFile
        };
        $('form[name="addUserForm"]').ajaxSubmit(option);
        
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
        
        saveDetailUserInfo();
    }           

    function saveDetailUserInfo() {
        var userId      = $('#userId').val();
        var userName    = $('#userName').val();
        var passwd      = $('#passwd').val();
        var pictureFile = $('#pictureFile').val();
        var sex         = $('#sex').val();
        var birthDt     = $('#birthDt').val();
        var mobilePhone = $('#mobilePhone').val();
        var telephone   = $('#telephone').val();
        var email       = $('#email').val();
        var addrZipcd   = $('#addrZipcd').val();
        var addrState   = $('#addrState').val();
        var addrStreet  = $('#addrStreet').val();
        var addrSuburb  = $('#addrSuburb').val();
        
        $.ajax({
            url : "/photome/common/createAccount/AccountRegist.action",
            data : {
                  userId      : userId      ,
                  userName    : userName    ,
                  passwd      : passwd      ,
                  pictureFile : pictureFile ,
                  sex         : sex         ,
                  birthDt     : birthDt     ,
                  mobilePhone : mobilePhone ,
                  telephone   : telephone   ,
                  email       : email       ,
                  addrZipcd   : addrZipcd   ,
                  addrState   : addrState   ,
                  addrStreet  : addrStreet  ,
                  addrSuburb  : addrSuburb       },
            success : callbackSaveDetailUserInfo
        });

    }
    function callbackSaveDetailUserInfo(data) {
        var returnValue = {
                message : $('#userName').val() + ' 사용자 정보가 추가되었습니다.'
        };
        setOpenerDataset(returnValue);
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
    function checkUserId(object){
        
        if($('#userId').val() == null || $('#userId').val() == ''){
            object.focus(); 
            object.style.background = "#fffacd";
            pageLog("ID field is mandatory.", "warn");
            return;
        }

        $.ajax({
            url : "/photome/common/createAccount/ExistUserInfo.action",
            data : "userId=" + $('#userId').val(),
            success : callbackCheckUserId,
        });
    }

    function callbackCheckUserId(data) {
        var json = data.message;
        if(json == 'true')  {
            alert('This ID is already used by other.');
            $('#userId').focus();
        }
    }   
</script> 

</head>
<body>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Form Table -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <form id="addUserForm" name="addUserForm" method="post" enctype="multipart/form-data">
    <div id="detail_panel" class="detail_panel">
        <table id="detail_table" class="detail_table" cellpadding="0" cellspacing="0">
            <colgroup>
                <col width="125px" />
                <col width="225px" />
                <col width="150px" />
                <col width="200px" />
            </colgroup>
            <tr>
                <td class="label"><span class="required">*</span>Uer ID :</td>
                <td class="value"><input type="text" id="userId" name="userId" style="width: 200px;" mandatory="true" onblur="checkUserId(this);"/></td>
                <td class="label"><span class="required">*</span>Name :</td>
                <td class="value"><input type="text" id="userName" name="userName" style="width: 200px;" mandatory="true"/></td>
            </tr>
            <tr>
                <td class="label"><span class="required">*</span>Password :</td>
                <td class="value" colspan="3"><input type="password" id="passwd" name="passwd" style="width: 200px;" mandatory="true"/></td>
            </tr>
            <tr>
                <td class="label"><span class="required">*</span>Confirm :</td>
                <td class="value" colspan="3"><input type="password" id="passwdConfirm" name="passwdConfirm" style="width: 200px;" mandatory="true"/></td>
            </tr>
            <tr>
                <td class="label">Birth Date :</td>
                <td class="value"><input id="birthDt" name="birthDt" style="width: 100px;"  readonly="readonly"/> &nbsp; dd/mm/yyyy</td>
                <td class="label"><span class="required">*</span>Sex :</td>
                <td class="value">
                        <select id="sex" name="sex" style="width: 150px"  mandatory="true"/>
                            <option selected></option>
                            <option value="F">Male</option>
                            <option value="M">Female</option>
                        </select>
                </td>
            </tr>             
            <tr>
                <td class="label">Photo :</td>
                <td class="value" colspan="3"> 
                    <div id="fileSaving" style="display: none;"><img src="/photome/resources/images/common/loding_re.gif" /><br/>Saving....</div>
                    <div id="fileField"  style="display: block;">
                        <input id="photoFile" type="file" name="file" style="width: 300px;"/> 
                        <input type="hidden" id="pictureFile" name="pictureFile" />
                    </div>
                    <div id="uploadStatus"></div>
                </td>
            </tr>
            <tr style="height: 10px;"><td colspan="4">&nbsp;</td></tr>
            
            <tr>
                <td class="label"><span class="required">*</span>Mobile :</td>
                <td class="value"><input type="text" id="mobilePhone" name="mobilePhone" style="width: 200px;" mandatory="true"/></td>
                <td class="label">Tel. :</td>
                <td class="value"><input type="text" id="telephone" name="telephone" style="width: 200px;"/></td>
            </tr>
            <tr>
                <td class="label"><span class="required">*</span>E-Mail :</td>
                <td class="value" colspan="3"><input type="text" id="email" name="email" style="width: 400px;" mandatory="true"/></td>
            </tr>
            <tr style="height: 10px;"><td colspan="4">&nbsp;</td></tr>
            
            
            <tr>
                <td class="label"><span class="required">*</span>Zip Code :</td>
                <td class="value"><input type="text" id="addrZipcd" name="addrZipcd" style="width: 100px;" mandatory="true" onblur="setAddress(this);"/></td>
                <td class="label">State :</td>
                <td class="value"><input type="text" id="addrState" name="addrState" style="width: 150px; background-color: #E5E5E5;" mandatory="true" readonly="readonly"/></td>
            </tr> 
            <tr>
                <td class="label"><span class="required">*</span>House No/Street :</td>
                <td class="value" colspan="3"><input type="text" id="addrStreet" name="addrStreet" style="width: 400px;" mandatory="true"/></td>
            </tr>
            <tr>
                <td class="label">Suburb :</td>
                <td class="value" colspan="3"><select name="addrSuburb" id="addrSuburb" style="width: 150px"></select></td>
            </tr>
            <tr style="height: 10px;"><td colspan="4">&nbsp;</td></tr>
                                   

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
                    <button class="word3" onclick="addUser();">save</button>
                </td>
            </tr>
        </table>
    </div>


</body>
</html>