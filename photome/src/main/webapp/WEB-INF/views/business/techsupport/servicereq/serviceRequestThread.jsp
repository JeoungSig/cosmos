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
    	getCommentList();
    });    
</script> 
<script type="text/javascript">
	function saveNewComment(){
	    var comment = $('#comment').val();
	    
	    if (checkMandatory() == false)  return;
	    
	    $.ajax({
	        url : "/photome/business/techsupport/servicereq/ServiceRequestCommentRegist.action",
	        data : {
	            historyId : '<c:out value="${historyDto.historyId}"/>',
	            comment : comment,
	        },
	        success : getCommentList,
	    });
	    pageLog('Your comment saved successfully ','info');
	}
	
	function getCommentList() {
	    $('#comment').val('');
	    
	    $.ajax({
	        url : "/photome/business/techsupport/servicereq/ServiceRequestCommentList.action",
	        data : "historyId=" + '<c:out value="${historyDto.historyId}"/>',
	        success : callbackGetCommentList,
	    });
	} 
	
	function callbackGetCommentList(data) {
		
        var json = data.commentList;
        var dataCnt = json.length;
        var sessionUserId = '<c:out value="${sessionUserId}" />';
        var claimStatus = '<c:out value="${historyDto.claimStatus}" />';

        var arrayData = null;
        var element = null;
		
        if (dataCnt > 0) {
            arrayData = new Array();
            $.each(json, function(i, obj) {
                element = new Array();
                element[0] = obj.comment;
                element[1] = obj.creatorName;
                element[2] = obj.createDt.substr(0,16);
                element[3] = ( (obj.creator == sessionUserId && claimStatus == 'ONGOING') ? "<img style=\"cursor:hand;\" src=\"/photome/resources/images/common/icon_del_on.gif\" onClick=\"deleteComment('" + obj.commentId + "')\" >" : "-" ); 
                element[4] = obj.claimStatus;
                arrayData[i] = element; 
            });
        }        
        
        var obj = {title: "<b>Service Request Detail</b>", numberCell: false, editable: false,  freezeCols: 4, resizable:false, columnBorders: true, flexHeight:false};
        obj.width = "98%";
        obj.height = 200;
        obj.colModel = [
            {title:'<b>Comment</b>', width:430, dataType:"string"},
            {title:'<b>Writer</b>', width:150, dataType:"string"},
            {title:"<b>Date</b>", width:110, dataType:"string"},
            {title:"<b>Del.</b>", width:40, dataType:"string", sortable:false, align:"center"},
            {title:'Hidden1(status)', hidden:true}
            ];        
        
        obj.dataModel = {data:arrayData, sortIndx: 2, sortDir: "down", 
                location: "local",
                sorting: "local",
                paging: "local",
                dataType: "Array",
                curPage: 1,
                rPP: 5,
                rPPOptions: [5] };
        obj.cellClick = function (evt, ui) {
            var column = ui.column;
            var rowData = ui.dataModel;
            
            var comment = rowData.data[ui.rowIndx][0];
            
             if (column && column.dataIndx == 0) {
            	 if(comment != '' && comment != null){
            		  alert('COMMENT:\n' + comment);
            	 }
             }
        };
        $("#grid_panel").pqGrid(obj);    
        
	}
	
	function deleteComment(commentId){
	    $.ajax({
	        url : "/photome/business/techsupport/servicereq/ServiceRequestCommentDelete.action",
	        data : "commentId=" + commentId,
	        success : getCommentList,
	    });
	}  
</script>   


</head>
<body>

    <div id="search" style="width: 95%; background-color: #F2F2F9;">
         <table class="search_table" border="0"> 
            <tr>
                <td class="label">Subject</td>
                <td colspan="5"><font color="#800040"><b><c:out value="${historyDto.subject }"/></b></font></td>
            </tr>
            <tr>
                <td class="label">Group/Booth</td>
                <td colspan="5"><c:out value="${historyDto.groupName }"/> / <c:out value="${historyDto.boothName }"/></td>
            </tr>
            <tr>
                <td class="label">Writer</td>
                <td><c:out value="${historyDto.creatorName }"/></td>
                <td class="label">Create Date</td>
                <td colspan="3"><c:out value="${historyDto.createDt }"/></td>
            </tr>
            <tr>
                <td class="label" style="width: 100px;">Claim Type</td>
                <td style="width: 150px;"><c:out value="${historyDto.claimTypeName }"/></td>
                <td style="width: 100px;" class="label">Status</td>
                <td style="width: 100px;"><font color="#008000"><b><c:out value="${historyDto.claimStatusName }"/></b></font></td>
                <td style="width: 100px;" class="label">Booth Status</td>
                <td style="width: 150px;"><c:out value="${historyDto.boothStatusName }"/></td>
            </tr>
            <tr>
                <td class="label">Contents</td>
                <td colspan="5"><c:out value="${historyDto.contents }"/></td>
            </tr>
        </table>    
    </div>
    
    <c:if test="${historyDto.claimStatus == 'ONGOING' }">
    <div id="search" style="width: 95%; background-color: #F2F2F9;">
		<table id="detail_table" class="detail_table" cellpadding="0" cellspacing="0" border="0">
	        <tr style="width: 100%;display: inline;" id="tr_comment_regist">
	            <td style="width: 95%;border-bottom-width: 0px;" align="right"><input type="text" id="comment" name="comment" style="width: 100%; font-size: 15px;background-color: #FFFFF0;border-color:#408080; height: 25px;" mandatory="true" /></td>
	            <td style="border-bottom-width: 0px; text-align: left;" align="left" onclick="saveNewComment();"><button class="word5">save</button></td>
	        </tr>
		</table>
	</div>
    </c:if>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Table List -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div class="grid_panel" id="grid_panel"></div>
    <br/>
    <br/>


</body>
</html>