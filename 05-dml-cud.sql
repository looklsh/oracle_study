--09/24수업

--INSERT
--AUTHOR 테이블 구조 확인
DESC author;

--INSERT : 세 레코드 추가
--모든 컬럼 데이터를 일괄 입력 하려면 테이블의 컬럼 구조에 맞게 데이터 입력
INSERT INTO author
VALUES (1, '박경리', '토지작가');
--특정 컬럼을 지정해서 데이터를 입력할 경우 컬럼의 목록을 제시
INSERT INTO author (author_id, author_name)
VALUES(2, '김영하');
--INSERT, UPDATE, DELETE는 트랜젝션의 대상,
--완료되기 전까지는 사용자는 변경 내용ㅇ을 볼 수없다
COMMIT;

DESC BOOK;
INSERT INTO book
VALUES(1, '토지', Sysdate, 1);

INSERT INTO book (book_id, title, author_id)
VALUES(2, '살인자의 기억법', 2);

SELECT * FROM book;
ROLLBACK; --변경 사항 원래대로 복구
SELECT * FROM book;

--UPDATE
--김영하 작가의 작가 소개를 변경해봅시다
UPDATE author
SET author_desc='알뜰신잡 출연';

SELECT * FROM author;
ROLLBACK;

--UPDETE DELETE 등의 DML은 WHERE절이 없으면 전체 레코드 병경
--항상 주의
UPDATE author
SET author_desc='알뜰신잡 출연'
where author_id=2;

SELECT * FROM author;
COMMIT;

--hr.employees테이블로붙 myemp 테이블 만들자
CREATE table myemp AS
    (SELECT * FROM hr.EMPLOYEES); 
    
DESC myemp;
SELECT * FROM myemp;

--DELETE : WHERE절을 지정하지 않으면 전체 레코드가 삭제되므로 주의 하자
DELETE FROM myemp
WHERE employee_id=100;

SELECT * FROM myemp;
ROLLBACK;

--DELETE TRUNCATE차이
DELETE FROM myemp; --딜리트는 개별 레코드를 삭제하고 삭제 기록을 로그로 보관
                    --rollback 가능
SELECT * FROM myemp;
ROLLBACK;
TRUNCATE TABLE myemp;--롤백 불가
ROLLBACK;

--