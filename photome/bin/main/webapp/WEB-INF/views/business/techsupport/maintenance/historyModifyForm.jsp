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
    	fildInit();
    }
    function fildInit() {
    	setBooth();
    	
/*         $('#claimStatus > option[value=\'ONGOING\']').attr("selected", "true");
        $('#claimType > option[value=\'<c:out value="${historyDto.claimType}"/>\']').attr("selected", "true");
        $('#groupId > option[value=\'<c:out value="${historyDto.groupId}"/>\']').attr("selected", "true");
        $('#boothStatus > option[value=\'<c:out value="${historyDto.boothStatus}"/>\']').attr("selected", "true"); */
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
        	modifyHistoryInfo();
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
        
        modifyHistoryInfo();
    }     
    
    function modifyHistoryInfo() {
        
        var contents = $('#contents').val();
        if(contents == '' || contents == null ){
        	alert('Can not be empty contents field');
        	$('#contents').focus();
            return;
        }
        
        var claimType         = $('#claimType').val();
        var pstPostcd         = $('#pstPostcd').val();
        var pstState          = $('#pstState').val();
        var pstStreetNo       = $('#pstStreetNo').val();
        var pstSuburb         = $('#pstSuburb').val();
        if(claimType == 'REQ_PART'){
        	if(pstPostcd == '' || pstPostcd == null
        			|| pstState == '' || pstState == null
        			|| pstSuburb == '' || pstSuburb == null
        			|| pstStreetNo == '' || pstStreetNo == null
        			){
        		alert('Can not be empty postal address fields');
        		$('#pstPostcd').focus();
        		return;
        	}
        }
        
        var boothStatus       = $('#boothStatus').val();
        if(claimType == 'RPT_BROKEN'){ 
        	if(boothStatus == '' || boothStatus == null ){
                alert('Can not be empty booth status field');
                $('#boothStatus').focus();
                return;
            }
        }
        
        var groupId           = $('#groupId').val();
        var boothId           = $('#boothId').val();
        var subject           = $('#subject').val();
        var attachFile        = $('#attachFile').val();
        var claimStatus       = $('#claimStatus').val();
        var historyId         = '<c:out value="${historyDto.historyId}"/>';

        $.ajax({
            url : "/photome/business/techsupport/maintenance/HistoryModify.action",
            data : {
            	historyId       : historyId    ,
            	claimType       : claimType    ,
            	boothStatus     : boothStatus    ,
            	groupId         : groupId         ,
            	boothId         : boothId     ,
            	pstPostcd       : pstPostcd ,
            	pstState        : pstState  ,
            	pstSuburb       : pstSuburb   ,
            	pstStreetNo     : pstStreetNo      ,
            	subject         : subject      ,
            	contents        : contents       ,
            	attachFile      : attachFile   ,
            	claimStatus     : claimStatus   },
            success : callbackSaveHistory
        });

    }
    function callbackSaveHistory(data) {
        var returnValue = {
        		message : "New code information modified"
        };
        setOpenerDataset(returnValue);
    }
    
    
</script>
<script type="text/javascript">
    function setAddress(object){
        var addrZipcd = $('#pstPostcd').val();
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
        $('#pstState').val('');
        $('#pstSuburb').empty();
        
        var script_template = '<option value=\"{locality}\">{locality}</option>';
        
        var state = data.state;
        var json = data.postAddrList;
        
        $('#pstState').val(state);
        
        var option = null;
        $.each(json, function(i, obj) {
            option = script_template.interpolate({
                locality : obj.locality
            });
            $(option).appendTo('#pstSuburb');
        });
    }   
</script> 
<script type="text/javascript">
    function setBooth(){
        var groupId = $('#groupId').val();
        $.ajax({
            url : "/photome/business/techsupport/maintenance/BoothListOfGroup.action",
            data : "groupId=" + groupId,
            success : callbackSetBooth,
        });     
    }
    function callbackSetBooth(data) {
    	var selectedBoothId = '<c:out value="${historyDto.boothId}" />';
        var boothList =  data.boothList;
        $('#boothId').empty();
        var options = "<option></option>";
        for(var i = 0; i < boothList.length; i++){
            options = options + "<option value='" + boothList[i].boothId + "'" + (boothList[i].boothId == selectedBoothId ? " selected >" : " >") + boothList[i].boothName + "</option>\n" ;
        }
        $('#boothId').html(options);
    }
    function setTrVisuality(type){
        var claimType = type.value;
        
        if(claimType == 'REQ_PART'){
        	$('#tbl_postalAddr').css('display', 'block');
        } else {
        	$('#tbl_postalAddr').css('display', 'none');
        }
        
        if(claimType == 'RPT_BROKEN'){
        	$('#tr_boothStatus').css('display', 'inline');
        } else {
        	$('#tr_boothStatus').css('display', 'none');
        }
        
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
            $('#tr_boothStatus').css('display', 'block');
        } else {
            $('#tr_boothStatus').css('display', 'none');
        }
    });    
