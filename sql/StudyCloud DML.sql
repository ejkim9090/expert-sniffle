-- desc MEMBER; 
-- SELECT * FROM MEMBER;
-- 예시
-- insert into MEMBER values('아이디','비밀번호','이름','전화번호','이메일', DEFAULT , '계정권한', '가입구분');
Insert Into Member values('admin1','1234','admin','123456','1234@ccc', 1 , 'ROLE_ADMIN', null);
Insert Into Member values('admin2','5678','admin','123456','1234@ccc', 1 , 'ROLE_ADMIN', null);
Insert Into Member values('user1','1234','admin','123456','1234@ccc', 1 , 'ROLE_USER', null);
Insert Into Member values('user2','1234','admin','123456','1234@ccc', 0 , 'ROLE_USER', null);
Insert Into Member values('KAKAO_soub0713@naver.com',NULL,'snsuser','123456','soub0713@naver.com', 1 , 'ROLE_USER', 'kakao');
-- update MEMBER set MEM_PASSWD = '비밀번호수정', MEM_PHONE = '전화번호수정', MEM_EMAIL = '이메일수정', MEM_SNS= '가입구분' where MEM_ID = '아이디';
-- DELETE FROM MEMBER WHERE MEM_ID = 'admin2';




-- desc MAP;
-- SELECT * FROM MAP;
-- 예시
-- insert into MAP values(상품번호, '상품이름', '상품주소', '전화번호');
insert into MAP values(1, '상품이름', '상품주소', '전화번호');
-- update MAP set PRO_NAME = '수정내용', PRO_ADDRESS = '수정내용', PRO_PHONE = '수정내용' where PRO_NUM = 1;
-- delete from MAP where PRO_NUM = 1;



-- desc PRODUCT;
-- SELECT * FROM PRODUCT;
-- 예시
insert into PRODUCT values(상품번호, '아이디', '상품소개', '시설안내', '유의사항', '환불정책', '우편번호');
-- update PRODUCT set PRO_POST = '상품소개수정내용', PRO_INFO = '시설안내수정내용', PRO_NOTICE = '유의사항수정내용', PRO_REFUND = '환불정책수정내용' where PRO_NUM = 1;
-- DELETE FROM PRODUCT WHERE PRO_NUM = 5;


 
-- desc PRODUCTFILE;
-- SELECT * FROM PRODUCTFILE;
-- 예시
insert into PRODUCTFILE values(상품번호, '상품사진', '상품사진사본');
-- update PRODUCTFILE set PRO_PIC_ORIGINAL = '수정내용', PRO_PIC_RENAME = '수정내용' where PRO_NUM = 1;
-- DELETE FROM PRODUCTFILE WHERE PRO_NUM = 5;

 

-- desc PROTIME;
-- SELECT * FROM PROTIME;
-- 예시
insert into PROTIME values('사용시간', 상품번호, 가격(시간당), '주문번호');
-- update PROTIME set PRO_PRICE = '가격수정내용' where PRO_NUM = 1;
-- DELETE FROM PROTIME WHERE PRO_NUM = 5


-- desc CANCEL;
-- SELECT * FROM CANCEL;
-- 예시
--insert into CANCEL values('주문번호', '취소날짜', '환불사유');
insert into CANCEL values('주문번호', '취소날짜', '환불사유');
-- delete from CANCEL where RSV_NUM = '1';







-- desc CHATTROOM;
-- SELECT * FROM CHATTROOM;
-- 예시
-- insert into CHATTROOM values(방번호, '내용', 마지막작성시간);
insert into CHATTROOM values(1, 'ROOM_CONTENTS', DEFAULT);
-- update CHATTROOM set ROOM_CONTENTS = '수정내용' where CHA_ROOM_NUM = 1;
-- delete from CHATTROOM where CHA_ROOM_NUM = 1;



-- desc MEMBER_ROOM;
-- SELECT * FROM MEMBER_ROOM;
-- 예시 
-- insert into MEMBER_ROOM values('아이디', 방번호);
insert into MEMBER_ROOM values('아이디', 1);
-- DELETE FROM MEMBER_ROOM WHERE ROOM_NUM = 1;

-- desc CHAT; 
-- SELECT * FROM CHAT; 
-- 예시
-- insert into CHAT values(작성시간, '아이디', 방번호, '내용');
insert into CHAT values(DEFAULT, '아이디', 1, '내용');
-- update CHAT set CHA_CONTENTS = '수정내용' where ROOM_NUM = 1;
-- delete from CHAT where ROOM_NUM = 1;



