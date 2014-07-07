Number.prototype.toMoney = function(decimals, decimal_sep, thousands_sep)
{ 
   var n = this,
   c = isNaN(decimals) ? 2 : Math.abs(decimals), //if decimal is zero we must take it, it means user does not want to show any decimal
   d = decimal_sep || '.', //if no decimal separator is passed we use the dot as default decimal separator (we MUST use a decimal separator)

   t = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep, //if you don't want to use a thousands separator you can pass empty string as thousands_sep value

   sign = (n < 0) ? '-' : '',

   //extracting the absolute value of the integer part of the number and converting to string
   i = parseInt(n = Math.abs(n).toFixed(c)) + '', 

   j = ((j = i.length) > 3) ? j % 3 : 0; 
   return sign + (j ? i.substr(0, j) + t : '') + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : ''); 
};


function toCurrency(money){
	if(money == null || money == '') return "$ 0";
	return "$ " + parseFloat(money).toMoney(2);
}


// Oracle의 NVL 함수와 비슷한 기능의 유틸리티
function nvl(parm, defalutValue) {
	var val = "";
	var returnVal = "";
	if (defalutValue != null)
		val = defalutValue;
	if (parm == null || parm == '')
		returnVal = val;
	return returnVal
}

// Oracle의 DECODE 함수와 비슷한 기능의 유틸리티
function decode() {
	var returnVal = "";
	var argCnt = arguments.length;

	var isEven = true; // 첫번째 인수를 제외한 나머지 것이 짝수인지 검사
	if ((((argCnt) - 1) % 2) != 0)
		isEven = false;
	var param = arguments[0];
	var lastIndex = argCnt - 1;

	if (argCnt == 1) {
		returnVal = arguments[0];
	} else if (argCnt == 2) {
		// NVL함수와 동일한 기능을 한다.
		if (arguments[0] == null || arguments[0] == '') {
			returnVal = arguments[1];
		} else {
			returnVal = arguments[0];
		}
	} else if (argCnt > 2) {
		var isMached = false;
		for ( var i = 1; i < lastIndex && isMached == false; i = i + 2) {
			if (param == arguments[i]) {
				returnVal = arguments[i + 1];
				isMached = true;
				break;
			}
		}

		if (isMached == false) {
			if (isEven) {
				returnVal = param;
			} else {
				returnVal = arguments[lastIndex];
			}
		}
	}
	return returnVal;
}

// 페이지의 상태지역에 상태표시를 한다.
function pageLog(message, type){
	var today = new Date(); 
	var timestamp = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
	$('<div>'+ timestamp +' :[' + type + ']' + message + '</font></div>').prependTo('#pageLog'); 
}

function viewPageLog(obj) {
	var logMsg = $('#pageLog').html();
	if(logMsg == '' || logMsg == null ) return;
	logMsg = logMsg.split("<div>").join("");
	logMsg = logMsg.split("</div>").join("\n");
    alert(logMsg);
}

// 팝업윈도우를 화면중앙에 오픈한다.
function openPopupForm(url, windowName, pwidth, pheight){
    var win = null;
    var winL = (screen.width-pwidth)/2;
    var winT = (screen.height-pheight)/2;
    var scrollYN = "yes";
    var resizeYN = "no";
    var spec = 'toolbar=no,'; // 도구메뉴
    spec += 'status=no,'; // 상태바
    spec += 'location=no,'; // 주소관련메뉴
    spec += 'height='+pheight+','; // 높이
    spec += 'width='+pwidth+','; // 너비
    spec += 'top='+winT+','; // 세로위치
    spec += 'left='+winL+','; // 가로위치
    spec += 'scrollbars='+(scrollYN == undefined ? "no" : scrollYN)+','; // 스크롤바 여부(기본)
    spec += 'resizable='+(resizeYN == undefined ? "no" : resizeYN); // 창크기조정 여부

    win = window.open(url, windowName, spec);
    if(parseInt(navigator.appVersion) >= 4) {
    	win.window.focus();
    }
    return win;
}

/**
 * @type   : function
 * @access : public
 * @desc   : 필수 입력 항목(mandatory="true"로 선언된 오브젝트)의 입력 여부를 확인하여, 모두 입력되었으면 true, 아니면 false를 리턴한다.<br>
 *           주로 '저장' 버튼을 클릭했을 때, 필수 입력 항목에 대한 validation용으로 사용한다.<br>
 *
 * <pre>
 *     if (cfCheckMandatory() == false)
 *         return;
 * </pre>
 * 필수 입력항목이 빠졌을 경우 그 오브젝트에 focus가 가고, 에러 메시지가 alert로 나타난 후에 이후의 작업(예:저장)을 수행하지 않고 리턴한다.
 * @return : boolean 필수입력항목의 입력 여부
 */