</script>
</head>
<body>

	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- Form Table -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<form id="moidfyForm" name="moidfyForm" method="post" enctype="multipart/form-data">
		<div id="detail_panel" class="detail_panel">
			<table id="detail_table" class="detail_table" cellpadding="0" cellspacing="0" >
				<colgroup>
					<col width="120px" />
					<col width="140px" />
					<col width="170px" />
					<col width="*" />
				</colgroup>

				<tr>
					<td colspan="4"><br />
					<h2 class="ckbox"> Modify Claim Information</h2></td>
				</tr>
				<tr>
					<td class="label" style="border-bottom-width: 0px;"><span class="required">*</span>Claim Type :</td>
					<td class="value" colspan="3"><select name="claimType" id="claimType" style="width: 200px" onChange="setTrVisuality(this)" mandatory="true" ><c:out value="${claimTypeOptions}" escapeXml="false"/></select></td>
				</tr>
                <tr>
                    <td class="label"></td>
                    <td class="value" colspan="3">
                       <table id="tbl_postalAddr" style="display: none;">
                            <tr>
                                <td class="label" style="border-bottom-width: 0px; background-color: #FFF7F2;">Postal Zip Code :</td>
                                <td class="value" style="border-bottom-width: 0px;"><input type="text" id="pstPostcd" name="pstPostcd" style="width: 100px;" onblur="setAddress(this);" value="<c:out value="${historyDto.pstPostcd}" escapeXml="false"/>"/></td>
                                <td class="label" style="border-bottom-width: 0px; background-color: #FFF7F2;">Postal State :</td>
                                <td class="value" style="border-bottom-width: 0px;"><input type="text" id="pstState" name="pstState" style="width: 100px; background-color: #E5E5E5;" readonly="readonly" value="<c:out value="${historyDto.pstState}" escapeXml="false"/>"  /> </td>
                            </tr>
                            <tr>
                                <td class="label" style="border-bottom-width: 0px; background-color: #FFF7F2;">Postal Suburb :</td>
                                <td class="value"  style="border-bottom-width: 0px;" colspan="3">
                                    <select name="pstSuburb" id="pstSuburb" style="width: 200px;" >
                                        <option value="<c:out value="${historyDto.pstSuburb}" />"><c:out value="${historyDto.pstSuburb}" /></option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="label" style="border-bottom-width: 0px; background-color: #FFF7F2;">Postal No/Street :</td>
                                <td class="value"  style="border-bottom-width: 0px;" colspan="3"><input type="text" id="pstStreetNo" name="pstStreetNo" style="width: 400px;" value="<c:out value="${historyDto.pstStreetNo}" escapeXml="false"/>" /></td>
                            </tr>
                       </table>
                       
                       <table id="tr_boothStatus" style="display: none; width: 100%;">
                            <tr>
                                <td class="label" style="border-bottom-width: 0px; width: 150px; background-color: #FFF7F2;">Booth Status :</td>
                                <td class="value" colspan="3" style="border-bottom-width: 0px;"><select name="boothStatus" id="boothStatus" style="width: 200px"><c:out value="${boothStatusOptions}" escapeXml="false"/></select></td>
                            </tr>
                       </table>
                       <br/>
                    </td>
                </tr>    
				<tr>
                    <td class="label">Group :</td>
                    <td class="value" colspan="3"><select name="groupId" id="groupId" style="width: 170px" onChange="setBooth(this)"><c:out value="${groupListOptions}" escapeXml="false" /></select></td>
                </tr>    
				<tr>
					<td class="label">Booth :</td>
					<td class="value" colspan="3"><select name="boothId" id="boothId" style="width: 250px"></select></td>
				</tr>
				

                
                <tr>
                    <td class="label"><span class="required">*</span>Subject :</td>
                    <td class="value" colspan="3"><input type="text" id="subject" name="subject" style="width: 550px;" mandatory="true" value="<c:out value="${historyDto.subject}"/>"/></td>
                </tr> 
                <tr>
                    <td class="label"><span class="required">*</span>Contents :</td> 
                    <td class="value" colspan="3"><br /> &nbsp;<textarea name="contents" id="contents" rows="10" cols="2" style="width: 550px; height: 150px;"  mandatory="true"><c:out value="${historyDto.contents}"/></textarea> <br /> <br /></td>
                </tr>

 
				<tr>
					<td colspan="4"></td>
				</tr>
                <tr>
                    <td class="label">Attach File :</td>
                    <td class="value" colspan="3">
                        <br/>
                        <c:out value="${attachFileDto.fileName}"/>
                        <br/>
                        <br/>
                        <div id="fileSaving" style="display: none;">
                            <img src="/photome/resources/images/common/loding_re.gif" /><br />Saving....
                        </div>
                        <div id="fileField" style="display: block;">
                            <input id="file" name="file" type="file" size="40" /> <input type="hidden" id="attachFile" name="attachFile" />
                        </div>
                        <div id="uploadStatus"></div>
                        <br/>
                        
                    </td>
                </tr>
                <tr><td colspan="4">&nbsp;</td></tr> 

                <tr>
                    <td class="label">Claim Status :</td>
                    <td class="value" colspan="3"><select name="claimStatus" id="claimStatus" style="width: 250px" mandatory="true"><c:out value="${claimStatusOptions}" escapeXml="false"/></select></td>
                </tr>
                <tr><td colspan="4">&nbsp;</td></tr> 
                
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


</body>
</html>