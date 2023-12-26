-- [SQL문법] 9. 데이터정의어(DDL) - Table
use hr;
-- 데이터정의어(DDL)란?
-- 객체를 생성, 수정, 삭제하는 명령어
-- 객체(테이블, 뷰, 인덱스 등)를 생성, 수정, 삭제하는 명령어
-- 테이블 관련 DDL 종류 : create table, alter table,
--                     drop table, truncate table

-- 9-1. 테이블 생성(create table)
-- [문법] create table 테이블명
--      (컬럼명1 데이터타입(컬럼사이즈),
--       컬럼명2 데이터타입(컬럼사이즈) [default 기본값],
--       컬럼명3 데이터타입(컬럼사이즈) [제약조건]);

-- 데이터타입 종류 1) 문자 - char : 고정형
--                    - varchar : 가변형
--            2) 숫자 - int, bigint : 정수형          
--                   - double, float : 실수형
--            3) 날짜 - date : 년/월/일
--                   - datetime : 년/월/일/시/분/초

-- dept 테이블 생성 예제
create table dept
(deptno int, 
 dname varchar(14),
 1oc varchar(13),
 create_date datetime default now());
 
 desc dept;
 
 insert into dept
 values (10, 'AAA', 'A100', '2023-01-13');
 
 insert into dept(deptno, dname)
 values (20, 'BBB');
 
 insert into dept
 values (30, 'CCC', 'C100', default);
 
 insert into dept
 values (40, 'DDD', null, null);
 
 insert into dept
 values (50, 'EEE', default, default);
 
 update dept
 set create_date = default
 where deptno = 40; 
 
 select *
 from dept;
 
-- 제약조건 
-- 제약조건 사용 목적 : 테이블에 부적합한 데이터가 들어오는 것을 막기 위함.
-- 제약조건 종류 : primary key, foreign key, not null, unique, check

-- [제약조건1] not null
-- 컬럼에 null값이 삽입/수정되는 것을 막아주는 제약조건
-- 값이 반드시 들어와야 하는 필수 컬럼에 선언함.
-- 필수 컬럼에 선언함.

-- [제약조건2] unique
-- 중복된 데이터가 삽입/수정되는 것을 막아주는 제약조건
-- 고유한 값만 들어와야 하는 컬럼에 활용됨.


-- [제약조건3] primary key
-- 테이블의 각 행을 고유하게 식별해 줄 수 있는 대표 컬럼에 선언하는 기본키 제약조건
-- not null + unique의 성격을 모두 가지고 있는 제약조건


-- [제약조건4] foreign key

-- [제약조건5] check

create table test1
(id int not null,
name varchar(30) not null,
jumin varchar(13) not null,
job varchar(20),
email varchar(20),
phone varchar(20) not null,
start_date date);

desc test1;

create table test2
(id int not null unique,
 name varchar(30) not null,
 jumin varchar(13) not null unique,
 job varchar(20),
 email varchar(20) unique,
 phone varchar(20) not null unique,
 start_date date);
 
 desc test2;
 
create table test3
 (id int primary key,
 name varchar(30) not null,
 jumin varchar(13) not null unique,
 job varchar(20),
 email varchar(20) unique,
 phone varchar(20) not null unique,
 start_date date);
 
desc test3;
-- [제약조건3] primary key
-- 테이블의 각 행을 고유하게 식별해 줄 수 있는 대표 컬럼에 선언하는 기본키 제약조건
-- not null + unique의 성격을 모두 가지고 있는 제약조건 
-- 테이블에 한번만 선언할 수 있음!!!
 
-- [제약조건4] foreign key
-- 자기 자신 테이블이나 다른 테이블의 특정 컬럼(PK, UK)을 참조하는 외래키 제약조건
-- FK 제약조건때문에 테이블과 테이블이 연계되어서 운영될 수 있음.
-- FK 제약조건이 선언된 컬럼 => 자식 컬럼
-- FK 제약조건이 참조하는 컬럼 => 부모 컬럼
-- 자식 컬럼에는 부모 컬럼에 있는 데이터 중 하나만 삽입/수정될 수 있음. 
-- foreign key 제약 조건이 포함된 테이블 생성 예제
-- [제약조건5] check
 
create table test4
(t_num int primary key,  -- 컬럼 레벨 문법
 t_id int,                  nn pk uk ck 
 title varchar(20) not null,
 story varchar(100) not null,
 foreign key(t_id) references test3(id)); -- 테이블 레벨 문법
                                          -- fk || pk uk ck
 desc test4;
 
-- [제약조건5] check
-- 해당 컬럼이 만족해야 하는 조건을 자유롭게 지정할 수 있는 제약조건 
-- (예1) salary int check (salary > 0)
-- (예2) birth date check (birth < '2001-01-01')
-- (예3) 성별 char(10) check (성별 in ('남', '여'))

create table test5
( id int(10) primary key,
  name varchar(30) not null,
  jumin varchar(13) not null unique check (length(jumin)=13),
  job varchar(20),
  email varchar(20) unique,
  phone varchar(20) not null unique,
  start_date date check (start_date >= '2005-01-01'));
  
  desc test5;

 -- 테이블에 선언된 제약조건 정보 조회하는 방법
 -- DB 사전(information_schema)을 사용해야함.
 show databases;
 use information_schema;
 show tables;
 
 -- test5 테이블에 선언된 제약조건 정보 조회
 select *
 from table_constraints
 where table_name = 'test5';
 
-- shopdb 데이터베이스(스키마)에 존재하는 테이블에 선언된 제약조건 정보 조회 
select *
from table_constraints
where constraint_schema = 'shopdb';

-- check 제약조건의 조건문 조회
select *
from check_constraints
where constraint_schema = 'hr';

