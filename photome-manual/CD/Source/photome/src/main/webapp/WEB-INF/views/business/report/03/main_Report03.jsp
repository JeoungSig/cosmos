<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!-- 
Photo Me Report 03.
Photo Me Report 03.
Photo Me Report 03.
 -->

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript"> 
    function loadPage() {
        //$("#groupId option:eq(1)").attr("selected", "selected");
        search();
    }
</script>
<script type="text/javascript">
    $(document).ready(function() {

    }
</script>    
<script type="text/javascript">
    function emptyDefaultValue(value, defaultValue){
    	if(value == null || value == '' || isNaN(value)) {
    		value = defaultValue;
    	}
    	return value;
    }
    function centRound(value){
    	var temVal = (Math.round(value*100)) / 100;
    	var retVal = temVal.toFixed(2);
    	return retVal;
    }
</script>    
<script type="text/javascript">
    function search() {
        var collectYear = $('#collectYear').val();
    	var collectCollector         = $('#collectCollector').val();

    	$.ajax({
            url : "/photome/business/report/photome/03/ReportDataList.action",
            data : {
            	collectCollector : collectCollector,
                collectYear   : collectYear
            },
            success : callbackSearch,
        });
        
        pageLog('data retirive complete','info');
    }

	function callbackSearch(data) {
		 
	     var json = data.list;
	     var dataCnt = json.length;
	     
	     var arrayData = null;
	     var element = null;
	     
	     if (dataCnt > 0) {
	         
	         arrayData = new Array();
	         $.each(json, function(i, obj) {
	        	 element = new Array();
	             element[0] = obj.userDto.addrState;
	             element[1] = obj.userDto.firstName;
	             
	             element[2] = obj.collectAmtTot;  
	             
	             element[3] = decode(obj.collectAmt01, '0.00','',obj.collectAmt01);
	             element[4] = decode(obj.collectAmt02, '0.00','',obj.collectAmt02);
	             element[5] = decode(obj.collectAmt03, '0.00','',obj.collectAmt03);
	             element[6] = decode(obj.collectAmtQ1, '0.0','',obj.collectAmtQ1);
	             
	             element[7] = decode(obj.collectAmt04, '0.00','',obj.collectAmt04);
	             element[8] = decode(obj.collectAmt05, '0.00','',obj.collectAmt05);
	             element[9] = decode(obj.collectAmt06, '0.00','',obj.collectAmt06);
                 element[10] = decode(obj.collectAmtQ2, '0.0','',obj.collectAmtQ2);              
	             
                 element[11] = decode(obj.collectAmt07, '0.00','',obj.collectAmt07);
	             element[12] = decode(obj.collectAmt08, '0.00','',obj.collectAmt08);
	             element[13] = decode(obj.collectAmt09, '0.00','',obj.collectAmt09);
                 element[14] = decode(obj.collectAmtQ3, '0.0','',obj.collectAmtQ3);
	             
                 element[15] = decode(obj.collectAmt10, '0.00','',obj.collectAmt10);
	             element[16] = decode(obj.collectAmt11, '0.00','',obj.collectAmt11);
	             element[17] = decode(obj.collectAmt12, '0.00','',obj.collectAmt12);
                 element[18] = decode(obj.collectAmtQ4, '0.0','',obj.collectAmtQ4);
	             
	             arrayData[i] = element; 
	         });
	     }
	     
	     var summaryData;
	     var collectAmtTotal = 0, 
	         collectAmtTotal01 = 0, collectAmtTotal02 = 0, collectAmtTotal03 = 0, collectAmtTotal04 = 0, collectAmtTotal05 = 0, collectAmtTotal06 = 0, 
	         collectAmtTotal07 = 0, collectAmtTotal08 = 0, collectAmtTotal09 = 0, collectAmtTotal10 = 0, collectAmtTotal11 = 0, collectAmtTotal12 = 0,
	         collectAmtTotalQ01 = 0, collectAmtTotalQ02 = 0, collectAmtTotalQ03 = 0, collectAmtTotalQ04 = 0;
	     
	     function calculateSummary() {
	         var footerSummary;
	         var collectAmt = 0, 
	             collectAmt01 = 0, collectAmt02 = 0, collectAmt03 = 0, collectAmt04 = 0, collectAmt05 = 0, collectAmt06 = 0, 
	             collectAmt07 = 0, collectAmt08 = 0, collectAmt09 = 0, collectAmt10 = 0, collectAmt11 = 0, collectAmt12 = 0,
	             collectAmtQ01 = 0, collectAmtQ02 = 0, collectAmtQ03 = 0, collectAmtQ04 = 0;;
	         
	         if (dataCnt > 0) {
	             for (var i = 0; i < arrayData.length; i++) {
	                 var row = arrayData[i];
	                 collectAmt = parseFloat(row[2].replace(/,/gi, ""));
	                 collectAmt01 = parseFloat(row[3].replace(/,/gi, ""));
	                 collectAmt02 = parseFloat(row[4].replace(/,/gi, ""));
	                 collectAmt03 = parseFloat(row[5].replace(/,/gi, ""));
	                 collectAmtQ01 = parseFloat(row[6].replace(/,/gi, ""));
	                 
	                 collectAmt04 = parseFloat(row[7].replace(/,/gi, ""));
	                 collectAmt05 = parseFloat(row[8].replace(/,/gi, ""));
	                 collectAmt06 = parseFloat(row[9].replace(/,/gi, ""));
	                 collectAmtQ02 = parseFloat(row[10].replace(/,/gi, ""));
	                 
	                 collectAmt07 = parseFloat(row[11].replace(/,/gi, ""));
	                 collectAmt08 = parseFloat(row[12].replace(/,/gi, ""));
	                 collectAmt09 = parseFloat(row[13].replace(/,/gi, ""));
	                 collectAmtQ03 = parseFloat(row[14].replace(/,/gi, ""));
	                 
	                 collectAmt10 = parseFloat(row[15].replace(/,/gi, ""));
	                 collectAmt11 = parseFloat(row[16].replace(/,/gi, ""));
	                 collectAmt12 = parseFloat(row[17].replace(/,/gi, ""));
	                 collectAmtQ04 = parseFloat(row[18].replace(/,/gi, ""));
	                 
	                 if(!isNaN(collectAmt)) collectAmtTotal += collectAmt;
                     if(!isNaN(collectAmt01)) collectAmtTotal01 += collectAmt01;
                     if(!isNaN(collectAmt02)) collectAmtTotal02 += collectAmt02;
                     if(!isNaN(collectAmt03)) collectAmtTotal03 += collectAmt03;
                     if(!isNaN(collectAmtQ01)) collectAmtTotalQ01 += collectAmtQ01;
                     
                     if(!isNaN(collectAmt04)) collectAmtTotal04 += collectAmt04;
                     if(!isNaN(collectAmt05)) collectAmtTotal05 += collectAmt05;
                     if(!isNaN(collectAmt06)) collectAmtTotal06 += collectAmt06;
                     if(!isNaN(collectAmtQ02)) collectAmtTotalQ02 += collectAmtQ02;
                     
                     if(!isNaN(collectAmt07)) collectAmtTotal07 += collectAmt07;
                     if(!isNaN(collectAmt08)) collectAmtTotal08 += collectAmt08;
                     if(!isNaN(collectAmt09)) collectAmtTotal09 += collectAmt09;
                     if(!isNaN(collectAmtQ03)) collectAmtTotalQ03 += collectAmtQ03;
                     
                     if(!isNaN(collectAmt10)) collectAmtTotal10 += collectAmt10;
                     if(!isNaN(collectAmt11)) collectAmtTotal11 += collectAmt11;
                     if(!isNaN(collectAmt12)) collectAmtTotal12 += collectAmt12;
                     if(!isNaN(collectAmtQ04)) collectAmtTotalQ04 += collectAmtQ04;
	             }
	         }
	         
	         collectAmtTotal    =  emptyDefaultValue(collectAmtTotal   , '0');                
	         collectAmtTotal01  =  emptyDefaultValue(collectAmtTotal01 , '0'); 
	         collectAmtTotal02  =  emptyDefaultValue(collectAmtTotal02 , '0'); 
	         collectAmtTotal03  =  emptyDefaultValue(collectAmtTotal03 , '0'); 
	         collectAmtTotalQ01 =  emptyDefaultValue(collectAmtTotalQ01, '0');

	         collectAmtTotal04  =  emptyDefaultValue(collectAmtTotal04 , '0'); 
	         collectAmtTotal05  =  emptyDefaultValue(collectAmtTotal05 , '0'); 
	         collectAmtTotal06  =  emptyDefaultValue(collectAmtTotal06 , '0'); 
	         collectAmtTotalQ02 =  emptyDefaultValue(collectAmtTotalQ02, '0');

	         collectAmtTotal07  =  emptyDefaultValue(collectAmtTotal07 , '0'); 
	         collectAmtTotal08  =  emptyDefaultValue(collectAmtTotal08 , '0'); 
	         collectAmtTotal09  =  emptyDefaultValue(collectAmtTotal09 , '0'); 
	         collectAmtTotalQ03 =  emptyDefaultValue(collectAmtTotalQ03, '0');

	         collectAmtTotal10  =  emptyDefaultValue(collectAmtTotal10 , '0'); 
	         collectAmtTotal11  =  emptyDefaultValue(collectAmtTotal11 , '0'); 
	         collectAmtTotal12  =  emptyDefaultValue(collectAmtTotal12 , '0');
	         collectAmtTotalQ04 =  emptyDefaultValue(collectAmtTotalQ04, '0');
	         
	         footerSummary = ["",
                     "<div style=\"text-align: right;\"><b>Total($)</b></div>",
                     "<font color='#0000FF'><b><div id=\"collectAmtTotal\" style=\"text-align: right;\">$ " + addCommas(centRound(collectAmtTotal)) + "</div></b></font>",
                        "<font color='#0000FF'><div id=\"collectAmtTotal01\" style=\"text-align: right;\">" + centRound(collectAmtTotal01) + "</div></font>",
                        "<font color='#0000FF'><div id=\"collectAmtTotal02\" style=\"text-align: right;\">" + centRound(collectAmtTotal02) + "</div></font>",
                        "<font color='#0000FF'><div id=\"collectAmtTotal03\" style=\"text-align: right;\">" + centRound(collectAmtTotal03) + "</div></font>",
                        "<font color='#0000FF'><b><div id=\"collectAmtTotalQ01\" style=\"text-align: right;\">" + centRound(collectAmtTotalQ01) + "</div></b></font>",
                        
                        "<font color='#0000FF'><div id=\"collectAmtTotal04\" style=\"text-align: right;\">" + centRound(collectAmtTotal04) + "</div></font>",
                        "<font color='#0000FF'><div id=\"collectAmtTotal05\" style=\"text-align: right;\">" + centRound(collectAmtTotal05) + "</div></font>",
                        "<font color='#0000FF'><div id=\"collectAmtTotal06\" style=\"text-align: right;\">" + centRound(collectAmtTotal06) + "</div></font>",
                        "<font color='#0000FF'><b><div id=\"collectAmtTotalQ02\" style=\"text-align: right;\">" + centRound(collectAmtTotalQ02) + "</div></b></font>",
                        
                        "<font color='#0000FF'><div id=\"collectAmtTotal07\" style=\"text-align: right;\">" + centRound(collectAmtTotal07) + "</div></font>",
                        "<font color='#0000FF'><div id=\"collectAmtTotal08\" style=\"text-align: right;\">" + centRound(collectAmtTotal08) + "</div></font>",
                        "<font color='#0000FF'><div id=\"collectAmtTotal09\" style=\"text-align: right;\">" + centRound(collectAmtTotal09) + "</div></font>",
                        "<font color='#0000FF'><b><div id=\"collectAmtTotalQ03\" style=\"text-align: right;\">" + centRound(collectAmtTotalQ03) + "</div></b></font>",
                        
                        "<font color='#0000FF'><div id=\"collectAmtTotal10\" style=\"text-align: right;\">" + centRound(collectAmtTotal10) + "</div></font>",
                        "<font color='#0000FF'><div id=\"collectAmtTotal11\" style=\"text-align: right;\">" + centRound(collectAmtTotal11) + "</div></font>",
                        "<font color='#0000FF'><div id=\"collectAmtTotal12\" style=\"text-align: right;\">" + centRound(collectAmtTotal12) + "</div></font>",   
                        "<font color='#0000FF'><b><div id=\"collectAmtTotalQ04\" style=\"text-align: right;\">" + centRound(collectAmtTotalQ04) + "</div></b></font>"];   
	         
	         return footerSummary;
	     }
	     summaryData = calculateSummary();
	
	     var obj = {title: "<b>Booth Incomes</b> List", resizable: true, freezeCols: 3,numberCell: false,  editable: false, flexHeight:true, selectionModel: { type: 'row' },scrollModel: { horizontal: true }};
	     obj.width = "98%";
	     obj.height = "350";
	
	     obj.colModel = [
	                     {title:'<b>State</b>', width:80, dataType:"string",align: "left",
                             render: function (ui) {
                                 var rowData = ui.rowData;
                                   return '<b>' + rowData[0] + '</b>';
                           } 	                    	 
	                     },
	                     {title:'<b>Collector</b>', width:150, dataType:"string",align: "left",
                             render: function (ui) {
                                 var rowData = ui.rowData;
                                   return '<b>' + rowData[1] + '</b>';
                           } 	                    	 
	                     },
	                     {title:'<b>Total</b>', width:100, dataType:"integer",align: "right",
                             render: function (ui) {
                                 var rowData = ui.rowData;
                                   return '<font color="#FF0080"><b>' + rowData[2] + '</b></font>';
                           } 	                    	 
	                     },
	                     
	                     {title:'<b><div style=\"text-align: center;\">1/4 Quater</div></b>', colModel: [
		                     {title:'Jan', width:80, dataType:"integer",align: "right"},
		                     {title:'Feb', width:80, dataType:"integer",align: "right"},
		                     {title:'Mar', width:80, dataType:"integer",align: "right"},
		                     {title:'<b>Sum</b>', width:80, dataType:"integer",align: "right",
                                 render: function (ui) {
                                     var rowData = ui.rowData;
                                       return '<font color="#CC0000"><b>' + rowData[6] + '</b></font>';
                               }  		                    	 
		                     }]
	                     },
	                     
	                     {title:'<b><div style=\"text-align: center;\">2/4 Quater</div></b>', colModel: [
		                     {title:'Apr', width:80, dataType:"integer",align: "right"},
		                     {title:'May', width:80, dataType:"integer",align: "right"},
		                     {title:'Jun', width:80, dataType:"integer",align: "right"},
		                     {title:'<b>Sum</b>', width:80, dataType:"integer",align: "right",
                                 render: function (ui) {
                                     var rowData = ui.rowData;
                                       return '<font color="#CC0000"><b>' + rowData[10] + '</b></font>';
                               }		                    	 
		                     }]
	                     },
	                     
	                     {title:'<b><div style=\"text-align: center;\">3/4 Quater</div></b>', colModel: [
		                     {title:'Jul', width:80, dataType:"integer",align: "right"},
		                     {title:'Aug', width:80, dataType:"integer",align: "right"},
		                     {title:'Sep', width:80, dataType:"integer",align: "right"},
		                     {title:'<b>Sum</b>', width:80, dataType:"integer",align: "right",
                                 render: function (ui) {
                                     var rowData = ui.rowData;
                                       return '<font color="#CC0000"><b>' + rowData[14] + '</b></font>';
                               }		                    	 
		                     }]
	                     },
	                     {title:'<b><div style=\"text-align: center;\">4/4 Quater</div></b>', colModel: [
                             {title:'Oct', width:80, dataType:"integer",align: "right"},
                             {title:'Nov', width:80, dataType:"integer",align: "right"},
                             {title:'Dec', width:80, dataType:"integer",align: "right"},
                             {title:'<b>Sum</b>', width:80, dataType:"integer",align: "right",
                                 render: function (ui) {
                                     var rowData = ui.rowData;
                                       return '<font color="#CC0000"><b>' + rowData[18] + '</b></font>';
                               }                            	 
                             }] 	                                                                                                         
	                     }
                     ]; 
	     
	     obj.dataModel = {data:arrayData, sortIndx: 1, sortDir: "down", 
	             location: "local",
	             sorting: "local",
	             paging: "local",
	             dataType: "Array",
	             curPage: 1,
	             rPP: 10,
	             rPPOptions: [10, 20] };
	     
	     var $summary = "";
	     var $grid = "";
	     obj.render = function (evt, ui) {
	         $summary = $("<div class='pq-grid-summary'></div>").prependTo($(".pq-grid-bottom", this));
	     };
	     
	     obj.refresh = function (evt, ui) {
	        var data = [summaryData];
	        var obj = { data: data, $cont: $summary };
	        $grid.pqGrid("createTable", obj);
	     };   
	
	     var $grid = $("#grid_panel").pqGrid(obj);
	     //$("#grid_panel").pqGrid(obj);
 	    
	     setTotalValue('collectAmtTotal', '$ ' + collectAmtTotal);
         setTotalValue('collectAmtTotal01', '$ ' + collectAmtTotal01);
         setTotalValue('collectAmtTotal02', '$ ' + collectAmtTotal02);
         setTotalValue('collectAmtTotal03', '$ ' + collectAmtTotal03);
         setTotalValue('collectAmtTotal04', '$ ' + collectAmtTotal04);
         setTotalValue('collectAmtTotal05', '$ ' + collectAmtTotal05);
         setTotalValue('collectAmtTotal06', '$ ' + collectAmtTotal06);
         setTotalValue('collectAmtTotal07', '$ ' + collectAmtTotal07);
         setTotalValue('collectAmtTotal08', '$ ' + collectAmtTotal08);
         setTotalValue('collectAmtTotal09', '$ ' + collectAmtTotal09);
         setTotalValue('collectAmtTotal10', '$ ' + collectAmtTotal10);
         setTotalValue('collectAmtTotal11', '$ ' + collectAmtTotal11);
         setTotalValue('collectAmtTotal12', '$ ' + collectAmtTotal12);
         
         setTotalValue('collectAmtTotalQ01', '$ ' + collectAmtTotalQ01);
         setTotalValue('collectAmtTotalQ02', '$ ' + collectAmtTotalQ02);
         setTotalValue('collectAmtTotalQ03', '$ ' + collectAmtTotalQ03);
         setTotalValue('collectAmtTotalQ04', '$ ' + collectAmtTotalQ04); 
         
	}
    function setTotalValue(id, value){
        var id = '#' + id;
        $(id).text(value);
    }    
</script>

</head>
<body>
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Search -->
    <!-- ++++++++++++++++++++++++++++++++++++++++++ -->
    <div id="search">
        <table class="search_table" border="0"> 
            <tr>
                <td class="label">Collect Year </td> 
                <td><select name="collectYear" id="collectYear" style="width: 100px"><c:out value="${yearOptions}" escapeXml="false" /></select></td>
                <td class="label">Collector </td> 
                <td><select name="collectCollector" id="collectCollector" style="width: 150px" ><c:out value="${collectorOptions}" escapeXml="false" /></select></td>
                <td style="text-align: right;"><button class="search" onclick="search();">Find</button></td>
            </tr>
        </table>
    </div>
   <div class="grid_panel" id="grid_panel"></div>
   <br/><br/>
	    

</body>

</html>