--사용자 생성
--system계정으로 수행

--bituser계정 bituser비밀번호 생성

CREATE USER bituser IDENTIFIED BY bituser;
--사용자의 삭제: drop user
DROP USER bituser CASCADE;
--다시 만들어봅시다
CREATE USER bituser IDENTIFIED BY bituser;

conn bituser/bituser; --login 시도
--오류 발생: 사용자 생성, 권한이 없음 ->로그인 안됨

--사용자 정보 확인
--USER_USERS : 현재 사용자 관련 정보
--ALL_USERS: DB내 모든 사용자의 정보
--DBA_USERS: DB내 모든 사용자의 상세정보
SHOW user

DESC USER_USERS;
--USER_USERS (현재 사용자)의 USERNAME과 계정 상태확인
SELECT username, account_status FROM USER_USERS;
DESC ALL_USERS;
SELECT USERNAME, created FROM ALL_USERS
WHERE username='BITUSER';
DESC DBA_USERS;
SELECT username, account_status
FROM DBA_USERS
WHERE USERNAME='BITUSER';

--FRANT/REVOKE
--사용자 BIUSER에게 접속권한을 줍시다
GRANT create session TO bituser;
--bituser로 로그인
conn bituser/bituser
SHOW user
--일반적으로 CONNECT,RESOURCE 역할
--부여되어야 데이터베이스에 접속
--테이블을 만들고 사용할 수 있다
GRANT connect, resource TO bituser;

--hr 스키마의 employees테이블의 select권한을
--ㅠㅑ션ㄷㄱdprp qndu
GRANT SELECT ON hr.employees TO bituser;
GRANT SELECT ON hr.departments TO bituser;

--향후에는 bituser로 로그인해서 실습을 진행할 계획
SHOW user

--BOOK 테이블 새성
--BOOK_ID, TITLE, AUTHOR, PUB_DATE
CREATE TABLE book(
    book_id NUMBER(5),
    title  VARCHAR2(50),
    author varchar2(10),
    pub_date DATE DEFAULT sysdate
);
--자신의 테이블 목록 확인해보자
SELECT * FROM tab;
--book테이블의 구조 확인
DESC BOOK;

--이미 존재하는 테이블을 기반으로 새 테이블을 생성
SELECT * FROM hr.employees;
--job_id가 IT관련된 직원들을 새 테이블로 만들어보자
SELECT  *  FROM hr.employees 
WHERE job_id LIKE 'IT_%';

CREATE TABLE it_emps AS(
--SUBQUERY
    SELECT * FROM hr.employees
    WHERE job_id LIKE 'IT_%'
);

SELECT * FROM tab;

SELECT * FROM it_emps;

--테이블 삭제: DROP TABLE
DROP TABLE it_emps;


--author 테이블 셍성
--author_id :10자리 숫자
--author_name: 100자리 가변문자열
--author_desc: 500자리 가변 문자열
--제약존건
--author_id : pk
--author_name: not null
CREATE TABLE author(
    author_id NUMBER(10),
    author_name VARCHAR2(100) NOT NULL,
    author_desc VARCHAR2(500),
    PRIMARY KEY (author_id)
);
DESC author;
--BOOK테이블 내 author 칼럼삭제
--나중에 author의 author_ID와연결
ALTER TABLE book
DROP COLUMN author;
DESC book;
--author테이블의 author_id와 연결시킬
--author_id 컬럼 추가
ALTER TABLE book
    ADD (author_id NUMBER(10));
DESC book;
--book테이블 book_id를 number(10)
--primary key속성 추가
ALTER TABLE book
MODIFY(book_id NUMBER(10));
DESC book;
--제약조건 부여 
ALTER TABLE book
ADD CONSTRAINT pk_book_id PRIMARY KEY (book_id); 
DESC book;
--book 테이블의 author_id 컬럼에 foreign key추가
--author테이블의 author_id 컬럼 참조
ALTER TABLE book
ADD CONSTRAINT fk_author_id FOREIGN KEY(author_id)
    REFERENCEs author(author_id);
DESC book; 

--data dictionary확인
SELECT * FROM DICTIONARY;

--사용자 객체 확인
SELECT * FROM user_objects;
--제약조건 확인
SELECT * FROM user_constraints;
--book테이블의 제약조건 확인
SELECT constraint_name,
    constraint_type,
    search_condition
FROM user_constraints
WHERE table_name='BOOK';



