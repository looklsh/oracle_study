--Guestbook
CREATE TABLE guestbook(
    no number primary key,
    name varchar2(20) NOT NULL,
    password varchar2(20) NOT NULL,
    content VARCHAR2(256) NOT NULL,
    regdate date DEFAULT SYSDATE
    );
    
    CREATE SEQUENCE seq_guestbook_no
        start with 1
        increment by 1;
        
    INSERT INTO guestbook (no,name,password,content)
    VALUES(seq_guestbook_no.nextval, '방문자', 'test', '테스트 방명록입니다.');
    
    select * from guestbook;
    commit;