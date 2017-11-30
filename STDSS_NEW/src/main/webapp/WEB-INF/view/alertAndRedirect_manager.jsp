<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<body>
<script type="text/javascript">
var message = '${message}';
var returnUrl = 'http://'+location.host+"/manager_list.do";
var returnUrlFail = 'http://'+location.host+"/openIndexPage.do";
var usr = '${userSession.user.user_id}'

if(usr != 'admin'){
	alert(message);
	document.location.href = returnUrlFail;
}else{
	document.location.href = returnUrl;
}

</script>
</body>
</html>