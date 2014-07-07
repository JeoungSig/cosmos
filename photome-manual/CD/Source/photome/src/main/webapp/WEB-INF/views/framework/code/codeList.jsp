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
        setSystemCombo();
        search();
    }
    function setSystemCombo() {
        $.ajax({
            url : "/photome/framework/codemanager/SystemCodeList.action",
            success : callbackChangeSystem,
        });
    }
    function callbackChangeSystem(data) {
        $('#systemCd').empty();
        var script_template = '<option value=\"{systemCd}\">{systemCd}</option>';
        $('<option></option>').appendTo('#systemCd');
        
        var json = data.message;
        var option = null;
        $.each(json, function(i, obj) {
            option = script_template.interpolate({
                systemCd : obj.systemCd
            });
            $(option).appendTo('#systemCd');
        });
        
    }

    function changeCategory(systemCd) {
        $.ajax({
            url : "/photome/framework/codemanager/CategoryCodeList.action",
            data : "systemCd=" + systemCd,
            success : callbackChangeCategory,
        });
    }

    function callbackChangeCategory(data) {
        // 카테고리 콤보를 비운다     
        $('#categoryCd').empty();
        $("<option></option>").appendTo('#categoryCd');
        
        var script_template = '<option value=\"{categoryCd}\">{categoryCd}</option>';
        // JSON
        var json = data.message;
        var option = null;
        $.each(json, function(i, obj) {
            option = script_template.interpolate({
                categoryCd : obj.categoryCd
            });
            $(option).appendTo('#categoryCd');
        });
    }
</script>

<script type="text/javascript">
    function addCodeInfo() {
        var url = '/photome/framework/codemanager/CodeRegistForm.action';
        var windowName = 'sysAdmin/framework/codeRegistForm';
        var win = openPopupForm(url, windowName, '800', '450');
    }
    
    function setReturnValue(returnValue) {
    	pageLog("하나의 코드가 추가되었습니다.", "info");
        $("#systemCd > option[value=" + returnValue.systemCd +"]").attr("selected", "true")
        $("#categoryCd > option[value=" + returnValue.categoryCd +"]").attr("selected", "true")
        search();
    }
    
    function modifyCodeInfo(systemCd,categoryCd,codeValue) {
        var url = '/photome/framework/codemanager/CodeModifyForm.action?systemCd=' + systemCd + '&categoryCd=' + categoryCd + '&codeValue=' + codeValue;
        var windowName = 'sysAdmin/framework/CodeModifyForm';
        var win = openPopupForm(url, windowName, '800', '450');
        win.focus();
    }   
    function deleteCodeInfo() {
        var isChecked = false;
        
        var systemCd = null;
        var categoryCd = null;
        var codeValue = null;
        
        // JSON형태로 마라미터를 구성한다.
        var jsonParam = "";
        var cnt = 0;    
            
        var jsonCode = null;
        var isChecked = false;
        $('#grid_panel #checkbox').each(function(){
            isChecked = $(this).is(':checked');
            
            if(isChecked == true){
                systemCd = $(this).attr('systemCd');
                categoryCd = $(this).attr('categoryCd');
                codeValue = $(this).attr('codeValue');
                
                if(cnt != 0) jsonParam = jsonParam + ",";
                jsonParam = jsonParam + "{\"systemCd\":\"" + systemCd + "\",\"categoryCd\":\"" + categoryCd + "\",\"codeValue\":\"" + codeValue + "\"}";
                cnt++;
            }
            
        });
        jsonParam = "{ \"list\":[" + jsonParam + "]}";
        
        if(cnt == 0) {
        	pageLog("삭제할 데이터가 선택되지 않았습니다.", "warn");
            return;
        } else {
            $.ajax({
                url : "/photome/framework/codemanager/CodeDelete.action",
                data : "jsonParam=" + jsonParam,
                success : callbackDeleteCodeInfo
            });
        }
    }
   function callbackDeleteCodeInfo(data) {
	   pageLog("데이터를 삭제하였습니다.", "warn");
       search();
    }
</script>
<script>
    function toggleCheckAll(allCheck) {
    	//$('#grid_panel #checkbox').attr("checked", allCheck.checked);
        $('#grid_panel #checkbox').each(function(){
            $(this).attr("checked", allCheck.checked);
        });
          
    }
