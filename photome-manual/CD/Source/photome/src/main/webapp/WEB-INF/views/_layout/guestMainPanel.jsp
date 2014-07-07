<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<html>
<head>
<tiles:insertAttribute name="globalHeader" />
<title><tiles:getAsString name="title" /></title>
<tiles:insertAttribute name="resource" />

<link rel="stylesheet" type="text/css" href="/photome/resources/skin/skin2.css" />

</head>
<body id="physical_body">

    <table width="100%" cellspacing="0" cellpadding="0" border="0">
        <tr>
            <td><tiles:insertAttribute name="header" /></td>
        </tr>
    </table>

    <table width="100%" cellspacing="0" cellpadding="0" border="0">
        <tr>
            <td>
                <table width="100%" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="40%" style="vertical-align: top;"><tiles:insertAttribute name="login" /></td>
                        <td width="60%" style="vertical-align: top;"><tiles:insertAttribute name="notice" /></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <table style="width: 100%" cellspacing="0" cellpadding="0">
        <tr>
            <td style="width: 100%; text-indent: 5px; color: #BCBCBC"><div id="pageLog" style="display: block; height:15px; overflow: hidden;" onclick="viewPageLog(this)"></div></td>
        </tr>
    </table>

    <table width="100%" cellspacing="0" cellpadding="0" border="0">
        <tr>
            <td><tiles:insertAttribute name="footer" /></td>
        </tr>
    </table>


</body>
</html>
<tiles:insertAttribute name="globalFooter" />