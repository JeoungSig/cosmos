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
     var table_template = '<table id="table_data" class="dataTable">'
         + '<thead>'
         + '    <tr>'
         + '        <th>-</th>'
         + '        <th colspan="4">Total</th>'
         + '        <th colspan="7">1/4 Quater</th>'
         + '        <th colspan="7">2/4 Quater</th>'
         + '        <th colspan="7">3/4 Quater</th>'
         + '        <th colspan="7">4/4 Quater</th>'
         + '        <th rowspan="2">hidden1</th>'
         + '        <th rowspan="2">hidden2</th>'
         + '        <th rowspan="2">hidden3</th>'
         + '        <th rowspan="2">hidden4</th>'
         + '    </tr>'
         + '    <tr>'
         + '        <th>Group Name</th>'
         + '        <th style="background-color:  #727238;">Income</th>'
         + '        <th style="background-color:  #727238;">Collect</th>'
         + '        <th style="background-color:  #727238;">Rent fee</th>'
         + '        <th style="background-color:  #727238;">Refund</th>'
         + '        <th>Jan</th>'
         + '        <th>Feb</th>'
         + '        <th>Mar</th>'
         + '        <th style="background-color:  #5F5F5F;">Q1 Income</th>'
         + '        <th style="background-color:  #5F5F5F;">Q1 Collect</th>'
         + '        <th style="background-color:  #5F5F5F;">Q1 Rent</th>'
         + '        <th style="background-color:  #5F5F5F;">Q1 Refund</th>'
         + '        <th>Apr</th>'
         + '        <th>May</th>'
         + '        <th>Jun</th>'
         + '        <th style="background-color:  #5F5F5F;">Q2 Income</th>'
         + '        <th style="background-color:  #5F5F5F;">Q2 Collect</th>'
         + '        <th style="background-color:  #5F5F5F;">Q2 Rent</th>'
         + '        <th style="background-color:  #5F5F5F;">Q2 Refund</th>'
         + '        <th>Jul</th>'
         + '        <th>Aug</th>'
         + '        <th>Sep</th>'
         + '        <th style="background-color:  #5F5F5F;">Q3 Income</th>'
         + '        <th style="background-color:  #5F5F5F;">Q3 Collect</th>'
         + '        <th style="background-color:  #5F5F5F;">Q3 Rent</th>'
         + '        <th style="background-color:  #5F5F5F;">Q3 Refund</th>'
         + '        <th>Oct</th>'
         + '        <th>Nov</th>'
         + '        <th>Dec</th>'
         + '        <th style="background-color:  #5F5F5F;">Q4 Income</th>'
         + '        <th style="background-color:  #5F5F5F;">Q4 Collect</th>'
         + '        <th style="background-color:  #5F5F5F;">Q4 Rent</th>'
         + '        <th style="background-color:  #5F5F5F;">Q4 Refund</th>'
         + '    </tr>'         
         + '</thead>'
         + '<tfoot>'
         + '    <tr>'
         + '        <th>Total : </th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '        <th></th>'
         + '    </tr>'
         + '</tfoot>'
         + '</table>';
         
         
     $('#grid_array').html(table_template);
     
      var list = data.list;
      var dataCnt = list.length;
      
      // 테이블의 타이틀 설정
      var colM = [ { "sWidth": "120px" },
                   { title: "Tot. %"       ,dataType: "string", "sWidth": "90px" },
                   { title: "Tot.Collect"  ,dataType: "string", "sWidth": "90px" },
                   { title: "Tot.Rent"     ,dataType: "string", "sWidth": "90px" },
                   { title: "Tot.Refund"   ,dataType: "string", "sWidth": "90px" },
                   { title: "Jan"          ,dataType: "string" },
                   { title: "Feb"          ,dataType: "string" },
                   { title: "Mar"          ,dataType: "string" },
                   { title: "Q1 %"         ,dataType: "string" },
                   { title: "Q1 Collect"   ,dataType: "string" },
                   { title: "Q1 Rent"      ,dataType: "string" },
                   { title: "Q1 Refund"    ,dataType: "string" },
                   { title: "Apr"          ,dataType: "string" },
                   { title: "May"          ,dataType: "string" },
                   { title: "Jun"          ,dataType: "string" },
                   { title: "Q2 %"         ,dataType: "string" },
                   { title: "Q2 Collect"   ,dataType: "string" },
                   { title: "Q2 Rent"      ,dataType: "string" },
                   { title: "Q2 Refund"    ,dataType: "string" },
                   { title: "Jul"          ,dataType: "string" },
                   { title: "Aug"          ,dataType: "string" },
                   { title: "Sep"          ,dataType: "string" },
                   { title: "Q3 %"         ,dataType: "string" },
                   { title: "Q3 Collect"   ,dataType: "string" },
                   { title: "Q3 Rent"      ,dataType: "string" },
                   { title: "Q3 Refund"    ,dataType: "string" },
                   { title: "Oct"          ,dataType: "string" },
                   { title: "Nov"          ,dataType: "string" },
                   { title: "Dec"          ,dataType: "string" },
                   { title: "Q4 %"         ,dataType: "string" },
                   { title: "Q4 Collect"   ,dataType: "string" },
                   { title: "Q4 Rent"      ,dataType: "string" },
                   { title: "Q4 Refund"    ,dataType: "string" },
                   { title: "hidden1"    ,dataType: "string" },   
                   { title: "hidden2"    ,dataType: "string" },   
                   { title: "hidden3"    ,dataType: "string" },   
                   { title: "hidden4"    ,dataType: "string" }
                ];
      
      // 테이블 데이터 설정
      if (dataCnt > 0) {
          var data = new Array();
          var element = null;
          
          $.each(list, function(i, obj) {
               element = new Array();
               element[0] = ('<a href=\"javascript:viewBoothInfo(\''+ obj.boothGroupDto.groupId + '\')\">' + obj.boothGroupDto.groupName + '</a>');
               element[1] = ('<font style="color: #FF0080;font-weight: bold;" > ' + toCurrency(obj.rateOfReturnTot) + '</font>');
               element[2] = ('<font style="color: #FF0080;" > ' + toCurrency(obj.collectAmtTot) + '</font>');
               element[3] = ('<font style="color: #FF0080;" > ' + toCurrency(obj.rentFeeAmtTot) + '</font>');
               element[4] = ('<font style="color: #FF0080;" > ' + toCurrency(obj.refundAmtTot) + '</font>');

               element[5] = decode(obj.collectAmt01, '0.00','-',obj.collectAmt01);
               element[6] = decode(obj.collectAmt02, '0.00','-',obj.collectAmt02);
               element[7] = decode(obj.collectAmt03, '0.00','-',obj.collectAmt03);
               element[8] = ('<font style="color: #7100E1;font-weight: bold;" > ' + toCurrency(obj.rateOfReturnQ1) + '</font>');
               element[9] = ('<font style="color: #7100E1;" > ' + toCurrency(obj.collectAmtQ1) + '</font>');
               element[10] = ('<font style="color: #7100E1;" > ' + toCurrency(obj.rentFeeAmtQ1) + '</font>');
               element[11] = ('<font style="color: #7100E1;" > ' + toCurrency(obj.refundAmtQ1) + '</font>');
               
               element[12] = decode(obj.collectAmt04, '0.00','-',obj.collectAmt04);
               element[13] = decode(obj.collectAmt05, '0.00','-',obj.collectAmt05);
               element[14] = decode(obj.collectAmt06, '0.00','-',obj.collectAmt06);
               element[15] = ('<font style="color: #7100E1;font-weight: bold;" > ' + toCurrency(obj.rateOfReturnQ2) + '</font>');
               element[16] = ('<font style="color: #7100E1;" > ' + toCurrency(obj.collectAmtQ2) + '</font>');
               element[17] = ('<font style="color: #7100E1;" > ' + toCurrency(obj.rentFeeAmtQ2) + '</font>');
               element[18] = ('<font style="color: #7100E1;" > ' + toCurrency(obj.refundAmtQ2) + '</font>');
               
               element[19] = decode(obj.collectAmt07, '0.00','-',obj.collectAmt07);
               element[20] = decode(obj.collectAmt08, '0.00','-',obj.collectAmt08);
               element[21] = decode(obj.collectAmt09, '0.00','-',obj.collectAmt09);
               element[22] = ('<font style="color: #7100E1;font-weight: bold;" > ' + toCurrency(obj.rateOfReturnQ3) + '</font>');
               element[23] = ('<font style="color: #7100E1;" > ' + toCurrency(obj.collectAmtQ3) + '</font>');
               element[24] = ('<font style="color: #7100E1;" > ' + toCurrency(obj.rentFeeAmtQ3) + '</font>');
               element[25] = ('<font style="color: #7100E1;" > ' + toCurrency(obj.refundAmtQ3) + '</font>');
               
               element[26] = decode(obj.collectAmt10, '0.00','-',obj.collectAmt10);
               element[27] = decode(obj.collectAmt11, '0.00','-',obj.collectAmt11);
               element[28] = decode(obj.collectAmt12, '0.00','-',obj.collectAmt12);
               element[29] = ('<font style="color: #7100E1;font-weight: bold;" > ' + toCurrency(obj.rateOfReturnQ4) + '</font>');
               element[30] = ('<font style="color: #7100E1;" > ' + toCurrency(obj.collectAmtQ4) + '</font>');
               element[31] = ('<font style="color: #7100E1;" > ' + toCurrency(obj.rentFeeAmtQ4) + '</font>');
               element[32] = ('<font style="color: #7100E1;" > ' + toCurrency(obj.refundAmtQ4)+ '</font>');
               
               element[33] = obj.rateOfReturnTot; 
               element[34] = obj.collectAmtTot;   
               element[35] = obj.rentFeeAmtTot;   
               element[36] = obj.refundAmtTot;    
               
               data[i] = element;
               
          }); 
      } 
      
      $('#table_data').dataTable( {
                 "sScrollX": "100%",
                 "sScrollXInner": "200%",
                 "bScrollCollapse": true,
                 "aaData": data, 
                 "aoColumns" : colM,
                 "sPaginationType": "full_numbers",
                 "fnFooterCallback": function ( nRow, aaData, iStart, iEnd, aiDisplay ) {
                     var iRateOfReturnTot = 0;
                     var iCollectAmtTot = 0;
                     var iRentFeeAmtTot = 0;
                     var iRefundAmtTot = 0;
                      
                     for ( var i=0 ; i<aaData.length ; i++ )
                     {
                    	 iRateOfReturnTot += aaData[i][33]*1; 
                    	 iCollectAmtTot   += aaData[i][34]*1; 
                    	 iRentFeeAmtTot   += aaData[i][35]*1;
                    	 iRefundAmtTot    += aaData[i][36]*1;

                     }
                     
                     var nCells = nRow.getElementsByTagName('th');
                     nCells[1].innerHTML    =  toCurrency(iRateOfReturnTot)  ;  
                     nCells[2].innerHTML    =  toCurrency(iCollectAmtTot)  ;  
                     nCells[3].innerHTML    =  toCurrency(iRentFeeAmtTot)  ;  
                     nCells[4].innerHTML    =  toCurrency(iRefundAmtTot);  
                 },
                 "aoColumnDefs": [ 
                               { "sType": "string",  "aTargets": [1] },
                               { "sType": "string",  "aTargets": [2] },
                               { "sType": "string",  "aTargets": [3] },
                               { "sType": "string",  "aTargets": [4] },
                               { "sType": "string",  "aTargets": [5] },
                               { "sType": "string",  "aTargets": [7] },
                               { "sType": "string",  "aTargets": [8] },
                               { "bVisible": false, "aTargets": [33] },
                               { "bVisible": false, "aTargets": [34] },
                               { "bVisible": false, "aTargets": [35] },
                               { "bVisible": false, "aTargets": [36] }
                        ] 
      });
        
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
    <div id="grid_array"></div>
    <br/>
    <br/>
    <div id="main_control" class="main_control">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="*" align="right">
                    <button class="word8" onclick="viewChart();">View Chart</button>
                </td>
            </tr>
        </table>
    </div>	    




</body>
</html>