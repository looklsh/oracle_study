CREATE TABLE users(
    no number primary key,
    name varchar2(20) not null,
    password varchar2(20) not null,
    email varchar2(120) unique not null,
    gender char(1) not null check(gender in ('M', 'F')),
    created_at date default sysdate);
    
CREATE SEQUENCE seq_user_pk;   

COMMIT;

select * from users;

delete from users;
commit;




    
    