
$(function(){
	$(".login_txt .input_box>label").click(function(){
		$(this).addClass("none");
	});
});
$(function(){
	$(".login_txt .input_box>input").focusin(function(){
		$(this).siblings("label").addClass("none");
	});
});

