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

</head>
<body>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Form Table -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
     <div id="detail_panel" class="detail_panel">
         <table id="detail_table" class="detail_table" cellpadding="0" cellspacing="0">
            <colgroup>
                <col width="100px" />
                <col width="100px" />
                <col width="150px" />
                <col width="100px" />
                <col width="*" />
            </colgroup>

             <tr><td colspan="5"><br/><h2 class="ckbox">Group Information</h2></td></tr> 
             <tr>
                 <td class="label" rowspan="3">Basic Info</td>
                 <td class="label">Group Name :</td>
                 <td class="value" colspan="3"><b>${groupDto.groupName }</b></td>
             </tr>
             <tr>
                 <td class="label">Description :</td>
                 <td class="value" colspan="3">${groupDto.groupDescript }</td>
             </tr>
             <tr>
                 <td class="label">Comment :</td>
                 <td class="value" colspan="3"><c:out value="${groupDto.groupComment }" escapeXml="false"/></td>
             </tr>               

             <tr><td colspan="5" style="height: 10px;" >&nbsp;</td></tr>  
             <tr>
                 <td class="label" rowspan="2">Manager Info</td>
                 <td class="label">Name :</td>
                 <td class="value"><c:out value="${groupDto.managerName }" /></td>
                 <td class="label">Tel. :</td>
                 <td class="value"><c:out value="${groupDto.managerTel }" /></td>
             </tr>
             <tr>
                 <td class="label">Mobile :</td>
                 <td class="value"><c:out value="${groupDto.managerMobile }" /></td>
                 <td class="label">Email :</td>
                 <td class="value"><c:out value="${groupDto.managerEmail }" /></td>
             </tr>

             <tr><td colspan="5"><br/><h2 class="ckbox">Contract Information</h2></td></tr> 
             <tr> 
                 <td class="label" colspan="2">Contract Condition :</td>
                 <td class="value" colspan="3"><pre><c:out value="${groupDto.contractCondition }" escapeXml="false"/></pre></td>
             </tr>

             <tr>
                 <td class="label" colspan="2">Attach File :</td>
                 <td class="value" colspan="3">
                     <c:if test="${!empty attachFileDto.fileName }"> <a href="/photome/download/${attachFileDto.fullPath }">${attachFileDto.fileName }</a></c:if>
                 </td>
             </tr>
             <tr><td colspan="5">&nbsp;</td></tr> 

         </table>
     </div>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Subaction buttons bar & Pagging -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="main_control" class="main_control">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="85%"></td>
                <td width="*" align="left">
                </td>
            </tr>
        </table>
    </div>


</body>
</html>