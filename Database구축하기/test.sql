-- [Database 구축하기]
-- 1. Database 생성
-- 2. Table 생성
-- 3. Data 삽입/수정/삭제
-- 4. Data 검색

-- 1. Database 생성
create schema shopdb;
use shopdb;

-- 2. Table 생성
-- [문법] create table 테이블명
--       (컬럼명1 데이터타입(컬럼사이즈),
--        컬럼명2 데이터타입(컬럼사이즈) default 기본값,
--        컬럼명3 데이터타입(컬럼사이즈) 제약조건);

-- 데이터타입 종류
-- 1) 숫자 : int, bigint, double, float
-- 2) 문자 문자 : char, varchar
-- 3) 날짜     : date, datetime

-- 제약조건 종류
-- 1) not null : null값이 삽입/수정되는 것을 막아주는 제약조건
--               필수 컬럼에 선언함.
--               (예) 이름, 주민번호, 전화번호 등 필수 컬럼에 선언함.
-- 2) unique : 중복된 값이 삽입/수정되는 것을 막아주는 제약조건
--             사번, 학번, 주민번호, 전화번호, 이메일 등
--             고유한 값이 들어와야 하는 컬럼에 선언함.  
-- 3) primary key : 기본키 제약조건
--                  not null + unique의 성격을 모두 가짐.
--                  테이블에 한번만 선언 가능함!!!
-- [stu] 테이블
-- stu_no | name | jumin | phone | grade | email
-- -----------------------------------------------
--   pk      nn     nn      nn      nn      uk
--                  uk      uk        
-- 4) foreign key : 외래키 제약조건
--                  자기자신 테이블이나 다른 테이블의 특정 컬럼(pk,uk)을
--                  참조하는 제약조건
--                  fk 제약조건때문에 테이블과 테이블이 연결되어서 운영됨.
-- 5) check : 컬럼이 만족해야하는 조건문을 자유롭게 지정하는 제약조건
-- 2-1. members
 create table members
 (member_id int primary key,
 member_name varchar(8) not null,
 birth date not null,
 job varchar(20),
 phone varchar(20) unique,
 address varchar(80) );
 
 desc members;
 
 create table products
 (prod_id int primary key,
 prod_name varchar(20) not null,
 price int check (price>0),
 make_date date,
 company varchar(10) not null);
 
 desc products;
 