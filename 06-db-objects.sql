--VIEW ����
DESC myemp;
SELECT * FROM myemp;
--��� ���̺� ����
DROP TABLE myemp;
CREATE TABLE myemp
AS SELECT * FROM hr.employees;
SELECT * FROM myemp;

--view����
--view ������ ���ؼ��� create view������ �־�� �Ѵ�
--system, sys��������
--grant create vieew to bituser
--department_id=10�� ������ ���
CREATE OR REPLACE VIEW myemp_10
AS SELECT employee_id, first_name, last_name, hire_date, salary
    FROM myemp
    WHERE department_id=10;
    --���� ���̺��� �ܼ� �÷��� ������� �ۻ�� view:simpleview
    --simple view�� �������ǿ� �ɸ��� ������ insert,update,delete����
    --view�� �Ϲ� tableó�� select�� ���ִ�
SELECT * FROM myemp_10;

UPDATE myemp_10 SET salary = salary * 2;
--�����ϸ� view�� read only(��ȸ����)�� ����ϵ��� �սô�

CREATE OR REPLACE VIEW myemp_10
AS SELECT employee_id, first_name, last_name, salary
    FROM myemp
    WHERE department_id=10
WITH READ ONLY; --�Ф��� ����view����

UPDATE myemp_10 SET salary = salary * 2;
--read only view�� insert, update, delete�Ұ�

--complex view
--�ΰ� �̻��� ���̺� Ȥ�� view�� ������� ����
--ǥ����, �Լ��� �����ϱ⵵ ��
--book���̺� autor���̺��� join�ؼ� book_detail view����
CREATE OR REPLACE VIEW book_detail
    (book_id, title, author_id, pub_date)
    AS SELECT book_id, title, author_name, pub_date
        FROM book b, author a
        WHERE b.author_id = a.author_id;
DESC book_detail;

SELECT * FROM book_detail;
SELECT *FROM book;

INSERT INTO book
VALUES(1,'����', sysdate, 1);
INSERT INTO book
VALUES(2, '�������� ����', sysdate, 2);
COMMIT;

SELECT * FROM book_detail;
--complex view�� �⺻������ insert, update, delete�� ������� ����

--view�� ���� dictionary
SELECT * FROM user_views;

--user_objects�� �̿��� viewȮ��
SELECT object_name, status, object_type FROM user_objects
WHERE object_type='VIEW';

--view�����
DROP VIEW myemp_10;
SELECT * FROM user_views;

--INDEX:���� ���� ����� ���� ���
select * from myemp;
--my emp���̺��� employee_id�÷��� unique �ε����� ������
create unique index myemp_id_unique
on myemp(employee_id);
create index myemp_dept_id
on myemp(department_id);

--����ڰ� ������ �ִ� indexȮ��
select * from user_indexes;
--��� �÷��� �ε����� �ִ��� Ȯ��
select * from user_ind_columns;

--��� �ε����� ��� �÷��� �ɷ� �ִ��� join�ؼ� Ȯ��
select t.index_name, c.column_name, c.column_position
from user_indexes t, user_ind_columns c
where t.index_name = c.index_name
    and t.table_name='MYEMP';
    
--index����
drop index myemp_dept_id;
drop index myemp_id_unique;

select * from user_indexes;

--sequence: ������ �������� �߻���Ű�� ��ü
select * from author;

--���ο� author���ڵ带 �߰��Ѵٰ� ����
--pk �ߺ� ������ ���ؼ� author_id�� ���� ū ���� Ȯ��
select max(author_id)+1 max_id FROM author;


--���ο� author�� �߰��� ���ô�
insert into author (author_id, author_name)
values((select max(author_id)+1 FROM author), '��Ƽ�� ŷ');
select * from author;
commit;
--�� ����� �������� ����

--sequence�� ���� primary key�� �����Ҷ� Ȱ��

--�� ������ ���� ����
create sequence test_seq
    start with 1
    increment by 1
    maxvalue 10;
    
--���������� ���� �޾ƿ� ���ô�
select test_seq.nextval from dual; --�� �� ����
select test_seq.currval from dual;
select test_seq.nextval from dual;

--������ �����غ��ô�
alter sequence teat_seq
    increment by 3 --������3
    maxvalue 1000000;

select test_seq.nextval from dual;

--����� ������ Ȯ��
select * from user_sequence;
select * from user_objects
where object_type='SEQUENCE';

--AUTHOR�� pk�� ���� seq�ۼ�
select max(author_id) from author;
create sequence seq_author_pk
    start with 4
    increment by 1;
    
--sequence�� Ȱ���� ���ڵ��� �߰�
insert into author (author_id, author_name)
values(seq_author_pk.nextval, '���ù�');
select * from author;
commit;

--book���̺��� pk�� ���� sequence ����
select max(book_id) from book;
create sequence seq_book_pk
    start with 3
    increment by 1;
select * from user_sequences;

--������ ����
drop sequence test_seq;

-------------------------------------------------------------
--9/25����
DESC author;
