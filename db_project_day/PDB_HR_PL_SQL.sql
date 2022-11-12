-- PL/SQL
-- 1. PL/SQL
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World');
END;
/

-- 1. 변수
-- 1) 변수의 값 대입
DECLARE
    val_num NUMBER;
BEGIN
    val_num := 100;
    DBMS_OUTPUT.PUT_LINE(val_num);
END;
/

-- 변수의 선언 및 할당을 하고 그 변수 값을 출력한다
DESC EMPLOYEES; -- 변수에 할당할 칼럼의 자료형 확인
DECLARE
    VEMPLOYEE_ID NUMBER(6);
    VFIRST_NAME VARCHAR2(20);
BEGIN
    VEMPLOYEE_ID := 105;
    VFIRST_NAME := 'David';
    
    DBMS_OUTPUT.PUT_LINE('사번 / 이름');
    DBMS_OUTPUT.PUT_LINE('----------');
    DBMS_OUTPUT.PUT_LINE(VEMPLOYEE_ID||' / '||VFIRST_NAME);
END;
/
-- 2) 스칼라 변수/ 레퍼런스 변수
-- (1) 스칼라 : SQL에서의 자료형 지정과 거의 동일
VEMPLOYEE_ID NUMBER(6);
VFIRST_NAME VARCHAR2(20);
-- (2) 레퍼런스 : %TYPE 속성과 %ROWTYPE 속성
VEMPLOYEE_ID EMPLOYEES.EMPLOYEE_ID%TYPE;
VFIRST_NAME EMPLOYEES.FIRST_NAME%TYPE;
-- %ROWTYPE : 로우 단위 참조
VEMPLOYEES EMLOYEES%ROWTYPE;

-- 3) PL/SQL에서 SQL문장
-- 조회된 컬럼의 결과를 변수에 대입시 INTO 절 사용
DECLARE
    -- %TYPE 속성으로 칼럼 단위로 데이터 저장할 수 있는 레퍼런스 변수 선언
    VEMPLOYEE_ID EMPLOYEES.EMPLOYEE_ID%TYPE;
    VFIRST_NAME EMPLOYEES.FIRST_NAME%TYPE; 
BEGIN
    DBMS_OUTPUT.PUT_LINE('사번 / 이름');
    DBMS_OUTPUT.PUT_LINE('----------');
    
    SELECT EMPLOYEE_ID, FIRST_NAME 
    INTO VEMPLOYEE_ID, VFIRST_NAME 
    FROM EMPLOYEES
    WHERE FIRST_NAME = 'Susan';
    
    DBMS_OUTPUT.PUT_LINE(VEMPLOYEE_ID||' / '||VFIRST_NAME);
END;
/

-- 전체 레코드 참조하기 위해서는 %rowtype으로 선언
DECLARE
    VEMPLOYEES EMPLOYEES%ROWTYPE;
BEGIN
    SELECT * INTO VEMPLOYEES FROM EMPLOYEES
    WHERE FIRST_NAME = 'Lisa';
    
    DBMS_OUTPUT.PUT_LINE('사원번호 :'||TO_CHAR(VEMPLOYEES.EMPLOYEE_ID));
    DBMS_OUTPUT.PUT_LINE('이   름 :'||VEMPLOYEES.FIRST_NAME);
    DBMS_OUTPUT.PUT_LINE('급   여 :'||VEMPLOYEES.SALARY);
    DBMS_OUTPUT.PUT_LINE('입사일자 :'||TO_CHAR(VEMPLOYEES.HIRE_DATE,'YYYY-MM-DD'));
END;
/

-- <예제> employees 테이블에 등록된 총사원의 수와 급여의 합, 급여의 평균을 변수에 대입하여 출력하여 보자.
DECLARE
    VEMPLOYEENUM NUMBER;
    VSALARYSUM NUMBER;
    VSALARYAVG NUMBER(10,2);
BEGIN
    SELECT COUNT(EMPLOYEE_ID), SUM(SALARY), ROUND(AVG(SALARY)) 
    INTO VEMPLOYEENUM, VSALARYSUM, VSALARYAVG 
    FROM EMPLOYEES;
    
    DBMS_OUTPUT.PUT_LINE('총사원 수 : '||VEMPLOYEENUM);
    DBMS_OUTPUT.PUT_LINE('급여의 합 : '||VSALARYSUM);
    DBMS_OUTPUT.PUT_LINE('급여의 평균 : '||VSALARYAVG);
