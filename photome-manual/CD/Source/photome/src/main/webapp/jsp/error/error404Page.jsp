<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<!-- js static messages -->

<!-- Ext 2.0 Resources -->
<link rel="stylesheet" type="text/css" href="/ext/resources/css/ext-all.css" />
<script type="text/javascript" src="/ext/source/core/Ext.js"></script>
<script type="text/javascript" src="/ext/source/adapter/ext-base.js"></script>
<script type="text/javascript" src="/ext/ext-all-debug.js"></script>
<!-- // Ext 2.0 Resources -->

<!-- compliance patch for microsoft browsers -->
<!--[if IE]>
<![endif]-->
<!-- 로딩속도의 문제로 현재로선 사용하지 않음.
<script src="/js/ie7-standard-p.js" type="text/javascript"></script>
-->
<![if !IE]>
<script type="text/javascript" src="/js/cross-browser-function.js"></script>
<![endif]>
<script type="text/javascript" src="/js/dragiframe.js"></script>
<script type="text/javascript" src="/js/prototype-1.6.0.2.js"></script>
<script type="text/javascript" src="/js/common/scriptaculous/scriptaculous.js?load=effects,dragdrop"></script>
<script type="text/javascript" src="/js/common/date.js"></script>
<script type="text/javascript" src="/js/common/domReady.js"></script>
<!-- Element border rounding
<script type="text/javascript" src="/js/common/round.js"></script>
<script type="text/javascript" src="/js/common/RUZEE/cssquery2-p.js"></script>
<script type="text/javascript" src="/js/common/RUZEE/ruzeeborders.js"></script>
-->

<script type="text/javascript" src="/js/ehrdui.js"></script>
<script type="text/javascript" src="/js/ehrduri.js"></script>
<script type="text/javascript" src="/js/BPF.js"></script>


<title>Layer_Box</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
<!--
.style2 {font-size: 12px; color: #666666; font-family: "굴림체", "돋움체", Seoul;}
-->
</style>
<script type="text/javascript">

	//--------------------------------
	// 이전페이지로!
	//--------------------------------
	function goBack() {
		// BPF.Popup인 경우 popup close
		if( BPF.Popup.getPoppyId() ) {
			BPF.Popup.close();
		} else {
			history.back();
		}
	}
 
</script>
</head>
<body topmargin="0" leftmargin="0">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center" bgcolor="ececec">
	    <table width="376" height="372" border="0" cellpadding="0" cellspacing="0" background="/images/error/bg02.gif">
	      <tr>
	        <td height="194" align="center" valign="top">&nbsp;</td>
	      </tr>
	      <tr>
	        <td align="center" valign="top" class="style2">
	
	
	
					  <!-----시스템오류------>
				
					  <!-----요청하신 페이지를 처리하는 도중 오류가 발생하였습니다.<br>
				          일시적 장애 일 경우 잠시 후<br>
				          다시 한번 시도해보시기 바랍니다.<br>
				          동일한 문제가 지속적으로 발생하실 경우에<br>
				          해당 서비스 관리자에게 문의해 주십시요.</td---->
	
	
	
	
	
					  <!-----페이지없음오류------->
				
					  <!---요청하신 오류페이지를 찾을 수 없습니다.<br>
					  찾으시려는 웹페이지의 이름이 바뀌었거나<br>
					  현재 사용할 수 없거나 삭제되었습니다.<br>
					  입력하신 페이지 주소가 정확한지<br>
					  다시 한번 확인해보시기 바랍니다.<br><br>
					  동일한 문제가 지속적으로 발생하실 경우에<br>
					  해당 서비스 관리자에게 문의해 주십시요.---->
					  
					  
					  
					  
					</td>
	      </tr>
	      <tr>
	        <td height="98" align="center" valign="top"><br>
	          <a href="javascript:goBack();"><img src="/images/error/error_back_btn.gif" width="95" height="29" border="0"></a></td>
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</body>
</html>

