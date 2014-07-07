String.prototype.interpolate = function(o) {
	return this.replace(/{([^{}]*)}/g, function(a, b) {
		var r = o[b];
		return typeof r === 'string' || typeof r === 'number' ? r : a;
	});
};

//Ajax 처리상태
$(document).ready(function() {
	$(this).ajaxStart(function() {
		var today = new Date();
		var timestamp = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
		$('<div>'+ timestamp +' :data in retrive....</div>').prependTo('#pageLog');
	});
	
	$(this).ajaxComplete(function() {
		var today = new Date();
		var timestamp = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds(); 
		$('<div>'+ timestamp +' :data inquiry complete.</div>').prependTo('#pageLog');
	});
	
	$.ajaxSetup({
		cache : true,
		dataType : 'json',
		error : function(xhr, status, error) {
			alert('An error occurred: ' + error);
		},
		timeout : 60000, // Timeout of 60 seconds
		type : 'POST',
		url : 'ajax-gateway.php'
	}); 
});


