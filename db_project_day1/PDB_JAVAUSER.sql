-- 학생테이블 생성
CREATE TABLE STUDENT(
    NO NUMBER(2) NOT NULL,                  -- 일련번호
    SD_NUM CHAR(8) NOT NULL,                -- 학번
    SD_NAME VARCHAR2(12) NOT NULL,          -- 이름
    SD_ID VARCHAR2(10) NOT NULL,            -- 아이디
    SD_PASSWD VARCHAR2(20) NOT NULL,        -- 비밀번호
    S_NUM CHAR(2) NOT NULL,                 -- 학과번호
    SD_BIRTH VARCHAR2(20) NOT NULL,         -- 생년월일
    SD_PHONE CHAR(13) NOT NULL,             -- 핸드폰
    SD_ADDRESS VARCHAR2(20 CHAR) NOT NULL,  -- 주소
    SD_EMAIL VARCHAR2(30) NOT NULL,         -- 이메일
    SD_DATE DATE NOT NULL,                  -- 등록일자
    CONSTRAINT STUDENT_NO_UK UNIQUE(NO)
);
INSERT INTO STUDENT
VALUES(1,06010001,'김정수','javajsp','1234','01','19920514','010-1234-1234','서울시 서대문구 창전동','kjs@gmail.com',SYSDATE);
INSERT INTO STUDENT
VALUES(2,95010002,'김수현','jdbcmania','1234','01','19840403','010-1234-1234','서울시 서초구 양재동','ksh@gmail.com',SYSDATE);
INSERT INTO STUDENT
VALUES(3,98040001,'공지영','gonji','1234','04','19870506','010-1234-1234','부산광역시 해운대구 반송동','kjy@gmail.com',SYSDATE);
INSERT INTO STUDENT
VALUES(4,02050001,'조수영','water','1234','05','19801213','010-1234-1234','대전광역시 중구 은행동','jsy@gmail.com',SYSDATE);
INSERT INTO STUDENT
VALUES(5,94040002,'최경란','novel','1234','04','19760708','010-1234-1234','경기도 수원시 장안구 이목동','ckr@gmail.com',SYSDATE);
INSERT INTO STUDENT
VALUES(6,08020001,'안익태','korea','1234','02','19881104','010-1234-1234','서울시 역삼동','ait@gmail.com',SYSDATE);
SELECT * FROM STUDENT;

-- 과목테이블 생성
CREATE TABLE LESSON(
    NO NUMBER(2) NOT NULL,              -- 일련번호
    L_ABBRE VARCHAR2(20) NOT NULL,      -- 과목약어
    L_NAME VARCHAR2(20) NOT NULL,       -- 과목명
    CONSTRAINT LESSON_NO_UK UNIQUE(NO)
);
SELECT * FROM LESSON;

-- 학과테이블 생성
CREATE TABLE SUBJECT(
    NO NUMBER(2) NOT NULL,                                    -- 일련번호
    S_NUM CHAR(2) CHECK(S_NUM IN('01','02','03','04','05')),  -- 학과번호
    S_NAME VARCHAR2(20) NOT NULL,                             -- 학과명
    CONSTRAINT SUBJECT_NO_UK UNIQUE(NO),                      -- 오류 : 이 열목록에 대해 일치하는 고유 또는 기본 키가 없습니다.
    CONSTRAINT SUBJECT_S_NUM_FK FOREIGN KEY(S_NUM) REFERENCES STUDENT(S_NUM)
);
DROP TABLE SUBJECT;
SELECT * FROM ALL_CONS_COLUMNS;

-- 수강테이블 생성
CREATE TABLE TRAINEE(
    NO NUMBER(2) PRIMARY KEY,                                               -- 일련번호, 오류 : 이 열목록에 대해 일치하는 고유 또는 기본 키가 없습니다.
    SD_NUM CHAR(8) NOT NULL,                                                -- 학번
    L_ABBRE VARCHAR2(20) NOT NULL,                                          -- 과목약어
    T_SECTION VARCHAR2(10) CHECK(T_SECTION IN('CULTURE','MAJOR','MINOR')),  -- 과목구분
    T_DATE DATE DEFAULT SYSDATE,                                            -- 등록일자
    CONSTRAINT TRAINEE_SD_NUM_FK FOREIGN KEY(SD_NUM) REFERENCES STUDENT(SD_NUM), 
    CONSTRAINT TRAINEE_L_ABBRE_FK FOREIGN KEY(L_ABBRE) REFERENCES SUBJECT(L_ABBRE)
);
