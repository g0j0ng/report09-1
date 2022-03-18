-- --------------------------------------------------------------------------------------------------------------------------------
--  								  				영화정보 정의
-- --------------------------------------------------------------------------------------------------------------------------------
drop database if exists 영화정보;
create database if not exists 영화정보;
-- --------------------------------------------------------------------------------------------------------------------------------
--  								  				영화정보 관리자 설정
-- --------------------------------------------------------------------------------------------------------------------------------
drop user if exists movie@localhost;
create user if not exists movie@localhost identified with mysql_native_password by 'movie';
grant all privileges on 영화정보.* to movie@localhost with grant option;
-- show databases;
use 영화정보;
-- --------------------------------------------------------------------------------------------------------------------------------
--  								  				테이블 생성
-- --------------------------------------------------------------------------------------------------------------------------------
create table 영화(
	영화코드 varchar(45),
    제목 varchar(45) not null,
    제작년도 varchar(45) not null,
    상영시간 varchar(45) not null,
    개봉일자 varchar(45) not null,
    제작사 varchar(45) not null,
    배급사 varchar(45) not null,
    primary key(영화코드)
);
desc  영화;

create table 감독(
	등록번호 varchar(45),
    이름 varchar(45) not null,
    성별 enum('남','여') not null,
    출생일 varchar(45) not null,
    출생지 varchar(45) not null,
    학력사항 varchar(45) not null,
    primary key(등록번호)
);
desc 감독;

create table 배우(
	주민번호 varchar(45),
    이름 varchar(45) not null,
    성별 enum('남','여') not null,
    출생일 varchar(45) not null,
    출생지 varchar(45) not null,
    키 varchar(45) not null,
    몸무게 varchar(45) not null,
    혈액형 enum('A','B','O','AB') not null,
    primary key(주민번호)
);
desc 배우;

create table 장르(
	장르코드 varchar(45),
    장르명 varchar(45) not null,
    primary key(장르코드)
);
desc 장르;

create table 정보(
	영화정보 varchar(45) not null,
    출연배우 varchar(45) not null,
    장르코드 varchar(45) not null,
    연출감독 varchar(45) not null,
    primary key(영화정보,출연배우,장르코드,연출감독),
    foreign key(영화정보) references 영화(영화코드),
    foreign key(출연배우) references 배우(주민번호),
    foreign key(장르코드) references 장르(장르코드),
    foreign key(연출감독) references 감독(등록번호)
);
desc 정보;
show tables;
-- --------------------------------------------------------------------------------------------------------------------------------
--  								  				  테이블 자료 삽입
-- --------------------------------------------------------------------------------------------------------------------------------
insert into 영화 values ('m1','배트맨','2020','100분','2020-01-01','1제작사','1배급사');
insert into 영화 values ('m2','조커','2020','111분','2020-02-01','2제작사','2배급사');
insert into 영화 values ('m3','시라노','2021','122분','2021-03-01','3제작사','3배급사');
insert into 영화 values ('m4','데드풀','2021','133분','2021-04-01','4제작사','4배급사');
insert into 영화 values ('m5','신데렐라','2022','144분','2022-05-01','5제작사','5배급사');
select * from 영화;

insert into 감독 values ('d1','캉테','남','1969-01-10','아르헨티나','하버드');
insert into 감독 values ('d2','멘디','남','1972-04-11','이라크','스탠포드');
insert into 감독 values ('d3','제코','남','1989-07-14','포르투갈','서울대');
insert into 감독 values ('d4','카가와','남','1990-06-10','네덜란드','연세대');
insert into 감독 values ('d5','이강인','남','2000-03-13','스위스','고려대');
select * from 감독;

