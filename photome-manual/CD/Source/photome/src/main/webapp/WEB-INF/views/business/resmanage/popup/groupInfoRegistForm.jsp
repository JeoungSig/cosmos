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
    function save() {
        
        if (checkMandatory() == false)
            return;
        
        if($('#file').val() != null && $('#file').val() != ''){
              uploadAttatchedFile();
        }else{
             saveBoothGroupInfo();
        }
    }
    
    function uploadAttatchedFile() {
        var option = {
                url  : "/photome/common/filecontrol/FileUpload.action",
                dataType : 'text',
                data : {info_type : "PHOTOME"},
                beforeSubmit : function() {
                    $('#fileSaving').css('display','block');
                    $('#fileField').css('display','none');
                },
                success : callbackUploadAttatchedFile
        };
        $('form[name="saveForm"]').ajaxSubmit(option);
        
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
        
        saveBoothGroupInfo();
    }           

    function saveBoothGroupInfo() {
        var groupName         = $('#groupName').val();
        var groupDescript     = $('#groupDescript').val();
        var managerName       = $('#managerName').val();
        var managerTel        = $('#managerTel').val();
        var managerMobile     = $('#managerMobile').val();
        var managerEmail      = $('#managerEmail').val();
        var contractCondition = $('#contractCondition').val();
        var groupComment      = $('#groupComment').val();
        var attachFile        = $('#attachFile').val();
        
        $.ajax({
            url : "/photome/business/resmanage/group/GroupInfoRegist.action",
            data : {
            	groupName          : groupName      ,
            	groupDescript      : groupDescript    ,
            	managerName        : managerName    ,
            	managerTel         : managerTel ,
            	managerMobile      : managerMobile         ,
            	managerEmail       : managerEmail     ,
            	contractCondition  : contractCondition ,
            	groupComment       : groupComment   ,
            	attachFile         : attachFile       },
            success : callbackSaveBoothGroupInfo
        });

    }
    function callbackSaveBoothGroupInfo(data) {
    	pageLog("New code information registed");
        
        var returnValue = {
                userName : $('#groupName').val()
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
	<form id="saveForm" name="saveForm" method="post" enctype="multipart/form-data">
		<div id="detail_panel" class="detail_panel">
			<table id="detail_table" class="detail_table" cellpadding="0" cellspacing="0">
	            <colgroup>
	                <col width="200px" />
	                <col width="200px" />
	                <col width="150px" />
	                <col width="100px" />
	                <col width="*" />
	            </colgroup>

                <tr><td colspan="5"><br/><h2 class="ckbox">Group Information</h2></td></tr> 
                <tr>
                    <td class="label" rowspan="3">Basic Info</td>
					<td class="label"><span class="required">*</span>Group Name</td>
					<td class="value" colspan="3"><input type="text" id="groupName" name="groupName" style="width: 200px;" mandatory="true" /></td>
				</tr>
				<tr>
					<td class="label">Description</td>
					<td class="value" colspan="3"><input type="text" id="groupDescript" name="groupDescript" style="width: 450px;" /></td>
				</tr>
                <tr>
                    <td class="label">Comment</td>
                    <td class="value" colspan="3" style="height: 40px;">
                       <textarea name="groupComment" id="groupComment" rows="10" cols="2" style="width: 450px; height: 30px;"></textarea>
                   </td>
                </tr>				
 
                <tr><td colspan="5" style="height: 10px;" >&nbsp;</td></tr> 
				<tr>
				    <td class="label" rowspan="2">Manager Info</td>
					<td class="label"><span class="required">*</span>Name</td>
					<td class="value"><input type="text" id="managerName" name="managerName" style="width: 150px;" mandatory="true" /></td>
					<td class="label">Tel.</td>
					<td class="value"><input type="text" id="managerTel" name="managerTel" style="width: 150px;" /></td>
				</tr>
				<tr>
					<td class="label">Mobile</td>
					<td class="value"><input type="text" id="managerMobile" name="managerMobile" style="width: 150px;" /></td>
					<td class="label">Email</td>
					<td class="value"><input type="text" id="managerEmail" name="managerEmail" style="width: 150px;" /></td>
				</tr>

                <tr><td colspan="5"><br/><h2 class="ckbox">Contract Information</h2></td></tr> 
				<tr> 
					<td class="label" colspan="2">Contract Condition</td>
					<td class="value" colspan="3" style="height: 40px;">
					   <textarea name="contractCondition" id="contractCondition" rows="3" cols="30" style="width: 450px; height: 30px;"></textarea>
					</td>
				</tr>

				<tr>
					<td class="label" colspan="2">Attach File</td>
					<td class="value" colspan="3">
						<div id="fileSaving" style="display: none;">
							<img src="/photome/resources/images/common/loding_re.gif" /><br />Saving....
						</div>
						<div id="fileField" style="display: block;">
							<input id="file" name="file" type="file" size="40" /> <input type="hidden" id="attachFile" name="attachFile" />
						</div>
						<div id="uploadStatus"></div>
						
					</td>
				</tr>
                <tr><td colspan="5">&nbsp;</td></tr> 

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
                    <button class="word3" onclick="save();">save</button>
                </td>
            </tr>
        </table>
    </div>


</body>
</html>