END;
/

-- <예제> Jack 사원의 직무, 급여, 입사일자, 부서명을 변수에 대입하여 출력하여 보자.
DECLARE
    JOB VARCHAR2(10);
    SAL NUMBER;
    HIREDATE DATE;
    DEPARTNAME VARCHAR2(10);
BEGIN
    SELECT JOB_ID, SALARY, HIRE_DATE, DEPARTMENT_NAME 
    INTO JOB, SAL, HIREDATE, DEPARTNAME
    FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE FIRST_NAME = 'Jack';
    
    DBMS_OUTPUT.PUT_LINE('직무 : '||JOB);
    DBMS_OUTPUT.PUT_LINE('급여 : '||SAL);
    DBMS_OUTPUT.PUT_LINE('입사일자 : '||HIREDATE);
    DBMS_OUTPUT.PUT_LINE('부서명 : '||DEPARTNAME);
END;
/

DECLARE
    VEMPLOYEES EMPLOYEES%ROWTYPE;
    VDEPARTMENTS DEPARTMENTS%ROWTYPE;
BEGIN
    SELECT JOB_ID, SALARY, HIRE_DATE, DEPARTMENT_NAME 
    INTO VEMPLOYEES.JOB_ID, VEMPLOYEES.SALARY, VEMPLOYEES.HIRE_DATE, VDEPARTMENTS.DEPARTMENT_NAME
    FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
    WHERE FIRST_NAME = 'Jack';
    
    DBMS_OUTPUT.PUT_LINE('직무 : '||VEMPLOYEES.JOB_ID);
    DBMS_OUTPUT.PUT_LINE('급여 : '||VEMPLOYEES.SALARY);
    DBMS_OUTPUT.PUT_LINE('입사일자 : '||VEMPLOYEES.HIRE_DATE);
    DBMS_OUTPUT.PUT_LINE('부서명 : '||VDEPARTMENTS.DEPARTMENT_NAME);
END;
/

-- <예제> 사원 테이블(employees01)에서 사원번호가 제일 큰 사원을 찾아낸 뒤, 이 번호 +3번으로 아래의 사원을 
-- 사원테이블에 신규 입력하는 PL/SQL을 만들어 보자.
CREATE TABLE EMPLOYEES01
AS
SELECT * FROM EMPLOYEES;

SELECT * FROM EMPLOYEES01;
-- 스칼라 변수 이용
DECLARE
    MAXEMPLOYEE_ID NUMBER;
BEGIN
    SELECT MAX(EMPLOYEE_ID) 
    INTO MAXEMPLOYEE_ID
    FROM EMPLOYEES01;
    
    INSERT INTO EMPLOYEES01(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, SALARY, HIRE_DATE, MANAGER_ID, JOB_ID, DEPARTMENT_ID)
    VALUES(MAXEMPLOYEE_ID+1,'Olivia','Gee','Spring',2800,sysdate,100,'PR_REP',20);
END;
/
-- DELETE FROM EMPLOYEES01 WHERE FIRST_NAME = 'Olivia';

-- 레퍼런스 변수 이용
DECLARE
    MAX_EMPLOYEE_ID EMPLOYEES01.EMPLOYEE_ID%TYPE;
BEGIN
    SELECT MAX(EMPLOYEE_ID) INTO MAX_EMPLOYEE_ID FROM EMPLOYEES01;
    
    INSERT INTO EMPLOYEES01(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, SALARY, HIRE_DATE, MANAGER_ID, JOB_ID, DEPARTMENT_ID)
    VALUES(MAX_EMPLOYEE_ID + 3,'Olivia','Gee','Spring',2800,sysdate,100,'PR_REP',20);
END;
/
SELECT * FROM EMPLOYEES01;

-- 3. 제어문
-- 1) IF ~ THEN ~ENDIF : 특정 조건 만족하면 어떤 처리하고 그렇지 않으면 아무 처리도 하지 않음
DECLARE
    vemployees employees%ROWTYPE;
    vsalary NUMBER(8,2);