insert into 배우 values ('900101-1111111','그린우드','남','1990-01-11','영국','192cm','91kg','A');
insert into 배우 values ('910222-2222222','실바','여','1991-02-22','스페인','183cm','82kg','B');
insert into 배우 values ('920303-1333333','밀너','남','1992-03-03','독일','175cm','74kg','O');
insert into 배우 values ('930414-2444444','조르지뉴','여','1993-04-14','이탈리아','166cm','44kg','AB');
insert into 배우 values ('940525-1555555','음바페','남','1994-05-25','프랑스','198cm','85kg','A');
insert into 배우 values ('950606-2666666','풀리시치','여','1995-06-06','미국','180cm','94kg','B');
insert into 배우 values ('960711-1777777','이승우','남','1996-07-11','한국','204cm','100kg','O');
insert into 배우 values ('970828-2888888','나카타','여','1997-08-28','일본','160cm','62kg','AB');
insert into 배우 values ('980909-1999999','워아이니','남','1998-09-09','중국','177cm','80kg','A');
insert into 배우 values ('991001-2101010','신짜오','여','1999-10-01','베트남','181cm','60kg','B');
select * from 배우;

insert into 장르 values('g1','Romantic comedy');
insert into 장르 values('g2','액션');
insert into 장르 values('g3','포르노');
select * from 장르;

insert into 정보 values('m1','900101-1111111','g1','d5');
insert into 정보 values('m1','910222-2222222','g1','d5');
insert into 정보 values('m2','920303-1333333','g1','d4');
insert into 정보 values('m2','930414-2444444','g1','d4');
insert into 정보 values('m3','940525-1555555','g2','d3');
insert into 정보 values('m3','950606-2666666','g2','d3');
insert into 정보 values('m4','960711-1777777','g2','d2');
insert into 정보 values('m4','970828-2888888','g2','d2');
insert into 정보 values('m5','980909-1999999','g3','d1');
insert into 정보 values('m5','991001-2101010','g3','d1');
select * from 정보;

-- 4번 2020년에 제작된 장르별 영화의 편수를 구하시오    
select distinct 장르.장르명 장르,  concat(count(*),'편') 제작편수
from 영화 join 정보 on 영화.영화코드=정보.영화정보 join 장르 on 정보.장르코드=장르.장르코드
where 영화.제작년도 like '2020'
group by 영화.제목;

-- 5번 Romantic comedy에 출연하지 않은 배우목록을 출력하시오
select 배우.이름 
from 배우 join 정보 on 배우.주민번호=정보.출연배우 join 장르 on 정보.장르코드=장르.장르코드
where 장르명 not like 'Romantic comedy' ;

-- 6번 장르명이 ‘Romantic comedy’인 자료의 장르코드와 장르명을 각각 ‘000111“,”로맨틱 코미디“로 변경하시오
select *
from 장르 join 정보 on 정보.장르코드=장르.장르코드
where 장르명 = (
	select 장르명 from 장르
    where 장르명 like 'Romantic comedy'
);

set foreign_key_checks = 0;   
update 장르 set 장르코드='000111', 장르명 ='로맨틱 코미디' where 장르명 = 'Romantic comedy';
update 정보 set 장르코드='000111' where 장르코드 = 'g1';
set foreign_key_checks = 1;

select  distinct 장르.장르명, 정보.장르코드  from 장르 join 정보 on 정보.장르코드=장르.장르코드;

-- 7번 장르가 '포르노'에 해당하는 영화는 불법이므로 해당 영화에 대한 모든 정보를 삭제하시오
select *
from 정보 join 장르 on 정보.장르코드=장르.장르코드
where 장르명 = (
	select 장르명 from 장르
    where 장르명 like '포르노'
);

delete from 정보 
where 정보.장르코드 in (
	select 장르코드
    from 장르
    where 장르명 = '포르노'
);

select *
from 정보 join 장르 on 정보.장르코드=장르.장르코드
where 장르명 = (
	select 장르명 from 장르
    where 장르명 like '포르노'
);

select 장르명 from 장르;
delete from 장르 where 장르명 = '포르노';
select 장르명 from 장르;
