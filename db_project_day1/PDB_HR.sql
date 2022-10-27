-- hr ������� ��ü ���̺� ��� Ȯ��
SELECT * FROM tab;
SELECT * FROM departments;
SELECT * FROM employees;

-- desc ���̺� : ���̺��� ������ Ȯ��
DESC employees;
DESC departments;

-- Į�� �̸� ����ؼ� Ư�� Į���� ����
SELECT department_id, department_name FROM departments;
-- <����> ����� �̸��� �޿��� �Ի����ڸ��� ����ϴ� SQL���� �ۼ��غ���
SELECT first_name, last_name, salary, hire_date FROM employees;

-- Į���̸��� ��Ī �����ϱ� : �÷� AS ��Ī  
SELECT department_id AS departmentNo, department_name AS departmentName FROM departments;
-- �ѱ� ��Ī�� ��� ���� : �÷� ��Ī
SELECT department_id �μ���ȣ, department_name �μ��� FROM departments;
-- ��Ī�� ���鹮��, Ư������, ��ҹ��� ������ ǥ���ϱ� ���ؼ��� AS�� �����ϰ� ""�� ���
SELECT department_id "department No", department_name "department Name" FROM departments;

-- Concatenation(����) �������� ���
-- ���� �÷��� �ϳ��� ���ڿ��� ����ϱ�
SELECT first_name||'�� ������ '||job_id||'�Դϴ�' AS ���� FROM employees;
SELECT first_name ||' '||last_name AS �̸�, salary AS �޿�, hire_date AS �Ի��� FROM employees;

-- �ߺ��� �����͸� �ѹ��� ����ϰ� �ϱ� : DISTINCT
SELECT job_id FROM employees;
SELECT DISTINCT job_id FROM employees;
SELECT DISTINCT first_name, job_id FROM employees;
-- <����> �������� � �μ��� �ҼӵǾ� �ִ��� �Ҽ� �μ���ȣ(department_id) ����ϵ� �ߺ������ϴ� ������ �ۼ�����
SELECT DISTINCT department_id FROM employees;

