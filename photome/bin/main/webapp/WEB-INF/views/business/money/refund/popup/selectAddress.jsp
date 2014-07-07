<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript">
    function loadPage() {  }
</script> 
<script type="text/javascript">
    function search() {
        var state   = $('#state').val();
        var suburb   = $('#suburb').val();
        
        if( state == '' || state == null ){
        	if( suburb == '' || suburb == null ){
                alert("You need to choose search condition !");
                return;
        	}
        } else {
            if( suburb == '' || suburb == null ){
                alert("You need to choose suburb for search condition !");
                return;
            }
        }
        
        $.ajax({
            url : "/photome/business/money/refund/SelectAddress.action",
            data : {
            	state  : state,
                suburb : suburb
            },
            success : callbackSearch,
        });
        
        pageLog('data retirive complete','info');
    }

    function callbackSearch(data) {
        $('#grid_table tbody').empty();
        
        var script_template = '<tr>'
            + '    <td> {pcode}</td>'
            + '    <td> {state} </td>'
            + '    <td> {locality}</td> '
            + '    <td> {comment} </td>'
            + '    <td> <button class="word4" onclick="select(\'{pcode}\',\'{state}\',\'{locality}\')">select</button></td>'
            + '</tr>';

        var json = data.jsonList;
        var dataCnt = json.length;

        var trObj = null;
        if (dataCnt > 0) {
            $.each(json, function(i, obj) {
                trObj = script_template.interpolate({
                	pcode   : obj.pcode,
                	locality : obj.locality,
                	state : obj.state,
                	comment : obj.comment
                });
                $(trObj).appendTo('#grid_table tbody');
            });
        } else {
            $('<tr><td colspan="5"><br/>No information<br/><br/></td></tr>').appendTo('#grid_table tbody');
        }
    }
    function select(pcode, state, locality) {
        opener.document.getElementById('reqPostcd').value = pcode;
        opener.document.getElementById('reqState').value = state;
        
        var f = opener.document.saveForm;
        f.reqSuburb.length = 1;
        f.reqSuburb.options[0].value = locality;
        f.reqSuburb.options[0].text = locality;
        
        self.close();
    }
</script>
<script type="text/javascript">
	function setBooth(group){
	    var groupId = group.value;
	    $.ajax({
	        url : "/photome/business/money/refund/BoothListOfGroup.action",
	        data : "groupId=" + groupId,
	        success : callbackSetBooth,
	    });     
	}
	function callbackSetBooth(data) {
	    var boothList =  data.boothList;
	    $('#boothId').empty();
	    var options = "<option></option>";
	    for(var i = 0; i < boothList.length; i++){
	        options = options + "<option value='" + boothList[i].boothId + "'>" + boothList[i].boothName + "</option>\n" ;
	    }
	    $('#boothId').html(options);
	}
</script>

</head>
<body>

    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Search -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="search" style="width: 90%"> 
        <table class="search_table" border="0"> 
            <tr>
                <td class="label">State :</td>
                <td><select name="state" id="state" style="width: 100px" ><c:out value="${stateListOptions}" escapeXml="false" /></select></td>
                <td class="label">Suburb </td>
                <td><input id="suburb" name="suburb" style="width: 150px;" /></td>
                <td rowspan="2" style="text-align: right;vertical-align: bottom;"><button class="search" onclick="search();">Find</button></td>
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
                    <th>Postcode</th>
                    <th>State</th>
                    <th>Locality</th>
                    <th>Comment</th>
                    <th class="last">&nbsp;</th>
                </tr>
            </thead>
            <tbody>
                <!-- Code List -->
                <tr><td colspan="5"><br/>No registed information<br/><br/></td></tr>
            </tbody>
        </table>
    </div>

</body>
</html>