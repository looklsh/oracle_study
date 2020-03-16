create table mvc_board(
bId number(4) PRIMARY KEY,
bName varchar2(20),
bTitle varchar2(100),
bContent varchar2(300),
bDate date default SYSDATE,
bHit number(4) default 0,
bGroup number(4),
bStep number(4),
bIndent number(4)
);

commit;

create sequence mvc_board_seq;

commit;

select * from mvc_board;