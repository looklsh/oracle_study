--이미 있는 테이블 삭제
DROP TABLE emillist;
--이미 있는 시퀀ㅅ 삭제
DROP SEQUENCE seq_emaillist_pk;

--테이블 생성
CREATE TABLE emaillist(
    no number primary key,
    last_name varchar2(20),
    first_name varchar2(20),
    email varchar2(128),
    created_at date default sysdate
    );
    
--시퀀스 생성
CREATE SEQUENCE seq_emaillist_pk;

--데이터 입력
INSERT INTO emaillist
values(
    seq_emaillist_pk.nextval,
    '이',
    '승휘',
    'looklsh@hanmail.net',
    sysdate);
    
    commit;
    
--데이터 확인
select * from emaillist;
    