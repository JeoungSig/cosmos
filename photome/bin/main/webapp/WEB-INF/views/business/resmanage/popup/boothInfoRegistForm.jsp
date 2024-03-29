<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript">
    $(document).ready(function() {
    	// 기본값 설정
		$('#rentFeeType > option[value=\'FIXED_MONEY\']').attr("selected", "true");
		
    	// 항목값 초기화
        $(function() {
            var option = {
                  changeMonth: true,
                  dateFormat: 'dd/mm/yy',
                  yearRange:'1940:+0',
                  changeYear: true
                };
            $("#tagDueDt").datepicker(option);
            $("#qualityTestDt").datepicker(option);
        });
        
        var t = new Date();
        var tDate = t.getDate();
        var tMonth = (t.getMonth()+1);
        if(tMonth < 10) tMonth = '0' + tMonth;
        var tYear = t.getFullYear();
    });  
</script>

<script type="text/javascript">
    function loadPage() {  }
</script>

<script type="text/javascript">
    function save() {
        if (checkMandatory() == false)  return;
        
        var groupId             = $('#groupId').val();
        var boothName           = $('#boothName').val();
        var type                = $('#type').val();
        var serialNo            = $('#serialNo').val();
        var printerModel        = $('#printerModel').val();
        var captureType         = $('#captureType').val();
        var padLock             = $('#padLock').val();
        var insideLock          = $('#insideLock').val();
        var rentFeeType         = $('#rentFeeType').val();
        var payOnsite           = $('#payOnsite').val();
        var tagDueDt            = $('#tagDueDt').val();
        var boothComment        = $('#boothComment').val();
        var qualityTestResult   = $('#qualityTestResult').val();
        var qualityTestDt       = $('#qualityTestDt').val();
        var status              = $('#status').val();
        var locPostcd           = $('#locPostcd').val();
        var locState            = $('#locState').val();
        var locStreetNo         = $('#locStreetNo').val();
        var locSuburb           = $('#locSuburb').val();
        var locDetail           = $('#locDetail').val();
        var manager             = $('#manager').val();
        var technician          = $('#technician').val();
        var monitorType         = $('#monitorType').val();

        $.ajax({
            url : "/photome/business/resmanage/booth/BoothInfoRegist.action",
            data : {
            	groupId            : groupId    ,
            	boothName          : boothName    ,
            	type               : type         ,
            	serialNo           : serialNo     ,
            	printerModel       : printerModel ,
            	captureType        : captureType  ,
            	padLock            : padLock      ,
            	insideLock         : insideLock   ,
            	rentFeeType        : rentFeeType  ,
            	payOnsite          : payOnsite  ,
            	tagDueDt           : tagDueDt     ,
            	boothComment       : boothComment ,
            	qualityTestResult  : qualityTestResult   ,
            	qualityTestDt      : qualityTestDt       ,
            	status             : status      ,
            	locPostcd          : locPostcd   ,
            	locState           : locState    ,
            	locStreetNo        : locStreetNo ,
            	locSuburb          : locSuburb   ,
            	locDetail          : locDetail   ,
            	manager            : manager     ,
            	monitorType        : monitorType ,
            	technician         : technician       },
            success : callbackSaveBoothInfo
        });

    }
    function callbackSaveBoothInfo(data) {
    	pageLog("New code information registed");
        
        var returnValue = {
        		groupId : $('#groupId').val()
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
<script type="text/javascript">
	function setPerson(who) {
		var url = '/photome/business/resmanage/booth/SetPersonForm.action?who=' + who;
	    var windowName = 'business/resmanage/booth/SetPersonForm';
	    var win = openPopupForm(url, windowName, '700', '500');
	}
    function setReturnValue(returnValue) {
    	pageLog("하나의 정보가 추가되었습니다.", "info");
        $('#svcName').val(returnValue.svcName);
        search();
    }
</script>
</head>
<body>

	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- Form Table -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++ -->
	<form id="saveForm" name="saveForm" method="post" enctype="multipart/form-data">
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
                    <td class="value" colspan="3"><input type="text" id="boothName" name="boothName" style="width: 380px;" mandatory="true" /></td>
                </tr>    
				<tr>
					<td class="label"><span class="required">*</span>Booth Group :</td>
					<td class="value" colspan="3">
					   <select id="groupId" name="groupId" style="width: 150px" mandatory="true" >
							<c:out value="${groupListOptions}" escapeXml="false"/> 
						</select></td>
				</tr>
                <tr>
                    <td class="label">Comment :</td> 
                    <td class="value" colspan="3"><br /> &nbsp;<textarea name="boothComment" id="boothComment" rows="10" cols="2" style="width: 500px; height: 40px;"></textarea> <br /> <br /></td>
                </tr>
                <tr>
                    <td class="label"><span class="required">*</span>Status :</td>
                    <td class="value">
                        <select id="status" name="status" style="width: 200px" mandatory="true" >
                            <c:out value="${boothStatusOptions}" escapeXml="false"/>
                        </select>
                    </td>
                </tr>    
                <tr><td colspan="4" style="height: 15px;"></td></tr>				
				
				<tr>
					<td class="label">Type :</td>
					<td class="value">
					   <select id="type" name="type" style="width: 150px" >
					       <c:out value="${boothTypeOptions}" escapeXml="false"/> 
					   </select>
					</td>
                    <td class="label"><span class="required">*</span>Serial No :</td>
                    <td class="value"><input type="text" id="serialNo" name="serialNo" style="width: 150px;" mandatory="true" /></td>					
				</tr>
				<tr>
                    <td class="label"><span class="required">*</span>Printer Model :</td>
                    <td class="value">
                        <select id="printerModel" name="printerModel" style="width: 150px" mandatory="true" >
                              <c:out value="${printerTypeOptions}" escapeXml="false"/>
                        </select>
                    </td>
                    <td class="label"><span class="required">*</span>Monitor type :</td>
                    <td class="value">
                        <select id="monitorType" name="monitorType" style="width: 150px" mandatory="true" >
                              <c:out value="${monitorTypeOptions}" escapeXml="false"/>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="label">TAG Due date :</td>
                    <td class="value"><input type="text" id="tagDueDt" name="tagDueDt" style="width: 150px;"  readonly="readonly" /></td>
                    <td class="label">Capture Type :</td>
                    <td class="value">
                       <select id="captureType" name="captureType" style="width: 150px" >
                           <c:out value="${captureTypeOptions}" escapeXml="false"/>
                       </select></td>   
                </tr>
				<tr>
					<td class="label"><span class="required">*</span>Pad Lock :</td>
					<td class="value"><input type="text" id="padLock" name="padLock" style="width: 150px;" mandatory="true" /></td>
					<td class="label"><span class="required">*</span>Inside Lock :</td>
					<td class="value"><input type="text" id="insideLock" name="insideLock" style="width: 150px;" mandatory="true" /></td>
				</tr>
                <tr>
                    <td class="label">Quality Result :</td>
                    <td class="value">
                        <select id="qualityTestResult" name="qualityTestResult" style="width: 200px" >
                            <c:out value="${qltyResultOptions}" escapeXml="false"/>
                        </select>
                    </td>
                    <td class="label">Test Date :</td>
                    <td class="value"><input id="qualityTestDt" name="qualityTestDt" style="width: 150px;" value="<c:out value="${userDto.birthDt}"/>" readonly="readonly" /> &nbsp;</td>
                </tr>
                <tr><td colspan="4" style="height: 15px;"></td></tr>
                
                 				
				<tr>
                    <td class="label"><span class="required">*</span>Rent fee type :</td>
                    <td class="value">
                    <select id="rentFeeType" name="rentFeeType" style="width: 200px" mandatory="true">
                           <c:out value="${rentFeeTypeOptions}" escapeXml="false"/>
                       </select>
                    </td>  				
                    <td class="label"><span class="required">*</span>Pay on-site :</td>
                    <td class="value">
                        <select id="payOnsite" name="payOnsite" style="width: 150px" mandatory="true" >
                            <option value="N" selected>No</option>
                            <option value="Y">Yes</option>
                        </select>
                    </td>
				</tr>
                <tr><td colspan="4" style="height: 15px;"></td></tr>
 
				<tr>
					<td class="label"><span class="required">*</span>Zip Code :</td>
					<td class="value"><input type="text" id="locPostcd" name="locPostcd" style="width: 100px;" mandatory="true" onblur="setAddress(this);" /></td>
					<td class="label"><span class="required">*</span>State :</td>
					<td class="value"><input type="text" id="locState" name="locState" style="width: 150px; background-color: #E5E5E5;" mandatory="true" readonly="readonly" /></td>
				</tr>
				<tr>
					<td class="label"><span class="required">*</span>No/Street :</td>
					<td class="value" colspan="3"><input type="text" id="locStreetNo" name="locStreetNo" style="width: 400px;" mandatory="true" /></td>
				</tr>
				<tr>
					<td class="label"><span class="required">*</span>Suburb :</td>
					<td class="value" colspan="3"><select name="locSuburb" id="locSuburb" style="width: 150px;" mandatory="true"></select></td>
				</tr>
				<tr>
					<td class="label"><span class="required">*</span>Location detail :</td>
					<td class="value" colspan="3"><input type="text" id="locDetail" name="locDetail" style="width: 400px;" mandatory="true" /></td>
				</tr>
                <tr><td colspan="4" style="height: 15px;"></td></tr>				


                <tr>
                    <td class="label">Manager :</td>
                    <td class="value">
                        <input type="text" id="managerDisplay" name="managerDisplay" style="width: 200px; background-color: #E5E5E5;" readonly="readonly" />
                        <img src="/photome/resources/images/common/roundinfo_icon.gif" onclick="setPerson('manager');" style="cursor:hand;" />
                        <input type="hidden" id="manager" name="manager" value="" />
                    </td>
                    <td class="label"><span class="required">*</span>Technician :</td>
                    <td class="value" nowrap>
                        <input type="text" id="technicianDisplay" name="technicianDisplay" style="width: 200px; background-color: #E5E5E5;" mandatory="true" readonly="readonly" />
                        <input type="hidden" id="technician" name="technician" value="" />
                        <img src="/photome/resources/images/common/roundinfo_icon.gif" onclick="setPerson('technician');" style="cursor:hand;" />
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
					<button class="word3" onclick="save();">save</button>
				</td>
			</tr>
		</table>
	</div>


</body>
</html>