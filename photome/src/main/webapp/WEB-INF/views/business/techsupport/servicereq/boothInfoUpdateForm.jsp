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

    function modify() {
        if (checkMandatory() == false)  return;
        var boothId             = '<c:out value="${boothDto.boothId}" />';
        var type                = $('#type').val();
        var serialNo            = $('#serialNo').val();
        var printerModel        = $('#printerModel').val();
        var payOnsite           = $('#payOnsite').val();
        var boothComment        = $('#boothComment').val();
        var status              = $('#status').val();
        var locPostcd           = $('#locPostcd').val();
        var locState            = $('#locState').val();
        var locStreetNo         = $('#locStreetNo').val();
        var locSuburb           = $('#locSuburb').val();
        var monitorType         = $('#monitorType').val();
        
        $.ajax({
            url : "/photome/business/techsupport/servicereq/BoothInfoUpdate.action",
            data : {
                boothId            : boothId    ,
                type               : type         ,
                serialNo           : serialNo     ,
                printerModel       : printerModel ,
                payOnsite          : payOnsite  ,                
                boothComment       : boothComment   ,
                status             : status      ,
                locPostcd          : locPostcd   ,
                locState           : locState    ,
                locStreetNo        : locStreetNo ,
                locSuburb          : locSuburb   ,
                monitorType        : monitorType      },
            success : callbackSaveBoothInfo
        });

    }
    function callbackSaveBoothInfo(data) {
        var returnValue = {
                message : 'Information registed modified : <c:out value="${boothDto.boothId}" />'
        };
        setOpenerDataset(returnValue);
    }
</script>
<script type="text/javascript">
    function setAddress(object){
        var addrZipcd = $('#locPostcd').val();
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
        $('#locState').val('');
        $('#locSuburb').empty();
        
        var script_template = '<option value=\"{locality}\">{locality}</option>';
        
        var state = data.state;
        var json = data.postAddrList;
        
        $('#locState').val(state);
        
        var option = null;
        $.each(json, function(i, obj) {
            option = script_template.interpolate({
                locality : obj.locality
            });
            $(option).appendTo('#locSuburb');
        });
    }   
</script> 

</head>
<body>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Form Table -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="detail_panel" class="detail_panel">
        <table id="detail_table" class="detail_table" cellpadding="0" cellspacing="0" style="width: 750px;" >
            <colgroup>
                <col width="170px" />
                <col width="230px" />
                <col width="170px" />
                <col width="*" />
            </colgroup>

            <tr>
                <td class="label"><span class="required">*</span>Booth Name :</td>
                <td class="value" colspan="3"><c:out value="${boothDto.boothName}" /></td>
            </tr>    
            <tr>
                <td class="label"><span class="required">*</span>Booth Group :</td>
                <td class="value" colspan="3"><c:out value="${boothDto.groupName}" /></td>
            </tr>
            <tr>
                <td class="label">Comment :</td> 
                <td class="value" colspan="3"><br /> &nbsp;<textarea name="boothComment" id="boothComment" rows="10" cols="2" style="width: 500px; height: 40px;"><c:out value="${boothDto.boothComment}" /></textarea> <br /> <br /></td>
            </tr>
            <tr>
                <td class="label"><span class="required">*</span>Status :</td>
                <td class="value" colspan="3">
                    <select id="status" name="status" style="width: 200px" mandatory="true" >
                        <c:out value="${boothStatusOptions}" escapeXml="false"/>
                    </select>
                </td>
            </tr>                                    
            <tr><td colspan="4" style="height: 15px;"></td></tr>  
            
            
            <tr>
                <td class="label">Type :</td>
                <td class="value">
                   <select id="type" name="type" style="width: 150px;" >
                       <c:out value="${boothTypeOptions}" escapeXml="false"/> 
                   </select>
                </td>
                <td class="label"><span class="required">*</span>Serial No :</td>
                <td class="value"><input type="text" id="serialNo" name="serialNo" style="width: 150px;" mandatory="true" value="<c:out value="${boothDto.serialNo}"/>" /></td>                    
            </tr>
            <tr>
                <td class="label"><span class="required">*</span>Printer Model :</td>
                <td class="value">
                    <select id="printerModel" name="printerModel" style="width: 150px;" mandatory="true" >
                          <c:out value="${printerTypeOptions}" escapeXml="false"/>
                    </select>
                </td>
                <td class="label"><span class="required">*</span>Monitor type :</td>
                <td class="value">
                    <select id="monitorType" name="monitorType" style="width: 150px;" mandatory="true" >
                          <c:out value="${monitorTypeOptions}" escapeXml="false"/>
                    </select>
                </td>                    
            </tr>     
        <tr>
                <td class="label">Quality Result :</td>
                <td class="value"><c:out value="${boothDto.qualityTestResultName}"/></td>
                <td class="label">Test Date :</td>
                <td class="value"><c:out value="${boothDto.qualityTestDt}"/></td>
            </tr>
            <tr><td colspan="4" style="height: 15px;"></td></tr> 
            
                              
            <tr>
                <td class="label"><span class="required">*</span>Rent fee type :</td>
                <td class="value"><c:out value="${boothDto.rentFeeTypeName}"/></td>                
                <td class="label"><span class="required">*</span>Pay on-site :</td>
                <td class="value">
                        <c:choose>
                            <c:when test="${boothDto.payOnsite == 'Y'}">
                                Yes
                            </c:when>
                            <c:when test="${boothDto.payOnsite == 'N'}">
                                No
                            </c:when>
                            <c:otherwise>
                                -
                            </c:otherwise>
                        </c:choose>                
                </td>                    
            </tr>
          
            <tr><td colspan="4" style="height: 15px;"></td></tr> 

            <tr>
                <td class="label"><span class="required">*</span>Zip Code :</td>
                <td class="value"><input type="text" id="locPostcd" name="locPostcd" style="width: 100px;" mandatory="true" onblur="setAddress(this);" value="<c:out value="${boothDto.locPostcd}" />" /></td>
                <td class="label"><span class="required">*</span>State :</td>
                <td class="value"><input type="text" id="locState" name="locState" style="width: 150px; background-color: #E5E5E5;" mandatory="true" readonly="readonly"  value="<c:out value="${boothDto.locState}" />" /></td>
            </tr>
            <tr>
                <td class="label"><span class="required">*</span>No/Street :</td>
                <td class="value" colspan="3"><input type="text" id="locStreetNo" name="locStreetNo" style="width: 400px;" mandatory="true"  value="<c:out value="${boothDto.locStreetNo}" />" /></td>
            </tr>
            <tr>
                <td class="label"><span class="required">*</span>Suburb :</td>
                <td class="value" colspan="3">
                    <select name="locSuburb" id="locSuburb" style="width: 150px;" mandatory="true">
                        <option value="<c:out value="${boothDto.locSuburb}" />"><c:out value="${boothDto.locSuburb}" /></option>
                    </select>
                </td>
            </tr>

            <tr><td colspan="4" style="height: 15px;"></td></tr>

            <tr>
                <td class="label"><span class="required">*</span>Technician :</td>
                <td class="value" nowrap colspan="3"><c:out value="${boothDto.technicianName}" /></td>
            </tr>

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
                    <button class="word3" onclick="javascript:modify()">modify</button>
                </td>
            </tr>
        </table>
    </div>


</body>
</html>