BEGIN
    DBMS_OUTPUT.PUT_LINE('사번 / 이름 / 급여');
    DBMS_OUTPUT.PUT_LINE('------------------------');
    -- Pat 사원의 전체 정보를 로우 단위로 얻어와 vemployees에 저장
    SELECT * INTO vemployees FROM employees 
    WHERE first_name = 'Pat';
    -- 커미션이 null일 경우 이를 0으로 변경해야 올바른 급여 계산 가능
    IF(vemployees.commission_pct IS NULL) THEN
       vemployees.commission_pct := 0;
    END IF;
    
    -- 스칼라 변수에 급여를 계산한 결과를 저장
    vsalary := vemployees.salary+(vemployees.salary*vemployees.commission_pct);
    -- 레퍼런스 변수와 스칼라 변수에 저장된 값 출력
    DBMS_OUTPUT.PUT_LINE('사원번호 : '||vemployees.employee_id||
                ' / 사원명 : '||vemployees.first_name||
                ' / 급여 : '||TO_CHAR(vsalary,'$999,999'));
END;
/

-- 2) IF ~ THEN ~ ELSE ~ END IF : 조건을 만족할 때의 처리와 그렇지 않을 때의 처리 선택해야 할 경우
DECLARE
    -- %ROWTYPE 속성으로 로우를 저장할 수 있는 레퍼런스 변수 선언
    vemployees employees%ROWTYPE;
    vsalary NUMBER(8,2);
BEGIN
    DBMS_OUTPUT.PUT_LINE('사번 / 이름 / 급여');
    DBMS_OUTPUT.PUT_LINE('------------------------');
    -- Jack 사원의 전체 정보를 로우 단위로 얻어와 vemployees에 저장한다.
    SELECT * INTO vemployees FROM employees
    WHERE first_name = 'Jack';
    -- 커미션이 NULL일 경우 이를 0으로 변경해야 올바른 급여 계산이 가능
    IF(vemployees.commission_pct IS NULL) THEN
        vsalary := vemployees.salary;
    ELSE
        vsalary := vemployees.salary + vemployees.salary*vemployees.commission_pct;
    END IF;
    
    -- 레퍼런스 변수와 스칼라 변수에 저장된 값을 출력한다.
    DBMS_OUTPUT.PUT_LINE('사원번호 : '||vemployees.employee_id||
                ' / 사원명 : '||vemployees.first_name||
                ' / 급여 : '||TO_CHAR(vsalary,'$999,999'));
END;
/

-- 3) IF ~ THEN ~ ELSIF ~ ELSE ~ END IF : 여러개 조건에 따라 처리도 여러개일 때 사용하는 다중 IF문
DECLARE
    -- %ROWTYPE 속성으로 로우를 저장할 수 있는 레퍼런스 변수 선언
    vemployees employees%ROWTYPE;
    vdepartment_name departments.department_name%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('사번 / 이름 / 부서번호 / 부서명');
    DBMS_OUTPUT.PUT_LINE('------------------------');
    -- 사원번호가 192인 사원의 전체 정보를 로우 단위로 얻어와 vemployees에 저장
    SELECT * INTO vemployees FROM employees
    WHERE employee_id = 192;
    
    IF (vemployees.department_id = 10) THEN
        vdepartment_name := 'Administration';
    ELSIF (vemployees.department_id = 20) THEN
        vdepartment_name := 'Marketing';
    ELSIF (vemployees.department_id = 30) THEN
        vdepartment_name := 'Purchasing';
    ELSIF (vemployees.department_id = 40) THEN
        vdepartment_name := 'Human Resources';
    ELSIF (vemployees.department_id = 50) THEN
        vdepartment_name := 'Shipping';
    END IF;
    DBMS_OUTPUT.PUT_LINE(vemployees.employee_id||' /'||vemployees.first_name||' /'||
                RPAD(vemployees.department_id,4)||' /'||vdepartment_name);
END;
/

-- 랜덤한 숫자 생성
SELECT DBMS_RANDOM.VALUE(1,5) FROM DUAL;
-- 랜덤한 문자열 생성
SELECT DBMS_RANDOM.STRING('U',1) FROM DUAL; -- 1개의 임의의 대문자
SELECT DBMS_RANDOM.STRING('a',2) FROM DUAL; -- 2개의 대소문자 관계없는 영문자
SELECT DBMS_RANDOM.STRING('L',1) FROM DUAL; -- 1개의 임의의 소문자
SELECT DBMS_RANDOM.STRING('x',8) FROM DUAL; -- 8개의 임의의 영문자와 숫자 혼합(임시 비밀번호 발급할 때)

