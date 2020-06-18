<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>注册</title>
  </head>
  
  <body>
        <h2>注册账号</h2>
    	<form action=CheckUser method="post">
                                    请输入用户名:
    		<input type="text" name="userName"><br/>
    		请输入密码:
    		<input type="password" name="password"><br/>
    		<input type="hidden" name="actiontype" value="register"/><!--用隐藏域来判断登陆还是注册 -->
    		<input type="submit" value="确定"/><br/><br/>
    	</form>

    	<button onclick="window.location='login.jsp'">返回登陆</button>
    	${sessionScope.registerMsg}
  </body>
</html>
