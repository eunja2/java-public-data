<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>
<%@ page import="example.Clock" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
		<title>JSP ���� ���� : date.jsp</title>
		
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
		Date nowDate = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy�� MM�� dd��");
		String formatDate = dateFormat.format(nowDate);
	%>
	<p>
		�Ϲ����� JSP �������� ���·� �Ʒ��� ���� ���� ��¥�� �����մϴ�.<br/>
		���� ��¥�� <%=formatDate%> �Դϴ�.
	</p>
	
	<% 
		// example ��Ű���� Clock Ŭ������ �����Ͽ� ���� ��¥�� �ð��� ������ּ���.
		/* SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
		String formatTime = timeFormat.format(nowDate); */
		
		Clock clock = new Clock();
		String data = clock.now();
		// out.print("���� ��¥��"+data+"�Դϴ�.");
	%>
	<p>
		���� ��¥ �� �ð��� <%=data%> �Դϴ�. <%-- ǥ�����̶�� ��. �������� ���� --%>
	</p>
	</body>
</html>