DECLARE
    vsalary NUMBER := 0;
    vdepartment_id NUMBER := 0;
BEGIN
    -- 10의 자리로 숫자 얻고 싶을 때 1의 자리에서 반올림(부서번호는 1의 자리가 없는 10, 20의 형태)
    vdepartment_id := ROUND(DBMS_RANDOM.VALUE(10,270),-1); 
    
    SELECT salary INTO vsalary
    FROM employees
    WHERE department_id = vdepartment_id AND ROWNUM = 1; -- 한 명의 데이터만 가져오기
    DBMS_OUTPUT.PUT_LINE('부서번호:'||vdepartment_id||'급여:'||vsalary);
    
    IF vsalary BETWEEN 1 AND 6000 THEN
        DBMS_OUTPUT.PUT_LINE('낮음');
    ELSIF vsalary BETWEEN 6001 AND 10000 THEN
        DBMS_OUTPUT.PUT_LINE('중간');
    ELSIF vsalary BETWEEN 10001 AND 20000 THEN
        DBMS_OUTPUT.PUT_LINE('높음');
    ELSE    
        DBMS_OUTPUT.PUT_LINE('최상위');
    END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE(vdepartment_id ||' 부서에 해당 사원이 없습니다.');
END;
/

-- 4) 반복문
-- 5) BASIC LOOP문
DECLARE
    vn_base_num NUMBER := 3;
    vn_cnt NUMBER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('*****구구단 3단*****');
    LOOP
        DBMS_OUTPUT.PUT_LINE(vn_base_num||'*'||vn_cnt||'='||vn_base_num * vn_cnt);
        vn_cnt := vn_cnt+1;
        EXIT WHEN vn_cnt>9;
        -- IF vn_cnt>9 THEN
        -- EXIT;
        -- END IF;
    END LOOP;
END;
/
-- 6) FOR LOOP문
DECLARE
    vdepartments departments%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명');
    DBMS_OUTPUT.PUT_LINE('---------------------------------');
    -- 변수 cnt는 1부터 1씩 증가하다가 27에 도달하면 반복문에서 벗어난다.
    FOR cnt IN 1..27 LOOP
        SELECT * INTO vdepartments FROM departments
        WHERE department_id = 10*cnt;
        DBMS_OUTPUT.PUT_LINE(vdepartments.department_id||' / '||
            vdepartments.department_name||' / '|| vdepartments.location_id);
    END LOOP;        
END;
/
-- 7) WHILE LOOP문
DECLARE
    i NUMBER := 1;
    vdepartments departments%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명');
    DBMS_OUTPUT.PUT_LINE('---------------------------------');
    WHILE i<= 27 LOOP
        IF i MOD 2 = 0 THEN
            SELECT * INTO vdepartments FROM departments WHERE department_id = 10*i;
            DBMS_OUTPUT.PUT_LINE(vdepartments.department_id||' / '|| vdepartments.department_name||' / '||
            vdepartments.location_id);
        END IF;
        i := i + 1;
    END LOOP;    
END;
/
-- 8) 커서
DECLARE
    vdepartments departments%ROWTYPE;
    CURSOR C1 -- 커서의이름
    IS
    SELECT department_id, department_name, location_id FROM departments; -- 커서에 담고 싶은 내용을 가져오는 서브쿼리
BEGIN
    DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명');
    DBMS_OUTPUT.PUT_LINE('-------------------------------');
    
    OPEN C1;
    -- 오픈한 C1 커서가 SELECT문에 의해 검색된 한개의 행의 정보를 읽어온다.
    LOOP -- 읽어온 정보는 INTO 뒤에 기술한 변수에 저장
        FETCH C1 INTO vdepartments.department_id, vdepartments.department_name, 
        vdepartments.location_id;
        EXIT WHEN C1 %NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(vdepartments.department_id||''||
        RPAD(vdepartments.department_name, 20)||''||vdepartments.location_id);
    END LOOP;
    CLOSE C1;
