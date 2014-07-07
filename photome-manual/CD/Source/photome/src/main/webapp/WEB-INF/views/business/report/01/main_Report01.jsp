<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!-- 
Photo Me Report 01.
Photo Me Report 01.
Photo Me Report 01.
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
    	//search();
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
    function viewBoothInfo(boothId) {
        var url = '/photome/business/report/photome/01/BoothInfo.action?boothId=' + boothId;
        var windowName = 'business/resmanage/booth/BoothInfo';
        var win = openPopupForm(url, windowName, '780', '560');
        win.focus();
    } 
     
    function viewChart() {
         alert('Under development...');
    }     
 </script>   
<script type="text/javascript">
    function search() {
    	var groupId         = $('#groupId').val();
        var collectYear = $('#collectYear').val();
        if(groupId == '' || groupId == null){
        	//groupId = $("#groupId option:eq(1)").val();
        	//$("#groupId option:eq(1)").attr("selected", "selected");
        	alert('You have to select a group');
        	$('#groupId').focus();
        	return;
        }
        
        if(groupId == '' || groupId == null){
        	groupId = '0000'
        }
        
        $.ajax({
            url : "/photome/business/report/photome/01/ReportDataList.action",
            data : {
                groupId         : groupId,
                collectYear   : collectYear
            },
            success : callbackSearch,
        });
        
        pageLog('data retirive complete','info');
    }

	function callbackSearch(data) {
		 
	     var json = data.list;
	     var dataCnt = json.length;
	     
	     var contractUnit = data.contractUnit;
	     var groupRentFeeAmtTot = data.groupRentFeeAmtTot;
	
	     var arrayData = null;
	     var element = null;
	     
	     if (dataCnt > 0) {
	         
	         arrayData = new Array();
	         $.each(json, function(i, obj) {
	        	 element = new Array();
	             element[0] = obj.boothDto.boothName;
	             element[1] = obj.rateOfReturnTot;
	             element[2] = decode(obj.rateOfExpenseTot,'0') + '%';
	             element[3] = obj.collectAmtTot;
	             if(contractUnit == 'GROUP'){
	                 element[4] = '0';
	             } else {
	                 element[4] = obj.rentFeeAmtTot;
	             }
	             element[5] = obj.refundAmtTot;
	             element[6] = decode(obj.collectAmt01, '0.00','',obj.collectAmt01);
	             element[7] = decode(obj.collectAmt02, '0.00','',obj.collectAmt02);
	             element[8] = decode(obj.collectAmt03, '0.00','',obj.collectAmt03);
	             element[9] = decode(obj.rateOfReturnQ1, '0.0','0',obj.rateOfReturnQ1);
	             element[10] = decode(obj.rateOfExpenseQ1, '0.0','0',null,'0',obj.rateOfExpenseQ1) + '%';
	             element[11] = decode(obj.collectAmtQ1, '0.0','0',obj.collectAmtQ1);
	             element[12] = decode(obj.rentFeeAmtQ1, '0.0','0',obj.rentFeeAmtQ1);
	             element[13] = decode(obj.refundAmtQ1, '0.0','0',obj.refundAmtQ1);
	             
	             element[14] = decode(obj.collectAmt04, '0.00','',obj.collectAmt04);
	             element[15] = decode(obj.collectAmt05, '0.00','',obj.collectAmt05);
	             element[16] = decode(obj.collectAmt06, '0.00','',obj.collectAmt06);
                 element[17] = decode(obj.rateOfReturnQ2, '0.0','0',obj.rateOfReturnQ2);
                 element[18] = decode(obj.rateOfExpenseQ2, '0.0','0',null,'0',obj.rateOfExpenseQ2) + '%';
                 element[19] = decode(obj.collectAmtQ2, '0.0','0',obj.collectAmtQ2);
                 element[20] = decode(obj.rentFeeAmtQ2, '0.0','0',obj.rentFeeAmtQ2);
                 element[21] = decode(obj.refundAmtQ2, '0.0','0',obj.refundAmtQ2);
	             
	             element[22] = decode(obj.collectAmt07, '0.00','',obj.collectAmt07);
	             element[23] = decode(obj.collectAmt08, '0.00','',obj.collectAmt08);
	             element[24] = decode(obj.collectAmt09, '0.00','',obj.collectAmt09);
                 element[25] = decode(obj.rateOfReturnQ3, '0.0','0',obj.rateOfReturnQ3);
                 element[26] = decode(obj.rateOfExpenseQ3, '0.0','0',null,'0',obj.rateOfExpenseQ3) + '%';
                 element[27] = decode(obj.collectAmtQ3, '0.0','0',obj.collectAmtQ3);
                 element[28] = decode(obj.rentFeeAmtQ3, '0.0','0',obj.rentFeeAmtQ3);
                 element[29] = decode(obj.refundAmtQ3, '0.0','0',obj.refundAmtQ3);
	             
	             element[30] = decode(obj.collectAmt10, '0.00','',obj.collectAmt10);
	             element[31] = decode(obj.collectAmt11, '0.00','',obj.collectAmt11);
	             element[32] = decode(obj.collectAmt12, '0.00','',obj.collectAmt12);
                 element[33] = decode(obj.rateOfReturnQ4, '0.0','0',obj.rateOfReturnQ4);
                 element[34] = decode(obj.rateOfExpenseQ4, '0.0','0',null,'0',obj.rateOfExpenseQ4) + '%';
                 element[35] = decode(obj.collectAmtQ4, '0.0','0',obj.collectAmtQ4);
                 element[36] = decode(obj.rentFeeAmtQ4, '0.0','0',obj.rentFeeAmtQ4);
                 element[37] = decode(obj.refundAmtQ4, '0.0','0',obj.refundAmtQ4);
                 element[38] = obj.boothDto.boothId;
	             
	             arrayData[i] = element; 
	         });
	     }
	     
	     var summaryData;
	     var incomeTotal = 0, collectTotal = 0, rentTotal = 0, refundTotal = 0;
	     function calculateSummary() {
	         
	         var footerSummary;
	         var totIncome = 0, totCollect = 0,totRent = 0, totRefund = 0;
	         if (dataCnt > 0) {
	             for (var i = 0; i < arrayData.length; i++) {
	                 var row = arrayData[i];
	                 totIncome = parseFloat(row[1].replace(/,/gi, ""));
	                 totCollect = parseFloat(row[3].replace(/,/gi, ""));
	                 totRent = parseFloat(row[4].replace(/,/gi, ""));
	                 totRefund = parseFloat(row[5].replace(/,/gi, ""));
	                 
	                 if(!isNaN(totIncome)) incomeTotal += totIncome;
	                 if(!isNaN(totCollect)) collectTotal += totCollect;
	                 if(!isNaN(totRent)) rentTotal += totRent;
	                 if(!isNaN(totRefund)) refundTotal += totRefund;
	             }
	         }
	         
	         incomeTotal  =  emptyDefaultValue(incomeTotal  , '0');
	         collectTotal =  emptyDefaultValue(collectTotal , '0');
	         rentTotal    =  emptyDefaultValue(rentTotal    , '0');
	         refundTotal  =  emptyDefaultValue(refundTotal  , '0');
	         
	         footerSummary = ["<b>Total</b>",
	                          "<font color='#0000FF'><b><div id=\"incomeTotal\" style=\"text-align: right;\">$ " + addCommas(centRound(incomeTotal)) + "</div></b></font>",
	                          "",
	                          "<font color='#0000FF'><b><div id=\"collectTotal\" style=\"text-align: right;\">$ " + addCommas(centRound(collectTotal)) + "</div></b></font>",
	                          "<font color='#0000FF'><b><div id=\"rentTotal\" style=\"text-align: right;\">$ " + addCommas(centRound(rentTotal)) + "</div></b></font>",
	                          "<font color='#0000FF'><b><div id=\"refundTotal\" style=\"text-align: right;\">$ " + addCommas(centRound(refundTotal)) + "</div></b></font>",
	                          "","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""];   
	         
	         return footerSummary;
	     }
	     summaryData = calculateSummary();
	
	     var obj = {title: "<b>Booth Incomes</b> List", resizable: true, freezeCols: 6,numberCell: false,  editable: false, flexHeight:true, selectionModel: { type: 'row' },scrollModel: { horizontal: true }};
	     obj.width = "98%";
	     obj.height = "350";
	
	     obj.colModel = [
	                     {title:'<b>Booth</b>',dataIndx: 0, width:200, dataType:"string",align: "left",
                             render: function (ui) {
                                 var rowData = ui.rowData;
                                   return '<a style=\"text-decoration:none;\" href=\"javascript:viewBoothInfo(\''+ rowData[38] + '\')\"><b>' +  rowData[0] + '</b></a>';
                           }
	                      },
	                     {title:'<b><div style=\"text-align: center;\">Total ($)</div></b>', colModel: [
	                                                                   {title:'<b>Income</b>',dataIndx: 1,width:90, dataType:"integer",align: "right",
	                                                                       render: function (ui) {
	                                                                           var rowData = ui.rowData;
	                                                                             return '<font color="#FF0080"><b>' + rowData[1] + '</b></font>';
	                                                                     }     	                                                                	   
	                                                                   },
	                                                                   {title:'<b>Cost %</b>',dataIndx: 2,width:80, dataType:"integer",align: "right",
	                                                                       render: function (ui) {
	                                                                           var rowData = ui.rowData;
	                                                                             return '<font color="#FF0080">' + rowData[2] + '</font>';
	                                                                     }     	                                                                	   
	                                                                   },
	                                                                   {title:"<b>Collect</b>",dataIndx: 3, width:90, dataType:"integer",align: "right",
                                                                           render: function (ui) {
                                                                               var rowData = ui.rowData;
                                                                                 return '<font color="#CC0000"><b>' + rowData[3] + '</b></font>';
                                                                         }	                                                                	   
	                                                                   },
	                                                                   {title:"<b>RentFee</b>",dataIndx: 4, width:90, dataType:"integer",align: "right",
                                                                           render: function (ui) {
                                                                               var rowData = ui.rowData;
                                                                                 return '<font color="#CC0000">' + rowData[4] + '</font>';
                                                                         }     	                                                                	   
	                                                                   }, 
	                                                                   {title:"<b>Refund</b>",dataIndx: 5, width:80, dataType:"integer",align: "right",
                                                                           render: function (ui) {
                                                                               var rowData = ui.rowData;
                                                                                 return '<font color="#CC0000">' + rowData[5] + '</font>';
                                                                         }                                                                             
	                                                                   } ]},
	                     {title:'<b><div style=\"text-align: center;\">1/4 Quater</div></b>', colModel: [
	                                                                   {title:"Jan",dataIndx: 6, width:60, dataType:"integer",align: "right"},
													                   {title:"Feb",dataIndx: 7, width:60, dataType:"integer",align: "right"},
													                   {title:"Mar",dataIndx: 8, width:60, dataType:"integer",align: "right"},
													                   {title:"<b>Income</b>",dataIndx: 9, width:80, dataType:"integer",align: "right",
                                                                           render: function (ui) {
                                                                               var rowData = ui.rowData;
                                                                                 return '<font color="#0076EC"><b>' + rowData[9] + '</b></font>';
                                                                         }    													                	   
													                   },
													                   {title:"<b>Cost %</b>",dataIndx: 10, width:80, dataType:"integer",align: "right",
                                                                           render: function (ui) {
                                                                               var rowData = ui.rowData;
                                                                                 return '<font color="#0076EC">' + rowData[10] + '</font>';
                                                                         }    													                	   
													                   },
													                   {title:"<b>Collect</b>",dataIndx: 11, width:60, dataType:"integer",align: "right",
                                                                           render: function (ui) {
                                                                               var rowData = ui.rowData;
                                                                                 return '<font color="#0076EC">' + rowData[11] + '</font>';
                                                                         } 													                	   
													                   },
													                   {title:"<b>Rent</b>",dataIndx: 12, width:60, dataType:"integer",align: "right",
                                                                           render: function (ui) {
                                                                               var rowData = ui.rowData;
                                                                                 return '<font color="#0076EC">' + rowData[12] + '</font>';
                                                                         } 													                	   
													                   },
													                   {title:"<b>Refund</b>",dataIndx: 13, width:60, dataType:"integer",align: "right",
                                                                           render: function (ui) {
                                                                               var rowData = ui.rowData;
                                                                                 return '<font color="#0076EC">' + rowData[13] + '</font>';
                                                                         } 													                	   
													                   }
													                   ]},
	                     {title:'<b><div style=\"text-align: center;\">2/4 Quater</div></b>', colModel: [
	                                                                   {title:"Apr",dataIndx: 14, width:60, dataType:"integer",align: "right"},
													                   {title:"May",dataIndx: 15, width:60, dataType:"integer",align: "right"},
													                   {title:"Jun",dataIndx: 16, width:60, dataType:"integer",align: "right"},
													                   {title:"<b>Income</b>",dataIndx: 17, width:80, dataType:"integer",align: "right",
                                                                           render: function (ui) {
                                                                               var rowData = ui.rowData;
                                                                                 return '<font color="#0076EC"><b>' + rowData[17] + '</b></font>';
                                                                         }  													                	   
													                   },
													                   {title:"<b>Cost %</b>",dataIndx: 18, width:80, dataType:"integer",align: "right",
                                                                           render: function (ui) {
                                                                               var rowData = ui.rowData;
                                                                                 return '<font color="#0076EC">' + rowData[18] + '</font>';
                                                                         }  													                	   
													                   },
													                   {title:"<b>Collect</b>",dataIndx: 19, width:60, dataType:"integer",align: "right",
                                                                           render: function (ui) {
                                                                               var rowData = ui.rowData;
                                                                                 return '<font color="#0076EC">' + rowData[19] + '</font>';
                                                                         }													                	   
													                   },
													                   {title:"<b>Rent</b>",dataIndx: 20, width:60, dataType:"integer",align: "right",
                                                                           render: function (ui) {
                                                                               var rowData = ui.rowData;
                                                                                 return '<font color="#0076EC">' + rowData[20] + '</font>';
                                                                         }													                	   
													                   },
													                   {title:"<b>Refund</b>",dataIndx: 21, width:60, dataType:"integer",align: "right",
                                                                           render: function (ui) {
                                                                               var rowData = ui.rowData;
                                                                                 return '<font color="#0076EC">' + rowData[21] + '</font>';
                                                                         }													                	   
													                   }
													                   ]},
	                     {title:'<b><div style=\"text-align: center;\">3/4 Quater</div></b>', colModel: [
	                                                                   {title:"Jul",dataIndx: 22, width:60, dataType:"integer",align: "right"},
													                   {title:"Aug",dataIndx: 23, width:60, dataType:"integer",align: "right"},
													                   {title:"Sep",dataIndx: 24, width:60, dataType:"integer",align: "right"},
													                   {title:"<b>Income</b>",dataIndx: 25, width:80, dataType:"integer",align: "right",
                                                                           render: function (ui) {
                                                                               var rowData = ui.rowData;
                                                                                 return '<font color="#0076EC"><b>' + rowData[25] + '</b></font>';
                                                                         }  													                	   
													                   },
													                   {title:"<b>Cost %</b>",dataIndx: 26, width:80, dataType:"integer",align: "right",
                                                                           render: function (ui) {
                                                                               var rowData = ui.rowData;
                                                                                 return '<font color="#0076EC">' + rowData[26] + '</font>';
                                                                         }  													                	   
													                   },
													                   {title:"<b>Collect</b>",dataIndx: 27, width:60, dataType:"integer",align: "right",
                                                                           render: function (ui) {
                                                                               var rowData = ui.rowData;
                                                                                 return '<font color="#0076EC">' + rowData[27] + '</font>';
                                                                         }  													                	   
													                	   },
													                   {title:"<b>Rent</b>",dataIndx: 28, width:60, dataType:"integer",align: "right",
	                                                                           render: function (ui) {
	                                                                               var rowData = ui.rowData;
	                                                                                 return '<font color="#0076EC">' + rowData[28] + '</font>';
	                                                                         }  													                		   
													                		   },
													                   {title:"<b>Refund</b>",dataIndx: 29, width:60, dataType:"integer",align: "right",
		                                                                           render: function (ui) {
		                                                                               var rowData = ui.rowData;
		                                                                                 return '<font color="#0076EC">' + rowData[29] + '</font>';
		                                                                         }  													                			   
													                   }
													                   ]},
	                     {title:'<b><div style=\"text-align: center;\">4/4 Quater</div></b>', colModel: [
	                                                                   {title:"Oct",dataIndx: 30, width:60, dataType:"integer",align: "right"},
													                   {title:"Nov",dataIndx: 31, width:60, dataType:"integer",align: "right"},
													                   {title:"Dev",dataIndx: 32, width:60, dataType:"integer",align: "right"},
													                   {title:"<b>Income</b>",dataIndx: 33, width:80, dataType:"integer",align: "right",
                                                                           render: function (ui) {
                                                                               var rowData = ui.rowData;
                                                                                 return '<font color="#0076EC"><b>' + rowData[33] + '</b></font>';
                                                                         }                                                                                     
													                	   },
													                   {title:"<b>Cost %</b>",dataIndx: 34, width:80, dataType:"integer",align: "right",
                                                                           render: function (ui) {
                                                                               var rowData = ui.rowData;
                                                                                 return '<font color="#0076EC">' + rowData[34] + '</font>';
                                                                         }                                                                                     
													                	   },
													                   {title:"<b>Collect</b>",dataIndx: 35, width:60, dataType:"integer",align: "right",
                                                                               render: function (ui) {
                                                                                   var rowData = ui.rowData;
                                                                                     return '<font color="#0076EC">' + rowData[35] + '</font>';
                                                                             }                                                                                     
													                	   },
													                   {title:"<b>Rent</b>",dataIndx: 36, width:60, dataType:"integer",align: "right",
                                                                               render: function (ui) {
                                                                                   var rowData = ui.rowData;
                                                                                     return '<font color="#0076EC">' + rowData[36] + '</font>';
                                                                             }                                                                                     
													                	   },
													                   {title:"<b>Refund</b>",dataIndx: 37, width:60, dataType:"integer",align: "right",
                                                                               render: function (ui) {
                                                                                   var rowData = ui.rowData;
                                                                                     return '<font color="#0076EC">' + rowData[37] + '</font>';
                                                                             }                                                                                     
													                	   }
													                   ]},
													                   {title:'Hidden1(boothId)', hidden:true}
	     ]; 
	     
	     obj.dataModel = {data:arrayData, sortIndx: 1, sortDir: "down", 
	             location: "local",
	             sorting: "local",
	             paging: "local",
	             dataType: "Array",
	             curPage: 1,
	             rPP: 15,
	             rPPOptions: [10, 20, 30, 50] };
	     
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
	    
	     setTotalValue('incomeTotal', '$ ' + addCommas(centRound(incomeTotal)));
	     setTotalValue('collectTotal', '$ ' + addCommas(centRound(collectTotal)));
	     setTotalValue('rentTotal', '$ ' + addCommas(centRound(rentTotal)));
	     setTotalValue('refundTotal', '$ ' + addCommas(centRound(refundTotal)));
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
                <td class="label"><span class="required">*</span>Group </td> 
                <td><select name="groupId" id="groupId" style="width: 150px" ><c:out value="${groupOptions}" escapeXml="false" /></select></td>
                <td class="label">Collect Year </td> 
                <td><select name="collectYear" id="collectYear" style="width: 100px"><c:out value="${yearOptions}" escapeXml="false" /></select></td>
                <td style="text-align: right;"><button class="search" onclick="search();">Find</button></td>
            </tr>
        </table>
    </div>
   <div class="grid_panel" id="grid_panel"></div>
   <br/><br/>
	    

</body>

</html>