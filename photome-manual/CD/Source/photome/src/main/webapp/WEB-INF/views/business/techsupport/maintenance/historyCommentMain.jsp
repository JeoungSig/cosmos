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
        var boothId = '<c:out value="${boothId}" />';
        var groupId = '<c:out value="${groupId}" />';
        
        if(boothId != null && boothId != '' && groupId != null && groupId != ''){
            $('#groupId > option[value=\'<c:out value="${groupId}"/>\']').attr("selected", "true");
            $('#boothId > option[value=\'<c:out value="${boothId}"/>\']').attr("selected", "true");
            setGroup(groupId);
            setBoothInfo();
        }
    });    
</script> 
<script type="text/javascript">    
	function viewGroupInfo(groupId) {
	    var url = '/photome/business/techsupport/maintenance/comment/GroupInfo.action?groupId=' + groupId;
	    var windowName = 'business/techsupport/maintenance/comment/GroupInfo';
	    var win = openPopupForm(url, windowName, '720', '520');
	} 
	function getUserInfo(userId) {
	    var url = '/photome/business/techsupport/maintenance/comment/UserDetailInfo.action?userId=' + userId;
	    var windowName = 'business/techsupport/maintenance/comment/UserDetailInfo';
	    var win = openPopupForm(url, windowName, '720', '540');
	}
	function viewBoothInfo(boothId) {
	    var url = '/photome/business/techsupport/maintenance/comment/BoothInfo.action?boothId=' + boothId;
	    var windowName = 'business/techsupport/maintenance/comment/BoothInfo';
	    var win = openPopupForm(url, windowName, '780', '560');
	} 
    function viewHistoryInfo(historyId) {
        var url = '/photome/business/techsupport/maintenance/comment/HistoryInfo.action?historyId=' + historyId;
        var windowName = 'business/techsupport/maintenance/comment/HistoryInfo';
        var win = openPopupForm(url, windowName, '780', '600');
    }	
  
</script>   
<script type="text/javascript">
	function setGroup(groupId){
        $.ajax({
            url : "/photome/business/techsupport/maintenance/comment/GroupInfoJson.action",
            data : "groupId=" + groupId,
            success : callbackSetGroup,
        });
	}
    function callbackSetGroup(data) {
        var groupDto = data.groupDto;
        $('#groupDto_groupName').html("<a href=\"javascript:viewGroupInfo('" + groupDto.groupId + "')\">"+ groupDto.groupName + "</a>");
        $('#groupDto_groupDescript').text(groupDto.groupDescript);
        $('#groupDto_managerName').text(decode(groupDto.managerName, '-'));
        $('#groupDto_managerTel').text(decode(groupDto.managerTel, '-'));
        $('#groupDto_managerMobile').text(decode(groupDto.managerMobile, '-'));
        $('#groupDto_managerEmail').text(decode(groupDto.managerEmail, '-'));
    }    
</script>