-- test4 테이블에 선언된 PK, FK 제약조건 정보 조회
select *
from key_column_usage
where table_name = 'test4';
 
use hr;
 
-- 서브쿼리를 활용한 테이블 생성
-- 서브쿼리를 사용해서 테이블 생성 시 원본 테이블의 구조와 데이터를 그대로 가지는 
-- 복사본의 테이블이 생성됨. 
-- 단, 제약조건은 not null만 복사됨.
-- 백업 테이블 또는 테스트 테이블 생성 시 많이 활용됨.
-- (예제1)
create table dept80
as select employee_id, last_name, salary*12 as annsal, hire_date
   from employees
   where department_id = 80;
   
desc dept80;

-- (예제2) 백업 테이블 또는 테스트 테이블 생성
create table emp_backup
as select *
   from employees;
select *
from dept80;
   
desc emp_backup;

-- 9-2.테이블 수정(alter table)
-- alter table 테이블명 add ---;        => 컬럼 추가, 제약조건 추가(pk, uk, ck, fk)
-- alter table 테이블명 modify ---;     => 컬럼 수정, 제약조건 추가 & 삭제(nn)
-- alter table 테이블명 drop ---;       => 컬럼 삭제, 제약조건 삭제(pk, uk, ck, fk)
-- alter table 테이블명 rename ---;     => 컬럼명 변경

-- (1) 컬럼 추가
-- dept80 테이블에 job_id 컬럼 추가
-- 마지막 컬럼으로 추가, 초기 값은 null값이 삽입됨.
alter table dept80
add job_id varchar(10);

-- 컬럼 추가 시 default값을 지정한 경우 초기값으로 default값이 삽입됨.
alter table dept80
add email varchar(30) default '미입력';

-- 컬럼 추가 시 특정 컬럼 뒤에 컬럼 추가하기
alter table dept80
add emp_number int first;

alter table dept80
add salary int default 300 not null after last_name;

desc dept80;
select *
from dept80;
-- (2) 컬럼 수정 : 테이터타입, 컬럼사이즈, default값, not null 제약조건
desc dept80;
-- salary(int, not null, default 300)
alter table dept80
modify salary bigint;

-- last_name(varchar(25), not null) -> (varchar(30),not mull)
alter table dept80
modify last_name varchar(30) not null;
 
-- salary(bigint) -> (bigint, default 500, not null)
alter table dept80
modify salary bigint default 500 not null;

desc dept80;
select *
from dept80;

-- (3) 컬럼 삭제
alter table dept80
drop emp_number;

desc dept80;
select *
from dept80;

-- (4) 제약조건 추가
-- pk, ck, uk, fk => alter table 테이블명 add ---;
alter table dept80
add primary key(employee_id);

alter table dept80
add unique(job_id);

alter table dept80
add check(salary > 100);

-- fk 제약조건 추가
alter table dept80
add mgr_id int default 150;

alter table dept80
add foreign key(mgr_id) references dept80(employee_id);

-- not null => alter table 테이블명 modify ---;
-- annsal(double(22,0) -> (double(22,0), not null)
alter table dept80
modify annsal double(22,0) not null;

desc dept80;
-- (5) 제약조건 삭제
-- nn => alter table 테이블명 modify ---;
-- annsal(double(22,0), not null) -> (double(22,0), null)
alter table dept80
modify annsal double(22,0);

-- pk => alter table 테이블명 drop ---;
-- 제약조건 유형(primary key)으로 삭제가 가능함.
alter table dept80
drop primary key;

-- fk, ck, uk => alter table 테이블명 drop ---;
-- 제약조건명(DB사전에서 알 수 있음)으로 삭제가 가능함.
-- 제약조건명 확인하기
use information_schema;
select *
from table_constraints
where table_name = 'dept80';

-- dept80 테이블의 mgr_id 컬럼에 선언된 fk 제약조건명 : dept80_ibfk_1
alter table dept80
drop foreign key dept80_ibfk_1;

use hr;

desc dept80;

-- (6) 컬럼명 변경
alter table dept80
rename column hire_date to start_date;

desc dept80;

-- 9-3. 테이블 삭제(drop table)
-- 데이터베이스로부터 테이블을 삭제하는 작업
-- 테이블 구조, 데이터, 제약조건 등 모두 삭제됨.
drop table dept80;
desc dept80; -- 테이블 존재하지 않음!

-- 9-4. 테이블 절단(truncate table)
-- 테이블로부터 구조만 남기고, 모든 데이터를 삭제하는 작업
-- 테이블을 비울때 사용됨.
truncate table copy_emp; -- (==) delete from copy_emp;

desc copy_emp;
select *
from copy_emp;

-- <연습문제>

use shopdb;

-- 테이블 이름: TITLE
CREATE TABLE TITLE
(TITLE_ID INT PRIMARY KEY,
 TITLE VARCHAR(60) NOT NULL,
 DESCRIPTION VARCHAR(400) NOT NULL,
 RATING VARCHAR(4) CHECK(RATING IN('G','PG','R','NC17','NR')),
 CATEGORY VARCHAR(20) CHECK(CATEGORY IN('DRAMA','COMEDY','ACTION','CHILD','SCIFI','DOCUMENTARY')),
 RELEASE_DATE DATE);

desc title;

CREATE TABLE TITLE_COPY
(COPY_ID INT,
 TITLE_ID INT,
 STATUS VARCHAR(15) NOT NULL 
 CHECK(STATUS IN('DRAMA','COMEDY','ACTION','CHILD','SCIFI','DOCUMENTARY')),
 PRIMARY KEY(COPY_ID, TITLE_ID),
 FOREIGN KEY(TITLE_ID) REFERENCES TITLE(TITLE_ID));
 
 desc TITLE_COPY;
 







 
 
 
