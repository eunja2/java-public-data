-- ����� ���� ����
-- DBA�� ����ڸ� ������ �� �ִ�. �׷��� �ְ������(SYSDBA)�� SYS�� ����
-- CREATE USER ����ڸ� IDENTIFIED BY ��й�ȣ;
CREATE USER javauser IDENTIFIED BY java1234;

-- ����� ���� �ο�
-- ����Ŭ�� ����� ������ ��� ���ѵ� ������ ���� �ʱ⿡ ���� �ο��� ���־�� �Ѵ�.
-- GRANT ���� TO ����ڸ�;
GRANT CREATE SESSION TO javauser; -- ���� ���� �� ���� �ְ�
GRANT CONNECT, RESOURCE TO javauser; -- �ѷ� ���� �ο��� �� ����
ALTER USER javauser 
DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

-- CONNECT �ѿ� ���Ե� ���� - CREATE SESSION ������ ������ �ش� ������ ������ ���� ����
SELECT * FROM role_sys_privs
WHERE role = 'CONNECT';

-- RESOURCE �ѿ� ���Ե� ����
-- CREATE Ʈ����, ������, Ÿ��, ���ν���, ���̺� �� 8���� ������ �ο��Ǿ� ����
SELECT * FROM role_sys_privs
WHERE role = 'RESOURCE';

-- ���� JAVAUSER���� �ο��� �� Ȯ��
SELECT * FROM dba_role_privs
WHERE GRANTEE = 'JAVAUSER';

-- Ȥ�� ������ ���� �Ǹ� Ȯ���ϱ� ���� ������
SELECT username, account_status, lock_date FROM dba_users
WHERE username = 'JAVAUSER';

-- ��� ����
ALTER USER javauser
ACCOUNT UNLOCK;

-- ��й�ȣ ����
ALTER USER javauser IDENTIFIED BY java1234;