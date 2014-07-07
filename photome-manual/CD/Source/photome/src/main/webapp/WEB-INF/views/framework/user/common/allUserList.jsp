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
		setUserTypeAndRole();
		search();
	}
</script>	
<script type="text/javascript">
	function search() {
		var firstName = $('#firstName').val();
		var userType = $('#userType').val();
		var roleId = $('#roleId').val();
		var useYn = $('#useYn').val();
		
		$.ajax({
			url : "/photome/common/common/alluserlist/UserList.action",
			data : {
				firstName : firstName,
				userType : userType,
				roleId : roleId,
				useYn : useYn
			},
			success : callbackSearch,
		});
		
		pageLog('data retirive complete','info');
	}

	function callbackSearch(data) {
		
        var table_template = '<table id="table_data" class="dataTable">'
            + '<thead>'
            + '    <tr>'
            + '        <th width="70px">Photo</th>'
            + '        <th width="70px">ID</th>'
            + '        <th width="200px">Name</th>'
            + '        <th width="40px">Sex</th>'
            + '        <th width="100px">Mobile</th>'
            + '        <th width="100px">Tel</th>'
            + '        <th width="200px">Email</th>'
            + '        <th width="350px">Address</th>'
            + '        <th width="*">Last Login</th>'
            + '    </tr>'
            + '</thead>'
            + '<tfoot>'
            + '    <tr>'
            + '        <th style="text-align:right" colspan="9"></th>'
            + '    </tr>'
            + '</tfoot>';
            
        $('#grid_array').html(table_template);
        
		var json = data.list;
		var dataCnt = json.length;

        // 테이블의 타이틀 설정
        var colM = [ { title: "Photo", dataType: "string", align: "left" },
                     { title: "ID", dataType: "string", align: "left" }, 
                     { title: "Nae", dataType: "string" },
                     { title: "Sex", dataType: "string" },
                     { title: "Mobile", dataType: "string", align: "right" },
                     { title: "Tel", dataType: "float", align: "right"},
                     { title: "Email", dataType: "date", align: "left" },
                     { title: "Address", dataType: "string", align: "left" },
                     { title: "Last Login", dataType: "string", align: "left" }
                  ];

        // 테이블 데이터 설정
        if (dataCnt > 0) {
            var data = new Array();
            var element = null;
            $.each(json, function(i, obj) {
                 element = new Array();
                 if(obj.pictureFullPath == '' || obj.pictureFullPath == null){
                	   element[0] = '-';
                 }else{
                	   element[0] = '<img src="/photome/image?file=' + obj.pictureFullPath + '" width="50px" height="55px"/>';
                 }
                 element[1] = obj.userId;
                 element[2] = '<b>' + obj.firstName + '</b>';
                 element[3] = decode(obj.sex, 'M','Male','F','Femal','-');
                 element[4] = '<font color="#006FA4">' + obj.mobilePhone + '</font>';
                 element[5] = obj.telephone;
                 element[6] = '<font color="#006FA4">' + obj.email + '</font>';
                 element[7] = decode(obj.addrStreet,'-') + ", " + decode(obj.addrSuburb,'-') + ", " + decode(obj.addrState,'-') + " " + decode(obj.addrZipcd,'-');
                 element[8] = obj.loginDt;
                 data[i] = element;
            }); 
        }       
        
        $('#table_data').dataTable( {
            "bScrollCollapse": true,
            "aaData": data,
            "aaSorting": [[ 2, "asc" ]],
            "aoColumns" : colM,
            "sPaginationType": "full_numbers"
        });		
		
	}
	
    function setUserTypeAndRole() {
        $.ajax({
            url : "/photome/framework/usermanager/UserTypeAndRole.action",
            success : callbackSetUserTypes,
        });
    }

    function callbackSetUserTypes(data) {
        // 사용자 Type     
        $('#userType').empty();
        $('<option></option>').appendTo('#userType');
        
        var script_template = '<option value=\"{codeValue}\">{codeName}</option>';
        var json = data.userTypes;
        var option = null;
        $.each(json, function(i, obj) {
            option = script_template.interpolate({
            	codeValue : obj.codeValue,
            	codeName : obj.codeName
            });
            $(option).appendTo('#userType');
        });
        
        // 롤 정보콤보 설정     
        $('#roleId').empty();
        $('<option></option>').appendTo('#roleId');
        
        var script_template = '<option value=\"{roleId}\">{roleName}</option>';
        var json = data.roles;
        var option = null;
        $.each(json, function(i, obj) {
            option = script_template.interpolate({
            	roleId : obj.roleId,
            	roleName : obj.roleName
            });
            $(option).appendTo('#roleId');
        });
    }
    
    
</script>

<script type="text/javascript">
    function addUserInfo() {
        var url = '/photome/framework/usermanager/UserRegistForm.action';
        var windowName = 'sysAdmin/framework/UserRegistForm';
        var win = openPopupForm(url, windowName, '720', '540');
    }
    
    function modifyUserInfo(userId) {
        var url = '/photome/framework/usermanager/UserModifyForm.action?userId=' + userId;
        var windowName = 'sysAdmin/framework/UserModifyForm';
        var win = openPopupForm(url, windowName, '720', '540');
    }
    
    function getUserInfo(userId) {
        var url = '/photome/framework/usermanager/UserDetailInfo.action?userId=' + userId;
        var windowName = 'sysAdmin/framework/UserDetailInfo';
        var win = openPopupForm(url, windowName, '720', '600');
        window.focus();
    }
    
    function viewUserRoles(userId) {
        var url = '/photome/framework/usermanager/UserRole.action?userId=' + userId;
        var windowName = 'sysAdmin/framework/UserDetailInfo';
        var win = openPopupForm(url, windowName, '720', '540');
    }
    
    function setReturnValue(returnValue) {
    	pageLog(returnValue.message, "info");
        search();
    }
</script>



</head>
<body>

	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- Search -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<div id="search">
		<table class="search_table">
			<tr>
				<td class="label">User Name :</td>
				<td><input id="firstName" name="firstName" style="width: 250px;" /></td>
				<td width="50" align="right"><button class="search" onclick="search();">Find</button></td>
			</tr>
		</table>
	</div>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Table List -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
   <div id="grid_array"></div>
    

</body>
</html>