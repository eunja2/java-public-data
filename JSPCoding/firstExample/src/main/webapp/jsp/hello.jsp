<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
		<title>JSP ù ���� �ۼ��ϱ� - hello.jsp</title>
		
		<!-- ����� �� ������ ���� -->
		<link rel="shortcut icon" href="../image/icon.png" />
		<link rel="apple-touch-icon" href="../image/icon.png" />
		<!-- ����� �� ������ ���� �� -->
		
		<!--IE8���� ���������� HTML5�� �ν��ϱ� ���ؼ��� �Ʒ��� �н����͸� �����ϸ� �ȴ�.--> 
		<!--[if lt IE 9]>
		<script src="../js/html5shiv.js"></script>
		<![endif]-->
	</head>
	<body>
	<%
		out.print("<h1>Hello JSP!</h1>");
		out.print("<p>ó������ ������ JSP �����Դϴ�.</p>");
	%>
	</body>
</html>