function checkMandatory() {
	var $mandatoryObjs = $('*[mandatory=true]');

	var returnVal = true;
	$mandatoryObjs.each(function (i, elementObj) {
		 if(elementObj.value == '' && elementObj.tagName == 'INPUT' && elementObj.type == 'text'){
			 elementObj.focus();
			 elementObj.style.background = "#fffacd";
			 returnVal = false;
		 } else if (elementObj.value == '' && elementObj.tagName == 'INPUT' && elementObj.type == 'password'){
			 elementObj.focus();
			 elementObj.style.background = "#fffacd";
			 returnVal = false;
		 } else if (elementObj.value == '' && elementObj.tagName == 'SELECT') {
			 elementObj.focus();
			 elementObj.style.background = "#fffacd";
			 returnVal = false;
		 } else if (elementObj.tagName == 'INPUT' &&  elementObj.type == 'radio') {
			 var radioVal =  $('INPUT:RADIO[NAME=' + elementObj.name + ']:checked').val();
			 if(radioVal == null){
				 elementObj.focus();
				 elementObj.style.background = "#fffacd";
				 returnVal = false;
			 }
		 }
		 return returnVal;
	 });
	
	if(returnVal == false) {
		//alert('입력항목을 체크해주세요');
		pageLog("Check input field(s)","warn");
	}
	
	return returnVal;
}


// 오픈너에게 데이터셋(JSON)을 넘기고 창을 닫는다.:오프너에게 setReturnValue(data)함수가 구현되어 있어야 한다.
function setOpenerDataset(returnValue) {
	window.opener.setReturnValue(returnValue);
	window.close();
}


function abbreviate(orgStringValue,maxLength) {
    var ls_str = orgStringValue;       // 이벤트가 일어난 컨트롤의 value 값
    var li_str_len = ls_str.length;    // 전체길이

    var li_max = maxLength;            // 제한할 글자수 크기
    var i = 0;                     
    var li_byte = 0;                   // 한글일경우는 2 그밗에는 1을 더함
    var li_len = 0;                    // substring하기 위해서 사용
    var ls_one_char = "";              // 한글자씩 검사한다
    var ls_str2 = "";                  // 글자수를 초과하면 제한할수 글자전까지만 보여준다.

    for(i=0; i< li_str_len; i++) {
    	ls_one_char = ls_str.charAt(i);

	    // 한글이면 2를 더한다.
	    if (escape(ls_one_char).length > 4){
	    	   li_byte += 2;
	    } else {
	    	   li_byte++; // 그밗의 경우는 1을 더한다.
	    }
	
	    // 전체 크기가 li_max를 넘지않으면
	    if(li_byte <= li_max){
	    	   li_len = i + 1;
	    }
    }

    // 전체길이를 초과하면
    if(li_byte > li_max) {
    	ls_str2 = ls_str.substr(0, li_len) + '...';

    } else {
    	ls_str2 = ls_str;
    }
    return ls_str2;
}  

//필드의 항목이 숫자인지 체크한다.
function isNumeric(s) {
	  for (i=0; i<s.length; i++) {
	    c = s.substr(i, 1);
	    if (c < "0" || c > "9") return false;
	  }
	  return true;
}

function digitchk(obj) {
	 e = window.event; //윈도우의 event를 잡는것입니다. 그냥 써주심됩니당.
	 //숫자열 0 ~ 9 : 48 ~ 57, 키패드 0 ~ 9 : 96 ~ 105 ,8 : backspace, 46 : delete , 190,110:. -->키코드값을 구분합니다. 저것들이 숫자랍니다.
	 if((e.keyCode >= 48 && e.keyCode <= 57) || (e.keyCode >= 96 && e.keyCode <= 105) || e.keyCode == 8 || e.keyCode == 46 || e.keyCode == 190 || e.keyCode == 110) {
		 if(e.keyCode == 48 || e.keyCode == 96 || e.keyCode == 190) { 
			 	if(obj.value == "" ) {
			 		return;
			 		//event.returnValue=false; // 아무것도 없는상태에서 0을 눌렀을경우 입력되지않는다.  
			 	} else{  
			 		return; //다른숫자뒤에오는 0은 입력시킨다.
			 	}	
		 } else { //0이 아닌숫자
			 return; //-->입력시킨다.
		 }	 
 	 } else {
 		 event.returnValue=false;
 	 }
}


//1.숫자인지 검사하는 코드가 내장되어 있으므로 따로 작성하실 필요없읍니다.
//2.소수점은 달러(2자리)를 넘으면 지워집니다.  2자리 이상 입력을 허용하시려면 addComma(this,3)처럼 맨 끝의 인자에 원하는 자리수(3=>3자리)를 전달하시면 됩니다.
//3.서버전송시 자바스크립트로 콤마를 제거하시려면 text1.value.replace(/,/,'')으로 모든 콤마 제거하신 후 전송
function addCommas(nStr)
{
    nStr += '';
    x = nStr.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
}