</script>

<script type="text/javascript">
    function search() {
        var systemCd = $('#systemCd').val();
        var categoryCd = $('#categoryCd').val();
        var codeName = $('#codeName').val();
        
        $.ajax({
            url : "/photome/framework/codemanager/CodeList.action",
            data : {
                systemCd : systemCd,
                categoryCd : categoryCd,
                codeName : codeName
            },
            success : callbackSearch,
        });
        
        pageLog('data retirive complete','info');
    }

    function callbackSearch(data) {
        var json = data.message;
        var dataCnt = json.length;

       	var data = null;
        var element = null;
        if (dataCnt > 0) {
            
        	data = new Array();
            $.each(json, function(i, obj) {
            	element = new Array();
            	element[0] = '<input type="checkbox" id="checkbox" systemCd="' + obj.systemCd + '"  categoryCd="'+obj.categoryCd+'" codeValue="'+obj.codeValue+'" />';
            	element[1] = obj.systemCd;
            	element[2] = obj.categoryCd;
            	element[3] = obj.codeValue;
            	element[4] = obj.codeName;
            	element[5] = obj.descript;
            	element[6] = decode(obj.useYn, 'Y', 'active', 'N', 'disabled','-');
            	data[i] = element; 
            });
        }
        
        var obj = {title: "<b>Code</b> List", numberCell: false, editable: false,  freezeCols: 3, resizable:false, columnBorders: true, flexHeight:true};
        obj.width = 1200;
        obj.height = 500;
        obj.colModel = [
            {title:'<input type="checkbox" name="check_all" id="check_all" onclick="toggleCheckAll(this);">', width:20, dataType:"integer", resizable: false, hidden: false, sortable:false},
            {title:"<b>Div</b>", width:100, dataType:"string",
                render: function (ui) {
                      var rowData = ui.rowData;
                      if (rowData[1] == 'SYSTEM') {
                      	return '<font color="#FF0000">' + rowData[1] + '</font>';
                      } else {
                      	return rowData[1];
                      }
                } },
            {title:"<b>Category</b>", width:200, dataType:"string"},
            {title:"<b>Value</b>", width:200, dataType:"string"},
            {title:"<b>Name</b>", width:200, dataType:"string"},
            {title:"<b>Description</b>", width:200, dataType:"string"},
            {title:"<b>Use</b>", width:70, dataType:"string"}
            ];
        
        obj.dataModel = {data:data, sortIndx: 1, sortDir: "up", 
        		location: "local",
                sorting: "local",
                paging: "local",
                dataType: "Array",
                curPage: 1,
                rPP: 15,
                rPPOptions: [15, 20, 30, 50] };
        obj.rowClick = function( event, ui ) {
        	var rowData = ui.dataModel;
            var systemCd = rowData.data[ui.rowIndx][1];
            var categoryCd = rowData.data[ui.rowIndx][2];
            var codeValue = rowData.data[ui.rowIndx][3];
            
            modifyCodeInfo(systemCd,categoryCd,codeValue );
        };
        $("#grid_panel").pqGrid(obj);
        
    }
</script>

</head>
<body>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Search -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="search">
        <table class="search_table">
            <tr>
                <td class="label"><span class="required">*</span>System : <select name="systemCd" id="systemCd" style="width: 150px;" onchange="changeCategory(this.value);">
                </select></td>
                <td class="label">Category : <select name="categoryCd" id="categoryCd" style="width: 150px"></select></td>
                <td class="label">Name : <input id="codeName" name="codeName"></input></td>
                <td width="50" align="right">
                    <button class="search" onclick="search();">Find</button>
                </td>
            </tr>
        </table>
    </div>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Table List -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div class="grid_panel" id="grid_panel"></div>
    
    <div class="main_control">
        <table border="0" cellpadding="0" cellspacing="0" style="width: 1200px;">
            <tr>
                <td style="text-align: right;">
                    <button class="word3" onclick="addCodeInfo();">add</button>
                    <button class="word5" onclick="deleteCodeInfo();">delete</button>
                </td>
            </tr>
        </table>
    </div>

</body>
</html>