<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
		<title>Insert title here</title>
		
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
		// ���ڸ� ������ ���� 3��(7, 5, 9)�� �����ϰ� �ִ밪 ���ϱ�
		int var1 = 7;
		int var2 = 5;
		int var3 = 9;
		int max;
		int count=0;
		
		max = var1;
		
		if(var2>max)
			max = var2;
		if(var3>max)
			max = var3;
	%>
	<p>
		�ִ밪�� : <%=max%> 
	</p>
	
	<%
		// �迭�� ��(12, 26, 68, 98, 76, 54, 8, 6, 4) �� �ִ밪�� �ּҰ� ���ϱ�
		int[] arr = {12, 26, 68, 98, 76, 54, 8, 6, 4};
		int max2 = arr[0];
		int min2 = arr[0];
		for(int i=1; i<arr.length; i++){
			if(arr[i]>max2)
				max2 = arr[i];
			if(arr[i]<min2)
				min2 = arr[i];
		}
	%>
	<p>
		�ּҰ� : <%=min2%>
		�ִ밪 : <%=max2%> 
	</p>
	
	<%
		// ���ڿ� �����ϱ�
		String str = "���� ���� ��λ��� ������ �⵵�� �ϴ����� �����ϻ� �츮���� ����";
		int length = str.length();
		int idx = str.indexOf('��');
		char cha = str.charAt(15);
	%>
	<p>
		"���� ���� ��λ��� ������ �⵵�� �ϴ����� �����ϻ� �츮���� ����" => <%=length%>���̸�, '��'�� <%=idx%>��°�� �ִ�.<br/>
		"���� ���� ��λ��� ������ �⵵�� �ϴ����� �����ϻ� �츮���� ����" �� 15��° ���ڴ� '<%=cha%>'�̴�.
	</p>
	</body>
</html>