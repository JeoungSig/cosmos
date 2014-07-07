<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript">
    function loadPage() { }
</script>   
<script type="text/javascript">
	function modify() {
	    if (checkMandatory() == false){
	        return;
	    }
	    
	    // 파일을 신규로 등록해야 할지 수정해야할지 결정한다.
	    // fileId : 파일의 ID를 가지고 Controller로 넘어간다.(hidden 값)
	    // photoFile : 파일을 지정하는 경우 들어가게될 필드
	    var url = "/photome/common/filecontrol/FileModify.action";
	    if($('#fileId').val() != null && $('#fileId').val() != ''){
	        //이미 저장된 파일이 있는 경우
	        url = "/photome/common/filecontrol/FileModify.action";
	    }else{
	        //수정을 하고있지만 신규로 사진을 등록해야하는 경우
	        url = "/photome/common/filecontrol/FileUpload.action";
	    }
	    
	    if($('#photoFile').val() != null && $('#photoFile').val() != ''){
	         uploadAttatchedFile(url);
	    }else{
	         modifyBasicInfo();
	    }
	    
	} 
	
    function uploadAttatchedFile(url) {
        var fileId = $('#fileId').val();
        var option = {
                url  : url,
                dataType : 'text',
                data : {
                    info_type : "SYSTEM",
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
        //$('input:hidden[name=fileId]').val(jData.fileName);
        $('#fileId').val(jData.fileId);
        
        modifyBasicInfo();
    }           

    function modifyBasicInfo() {
        var sysName     = $('#sysName').val();
        var sysDescript = $('#sysDescript').val();
        var copyright   = $('#copyright').val();
        var fileId      = $('#fileId').val();
        
        $.ajax({
            url  : "/photome/framework/sysproperty/BasicInfoModify.action",
            data : { sysName     : sysName        ,
            	     sysDescript : sysDescript    ,
            	     copyright   : copyright      ,
                     fileId      : fileId  }      ,
            success : callbackModifyBasicInfo
        });

    }
    function callbackModifyBasicInfo(data) {
        var returnValue = {
                message : data.message
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
    <h2 class="ckbox">Access check exception URLs</h2>
    <form id="moidfyForm" name="moidfyForm" method="post">
    <div id="detail_panel" class="detail_panel">
        <table id="detail_table" class="detail_table" cellpadding="0" cellspacing="0">
            <tr>
                <td class="label" style="width: 150px;">System Name :</td>
                <td class="value" style="width: *;"><input type="text" id="sysName" name="sysName" style="width: 300px;" mandatory="true" value="<c:out value="${propertyInfo.sysName}"/>"/></td>
            </tr> 
            <tr>
                <td class="label">Description :</td>
                <td class="value" style="width: *;"><input type="text" id="sysDescript" name="sysDescript" style="width: 500px;" mandatory="true" value="<c:out value="${propertyInfo.sysDescript}"/>"/></td>
            </tr> 
            <tr>
                <td class="label">Copyright :</td>
                <td class="value" style="width: *;">
                    <textarea name="copyright" id="copyright"  rows="10" cols="30" style="width: 500px; height: 200px;"><c:out value="${propertyInfo.copyright}"/></textarea>
            </tr> 
            <tr>
                <td class="label">Logo Image :</td>
                <td class="value" style="width: *;">
                    <div id="fileSaving" style="display: none;"><img src="/photome/resources/images/common/loding_re.gif" /><br/>Saving....</div>
                    <div id="fileField"  style="display: block;">
                        <input id="photoFile" type="file" name="file" size="10"  style="width: 300px;"/> 
                        <input type="hidden" id="fileId" name="fileId" value="<c:out value="${fileInfo.fileId}"/>"/>
                    </div>
                    <div id="uploadStatus"></div>              
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
                    <button class="word3" onclick="modify();">modify</button>
                </td>
            </tr>
        </table>
    </div>
    <br/>
    <br/>

</body>
</html>