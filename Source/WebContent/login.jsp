<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>登陆</title>
  </head>
  <body>
        <h2>欢迎登陆</h2>
    	<form action="CheckUser" method="post">
    		账号:<input type="text" name="userName"><br/>
    		密码:<input type="password" name="password"><br/>
    		<input type="hidden" name="actiontype" value="login" /> <!-- 用隐藏域来判断登陆还是注册 -->
    		<input type="submit" value="登陆"/><br/><br />
    	</form>
  	    <button onclick="window.location='register.jsp'">注册</button>
    	${sessionScope.errorMsg} <!-- EL语法--获取session的errorMsg并显示 -->
  </body>
</html>
