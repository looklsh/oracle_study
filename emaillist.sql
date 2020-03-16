--�̹� �ִ� ���̺� ����
DROP TABLE emillist;
--�̹� �ִ� ������ ����
DROP SEQUENCE seq_emaillist_pk;

--���̺� ����
CREATE TABLE emaillist(
    no number primary key,
    last_name varchar2(20),
    first_name varchar2(20),
    email varchar2(128),
    created_at date default sysdate
    );
    
--������ ����
CREATE SEQUENCE seq_emaillist_pk;

--������ �Է�
INSERT INTO emaillist
values(
    seq_emaillist_pk.nextval,
    '��',
    '����',
    'looklsh@hanmail.net',
    sysdate);
    
    commit;
    
--������ Ȯ��
select * from emaillist;
    