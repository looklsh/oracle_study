--board ���̺�(��ȣ �ʿ����)
CREATE TABLE board(
    no number primary key,
    title varchar2(128) NOT NULL,
     content varchar2(255) NOT NULL,
     hit number default 0,
     regdate date DEFAULT SYSDATE,
     member_no number NOT NULL
     );
     
     
--����� member_no�� FK�� ��ƾ� ������
--���⼭�� �� ������ �����ϵ��� �մϴ�

CREATE SEQUENCE seq_board_no;

--��� Ȯ��
SELECT * FROM members;

--�Խù� �Ѱ� �ۼ�
INSERT INTO board
(no, title, content, member_no)
VALUES
(seq_board_no.nextval, 'ù ��° �Խù�', 'ù��° �Խù��Դϴ�', 4);
commit;

select * from board;