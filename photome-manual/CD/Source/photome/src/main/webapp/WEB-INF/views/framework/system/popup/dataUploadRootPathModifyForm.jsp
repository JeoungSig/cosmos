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
    function modfy() {

    	var dataUploadRootpath = $('#dataUploadRootpath').val();
        var option = {
        		url : "/photome/framework/sysproperty/DataUploadRootPathModify.action",
                dataType : 'text',
                data : {
                	dataUploadRootpath : dataUploadRootpath
                    },
                success : callbackModfy
        };
        $('form[name="moidfyForm"]').ajaxSubmit(option);        
    }
    function callbackModfy(data) {
        var returnValue = {
                message : "Success to modify for excption URL of Access Check"
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
    <h2 class="ckbox">Data Upload Rootpath</h2>
    <form id="moidfyForm" name="moidfyForm" method="post">
    <div id="detail_panel" class="detail_panel">
        <table id="detail_table" class="detail_table" cellpadding="0" cellspacing="0">
            <tr>
                <td class="label" style="width: 100px;">Rootpath  :</td>
                <td class="value" style="width: *;">
                    <br/>
                    <input type="text" id="dataUploadRootpath" name="dataUploadRootpath" style="width: 100%;" mandatory="true" value="<c:out value="${dataUploadRootpath}"/>"/>
                    <br/><br/>
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
                    <button class="word3" onclick="modfy();">modify</button>
                </td>
            </tr>
        </table>
    </div>
    <br/>
    <br/>


</body>
</html>