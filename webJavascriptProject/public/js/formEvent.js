// html load 되고 난 후 읽으라는 ready 함수
$(function(){
	$("#userId").on("input", function(){
		// 아이디는 첫글자 영문자, 두번째부터 영문자와 숫자로 6글자 이상 12글자 이하
		const regExp = /^[a-zA-Z][a-zA-Z0-9]{5,11}$/;
		
		if(regExp.test($(this).val())){
			$("#msgId").html("사용가능한 아이디입니다");
			$("#msgId").addClass("confirm");
			$("#msgId").removeClass("error");
		} else {
			$("#msgId").html("첫글자 영문자, 두번째부터 영문자와 숫자로 6글자 이상 12글자 이하로 입력해주세요");
			$("#msgId").addClass("error");
			$("#msgId").removeClass("confirm");
		}
	});
	
	
	$("#userPw").on("input", function(){
		// 비밀번호는 영문 대문자와 소문자, 숫자, 특수문자로 구성되고 8글자 이상 32글자 이하
		const regExp = /^[a-zA-Z0-9`~!@#$%^&*()\-_=+]{8,32}$/;
		
		if(regExp.test($(this).val())){
			$("#msgPw").html("사용가능한 비밀번호입니다");
			$("#msgPw").addClass("confirm");
			$("#msgPw").removeClass("error");
		} else {
			$("#msgPw").html("영문 대문자와 소문자, 숫자, 특수문자로 구성되고 8글자 이상 32글자 이하로 입력해주세요");
			$("#msgPw").addClass("error");
			$("#msgPw").removeClass("confirm");
		}
	});
	
	
	// 이메일 선택하면 input 들어가게
	$("#emailAddress").on("change", function(){
		let email = $("#emailAddress option:selected").val();
		
		if(email == "naver"){
			$("#emailDomain").val("naver.com");
		} else if(email == "daum"){
			$("#emailDomain").val("daum.net");
		} else if(email == "gmail"){
			$("#emailDomain").val("gmail.com");
		} else {
			$("#emailDomain").val("");
			$("#emailDomain").focus();
		}
	});
	
	// 취미 옆 checkbox 선택하면 option 다 선택되게
	$("#hobbyCheckTotal").on("change", function(){
		let hobby = $(".hobbyCheck");
		
		if($("#hobbyCheckTotal").checked){
			for(let i=0; i<hobby.length; i++){
				hobby[i].checked = true;
			}
		} else {
			for(let i=0; i<hobby.length; i++){
				hobby[i].checked = false;
			}
		}
		
	});
	
});

// 필수 항목 제어
function validate(){
	
}




