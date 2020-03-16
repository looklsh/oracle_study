-- phonebookoracle 과제를 위한 sql
create table PHONE_BOOK (
    id number(10) primary key,
    name VARCHAR2(10),
    hp VARCHAR2(20),
    tel VArCHAR2(20)
    );
    
    create sequence seq_phone_book;
    
    select * from phone_book;
    
select * from user_sequences;

INSERT INTO PHONE_BOOK
VALUES(seq_phone_book.nextval, '고길동', '010-1234-5678', '02-9876-5432');

DELETE
FROM PHONE_BOOK
WHERE name = '고길동';

commit;
 
----------------------------------------------------------------------------------------
