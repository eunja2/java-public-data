// html() 버튼
$("#btn1").on("click", function(){

    // 아이디가 area인 요소의 내용을 모두 삭제
    $("#area").html(""); // document.getElementById("area").innerHTML = "";
   
    // 아이디가 area인 요소의 내용 출력 (태그 인식)
    $("#area").html("<p class=cls1>html() 메소드로 작성된 내용</p>");
});

// text() 버튼
$("#btn2").on("click", function(){

    // 아이디가 area인 요소의 내용을 모두 삭제
    $("#area").text("");

    // 아이디가 area인 요소의 내용 출력 (태그 인식X)
    $("#area").text("<p class=cls1>text() 메소드로 작성된 내용</p>");
});

// val() 버튼
$("#btn3").on("click", function(){

    // 아이디가 inputId 요소의 내용을 모두 삭제
    $("#inputId").val("");

    $("#inputId").val("cherry");
});

$(document).ready(function(){
    let count = 1;

    // append() : 마지막 자식 요소로 추가
    $("#list2").append("<li>리스트" + count++ + "</li>");
    $("#list2").append("<li>리스트" + count++ + "</li>");
    $("#list2").append("<li>리스트" + count++ + "</li>");

    // prepend() : 첫번째 자식 요소로 추가
    $("#list2").prepend("<li>리스트" + count++ + "</li>");
    $("#list2").prepend("<li>리스트" + count++ + "</li>");
    $("#list2").prepend("<li>리스트" + count++ + "</li>");

    for(let i=0; i<3; i++){
        const el = "<p>새로 추가된 요소" + i + "</p>";

        // before() : 바로 이전 형제 요소 추가
        // after() : 바로 다음 형제 요소 추가
        $("#list2").before(el);
        $("#list2").after(el);
    }
});

// empty() 버튼
$("#btn2-1").on("click", function(){

    // empty() : 자식 요소들을 모두 제거하는 메소드
    //           -> 특정 요소 내부를 비움

    // id가 area3인 요소의 내부를 비움
    $("#area3").empty();
});

// id가 div3인 요소에 마우스가 들어왔다 나갔다 할 때의 동작
// $("#div3").hover(function(){} , function(){} );
//               마우스 들어왔을 때, 나갔을 때
$("#div3").hover(function(){
    
    // test
    // console.log($("#div3"));

    // 마우스가 들어왔을 때 현재 요소에 lime 클래스 추가
    $(this).addClass("lime"); /* JS에서는 classList.add("클래스명") */

}, function(){
    // 마우스가 나갔을 때 현재 요소에서 lime 클래스 제거
    $(this).removeClass("lime"); /* JS에서는 classList.remove("클래스명") */
});

// remove() 버튼
$("#btn2-2").on("click", function(){

    // remove() : 요소 잘라내기, 관련 이벤트 삭제
    const el = $("#div3").remove();
    console.log(el);
    $("#area4").append(el);
});

// detach() 버튼
$("#btn2-3").on("click", function(){

    // detach() : 요소 잘라내기, 관련 이벤트도 같이 잘라냄
    const el = $("#div3").detach();
    $("#area4").append(el); // id가 area4인 요소 뒤에 붙여도 이벤트 남아있음
});