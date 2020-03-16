--����� ����
--system�������� ����

--bituser���� bituser��й�ȣ ����

CREATE USER bituser IDENTIFIED BY bituser;
--������� ����: drop user
DROP USER bituser CASCADE;
--�ٽ� �����ô�
CREATE USER bituser IDENTIFIED BY bituser;

conn bituser/bituser; --login �õ�
--���� �߻�: ����� ����, ������ ���� ->�α��� �ȵ�

--����� ���� Ȯ��
--USER_USERS : ���� ����� ���� ����
--ALL_USERS: DB�� ��� ������� ����
--DBA_USERS: DB�� ��� ������� ������
SHOW user

DESC USER_USERS;
--USER_USERS (���� �����)�� USERNAME�� ���� ����Ȯ��
SELECT username, account_status FROM USER_USERS;
DESC ALL_USERS;
SELECT USERNAME, created FROM ALL_USERS
WHERE username='BITUSER';
DESC DBA_USERS;
SELECT username, account_status
FROM DBA_USERS
WHERE USERNAME='BITUSER';

--FRANT/REVOKE
--����� BIUSER���� ���ӱ����� �ݽô�
GRANT create session TO bituser;
--bituser�� �α���
conn bituser/bituser
SHOW user
--�Ϲ������� CONNECT,RESOURCE ����
--�ο��Ǿ�� �����ͺ��̽��� ����
--���̺��� ����� ����� �� �ִ�
GRANT connect, resource TO bituser;

--hr ��Ű���� employees���̺��� select������
--�Ф��Ǥ���dprp qndu
GRANT SELECT ON hr.employees TO bituser;
GRANT SELECT ON hr.departments TO bituser;

--���Ŀ��� bituser�� �α����ؼ� �ǽ��� ������ ��ȹ
SHOW user

--BOOK ���̺� ����
--BOOK_ID, TITLE, AUTHOR, PUB_DATE
CREATE TABLE book(
    book_id NUMBER(5),
    title  VARCHAR2(50),
    author varchar2(10),
    pub_date DATE DEFAULT sysdate
);
--�ڽ��� ���̺� ��� Ȯ���غ���
SELECT * FROM tab;
--book���̺��� ���� Ȯ��
DESC BOOK;

--�̹� �����ϴ� ���̺��� ������� �� ���̺��� ����
SELECT * FROM hr.employees;
--job_id�� IT���õ� �������� �� ���̺�� ������
SELECT  *  FROM hr.employees 
WHERE job_id LIKE 'IT_%';

CREATE TABLE it_emps AS(
--SUBQUERY
    SELECT * FROM hr.employees
    WHERE job_id LIKE 'IT_%'
);

SELECT * FROM tab;

SELECT * FROM it_emps;

--���̺� ����: DROP TABLE
DROP TABLE it_emps;


--author ���̺� �ļ�
--author_id :10�ڸ� ����
--author_name: 100�ڸ� �������ڿ�
--author_desc: 500�ڸ� ���� ���ڿ�
--��������
--author_id : pk
--author_name: not null
CREATE TABLE author(
    author_id NUMBER(10),
    author_name VARCHAR2(100) NOT NULL,
    author_desc VARCHAR2(500),
    PRIMARY KEY (author_id)
);
DESC author;
--BOOK���̺� �� author Į������
--���߿� author�� author_ID�Ϳ���
ALTER TABLE book
DROP COLUMN author;
DESC book;
--author���̺��� author_id�� �����ų
--author_id �÷� �߰�
ALTER TABLE book
    ADD (author_id NUMBER(10));
DESC book;
--book���̺� book_id�� number(10)
--primary key�Ӽ� �߰�
ALTER TABLE book
MODIFY(book_id NUMBER(10));
DESC book;
--�������� �ο� 
ALTER TABLE book
ADD CONSTRAINT pk_book_id PRIMARY KEY (book_id); 
DESC book;
--book ���̺��� author_id �÷��� foreign key�߰�
--author���̺��� author_id �÷� ����
ALTER TABLE book
ADD CONSTRAINT fk_author_id FOREIGN KEY(author_id)
    REFERENCEs author(author_id);
DESC book; 

--data dictionaryȮ��
SELECT * FROM DICTIONARY;

--����� ��ü Ȯ��
SELECT * FROM user_objects;
--�������� Ȯ��
SELECT * FROM user_constraints;
--book���̺��� �������� Ȯ��
SELECT constraint_name,
    constraint_type,
    search_condition
FROM user_constraints
WHERE table_name='BOOK';