END;
/
-- 9) CURSOR와 FOR LOOP(묵시적으로 CURSOR에서 행을 처리한다.)
DECLARE
    vdepartments departments%ROWTYPE;
    CURSOR C1
    IS
    SELECT * FROM departments;
BEGIN
    DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명');
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
    FOR vdepartments IN C1 LOOP
        DBMS_OUTPUT.PUT_LINE(vdepartments.department_id||''||
        RPAD(vdepartments.department_name,20)||''||vdepartments.location_id);
    END LOOP;        
END;
/
--커서 정의 부분을 FOR문에서 직접 명시
DECLARE
    vdepartments departments%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명');
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
    FOR vdepartments IN (SELECT * FROM departments) LOOP
        DBMS_OUTPUT.PUT_LINE(vdepartments.department_id||''||
        RPAD(vdepartments.department_name,20)||''||vdepartments.location_id);
    END LOOP;    
END;
/
-- 부서 번호를 임의의 수로 얻어 레코드를 출력하도록 쿼리 작성
DECLARE
    vrandomid employees.department_id%TYPE;
    vsalarystring VARCHAR2(20);
    CURSOR cur_employees(vdepartment_id employees.department_id%TYPE)
    IS
    SELECT salary, first_name FROM employees WHERE department_id = vdepartment_id; -- 위에 선언
BEGIN
    vrandomid := ROUND(DBMS_RANDOM.VALUE(10,270),-1);
    DBMS_OUTPUT.PUT_LINE('부서번호 : '||vrandomid);
    IF vrandomid BETWEEN 120 AND 270 THEN
        DBMS_OUTPUT.PUT_LINE(vrandomid||' 부서에 해당 사원이 없습니다.');
        RETURN;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사원명 / 급여 / 급여수준');
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
    
    FOR vemployees IN cur_employees(vrandomid) LOOP 
        IF vemployees.salary BETWEEN 1 AND 6000 THEN 
            vsalarystring := '낮음';
        ELSIF vemployees.salary BETWEEN 6001 AND 10000 THEN 
            vsalarystring := '중간'; 
        ELSIF vemployees.salary BETWEEN 10001 AND 20000 THEN 
            vsalarystring := '높음';    
        ELSE
            vsalarystring := '최상위';  
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(RPAD(vemployees.first_name,6)||'/'||RPAD(vemployees.salary,5)||'/'||
        vsalarystring);
    END LOOP;    
END;
/

-- 10) 커서변수
-- 한 개 이상의 레코드를 가진 쿼리를 연결해 사용할 수 있음
-- 변수처럼 커서 변수를 함수나 프로시저의 매개변수로 전달할 수 있음

-- 커서 변수 선언
-- TYPE 커서_타입명 IS REF CURSOR;
-- 커서_변수명 커서_타입명;

-- 오라클이 제공하는 커서 타입 이용 -> 커서변수 SYS_REFCURSOR;

-- 커서 변수의 사용
-- (1) 커서 변수와 커서 정의 쿼리문 연결
-- OPEN 커서변수명 FOR SELECT문;
-- (2) 커서 변수에서 결과집합 가져오기
-- FETCH 커서변수명 INTO 변수1, 변수2, ...;

DECLARE
    vfirst_name employees.first_name%TYPE;
    --TYPE employeescursor IS REF CURSOR; -- 커서 타입 선언
    --vemployees employeescursor; -- 커서 변수 선언
    vemployees SYS_REFCURSOR;
BEGIN
    -- 커서 변수를 사용한 커서 정의 및 오픈
    OPEN vemployees FOR SELECT first_name FROM employees WHERE department_id = 10;
    
    -- LOOP문
    LOOP
        --커서 변수를 사용해 결과 집합을 EMPNAME 변수에 할당
        FETCH vemployees INTO vfirst_name;
        EXIT WHEN vemployees%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('사원명:'||vfirst_name); -- 사원명을 출력
    END LOOP;    
END;
/

-- 저장 프로시저, 트리거, 함수
-- 1. 저장 프로시저
-- 지정된 특정 처리를 실행하는 서브 프로그램의 한 유형으로 자주 사용하는 쿼리문을 모듈화시켜 필요할 때마다 호출하여 사용하는 것
CREATE OR REPLACE PROCEDURE EMPPROC
IS
    vword VARCHAR2(1);
    vemployees employees%ROWTYPE;
    CURSOR C1(vword VARCHAR2)
    IS
    SELECT employee_id, first_name, salary
    FROM employees WHERE first_name LIKE '%'||vword||'%';
