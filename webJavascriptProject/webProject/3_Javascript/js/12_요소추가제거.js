// 추가 버튼(#add)가 클릭되었을 때
document.getElementById("add").addEventListener("click", function(){
    // div 요소 생성
    const div = document.createElement("div");
    // div에 row 클래스 추가
    div.classList.add("row");

    // --------------------------------------------------

    // input 요소 생성
    const input = document.createElement("input");
    // input에 in 클래스 추가
    input.classList.add("in");
    // input에 "type" 속성, "number" 속성값 추가 (type="number")
    // - 요소.setAttribute("속성","속성값") : 요소에 속성/속성값 추가
    input.setAttribute("type","number");
    // --------------------------------------------------

    // span 요소 생성
    const span = document.createElement("span");
    // span에 remove 클래스 추가
    span.classList.add("remove");
    // span의 내용으로 "x" 추가
    span.innerText = "X";
    // span이 클릭 되었을 때에 대한 이벤트 동작 추가
    // 요소.parentElement : 부모 요소
    // 요소.remove() : 요소 제거

    // 부모(.row)
    span.addEventListener("click", function(){
        span.parentElement.remove();
    })
    // --------------------------------------------------


    // div 내부에 (자식으로) input, span 순서대로 추가
    div.append(input);
    div.append(span);

    // #container에 div를 마지막 자식으로 추가
    document.getElementById("container").append(div); 
})

// 계산 버튼 클릭시 이벤트 동작
document.getElementById("calc").addEventListener("click", function(){

    // 합계 저장용 변수
    let sum = 0;

    // in 클래스 요소를 모두 얻어옴 -> 배열 형태
    const list = document.getElementsByClassName("in"); // 여기서 가져오는 것은 배열형태. 배열 전체에 .value 해버리면 안 나옴(0번 인덱스의 value값을 원하는 거지 배열자체의 value값 아님)

    // 배열용 향상된 for문(for ... of ...) 사용
    for(let input of list){

        // Number("") == 0 // 빈칸은 0으로 변환되기 때문에 신경쓰지 말자
        // sum에 입력값 누적
        // -> input에 작성된 값은 모두 string -> 숫자 변환 Number() 필요 
        sum += Number(input.value); 
    }

    // sum을 alert로 출력
    alert("합계 : "+sum);

})
