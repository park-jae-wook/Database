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
 
  -- 2-3. ordes 테이블 생성하기
 -- not() 함수 : 현재 날짜/시간을 반환하는 함수           
 select now()
 from dual;
 
 create table orders
 (order_num int,
 member_id int,
 prod_id int,
 order_date datetime default now(),
 primary key(order_num),
 foreign key(member_id) references members(member_id),
 foreign key(prod_id) references products(prod_id));
 
 desc orders;
 
 -- 2-4. auto_increment 속성 활용해서 stu 테이블 생성하기
-- auto_increment 속성이란?
-- auto_increment 속성이 부여된 컬럼은 데이터 삽입 시 자동으로
-- 1부터 시작해서 1씩 증가하는 값이 반환됨.
-- 시작값과 증가값(증가사이즈) 변경 가능함.
-- 단, pk 또는 uk 제약조건이 선언된 컬럼이면서 숫자 데이터타입 컬럼에 사용 가능함.
-- 숫자 데이터타입 컬럼에 사용 가능함.

-- [문법] create table 테이블명
--       (컬럼명1 int auto_increment primary key,
--        컬럼명2 데이터타입, 
--        컬러명3 데이터타입);

-- stu20 테이블 생성하기
create table stu20
(stu_id int auto_increment primary key,
stu_name varchar(5) not null,
age int check (age > 19));



desc stu20;  
 
-- 3. 데이터 삽입/수정/삭제
-- 3-1. 데이터 삽입(insert)
-- [문법] insert into 테이블명[(컬럼명1, 컬럼명2, 컬럼명3, ...)]
--       values (값1, 값2, 값3, ...);
-- 값 작성 방법 1) 숫자 : 그냥 작성하면 됨.
--           2) 문자 : 작은따옴표로 몪어서 작성해야함.
--           3) 날짜 : 작은따옴표로 묶어서 작성해야함.
--                    '년-월-일' 순서로 작성함.              

-- (1)members 테이블에 데이터 삽입하기
desc members;

-- 테이블명 뒤에 컬럼리스트 생략 시 values절 뒤에 기본 컬럼 순서대로 모든 값 나열해야함.
insert into members 
values (100, '홍길동', '1991-12-30', '학생', '010-1111-1111', '부산 부산진구 부전동');

-- 테이블명 뒤에 컬럼리스트를 작성한 경우에는 values절의 값리스트와 짝이 맞아야함.
-- 생략된 컬럼에는 자동으로 null값이 삽입됨.
insert into members(member_id, member_name, birth, phone)
values (101,'김민수','1990-03-05', '010-2222-2222'); -- 오류

-- not null 제약조건이 선언된 컬럼 생략된 경우 오류 발생됨.
insert into members(member_id, member_name, phone, address, birth)
values (102, '최아영', '010-3333-3333', '서울 강남구 선릉로', '1987-11-23'); -- 수정

-- upique 제약조건이 선언된 컬럼에 중복 값이 삽입되는 경우 오류 발생됨.
insert into members(member_id, member_name, birth, job, phone) -- 오류
values (103, '홍길동', '1988-05-10', '회사원', '010-1111-1111');

insert into members(member_id, member_name, birth, job, phone) -- 오류
values (103, '홍길동', '1988-05-10', '회사원', '010-4444-4444'); -- 수정

-- primary key 제약조건이 선언된 컬럼에 중복 값이 삽입된 경우 오류 발생됨.
insert into members(member_id, member_name, birth, job)
values (101, '강주영', '1998-08-09', '대학생'); -- 오류

insert into members(member_id, member_name, birth, job)
values (104, '강주영', '1998-08-09', '대학생'); -- 수정

-- primary key 제약조건이 선언된 컬럼에 null값이 삽입된 경우 오류 발생됨.
insert into members(member_name, birth, job, phone, address)
values ('고승현', '1995-07-10', '트레이너', '010-5555-5555','경기도 부천시 원미구'); -- 오류
insert into members(member_name, birth, job, phone, address,member_id)
values ('고승현', '1995-07-10', '트레이너', '010-5555-5555','경기도 부천시 원미구', 105); -- 수정

insert into members(member_id, member_name, birth, job, phone, address)
values (106, '정유빈', '1970-02-04', '회사원', '010-6666-6666','');  
insert into members(member_id, member_name, birth, job, phone, address)
values (107, '이영수', '1988-12-06', '','010-7777-7777');  
insert into members(member_id, member_name, birth, job, phone, address)
values (108, '김철수', '1970-02-04', '','010-8888-8888','부산 해운대구 센텀로');  