BEGIN
    vword := DBMS_RANDOM.STRING('U',1);
    DBMS_OUTPUT.PUT_LINE('임의의 문자:'||vword);
    OPEN C1(vword);
    DBMS_OUTPUT.PUT_LINE('사번 / 사원명 / 급여');
    DBMS_OUTPUT.PUT_LINE('--------------------------');
    LOOP
        FETCH C1 INTO vemployees.employee_id, vemployees.first_name, vemployees.salary;
        IF C1%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('해당 사원이 존재하지 않습니다');
        END IF;
        EXIT WHEN C1 %NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(vemployees.employee_id||' / '||vemployees.first_name||' / '||
        vemployees.salary);
    END LOOP;    
END;
/

-- 명령어로 실행하면 됨
EXEC EMPPROC;

-- 저장 프로시저 작성 후 사용자가 저장 프로시저가 생성되었는지 확인하려면 USER_SOURCE 살펴보면 됨
SELECT * FROM USER_SOURCE;

-- 상세 오류 메시지 확인하려면 새로운 워크시트에 프로시저 생성 쿼리문 복사하고 바로 아래 SHOW ERROR; 추가하여
-- 전체 블록 후 실행하면 됨

-- 1) 매개변수
-- 프로시저 이름 뒤에 ()를 기술하여 그 내부에 매개변수를 정의
-- 프로시저 생성               프로시저명 ( 변수명       모드          자료형)으로 기술
CREATE OR REPLACE PROCEDURE EMPPROC02(vdepartment_id IN employees.department_id%TYPE)
IS
    CURSOR C1
    IS
    SELECT * FROM employees WHERE department_id = vdepartment_id;
BEGIN
    DBMS_OUTPUT.PUT_LINE('사원번호 / 사원명 / 급여');
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
    FOR vemployees IN C1 LOOP
        DBMS_OUTPUT.PUT_LINE(vemployees.employee_id||' / '||vemployees.first_name||' / '||
        vemployees.salary);
    END LOOP;    
END;
/
SHOW ERROR;

-- 프로시저 실행(라인 단위 실행이기 때문에 코드 옆에 주석달면 에러남)
EXECUTE EMPPROC02(10);

-- (1) IN MODE 매개변수
-- 실행환경에서 서브 프로시저로 값을 전달
-- 부서별로 salary 인상. 부서코드가 10이면 10% 인상, 20이면 20% 인상, 나머지는 동결하는 쿼리문 작성

-- 그 전에 변경 전 데이터확인
SELECT department_id, first_name, salary FROM employees01 WHERE department_id=20;
-- 프로시저 생성
CREATE OR REPLACE PROCEDURE EMPPROC_INMODE(vdepartment_id IN employees01.department_id%TYPE)
IS
BEGIN
    UPDATE employees01 SET salary = DECODE(vdepartment_id, 10, salary*1.1, 20, salary*1.2, salary)
    WHERE department_id = vdepartment_id;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('수정이 완료되었습니다.');
END EMPPROC_INMODE;
/
SHOW ERROR;
-- 프로시저 실행
EXECUTE EMPPROC_INMODE(20);
-- 인상되었는지 조회
SELECT department_id, first_name, salary FROM employees01 WHERE department_id=20;

-- 제약조건 삭제
-- ALTER TABLE 테이블명
-- DROP CONSTRAINT 제약조건명;

-- 기존테이블 삭제
DROP TABLE DEPT10;

-- 테이블 생성
CREATE TABLE DEPT10(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(30) NOT NULL,
    LOC VARCHAR2(15) NOT NULL,
    CONSTRAINT DEPT10_DEPTNO_PK PRIMARY KEY(DEPTNO)
);
-- DROP TABLE DEPT10;

-- 시퀀스 생성
CREATE SEQUENCE DEPT10_SEQ
START WITH 10
INCREMENT BY 10
MINVALUE 10
MAXVALUE 100000
NOCYCLE
CACHE 2;
-- DROP SEQUENCE DEPT10_SEQ;

