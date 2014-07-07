<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript">
    function loadPage() {
    }
    function addUserInfo() {
        var url = '/photome/common/createAccount/AccountRegistForm.action';
        var windowName = 'guest/AccountRegistForm';
        var win = openPopupForm(url, windowName, '770', '570'); 
    }
    function setReturnValue(returnValue) {
    	pageLog(returnValue.message, "info");
    }
    function pressEnter(){
        if ( event.keyCode == 13 ) { 
            login();
        }
    }
</script>
<script type="text/javascript">
    function login(){
        var userId = $('#userId').val();
        var passwd = $('#passwd').val();
        
        $.ajax({
            url : "/photome/common/auth/Login.action",
            data : {
                userId : userId,
                passwd : passwd },  
            success : callbackLogin,
        });
    }
    
    function callbackLogin(data) {
        
        if(data.status == 'success'){
            // 로그인이 성공적으로 이루어진경우
            document.location.href = "/photome/common/auth/Welcome.action";
        } else {
        	pageLog(data.message, "warn");
        }
    }  
</script>

</head>
<body id="wrapper_skin2">
 
    <br/><br/>
    <h2>LOGIN</h2>
    <div class="detail_panel">
        <table cellpadding="0" cellspacing="0" class="detail_table" style="width: 550px;">
            <tr>
                <td class="label"  style="width: 150px;">User ID :</td>
                <td class="value"  style="width: 200px;"><input type="text" name="userId" id="userId" maxlength="15" style="width: 200px; height: 30px; font-size: 15; font-weight: bold; background-color: #D8D8EB;" onkeydown="pressEnter();"></td>
                <td style="width: 200px; vertical-align: bottom;" rowspan="2"><img src="/photome/resources/images/common/Login.jpg" style="width: 40%;cursor: pointer;" onclick="javascript:login();"></td>
            </tr>
            <tr>
                <td class="label">User Password :</td>
                <td class="value"><input type="password" name="passwd" id="passwd" maxlength="15" style="width: 200px; height: 30px;background-color: #F1F1F8;" onkeydown="pressEnter();"></td>
                <td></td>
            </tr>
            <tr>
                <td class="value">&nbsp;</td>
                <td class="value">&nbsp;</td>
                <td class="value" align="right"> <a href="javascript:addUserInfo();"> >> Create an account </a></td>
            </tr>
        </table>
    </div>
    <table cellpadding="0" cellspacing="0" class="detail_table" style="width: 550px;">
       <tr>
           <td><c:out value="${message}"/></td>
           <td><c:out value="${status}"/></td>
       </tr>
    </table>
    <br/><br/>
</body>
</html>