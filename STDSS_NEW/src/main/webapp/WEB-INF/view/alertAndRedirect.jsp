<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<body>
<script type="text/javascript">
var message = '${message}';
var returnUrl = '${returnUrl}';

alert(message);
document.location.href = "http://"+location.host+returnUrl;
</script>
</body>
</html>