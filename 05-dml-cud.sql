--09/24����

--INSERT
--AUTHOR ���̺� ���� Ȯ��
DESC author;

--INSERT : �� ���ڵ� �߰�
--��� �÷� �����͸� �ϰ� �Է� �Ϸ��� ���̺��� �÷� ������ �°� ������ �Է�
INSERT INTO author
VALUES (1, '�ڰ渮', '�����۰�');
--Ư�� �÷��� �����ؼ� �����͸� �Է��� ��� �÷��� ����� ����
INSERT INTO author (author_id, author_name)
VALUES(2, '�迵��');
--INSERT, UPDATE, DELETE�� Ʈ�������� ���,
--�Ϸ�Ǳ� �������� ����ڴ� ���� ���뤷�� �� ������
COMMIT;

DESC BOOK;
INSERT INTO book
VALUES(1, '����', Sysdate, 1);

INSERT INTO book (book_id, title, author_id)
VALUES(2, '�������� ����', 2);

SELECT * FROM book;
ROLLBACK; --���� ���� ������� ����
SELECT * FROM book;

--UPDATE
--�迵�� �۰��� �۰� �Ұ��� �����غ��ô�
UPDATE author
SET author_desc='�˶���� �⿬';

SELECT * FROM author;
ROLLBACK;

--UPDETE DELETE ���� DML�� WHERE���� ������ ��ü ���ڵ� ����
--�׻� ����
UPDATE author
SET author_desc='�˶���� �⿬'
where author_id=2;

SELECT * FROM author;
COMMIT;

--hr.employees���̺�κ� myemp ���̺� ������
CREATE table myemp AS
    (SELECT * FROM hr.EMPLOYEES); 
    
DESC myemp;
SELECT * FROM myemp;

--DELETE : WHERE���� �������� ������ ��ü ���ڵ尡 �����ǹǷ� ���� ����
DELETE FROM myemp
WHERE employee_id=100;

SELECT * FROM myemp;
ROLLBACK;

--DELETE TRUNCATE����
DELETE FROM myemp; --����Ʈ�� ���� ���ڵ带 �����ϰ� ���� ����� �α׷� ����
                    --rollback ����
SELECT * FROM myemp;
ROLLBACK;
TRUNCATE TABLE myemp;--�ѹ� �Ұ�
ROLLBACK;

--