<script type="text/javascript">
	function setBooth(group){
		var groupId = $('#groupId').val();
		if(groupId == null || groupId == '') return;
		
        $.ajax({
            url : "/photome/business/techsupport/maintenance/comment/BoothListOfGroup.action",
            data : "groupId=" + groupId,
            success : callbackSetBooth,
        });
        
        $.ajax({
            url : "/photome/business/techsupport/maintenance/comment/GroupInfoJson.action",
            data : "groupId=" + groupId,
            success : callbackGroupInfo,
        });
	}
    function callbackSetBooth(data) {
    	var boothList =  data.boothList;
        $('#boothId').empty();
        var options = "<option></option>";
        for(var i = 0; i < boothList.length; i++){
        	options = options + "<option value='" + boothList[i].boothId + "'>" + boothList[i].boothName + "</option>\n" ;
        }
        $('#boothId').html(options);
    }	
    
    function callbackGroupInfo(data) {
    	var groupDto = data.groupDto;
    	$('#groupDto_groupName').html("<a href=\"javascript:viewGroupInfo('" + groupDto.groupId + "')\">"+ groupDto.groupName + "</a>");
    	$('#groupDto_groupDescript').text(groupDto.groupDescript);
    	$('#groupDto_managerName').text(decode(groupDto.managerName, '-'));
    	$('#groupDto_managerTel').text(decode(groupDto.managerTel, '-'));
    	$('#groupDto_managerMobile').text(decode(groupDto.managerMobile, '-'));
    	$('#groupDto_managerEmail').text(decode(groupDto.managerEmail, '-'));
    }
    function setBoothInfo(booth){
    	var boothId = $('#boothId').val();
        if(boothId == null || boothId == '') return;
        
        $.ajax({
            url : "/photome/business/techsupport/maintenance/comment/BoothInfoJson.action",
            data : "boothId=" + boothId,
            success : callbackSetBoothInfo,
        });
        
        getHistoryList(boothId);
    } 
    function callbackSetBoothInfo(data) {
        var boothDto = data.boothDto;
        $('#boothDto_boothName').html("<a href=\"javascript:viewBoothInfo('" + boothDto.boothId + "')\">"+ boothDto.boothName + "</a>");
        $('#boothDto_statusName').text(decode(boothDto.statusName, '-'));
        if(boothDto.technician != null && boothDto.technician != ''){
            $('#boothDto_technicianName').html("<a href=\"javascript:getUserInfo('" + boothDto.technician + "')\">"+ boothDto.technicianName + "</a>");
        }
        $('#boothDto_typeName').text(decode(boothDto.typeName, '-'));
        $('#boothDto_location').text(boothDto.locPostcd + "," + boothDto.locState + "," + boothDto.locSuburb  + "," + boothDto.locStreetNo);
        
    } 
    function getHistoryList(boothId) {
        
        $.ajax({
            url : "/photome/business/techsupport/maintenance/comment/HistoryList.action",
            data : "boothId=" + boothId,
            success : callbackGetHistoryList,
        });
        
        pageLog('data retirive complete','info');
    }
    
    function callbackGetHistoryList(data) {
        $('#grid_table_claim tbody').empty();
        
        var script_template = '<tr>'
            + '    <td> <input class="radio" type="radio" name="claimList" value="{historyId}" onClick="getHistoryCommentList(\'{historyId}\',\'{claimStatus}\')" /> </td>'
            + '    <td> {claimType}</td>'
            + '    <td class="key"> <a href="javascript:viewHistoryInfo(\'{historyId}\')" style="text-decoration: none;">{subject} </a></td>'
            + '    <td> {claimStatusName}</td>'
            + '    <td> <a href="javascript:getUserInfo(\'{technician}\')" style="text-decoration: none;">{technicianName}</a> </td>'
            + '    <td> {createDt} </td> '
            + '</tr>';

        var json = data.list;
        var dataCnt = json.length;

        var trObj = null;
        if (dataCnt > 0) {
            $.each(json, function(i, obj) {
                trObj = script_template.interpolate({
                    historyId   : obj.historyId,
                    claimType   : obj.claimTypeName,
                    subject : abbreviate(obj.subject,30),
                    claimStatus : obj.claimStatus,
                    claimStatusName : ( obj.claimStatus == 'ONGOING' ? ('<font color=#EA0075>' + obj.claimStatusName + '</font>') : obj.claimStatusName),
                    technician : obj.creator,
                    technicianName : obj.creatorName,
                    createDt   : obj.createDt.substr(0,10)
                });
                $(trObj).appendTo('#grid_table_claim tbody');
            });
        } else {
            $('<tr><td colspan="6"><br/>No registed information<br/><br/></td></tr>').appendTo('#grid_table_claim tbody');
        }
    }
        
    function getHistoryCommentList(historyId, claimStatus) {
    	$('#historyId').val(historyId);
    	$('#claimStatus').val(claimStatus);
    	if(claimStatus != 'ONGOING'){
    		$('#tr_comment_regist').css('display', 'none');
    	}else{
    		$('#tr_comment_regist').css('display', 'inline');
    	}
    	getCommentList();
    }

    function callbackGetHistoryCommentList(data) {
       
    }
    function saveNewComment(){
    	var comment = $('#comment').val();
    	var historyId = $('#historyId').val();
    	if(historyId == '' || historyId == null) {
    		alert('You have to select a CLAIM ITEM before post comment');
    		return
    	}
    	if (checkMandatory() == false)  return;
    	
        $.ajax({
            url : "/photome/business/techsupport/maintenance/comment/CommentRegist.action",
            data : {
            	historyId : historyId,
            	comment : comment,
            },
            success : getCommentList,
        });
        pageLog('Your comment saved successfully ','info');
    }
    
    function getCommentList() {
    	$('#comment').val('');
    	var historyId = $('#historyId').val();
    	
    	$.ajax({
            url : "/photome/business/techsupport/maintenance/comment/CommentList.action",
            data : "historyId=" + historyId,
            success : callbackGetCommentList,
        });
    } 
    
    function callbackGetCommentList(data) {
        $('#comment_list').empty();
        var claimStatus = $('#claimStatus').val();
        
        var script_template = '<li>'
            +      '{comment}'
            +       ', &nbsp;&nbsp;  {creator}'
            +       ', &nbsp;&nbsp;  {createDt}'
            +       ', &nbsp;&nbsp;  {deleteIcon}'
            + '</li>';

        var json = data.commentList;
        var dataCnt = json.length;
        var sessionUserId = '<c:out value="${sessionUserId}" />';

        var trObj = null;
        if (dataCnt > 0) {
            $.each(json, function(i, obj) {
                trObj = script_template.interpolate({
                	comment   : "<font style=\"font-size: 13px; font-weight: bold; color: #006464;\">" + obj.comment + "</font>",
                	creator   : "<a href=\"javascript:getUserInfo('" + obj.creator +"')\" >" + obj.creatorName + "</a>",
                	createDt   : obj.createDt.substr(0,10),
                	deleteIcon :  ( (obj.creator == sessionUserId && claimStatus == 'ONGOING') ? "<img style=\"cursor:hand;\" src=\"/photome/resources/images/common/icon_del_on.gif\" onClick=\"deleteComment('" + obj.commentId + "')\" >" : "" ) 
                });
                $(trObj).appendTo('#comment_list');
            });
        } else {
            $('<br/>No registed information<br/>').appendTo('#comment_list');
        }
    }
    
    function deleteComment(commentId){
        $.ajax({
            url : "/photome/business/techsupport/maintenance/comment/CommentDelete.action",
            data : "commentId=" + commentId,
            success : getCommentList,
        });
    }
    
