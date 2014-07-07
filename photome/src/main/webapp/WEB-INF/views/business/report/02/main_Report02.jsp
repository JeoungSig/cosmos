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
    	search();
    }
</script> 
<script type="text/javascript">    
    function viewBoothInfo(groupId) {
        var url = '/photome/business/report/photome/02/GroupInfo.action?groupId=' + groupId;
        var windowName = 'business/report/photome/02/GroupInfo';
        var win = openPopupForm(url, windowName, '720', '560');
    } 
     
    function viewChart() {
         alert('Under development...');
    }     
 </script>   
<script type="text/javascript">
    function search() {
        var collectYear = $('#collectYear').val();
        
        $.ajax({
            url : "/photome/business/report/photome/02/ReportDataList.action",
            data : {
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
     

      // 테이블 데이터 설정
      if (dataCnt > 0) {
    	  
    	  arrayData = new Array();
          $.each(json, function(i, obj) {
              element = new Array();
               
               element[0] = obj.boothGroupDto.groupName;
               element[1] = obj.rateOfReturnTot;
               element[2] = obj.collectAmtTot;
               element[3] = obj.rentFeeAmtTot;
               element[4] = obj.refundAmtTot;

               element[5] = decode(obj.collectAmt01, '0.00','',obj.collectAmt01);
               element[6] = decode(obj.collectAmt02, '0.00','',obj.collectAmt02);
               element[7] = decode(obj.collectAmt03, '0.00','',obj.collectAmt03);
               element[8] = decode(obj.rateOfReturnQ1, '0.00','0',obj.rateOfReturnQ1);
               element[9] = decode(obj.collectAmtQ1, '0.00','0',obj.collectAmtQ1);
               element[10] = decode(obj.rentFeeAmtQ1, '0.00','0',obj.rentFeeAmtQ1);
               element[11] = decode(obj.refundAmtQ1, '0.00','0',obj.refundAmtQ1);
               
               element[12] = decode(obj.collectAmt04, '0.00','',obj.collectAmt04);
               element[13] = decode(obj.collectAmt05, '0.00','',obj.collectAmt05);
               element[14] = decode(obj.collectAmt06, '0.00','',obj.collectAmt06);
               element[15] = decode(obj.rateOfReturnQ2, '0.00','0',obj.rateOfReturnQ2);
               element[16] = decode(obj.collectAmtQ2, '0.00','0',obj.collectAmtQ2);
               element[17] = decode(obj.rentFeeAmtQ2, '0.00','0',obj.rentFeeAmtQ2);
               element[18] = decode(obj.refundAmtQ2, '0.00','0',obj.refundAmtQ2);
               
               element[19] = decode(obj.collectAmt07, '0.00','',obj.collectAmt07);
               element[20] = decode(obj.collectAmt08, '0.00','',obj.collectAmt08);
               element[21] = decode(obj.collectAmt09, '0.00','',obj.collectAmt09);
               element[22] = decode(obj.rateOfReturnQ3, '0.00','0',obj.rateOfReturnQ3);
               element[23] = decode(obj.collectAmtQ3, '0.00','0',obj.collectAmtQ3);
               element[24] = decode(obj.rentFeeAmtQ3, '0.00','0',obj.rentFeeAmtQ3);
               element[25] = decode(obj.refundAmtQ3, '0.00','0',obj.refundAmtQ3);

               element[26] = decode(obj.collectAmt10, '0.00','',obj.collectAmt10);
               element[27] = decode(obj.collectAmt11, '0.00','',obj.collectAmt11);
               element[28] = decode(obj.collectAmt12, '0.00','',obj.collectAmt12);
               element[29] = decode(obj.rateOfReturnQ4, '0.00','0',obj.rateOfReturnQ4);
               element[30] = decode(obj.collectAmtQ4, '0.00','0',obj.collectAmtQ4);
               element[31] = decode(obj.rentFeeAmtQ4, '0.00','0',obj.rentFeeAmtQ4);
               element[32] = decode(obj.refundAmtQ4, '0.00','0',obj.refundAmtQ4);
               
               arrayData[i] = element; 
               
          }); 
      } 
      
      var summaryData;
      var incomeTotal = 0, collectTotal = 0, rentTotal = 0,refundTotal = 0;
      function calculateSummary() {
          
          var footerSummary;
          var totIncome = 0, totCollect = 0,totRent = 0, totRefund = 0;
          if (dataCnt > 0) {
              for (var i = 0; i < arrayData.length; i++) {
                  var row = arrayData[i];
                  totIncome = parseFloat(row[1].replace(/,/gi, ""));
                  totCollect = parseFloat(row[2].replace(/,/gi, ""));
                  totRent = parseFloat(row[3].replace(/,/gi, ""));
                  totRefund = parseFloat(row[4].replace(/,/gi, ""));
                  
                  if(!isNaN(totIncome)) incomeTotal += totIncome;
                  if(!isNaN(totCollect)) collectTotal += totCollect;
                  if(!isNaN(totRent)) rentTotal += totRent;
                  if(!isNaN(totRefund)) refundTotal += totRefund;
              }
          }
          if(incomeTotal == null || incomeTotal == '' || isNaN(incomeTotal)) incomeTotal = '0';
          if(collectTotal == null || collectTotal == '' || isNaN(collectTotal)) collectTotal = '0';
          if(rentTotal == null || rentTotal == '' || isNaN(rentTotal)) collectTotal = '0';
          if(refundTotal == null || refundTotal == '' || isNaN(refundTotal)) refundTotal = '0';
          footerSummary = ["<b>Total</b>",
                           "<font color='#0000FF'><b><div id=\"incomeTotal\" style=\"text-align: right;\">$ " + addCommas(incomeTotal) + "</div></b></font>",
                           "<font color='#0000FF'><b><div id=\"collectTotal\" style=\"text-align: right;\">$ " + addCommas(collectTotal) + "</div></b></font>",
                           "<font color='#0000FF'><b><div id=\"rentTotal\" style=\"text-align: right;\">$ " + addCommas(rentTotal) + "</div></b></font>",
                           "<font color='#0000FF'><b><div id=\"refundTotal\" style=\"text-align: right;\">$ " + addCommas(refundTotal) + "</div></b></font>",
                           "",
                           "","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""];   
          
          incomeTotal = addCommas(incomeTotal);
          collectTotal = addCommas(collectTotal);
          rentTotal = addCommas(rentTotal);
          refundTotal = addCommas(refundTotal);
          
          return footerSummary;
      }
      summaryData = calculateSummary();
 
      var obj = {title: "<bGroup Incomes</b> List", resizable: true, freezeCols: 5,numberCell: false,  editable: false, flexHeight:true, selectionModel: { type: 'row' },scrollModel: { horizontal: true }};
      obj.width = "98%";
      obj.height = "350";
 
      obj.colModel = [
                      {title:'<b>Group</b>',dataIndx: 0, width:200, dataType:"string",align: "left", sortable:false},
                      {title:'<b><div style=\"text-align: center;\">Total ($)</div></b>', colModel: [
                                                                    {title:'<b>Income</b>',dataIndx: 1,width:80, dataType:"integer",align: "right",
                                                                        render: function (ui) {
                                                                            var rowData = ui.rowData;
                                                                              return '<font color="#FF0080"><b>' + rowData[1] + '</b></font>';
                                                                      }                                                                             
                                                                    },
                                                                    {title:"<b>Collect</b>",dataIndx: 2, width:80, dataType:"integer",align: "right",
                                                                        render: function (ui) {
                                                                            var rowData = ui.rowData;
                                                                              return '<font color="#CC0000"><b>' + rowData[2] + '</b></font>';
                                                                      }                                                                         
                                                                    },
                                                                    {title:"<b>RentFee</b>",dataIndx: 3, width:80, dataType:"integer",align: "right",
                                                                        render: function (ui) {
                                                                            var rowData = ui.rowData;
                                                                              return '<font color="#CC0000">' + rowData[3] + '</font>';
                                                                      }                                                                             
                                                                    }, 
                                                                    {title:"<b>Refund</b>",dataIndx: 4, width:80, dataType:"integer",align: "right",
                                                                        render: function (ui) {
                                                                            var rowData = ui.rowData;
                                                                              return '<font color="#CC0000">' + rowData[4] + '</font>';
                                                                      }                                                                             
                                                                    } ]},
                      {title:'<b><div style=\"text-align: center;\">1/4 Quater ($)</div></b>', colModel: [
                                                                    {title:"Jan",dataIndx: 5, width:60, dataType:"integer",align: "right"},
                                                                    {title:"Feb",dataIndx: 6, width:60, dataType:"integer",align: "right"},
                                                                    {title:"Mar",dataIndx: 7, width:60, dataType:"integer",align: "right"},
                                                                    {title:"<b>Income</b>",dataIndx: 8, width:80, dataType:"integer",align: "right",
                                                                        render: function (ui) {
                                                                            var rowData = ui.rowData;
                                                                              return '<font color="#0076EC"><b>' + rowData[8] + '</b></font>';
                                                                      }                                                                             
                                                                    },
                                                                    {title:"<b>Collect</b>",dataIndx: 9, width:60, dataType:"integer",align: "right",
                                                                        render: function (ui) {
                                                                            var rowData = ui.rowData;
                                                                              return '<font color="#0076EC">' + rowData[9] + '</font>';
                                                                      }                                                                         
                                                                    },
                                                                    {title:"<b>Rent</b>",dataIndx: 10, width:60, dataType:"integer",align: "right",
                                                                        render: function (ui) {
                                                                            var rowData = ui.rowData;
                                                                              return '<font color="#0076EC">' + rowData[10] + '</font>';
                                                                      }                                                                         
                                                                    },
                                                                    {title:"<b>Refund</b>",dataIndx: 11, width:60, dataType:"integer",align: "right",
                                                                        render: function (ui) {
                                                                            var rowData = ui.rowData;
                                                                              return '<font color="#0076EC">' + rowData[11] + '</font>';
                                                                      }                                                                         
                                                                    }
                                                                    ]},
                      {title:'<b><div style=\"text-align: center;\">2/4 Quater ($)</div></b>', colModel: [
                                                                    {title:"Apr",dataIndx: 12, width:60, dataType:"integer",align: "right"},
                                                                    {title:"May",dataIndx: 13, width:60, dataType:"integer",align: "right"},
                                                                    {title:"Jun",dataIndx: 14, width:60, dataType:"integer",align: "right"},
                                                                    {title:"<b>Income</b>",dataIndx: 15, width:80, dataType:"integer",align: "right",
                                                                        render: function (ui) {
                                                                            var rowData = ui.rowData;
                                                                              return '<font color="#0076EC"><b>' + rowData[15] + '</b></font>';
                                                                      }                                                                             
                                                                    },
                                                                    {title:"<b>Collect</b>",dataIndx: 16, width:60, dataType:"integer",align: "right",
                                                                        render: function (ui) {
                                                                            var rowData = ui.rowData;
                                                                              return '<font color="#0076EC">' + rowData[16] + '</font>';
                                                                      }                                                                         
                                                                    },
                                                                    {title:"<b>Rent</b>",dataIndx: 17, width:60, dataType:"integer",align: "right",
                                                                        render: function (ui) {
                                                                            var rowData = ui.rowData;
                                                                              return '<font color="#0076EC">' + rowData[17] + '</font>';
                                                                      }                                                                         
                                                                    },
                                                                    {title:"<b>Refund</b>",dataIndx: 18, width:60, dataType:"integer",align: "right",
                                                                        render: function (ui) {
                                                                            var rowData = ui.rowData;
                                                                              return '<font color="#0076EC">' + rowData[18] + '</font>';
                                                                      }                                                                         
                                                                    }
                                                                    ]},
                      {title:'<b><div style=\"text-align: center;\">3/4 Quater ($)</div></b>', colModel: [
                                                                    {title:"Jul",dataIndx: 19, width:60, dataType:"integer",align: "right"},
                                                                    {title:"Aug",dataIndx: 20, width:60, dataType:"integer",align: "right"},
                                                                    {title:"Sep",dataIndx: 21, width:60, dataType:"integer",align: "right"},
                                                                    {title:"<b>Income</b>",dataIndx: 22, width:80, dataType:"integer",align: "right",
                                                                        render: function (ui) {
                                                                            var rowData = ui.rowData;
                                                                              return '<font color="#0076EC"><b>' + rowData[22] + '</b></font>';
                                                                      }                                                                             
                                                                    },
                                                                    {title:"<b>Collect</b>",dataIndx: 23, width:60, dataType:"integer",align: "right",
                                                                        render: function (ui) {
                                                                            var rowData = ui.rowData;
                                                                              return '<font color="#0076EC">' + rowData[23] + '</font>';
                                                                      }                                                                             
                                                                        },
                                                                    {title:"<b>Rent</b>",dataIndx: 24, width:60, dataType:"integer",align: "right",
                                                                            render: function (ui) {
                                                                                var rowData = ui.rowData;
                                                                                  return '<font color="#0076EC">' + rowData[24] + '</font>';
                                                                          }                                                                                 
                                                                            },
                                                                    {title:"<b>Refund</b>",dataIndx: 25, width:60, dataType:"integer",align: "right",
                                                                                render: function (ui) {
                                                                                    var rowData = ui.rowData;
                                                                                      return '<font color="#0076EC">' + rowData[26] + '</font>';
                                                                              }                                                                                     
                                                                    }
                                                                    ]},
                      {title:'<b><div style=\"text-align: center;\">4/4 Quater ($)</div></b>', colModel: [
                                                                    {title:"Oct",dataIndx: 26, width:60, dataType:"integer",align: "right"},
                                                                    {title:"Nov",dataIndx: 27, width:60, dataType:"integer",align: "right"},
                                                                    {title:"Dev",dataIndx: 28, width:60, dataType:"integer",align: "right"},
                                                                    {title:"<b>Income</b>",dataIndx: 29, width:80, dataType:"integer",align: "right",
                                                                        render: function (ui) {
                                                                            var rowData = ui.rowData;
                                                                              return '<font color="#0076EC"><b>' + rowData[29] + '</b></font>';
                                                                      }                                                                                     
                                                                        },
                                                                    {title:"<b>Collect</b>",dataIndx: 30, width:60, dataType:"integer",align: "right",
                                                                            render: function (ui) {
                                                                                var rowData = ui.rowData;
                                                                                  return '<font color="#0076EC">' + rowData[30] + '</font>';
                                                                          }                                                                                     
                                                                        },
                                                                    {title:"<b>Rent</b>",dataIndx: 31, width:60, dataType:"integer",align: "right",
                                                                            render: function (ui) {
                                                                                var rowData = ui.rowData;
                                                                                  return '<font color="#0076EC">' + rowData[31] + '</font>';
                                                                          }                                                                                     
                                                                        },
                                                                    {title:"<b>Refund</b>",dataIndx: 32, width:60, dataType:"integer",align: "right",
                                                                            render: function (ui) {
                                                                                var rowData = ui.rowData;
                                                                                  return '<font color="#0076EC">' + rowData[32] + '</font>';
                                                                          }                                                                                     
                                                                        }
                                                                    ]}
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
     
      setTotalValue('incomeTotal', '$ ' + incomeTotal);
      setTotalValue('collectTotal', '$ ' + collectTotal);
      setTotalValue('rentTotal', '$ ' + rentTotal);
      setTotalValue('refundTotal', '$ ' + refundTotal);      
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
                <td style="text-align: right;"><button class="search" onclick="search();">Find</button></td>
            </tr>
        </table>
    </div>
    <div class="grid_panel" id="grid_panel"></div>
   <br/><br/>    




</body>
</html>