-- 데이터 입력
INSERT INTO DEPT10(DEPTNO, DNAME, LOC) VALUES(DEPT10_SEQ.NEXTVAL, '인사과', '서울');
INSERT INTO DEPT10(DEPTNO, DNAME, LOC) VALUES(DEPT10_SEQ.NEXTVAL, '총무과', '대전');
INSERT INTO DEPT10(DEPTNO, DNAME, LOC) VALUES(DEPT10_SEQ.NEXTVAL, '교육팀', '서울');
INSERT INTO DEPT10(DEPTNO, DNAME, LOC) VALUES(DEPT10_SEQ.NEXTVAL, '기술팀', '인천');
INSERT INTO DEPT10(DEPTNO, DNAME, LOC) VALUES(DEPT10_SEQ.NEXTVAL, '시설관리팀', '광주');

-- 시퀀스 만들지 않았다면 
-- INSERT INTO DEPT10 VALUES(SELECT MAX(DEPTNO)+10 FROM DEPT10), '시설관리팀', '광주');

-- 자료구조 변경(컬럼 추가) : DEPT10 테이블에 CREDATE라는 이름의 컬럼을 날짜 자료형으로 추가
ALTER TABLE DEPT10 
ADD(CREDATE DATE DEFAULT SYSDATE); -- 이전에 입력했더 레코드들에 기본값이 추가됨

SELECT * FROM DEPT10;

-- 프로시저 생성
CREATE OR REPLACE PROCEDURE DEPTPROC_INMODE
(DNAME IN DEPT10.DNAME%TYPE,
 LOC IN DEPT10.LOC%TYPE)
IS
BEGIN
    INSERT INTO DEPT10(DEPTNO, DNAME, LOC, CREDATE)
    VALUES(DEPT10_SEQ.NEXTVAL, DNAME, LOC, SYSDATE);
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명 / 등록일');
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
    
    FOR VDEPT IN (SELECT DEPTNO, DNAME, LOC, CREDATE FROM DEPT10 ORDER BY DEPTNO) LOOP
        DBMS_OUTPUT.PUT_LINE(VDEPT.DEPTNO||' / '||RPAD(VDEPT.DNAME,10)||' / '||
            VDEPT.LOC||' / '||TO_CHAR(VDEPT.CREDATE,'YYYY-MM-DD'));
    END LOOP;        
END;
/
SHOW ERROR;

-- 프로시저 실행 -> 데이터 입력 코드 짧아짐
EXECUTE DEPTPROC_INMODE('기획부','부산');

SELECT * FROM DEPT10;

-- DEPTPROC_INUP 프로시저 생성
-- 프로시저 실행시 인수로 부서번호, 부서명, 지역명을 얻어 현재 DEPT10 테이블에 부서번호가 존재하면 수정을 실행하고 
-- 부서번호가 존재하지 않는다면 입력을 실행하도록 생성
CREATE OR REPLACE PROCEDURE deptproc_inup
(pdeptno IN dept10.deptno%TYPE,
 pdname IN dept10.dname%TYPE,
 ploc IN dept10.loc%TYPE)
IS
    cnt NUMBER := 0;
    vdept dept10%ROWTYPE;
BEGIN
    SELECT COUNT(*) INTO CNT FROM dept10 WHERE deptno = pdeptno;
    IF cnt = 0 THEN
        INSERT INTO DEPT10(deptno, dname, loc, credate)
        VALUES(pdeptno, pdname, ploc, sysdate);
    ELSE
        UPDATE DEPT10
        SET dname = pdname, loc = ploc, credate = sysdate
        WHERE deptno = pdeptno;
    END IF;
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명 / 등록일');
    DBMS_OUTPUT.PUT_LINE('----------------------------');
    SELECT deptno, dname, loc, credate INTO vdept
    FROM DEPT10 WHERE deptno = pdeptno;
    DBMS_OUTPUT.PUT_LINE(vdept.deptno||' , '||RPAD(vdept.dname,10)||' , '||
    vdept.loc||' , '||TO_CHAR(vdept.credate,'YYYY-MM-DD'));
END;
/
SHOW ERROR;
--프로시저 실행
EXECUTE deptproc_inup(60,'기획부','전주');
EXECUTE deptproc_inup(70,'영업부','서울');