</script>

</head>
<body>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Search -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="search" style="width: 95%">
        <table class="search_table" border="0"> 
            <tr>
                <td class="label">Group </td>
                <td><select name="groupId" id="groupId" style="width: 150px" onChange="setBooth(this)"><c:out value="${groupListOptions}" escapeXml="false" /></select></td>
                <td class="label">Booth </td>
                <td><select name="boothId" id="boothId" style="width: 250px" onChange="setBoothInfo(this)"><c:out value="${boothList}" escapeXml="false" /></select></td>
            </tr>
        </table>
    </div>
    <div id="search" style="width: 95%; background-color: #F2F2F9;">
         <table class="search_table" border="0"> 
            <tr>
                <td class="label">Group Name : </td><td><div id="groupDto_groupName" style="font-weight: bold;color: #D5006A;">-</div></td>
                <td class="label">Description:</td><td><div id="groupDto_groupDescript">-</div></td>
                <td class="label">Manager Name:</td><td><div id="groupDto_managerName">-</div></td>
                <td class="label">Manager tel:</td><td><div id="groupDto_managerTel">-</div></td>
                <td class="label">Manager mobile:</td><td><div id="groupDto_managerMobile">-</div></td>
                <td class="label">Manager email:</td><td><div id="groupDto_managerEmail">-</div></td>
            </tr>
            <tr>
                <td class="label">Booth Name : </td><td><div id="boothDto_boothName" style="font-weight: bold;color: #D5006A;">-</div></td>
                <td class="label">Status:</td><td><div id="boothDto_statusName">-</div></td>
                <td class="label">Technician:</td><td><div id="boothDto_technicianName">-</div></td>
                <td class="label">Type:</td><td><div id="boothDto_typeName">-</div></td>
                <td class="label" colspan="2">Location:</td><td><div id="boothDto_location">-</div></td>
            </tr>
        </table>    
    </div>
	<div id="detail_panel" class="detail_panel">
		<table id="detail_table" class="detail_table" cellpadding="0" cellspacing="0" border="0">
			<tr><td colspan="2" style="border-bottom-width: 0px;">&nbsp;</td></tr> 
			<tr>
				<td style="border-bottom-width: 0px; width: 50%"><h2 class="ckbox">Claim List</h2></td>
				<td style="border-bottom-width: 0px; width: 50%;"><h2 class="ckbox">Claim Comment List</h2></td>
			</tr>
			<tr>
				<td style="border-bottom-width: 0px; vertical-align: top;">
				    <div class="grid_table_panel" style="border-bottom-width: 0px;">
				        <table id="grid_table_claim" class="grid_table" width="100%" cellspacing="0" cellpadding="0">
				            <thead>
				                <tr>
				                    <th>&nbsp;</th>
				                    <th>Type</th>
				                    <th>Subject</th>
				                    <th>status</th>
				                    <th>writer</th>
				                    <th class="last">create</th>
				                </tr>
				            </thead>
				            <tbody>
				                <!-- Code List -->
				                <tr><td colspan="5"><br/>No registed information<br/><br/></td></tr>
				            </tbody>
				        </table>
				    </div>
				</td>
				<td style="border-bottom-width: 0px; vertical-align: top;">
					<table>
						<tr style="width: 100%;display: inline;" id="tr_comment_regist">
							<td style="width: 95%;border-bottom-width: 0px;" align="right"><input type="text" id="comment" name="comment" style="width: 100%; font-size: 15px;background-color: #FFF2F9; height: 25px;" mandatory="true" /></td>
							<td style="border-bottom-width: 0px; text-align: left;" align="left" onclick="saveNewComment();"><button class="word5">save</button></td>
						</tr>
						<tr>
							<td colspan="2" style="border-bottom-width: 0px;">
								<div class="comment_list" id="comment_list" >No registed comment items</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr><td colspan="2" style="border-bottom-width: 0px;">&nbsp;</td></tr> 
		</table>
		<input type="hidden" name="historyId" id="historyId" value="" />
		<input type="hidden" name="claimStatus" id="claimStatus" value="" />
	</div>

	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Subaction buttons bar & Pagging -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="main_control" class="main_control">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="80%">
                    <!-- Paging -->
                    <div class="paging"></div>
                </td>
                <td width="*" align="left">
                    <!-- <button class="word8" onclick="makeClaim();">Make Claim</button> -->
                </td>
            </tr>
        </table>
    </div>


</body>
</html>