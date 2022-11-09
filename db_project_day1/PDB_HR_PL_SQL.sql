-- PL/SQL
-- 1. PL/SQL
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World');
END;
/

-- 1. ����
-- 1) ������ �� ����
DECLARE
    val_num NUMBER;
BEGIN
    val_num := 100;
    DBMS_OUTPUT.PUT_LINE(val_num);
END;
/

-- ������ ���� �� �Ҵ��� �ϰ� �� ���� ���� ����Ѵ�
DESC EMPLOYEES; -- ������ �Ҵ��� Į���� �ڷ��� Ȯ��
DECLARE
    VEMPLOYEE_ID NUMBER(6);
    VFIRST_NAME VARCHAR2(20);
BEGIN
    VEMPLOYEE_ID := 105;
    VFIRST_NAME := 'David';
    
    DBMS_OUTPUT.PUT_LINE('��� / �̸�');
    DBMS_OUTPUT.PUT_LINE('----------');
    DBMS_OUTPUT.PUT_LINE(VEMPLOYEE_ID||' / '||VFIRST_NAME);
END;
/
-- 2) ��Į�� ����/ ���۷��� ����
-- (1) ��Į�� : SQL������ �ڷ��� ������ ���� ����
VEMPLOYEE_ID NUMBER(6);
VFIRST_NAME VARCHAR2(20);
-- (2) ���۷��� : %TYPE �Ӽ��� %ROWTYPE �Ӽ�
VEMPLOYEE_ID EMPLOYEES.EMPLOYEE_ID%TYPE;
VFIRST_NAME EMPLOYEES.FIRST_NAME%TYPE;
-- %ROWTYPE : �ο� ���� ����
VEMPLOYEES EMLOYEES%ROWTYPE;

-- 3) PL/SQL���� SQL����
-- ��ȸ�� �÷��� ����� ������ ���Խ� INTO �� ���
DECLARE
    -- %TYPE �Ӽ����� Į�� ������ ������ ������ �� �ִ� ���۷��� ���� ����
    VEMPLOYEE_ID EMPLOYEES.EMPLOYEE_ID%TYPE;
    VFIRST_NAME EMPLOYEES.FIRST_NAME%TYPE; 
BEGIN
    DBMS_OUTPUT.PUT_LINE('��� / �̸�');
    DBMS_OUTPUT.PUT_LINE('----------');
    
    SELECT EMPLOYEE_ID, FIRST_NAME 
    INTO VEMPLOYEE_ID, VFIRST_NAME 
    FROM EMPLOYEES
    WHERE FIRST_NAME = 'Susan';
    
    DBMS_OUTPUT.PUT_LINE(VEMPLOYEE_ID||' / '||VFIRST_NAME);
END;
/

-- ��ü ���ڵ� �����ϱ� ���ؼ��� %rowtype���� ����
DECLARE
    VEMPLOYEES EMPLOYEES%ROWTYPE;
BEGIN
    SELECT * INTO VEMPLOYEES FROM EMPLOYEES
    WHERE FIRST_NAME = 'Lisa';
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ :'||TO_CHAR(VEMPLOYEES.EMPLOYEE_ID));
    DBMS_OUTPUT.PUT_LINE('��   �� :'||VEMPLOYEES.FIRST_NAME);
    DBMS_OUTPUT.PUT_LINE('��   �� :'||VEMPLOYEES.SALARY);
    DBMS_OUTPUT.PUT_LINE('�Ի����� :'||TO_CHAR(VEMPLOYEES.HIRE_DATE,'YYYY-MM-DD'));
END;
/

-- <����> employees ���̺� ��ϵ� �ѻ���� ���� �޿��� ��, �޿��� ����� ������ �����Ͽ� ����Ͽ� ����.
DECLARE
    VEMPLOYEENUM NUMBER;
    VSALARYSUM NUMBER;
    VSALARYAVG NUMBER(10,2);
BEGIN
    SELECT COUNT(EMPLOYEE_ID), SUM(SALARY), ROUND(AVG(SALARY)) 
    INTO VEMPLOYEENUM, VSALARYSUM, VSALARYAVG 
    FROM EMPLOYEES;
    
    DBMS_OUTPUT.PUT_LINE('�ѻ�� �� : '||VEMPLOYEENUM);
    DBMS_OUTPUT.PUT_LINE('�޿��� �� : '||VSALARYSUM);
    DBMS_OUTPUT.PUT_LINE('�޿��� ��� : '||VSALARYAVG);
END;
/

-- <����> Jack ����� ����, �޿�, �Ի�����, �μ����� ������ �����Ͽ� ����Ͽ� ����.
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
    
    DBMS_OUTPUT.PUT_LINE('���� : '||JOB);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||SAL);
    DBMS_OUTPUT.PUT_LINE('�Ի����� : '||HIREDATE);
    DBMS_OUTPUT.PUT_LINE('�μ��� : '||DEPARTNAME);
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
    
    DBMS_OUTPUT.PUT_LINE('���� : '||VEMPLOYEES.JOB_ID);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||VEMPLOYEES.SALARY);
    DBMS_OUTPUT.PUT_LINE('�Ի����� : '||VEMPLOYEES.HIRE_DATE);
    DBMS_OUTPUT.PUT_LINE('�μ��� : '||VDEPARTMENTS.DEPARTMENT_NAME);
END;
/

-- <����> ��� ���̺�(employees01)���� �����ȣ�� ���� ū ����� ã�Ƴ� ��, �� ��ȣ +3������ �Ʒ��� ����� ������̺� �ű� �Է��ϴ� PL/SQL�� ����� ����.