-- (2) OUT MODE 매개변수
-- 프로시저 호출 후 해당 매개변수 값을 받아 사용 가능(출력)
-- 프로시저 내에서 로직 처리 후, 해당 매개변수에 값을 할당해 프로시저 호출 부분에서 이 결과값을 참조할 수 있음

-- 사원 번호로 특정 고객을 조회하기 때문에 사원번호는 IN으로 지정하고 조회해서 얻은 고객의 정보 중 고객의 이름과 급여와 담당 업무를 출력하기 위해 이들은 OUT으로 지정
CREATE OR REPLACE PROCEDURE EMPPROC_OUTMODE
(vemployee_id IN employees.employee_id%TYPE,
 vfirst_name OUT employees.first_name%TYPE,
 vsalary OUT employees.salary%TYPE,
 vjob_id OUT employees.job_id%TYPE)
IS
BEGIN
    SELECT first_name, salary, job_id INTO vfirst_name, vsalary, vjob_id
    FROM employees
    WHERE employee_id = vemployee_id;
END;
/
SHOW ERROR;

-- 익명블록 내 프로시저 호출은 EXECUTE 생략하고 프로시저명만 명시하면 됨
DECLARE
    vemployee employees%ROWTYPE;
BEGIN
    EMPPROC_OUTMODE(120, vemployee.first_name, vemployee.salary, vemployee.job_id);
    DBMS_OUTPUT.PUT_LINE('사원명:'||vemployee.first_name);
    DBMS_OUTPUT.PUT_LINE('급여:'||vemployee.salary);
    DBMS_OUTPUT.PUT_LINE('직무:'||vemployee.job_id);
END;
/

-- 해당 급여를 초과하는 사원들을 커서로 반환받도록 프로시저 생성
CREATE OR REPLACE PROCEDURE EMP_SAL_DATA
(vsalary IN employees.salary%TYPE, 
 vemployees OUT SYS_REFCURSOR) -- 오라클 지정 커서타입의 커서변수 선언
IS
BEGIN
    OPEN vemployees FOR SELECT employee_id, first_name, salary 
    FROM employees
    WHERE salary > vsalary;
END;
/
SHOW ERROR;

-- 프로시저 실행 -> 정렬 방법?
DECLARE
    pemployees SYS_REFCURSOR;
    vemployees employees%ROWTYPE;
BEGIN
    EMP_SAL_DATA(12000, pemployees);
    LOOP
        FETCH pemployees INTO vemployees.employee_id, vemployees.first_name, vemployees.salary;
        EXIT WHEN pemployees%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(vemployees.employee_id||'. '||vemployees.first_name||' '||vemployees.salary);
    END LOOP;    
END;
/

-- <예제> 사원번호(in)을 입력받아 해당 사원의 사원명(out), 급여(out)와 해당 사원이 소속된 부서명(out) 및
-- 부서의 평균 급여(out)를 구하는 프로시저를 작성하여보자(EMPPROC02_OUTMODE).
CREATE OR REPLACE PROCEDURE EMPPROC02_OUTMODE
(vemployee_id IN employees.employee_id%TYPE,
 vfirst_name OUT employees.first_name%TYPE,
 vdepartment_name OUT departments.department_name%TYPE,
 vdepartment_avg_sal OUT NUMBER)
IS
BEGIN
    SELECT ROUND(AVG(salary)) INTO vdepartment_avg_sal
    FROM employees WHERE employee_id = vemployee_id;
    SELECT E.first_name, D.department_name INTO vfirst_name, vdepartment_name 
    FROM employees E INNER JOIN departments D ON E.department_id = D.department_id
    WHERE employee_id = vemployee_id;    
    COMMIT;
END;
/
SHOW ERROR;

DECLARE
    vemployee employees%ROWTYPE;
    vfirst_name employees.first_name%TYPE;
    vdepartment_name departments.department_name%TYPE;
    vdepartment_avg_sal NUMBER;
BEGIN
    EMPPROC02_OUTMODE(145, vfirst_name, vdepartment_name, vdepartment_avg_sal);
    DBMS_OUTPUT.PUT_LINE('사원명 :'||vfirst_name);
    DBMS_OUTPUT.PUT_LINE('부서명 :'||vdepartment_name);
    DBMS_OUTPUT.PUT_LINE('부서평균급여 :'||vdepartment_avg_sal);
END;
/
