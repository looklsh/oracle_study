--board 테이블(암호 필요없고)
CREATE TABLE board(
    no number primary key,
    title varchar2(128) NOT NULL,
     content varchar2(255) NOT NULL,
     hit number default 0,
     regdate date DEFAULT SYSDATE,
     member_no number NOT NULL
     );
     
     
--사실은 member_no를 FK로 잡아야 하지만
--여기서는 이 과정은 무시하도록 합니다

CREATE SEQUENCE seq_board_no;

--멤버 확인
SELECT * FROM members;

--게시물 한개 작성
INSERT INTO board
(no, title, content, member_no)
VALUES
(seq_board_no.nextval, '첫 번째 게시물', '첫번째 게시물입니다', 4);
commit;

select * from board;