-- desc NOTICE;
-- SELECT * FROM NOTICE;
INSERT INTO NOTICE VALUES(
       (SELECT NVL(MAX(NOTI_NUM), 0)+1 FROM NOTICE)
      , 'admin1'
      , '공지'
      , '숏폼 크리에이터 ‘스클 힙스터’에 도전해봐'
      , '나만의 라이프스타일로 사람들에게 영감을 줄 숏폼 크리에이터 ‘스클 힙스터’ 대모집! 당당하고 자기다운 공간 라이프를 즐기고 콘텐츠를 통한 퍼스널 브랜딩에 관심이 있다면 망설이지 말고 지금 바로 지원해봐^^ 스클 힙스터란? 자신만의 라이프스타일을 대중과 공유하는 디지털 크리에이터로, 스터디클라우드에 등록된 다양한 공간에서 숏폼 콘텐츠를 제작하고 홍보하는 인플루언서야.
      활동내용 매달 미션주제에 따라 1~3분 길이의 영상 콘텐츠 2건씩 제작할거야. 스터디클라우드 공간에서 학교, 직장, 여가와 연계된 공간활용 꿀팁을 소개하거나 공감할 수 있는 관련 에피소드를 담으면 돼'
      , DEFAULT
      , NULL
      , NULL
);

INSERT INTO NOTICE VALUES(
       (SELECT NVL(MAX(NOTI_NUM), 0)+1 FROM NOTICE)
      , 'admin1'
      , '이벤트'
      , '우리학교 근처 버스정류장에서 QR 찍고 공간 쿠폰 받자!'
      , '스터디클라우드가 3월 한달간 서울 시내 대학가 버스정류장 10곳에서 쿠폰 증정 이벤트를 진행합니다.
      QR코드 찍고 이벤트 페이지에서 동아리, 알바, 장학금, 우정사진 등 새학기 버킷리스트를 고르기만 하면 1만원 공간쿠폰 선물이 딱!'
      , DEFAULT
      , NULL
      , NULL
);
INSERT INTO NOTICE VALUES(
       (SELECT NVL(MAX(NOTI_NUM), 0)+1 FROM NOTICE)
      , 'admin1'
      , '복구'
      , '설 연휴 기간 고객센터 임시운영 안내'
      , '2023년 설 연휴를 앞두고 고객센터 임시운영 일정 안내드립니다. 아래 일정을 확인하시고 서비스 이용에 참고부탁드립니다.'
      , DEFAULT
      , NULL
      , NULL
);
INSERT INTO NOTICE VALUES(
       (SELECT NVL(MAX(NOTI_NUM), 0)+1 FROM NOTICE)
      , 'admin1'
      , '복구'
      , '네이버페이 결제/취소 관련 장애 안내'
      , '2023년 1월 23일 14시 24분 ~ 15시 50 동안 네이버페이 서비스 접속불가 현상이 발생했습니다. 네이버페이 측 공지사항, 관련기사 확인하기'
      , DEFAULT
      , NULL
      , NULL
);

--UPDATE NOTICE SET
--   NOTI_IDX = '복구 완료'
--,  NOTI_TITLE = '설연휴 고객센터(수정)'
--,  NOTI_CONTENTS = '<복구 완료> 현재 네이버페이 접속 장애가 복구되어, 정상적으로 서비스 이용이 가능합니다. 감사합니다. 2023년 1월 23일 14시 24분 ~ 15시 50 동안 네이버페이 서비스 접속불가 현상이 발생했습니다. 네이버페이 측 공지사항, 관련기사 확인하기'
--WHERE NOTI_NUM = 1;

-- DELETE FROM NOTICE WHERE NOTI_NUM = 5;

 
-- desc RESERVE;
-- SELECT * FROM RESERVE;
-- 예시
insert into RESERVE values('주문번호', '예약날짜', 예약인원, '아이디', '결제수단', '결제시간', 총금액, 주문상태);
-- update RESERVE set MEM_QUESTION = '사용자문의글 수정내용' where RSV_NUM = 1;
-- DELETE FROM RESERVE WHERE RSV_NUM = 5;
 
 
 
-- desc REVIEW;
-- SELECT * FROM REVIEW;
-- 예시
insert into REVIEW values('주문번호', '상품이름', '리뷰내용', DEFAULT, '계정권한', '호스트답글');
-- update REVIEW set REV_CONTENTS = '리뷰내용 수정내용' where RSV_NUM = 1;
-- DELETE FROM REVIEW WHERE RSV_NUM = 5;

 
-- desc QNA;
-- SELECT * FROM QNA;
-- 예시
insert into QNA values(상품번호, '상품이름', '아이디', '사용자문의글', '계정권한', '호스트답글', 'QNA작성시간');
-- update QNA set MEM_QUESTION = '사용자문의글 수정내용' where PRO_NUM = 1;
-- DELETE FROM QNA WHERE PRO_NUM = 5;




-- desc SNS;
-- SELECT * FROM SNS;
-- 예시
insert into SNS values('토큰', '아이디', 'SNS별명', 'SNS연동날짜 DEFAULT', 'SNS종류', '계정권한');
-- update SNS set SNS_NAME = 'SNS별명 수정내용' where MEM_ID = '아이디';
-- DELETE FROM SNS WHERE MEM_ID = '아이디';