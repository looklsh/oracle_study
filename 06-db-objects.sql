--VIEW 생성
DESC myemp;
SELECT * FROM myemp;
--기반 테이블 생성
DROP TABLE myemp;
CREATE TABLE myemp
AS SELECT * FROM hr.employees;
SELECT * FROM myemp;

--view생성
--view 생성을 위해서는 create view권한이 있어야 한다
--system, sys계정으로
--grant create vieew to bituser
--department_id=10인 직원들 목록
CREATE OR REPLACE VIEW myemp_10
AS SELECT employee_id, first_name, last_name, hire_date, salary
    FROM myemp
    WHERE department_id=10;
    --단일 테이블의 단순 컬럼의 목록으로 작상된 view:simpleview
    --simple view는 제약조건에 걸리지 않으면 insert,update,delete가능
    --view는 일반 table처럼 select할 수있다
SELECT * FROM myemp_10;

UPDATE myemp_10 SET salary = salary * 2;
--가능하면 view는 read only(조회전용)로 사용하도록 합시다

CREATE OR REPLACE VIEW myemp_10
AS SELECT employee_id, first_name, last_name, salary
    FROM myemp
    WHERE department_id=10
WITH READ ONLY; --읽ㄱ기 전용view생성

UPDATE myemp_10 SET salary = salary * 2;
--read only view는 insert, update, delete불가

--complex view
--두개 이상의 테이블 혹은 view를 기반으로 생성
--표현식, 함수를 포함하기도 함
--book테이블 autor테이블을 join해서 book_detail view생성
CREATE OR REPLACE VIEW book_detail
    (book_id, title, author_id, pub_date)
    AS SELECT book_id, title, author_name, pub_date
        FROM book b, author a
        WHERE b.author_id = a.author_id;
DESC book_detail;

SELECT * FROM book_detail;
SELECT *FROM book;

INSERT INTO book
VALUES(1,'토지', sysdate, 1);
INSERT INTO book
VALUES(2, '살인자의 기억법', sysdate, 2);
COMMIT;

SELECT * FROM book_detail;
--complex view는 기본적으로 insert, update, delete를 허용하지 않음

--view를 위한 dictionary
SELECT * FROM user_views;

--user_objects를 이용한 view확인
SELECT object_name, status, object_type FROM user_objects
WHERE object_type='VIEW';

--view지우기
DROP VIEW myemp_10;
SELECT * FROM user_views;

--INDEX:쿼리 성능 상승을 위해 사용
select * from myemp;
--my emp테이블의 employee_id컬럼에 unique 인덱스를 만들어보자
create unique index myemp_id_unique
on myemp(employee_id);
create index myemp_dept_id
on myemp(department_id);

--사용자가 가지고 있는 index확인
select * from user_indexes;
--어느 컬럼에 인덱스가 있는지 확인
select * from user_ind_columns;

--어느 인덱스가 어느 컬럼에 걸려 있는지 join해서 확인
select t.index_name, c.column_name, c.column_position
from user_indexes t, user_ind_columns c
where t.index_name = c.index_name
    and t.table_name='MYEMP';
    
--index제거
drop index myemp_dept_id;
drop index myemp_id_unique;

select * from user_indexes;

--sequence: 유일한 정수값을 발생시키는 객체
select * from author;

--새로운 author레코드를 추가한다고 가정
--pk 중복 방지를 위해서 author_id의 가장 큰 값을 확인
select max(author_id)+1 max_id FROM author;


--새로운 author를 추가해 봅시다
insert into author (author_id, author_name)
values((select max(author_id)+1 FROM author), '스티븐 킹');
select * from author;
commit;
--이 방식은 안전하지 않음

--sequence를 만들어서 primary key를 생성할때 활용

--새 시퀀스 만들어서 연습
create sequence test_seq
    start with 1
    increment by 1
    maxvalue 10;
    
--시퀀스에서 값을 받아와 봅시다
select test_seq.nextval from dual; --새 값 생성
select test_seq.currval from dual;
select test_seq.nextval from dual;

--시퀀스 변경해봅시다
alter sequence teat_seq
    increment by 3 --증가밧3
    maxvalue 1000000;

select test_seq.nextval from dual;

--사용자 시퀀스 확인
select * from user_sequence;
select * from user_objects
where object_type='SEQUENCE';

--AUTHOR의 pk를 위한 seq작성
select max(author_id) from author;
create sequence seq_author_pk
    start with 4
    increment by 1;
    
--sequence를 활용한 레코드의 추가
insert into author (author_id, author_name)
values(seq_author_pk.nextval, '유시민');
select * from author;
commit;

--book테이블의 pk를 위한 sequence 생성
select max(book_id) from book;
create sequence seq_book_pk
    start with 3
    increment by 1;
select * from user_sequences;

--시퀀스 삭제
drop sequence test_seq;

-------------------------------------------------------------
--9/25수업
DESC author;
