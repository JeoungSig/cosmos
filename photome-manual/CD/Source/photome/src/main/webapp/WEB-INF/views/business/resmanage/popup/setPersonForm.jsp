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
    }
</script>   
<script type="text/javascript">
    function search() {
        var firstName = $('#firstName').val();
        var userType = $('#userType').val();
        var roleId = $('#roleId').val();
        var useYn = $('#useYn').val();
        
        $.ajax({
            url : "/photome/business/resmanage/booth/UserList.action",
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
        $('#grid_table tbody').empty();

        var script_template = '<tr>'
            + '    <td class="key"> {firstName} </td>'
            + '    <td> {userType} </td>'
            + '    <td> {mobilePhone} </td> '
            + '    <td> {useYn} </td>'
            + '    <td> <button class="word6" onclick="select(\'{userId}\',\'{firstName}\')">select</button></td>'
            + '</tr>';

        var json = data.list;
        var dataCnt = json.length;

        var trObj = null;
        if (dataCnt > 0) {
            $.each(json, function(i, obj) {
                trObj = script_template.interpolate({
                    userId : obj.userId,
                    userType : decode(obj.userType,null,'',obj.userType),
                    firstName : obj.firstName,
                    mobilePhone : obj.mobilePhone,
                    email : obj.email,
                    useYn : decode(obj.useYn, 'Y', 'active', 'N', 'disabled','-')
                });
                $(trObj).appendTo('#grid_table tbody');
            });
        } else {
            $('<tr><td colspan="5"><br/>No registed information<br/><br/></td></tr>').appendTo('#grid_table tbody');
        }
    }
    
    function setUserTypeAndRole() {
        $.ajax({
            url : "/photome/business/resmanage/booth/UserTypeAndRole.action",
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
	function select(userId, userName) {
		
		if( '<c:out value="${who}" />' == 'technician'){
		  opener.document.getElementById('technicianDisplay').value = userName;
		  opener.document.getElementById('technician').value = userId;
		}else{
		  opener.document.getElementById('managerDisplay').value = userName;
		  opener.document.getElementById('manager').value = userId;
		}
		self.close();
	}
</script>


</head>
<body>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Search -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="search" style="width: 90%;">
        <table class="search_table" style="width: 100%;">
            <tr>
                <td class="label">Type :</td>
                <td><select name="userType" id="userType" style="width: 150px"></select></td>
                <td class="label">Name :</td>
                <td><input id="firstName" name="firstName" style="width: 150px;" /></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="label">Role :</td>
                <td><select name="roleId" id="roleId" style="width: 150px"></select></td>
                <td class="label">Active :</td>
                <td>
                    <select id="useYn" name="useYn" style="width: 100px">
                            <option selected></option>
                            <option value="Y">Active</option>
                            <option value="N">Disable</option>
                    </select>
                </td>
                <td width="50" align="right"><button class="search" onclick="search();">Find</button></td>
            </tr>

        </table>
    </div>


    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Table List -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div class="grid_table_panel">
        <table id="grid_table" class="grid_table" width="100%" cellspacing="0" cellpadding="0">
            <thead>
                <tr>
                    <th width='100px'>Name</th>
                    <th width='100px'>User Type</th>
                    <th width='100px'>Mobile</th>
                    <th width='100px'>Use Y/N</th>
                    <th class="last">&nbsp;</th>
                </tr>
            </thead>
            <tbody>
                <!-- Code List -->
                <tr><td colspan="5"><br/>No information<br/><br/></td></tr>
            </tbody>
        </table>
    </div>

    <br/>
    <br/>

</body>
</html>