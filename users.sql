--Users 테이블 만들기
CREATE TABLE members(
    no number primary key,
    name varchar2(20) NOT NULL,
    email VARCHAR2(128) NOT NULL,
    password VARCHAR2(20) NOT NULL,
    gender char(1) default 'M'
        check (gender in ('M', 'F')),
    joindate date default sysdate
);

--시퀀스 생성
CREATE SEQUENCE seq_members_no;

select * from members;

delete from members;
commit;
