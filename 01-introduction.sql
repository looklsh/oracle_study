-- APEX PORT 변경
-- APEX HTTPPORT확인
SELECT DBMS_XDB.GETHTTPPORT() FROM DUAL;
-- APEX 포트 변경(apache Tomcat 때문에)
EXEC DBMS_XDB.SETHTTPPORT(8090);

-- hr 계정 사용 가능하게(unlock)
SELECT username, account_status FROM DBA_USERS
    WHERE username='HR';
--hr계정 잠금 해제
ALTER USER hr IDENTIFIED BY hr ACCOUNT unlock;