-- APEX PORT ����
-- APEX HTTPPORTȮ��
SELECT DBMS_XDB.GETHTTPPORT() FROM DUAL;
-- APEX ��Ʈ ����(apache Tomcat ������)
EXEC DBMS_XDB.SETHTTPPORT(8090);

-- hr ���� ��� �����ϰ�(unlock)
SELECT username, account_status FROM DBA_USERS
    WHERE username='HR';
--hr���� ��� ����
ALTER USER hr IDENTIFIED BY hr ACCOUNT unlock;