insert into members (member_id, member_name, birth, job, phone, address)
values (109, '최승현', '1970-02-04', '간호사', '010-9999-7777','서울 강북고 수유동');
insert into members (member_id, member_name, birth, job, phone, address) 
values (110, '한주연', '1970-02-04', '승무원', '010-1010-1010','대구 수성수 수성로');  

select *
from members;

-- (2) products 테이블에 데이터 삽입하기
desc products;

-- null값을 수동으로 삽입하는 방법
insert into products(prod_id, prod_name, price, make_date, company)
values (10, '냉장고', 500, null, '삼성');
insert into products(prod_id, prod_name, price, make_date, company)
values (20, '컴퓨터', 150, '2022-01-13', '애플');
insert into products(prod_id, prod_name, price, make_date, company)
values (30, '세탁기', 250, '2022-01-13', 'LG');
insert into products(prod_id, prod_name, price, make_date, company)
values (40, 'TV', 200, '2022-01-13', 'LG');
insert into products(prod_id, prod_name, price, make_date, company)
values (50, '전자렌지', 400, '2022-01-13', '삼성');
insert into products(prod_id, prod_name, price, make_date, company)
values (60, '건조기', 300, '2021-07-09', 'LG');

select *
from products;

-- (3) orders 테이블에 데이터 삽입하기
desc orders;

insert into orders
values (1, 101, 20, '2023-02-01');

insert into orders
values (2,107, 40, '2023-02-05 17:51');

-- now() 함수 활용해서 데이터 삽입하기
insert into orders
values (3, 106, 50, now());

-- insert 시 default값이 선언된 컬럼은 생략하면 자동으로 default값 삽입됨. 
insert into orders(order_num, member_id, prod_id)
values (4, 103, 10);

-- 수동으로 default값 삽입하는 방법
insert into orders
values(5, 108, 50, default);

-- fk 제약조건이 선언된 컬럼 데이터 삽입1
insert into orders
values (6, 120, 30, default);  -- 오류(120번 멤버 X)

insert into orders
values (6, 103, 30, default); -- 수정

-- fk 제약조건이 선언된 컬럼 데이터 삽입2
insert into orders
values (7, 105, 80, default); -- 오류(80번 제품X)

insert into orders
values (7, 105, 60, default); -- 수정



-- 추가 데이터 삽입하기
insert into orders
values (8, 110, 40, default);
insert into orders
values (9, 107, 30, default);
insert into orders
values (10, 101, 60, default);

select *
from orders;

-- (4) stu20 테이블에 데이터 삽입하기
desc stu20;

-- auto_increment 속성이 선언된 컬럼에 데이터 삽입 방법
-- 기본값은 1부터 시작해서 1씩 증가하는 값이 반환됨.

insert into stu20
values (null, '김온달', 28);

insert into stu20
values (null, '이평강', 24);

-- 시작값 변경
alter table stu20 auto_increment = 100;

insert into stu20
values (null, '최찬미', 29);

insert into stu20
values (null, '김동희', 31);

-- 증가값(증가사이즈) 변경
set @@auto_increment_increment=5;

insert into stu20
values (null, '박혜경', 22);

insert into stu20
values (null, '문진원', 27);

select *
from stu20;

-- 3-2. 데이터 수정(update)
-- [문법] update 테이블명
--       set 컬럼명 = 값
--       [where 조건문];

-- products 테이블의 모든 상품의 가격을 50씩 인상하시오.
-- where절 없이 update 작업 시 모든 행이 수정됨.
update products
set price = price + 50;

-- products 테이블의 TV 제품 가격을 30만큼 인상하시오.
-- where절 작성 시 특정 행이 수정됨.

update products
set price = price + 30
where prod_name = 'TV';

select *
from products;

-- member 테이블의 150번 회원 전화번호를 010-5050-5050으로 변경하시오.
update members
set phone = '010-5050-5050'
where member_id = 105;

select *
from members;

-- orders 테이블의 2번 주문의 주문자(member_id)를 120으로 변경 => 
update orders
set member_id = 120
where order_num = 2; -- 수정
update orders
set member_id = 109
where order_num = 2;

select *
from orders;
 
-- null값으로 update하는 방법
update members
set phone = null
where member_id = 109;


select *
from members;

-- 3-3. 데이터 삭제(delete)
-- [문법] delete from 테이블명
--      [where 조건문];

-- stu20 테이블에서 나이가 25세 이하인 학생을 삭제하시오.
delete from stu20
where age <= 25;


