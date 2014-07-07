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
    function modify() {
        
        if (checkMandatory() == false)
            return;
 
        // 파일을 신규로 등록해야 할지 수정해야할지 결정한다.
        // file : 파일을 지정하는 경우 들어가게될 필드
        // attachFile : 파일의 ID를 가지고 Controller로 넘어간다.(hidden 값)
        var url = "/photome/common/filecontrol/FileModify.action";
        if($('#attachFile').val() != null && $('#attachFile').val() != ''){
            //이미 저장된 파일이 있는 경우
            url = "/photome/common/filecontrol/FileModify.action";
        }else{
            //수정을 하고있지만 신규로 사진을 등록해야하는 경우
            url = "/photome/common/filecontrol/FileUpload.action";
        }
        
        if($('#file').val() != null && $('#file').val() != ''){
             uploadAttatchedFile(url);
        }else{
        	modifyBoothGroupInfo();
        }
    }
    
    function uploadAttatchedFile(url) {
        var fileId = $('#attachFile').val();
        var option = {
                url  : url,
                dataType : 'text',
                data : {
                    info_type : "PHOTOME",
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
        $('#attachFile').val(jData.fileId);
        
        modifyBoothGroupInfo();
    }           

    function modifyBoothGroupInfo() {
        var groupId           = $('#groupId').val();
        var groupName         = $('#groupName').val();
        var groupDescript     = $('#groupDescript').val();
        var managerName       = $('#managerName').val();
        var managerTel        = $('#managerTel').val();
        var managerMobile     = $('#managerMobile').val();
        var managerEmail      = $('#managerEmail').val();
        var contractCondition = $('#contractCondition').val();
        var grpContractUnit   = $('#grpContractUnit').val();
        var groupComment      = $('#groupComment').val();
        var attachFile        = $('#attachFile').val();
        
        $.ajax({
            url : "/photome/business/resmanage/group/GroupInfoUpdate.action",
            data : {
            	groupId            : groupId      ,
                groupName          : groupName      ,
                groupDescript      : groupDescript    ,
                managerName        : managerName    ,
                managerTel         : managerTel ,
                managerMobile      : managerMobile         ,
                managerEmail       : managerEmail     ,
                contractCondition  : contractCondition ,
                grpContractUnit    : grpContractUnit ,
                groupComment       : groupComment   ,
                attachFile         : attachFile       },
            success : callbackModifyBoothGroupInfo
        });

    }
    function callbackModifyBoothGroupInfo(data) {
    	pageLog("New code information registed");
        alert('Group information modified successfully');
        var returnValue = {
                message : $('#message').val()
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
    <form id="moidfyForm" name="moidfyForm" method="post" enctype="multipart/form-data">
        <div id="detail_panel" class="detail_panel">
            <table id="detail_table" class="detail_table" cellpadding="0" cellspacing="0">
                <colgroup>
                    <col width="150px" />
                    <col width="225px" />
                    <col width="100px" />
                    <col width="225px" />
                </colgroup>

                <tr><td colspan="4"><br/><h2 class="ckbox">Group Basic Information</h2></td></tr> 
                <tr>
                    <td class="label"><span class="required">*</span>Group Name :</td>
                    <td class="value" colspan="3"><input type="text" id="groupName" name="groupName" style="width: 200px;" mandatory="true" value="${groupDto.groupName }"/></td>
                </tr>
                <tr>
                    <td class="label">Description :</td>
                    <td class="value" colspan="3"><input type="text" id="groupDescript" name="groupDescript" style="width: 500px;" value="${groupDto.groupDescript }" /></td>
                </tr>
                <tr>
                    <td class="label">Comment :</td>
                    <td class="value" colspan="3">
                       <br/>
                       &nbsp;<textarea name="groupComment" id="groupComment" rows="10" cols="2" style="width: 400px; height: 40px;">${groupDto.groupComment }</textarea>
                       <br/>
                       <br/>
                   </td>
                </tr>               

                <tr><td colspan="4"><br/><h2 class="ckbox">Manager Information</h2></td></tr> 
                <tr>
                    <td class="label"><span class="required">*</span>Name :</td>
                    <td class="value"><input type="text" id="managerName" name="managerName" style="width: 200px;" mandatory="true" value="${groupDto.managerName }" /></td>
                    <td class="label">Tel. :</td>
                    <td class="value"><input type="text" id="managerTel" name="managerTel" style="width: 200px;" value="${groupDto.managerTel }" /></td>
                </tr>
                <tr>
                    <td class="label">Mobile :</td>
                    <td class="value"><input type="text" id="managerMobile" name="managerMobile" style="width: 200px;" value="${groupDto.managerMobile }" /></td>
                    <td class="label">Email :</td>
                    <td class="value"><input type="text" id="managerEmail" name="managerEmail" style="width: 200px;" value="${groupDto.managerEmail }" /></td>
                </tr>
 
                <tr><td colspan="4"><br/><h2 class="ckbox">Contract Information</h2></td></tr> 
                <tr> 
                    <td class="label">Contract Condition :</td>
                    <td class="value" colspan="3">
                       <br/>
                       &nbsp;<textarea name="contractCondition" id="contractCondition" rows="3" cols="30" style="width: 500px; height: 70px;">${groupDto.contractCondition }</textarea>
                       <br/>
                       <br/>
                    </td>
                </tr>

                <tr>
                    <td class="label">Attach File :</td>
                    <td class="value" colspan="3">
                        <br/>
                        <c:if test="${!empty attachFileDto.fileName }"> 
                        &nbsp;${attachFileDto.fileName }
                        <br/>
                        </c:if>
                        <div id="fileSaving" style="display: none;">
                            <img src="/photome/resources/images/common/loding_re.gif" /><br />Saving....
                        </div>
                        <div id="fileField" style="display: block;">
                            <input id="file" name="file" type="file" size="40" /> <input type="hidden" id="attachFile" name="attachFile" value="${groupDto.attachFile }"  />
                        </div>
                        <div id="uploadStatus"></div>
                        <br/>
                    </td>
                </tr>
                <tr>
                    <td class="label"><span class="required">*</span>Contract Unit :</td>
                    <td class="value" colspan="3"><select id="grpContractUnit" name="grpContractUnit" style="width: 150px" mandatory="true" ><c:out value="${grpContractUnitOptions }" escapeXml="false"/></select></td>
                </tr>                
                <tr><td colspan="4">&nbsp;</td></tr> 

            </table>
        </div>
        <input id="groupId" name="groupId" type="hidden" value="${groupDto.groupId }" />
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
                    <button class="word3" onclick="modify();">save</button>
                </td>
            </tr>
        </table>
    </div>


</body>
</html>