select *
from stu20;

-- stu20 테이블의 모든 학생을 삭제하시오.
-- where절 생략 시 모든 행 삭제됨.
delete from stu20;

select *
from stu20;

-- 3-4. DML 작업 후 저장/취소하기
-- DML 작업 후 저장하는 명령어 : commit
-- DML 작업 후 취소하는 명령어 : rollback

-- [설정1] auto commit 활성화(default)
-- 장점 : DML 발생 시 자동 저장되므로 따로 저장할 필요가 없어서 편함.
-- 단점 : 자동 저장되므로 작업 취소가 안됨.

-- [설정2] auto commit 비활성화
-- 장점 : 작업 후 select 구문을 사용해서 충분히 미리보기를 한 다음
--       저장 및 취소를 결정할 수 있음.

-- 단점 : DML 작업 후 매번 저장 및 취소 명령어를 수행해서 작업을 마무리 해야함.

-- 4. 데이터 검색
-- [문법] select * | 컬럼명1, 컬럼명2, 컬럼명3, ...
--       from 테이블명;
--       [where 조건문];

-- 테이블로부터 모든 컬럼, 모든 행 조회하기
select *
from members;

select *
from orders;

-- 테이블부터 특정 컬럼, 모든 행 조회하기
select member_id, member_name, phone
from members;

desc products;
select company, prod_name, price
from products;

select order_num, order_date
from orders;

-- 테이블로부터 특정 행 조회하기
-- 테이블로부터 특정 행 출력을 원할 경우 where절에 조건문작성해야함.
-- [문법] select * | 컬럼명1, 컬럼명2, 컬럼명3, ...
--       from 테이블명;
--       where   좌변       =    우변;
--              (컬럼명) (비교연산자) (값) -> 숫자, '문자', '년-월-일'

-- 비교연산자 : =, >, >= <, <=, <>, !=

-- members 테이블에서 member_id가 105번인 회원 정보를 출력하시오.
select *
from members
where member_id = 105;

-- members 테이블에서 이름이 '홍길동'인 회원 정보를 출력하시오.
select *
from members
where member_name = '홍길동';

-- members 테이블에서 직업이 회사원이 아닌 회원 정보를 출력하시오.
select *
from members
where job <> '회사원';

-- products 테이블에서 가격이 300 이상인 제품의 이름과 가격을 출력하시오.
select prod_name, price
from products
where price >= 300;

-- members 테이블에서 생년월일이 1990년 이전인 회원의 이름, 생년월일,
-- 전화번호를 조회하시오.
select member_name, birth, phone
from members
where birth < '1990-01-01';
-- where절에 여러 조건문 작성 방법
-- where절에 여러개의 조건문 작성 시에는 and, or 논리연산자로 나열함.

-- products 테이블에서 상품 가격이 300이상 500이하인 상품만 출력하시오.
select *
from products
where price >= 300 and price <=500;

-- members 테이블에서 생년월일이 1990년 이전이거나 1991년 이후인
-- 회원만 출력하시오.
select *
from members
where birth < '1990-01-01' or birth > '1991-12-13';

-- products 테이블로부터 LG 제품 중 가격이 300 이하인 상품만 출력하시오.
select *
from products
where company = 'LG' and price <=300;

-- where절에 and와 or가 함께 사용된 경우 작업 순서
-- [예제1] 우선순위 : and(높) >> or(낮)
select *
from products
where company = 'LG'
or    company = '삼성'
and   price <= 300;

-- [예제2] or 연산을 먼저하고 싶은 경우 괄호로 묶어준다.
select *
from products
where (company = 'LG' or company = '삼성') and price <= 300;

-- 테이블로부터 데이터 조회 정렬하기
-- [문법] select * | 컬럼명1, 컬럼명2, 컬럼명3
--       from 테이블명
--      [where 조건문]                       
--      [order by 컬럼명 [asc(기본) | desc]];

-- 숫자 컬럼을 기준으로 정렬하기
select *
from products
order by price asc;

select *
from products
order by price desc;

select *
from orders
order by member_id;

-- 날짜 컬럼을 기준으로 정렬하기
select *
from products
order by make_date desc;

-- 문자 컬럼을 기준으로 정렬하기
select *
from members
order by member_name;

select *
from products
order by prod_name desc;

-- 여러 컬럼을 기준으로 정렬하기
select *
from orders
order by member_id, order_num desc;
select *
from orders
order by member_id desc, order_num desc;

select *
from products
order by company, price desc;


   



