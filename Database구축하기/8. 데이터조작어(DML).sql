-- [SQL활용] 8. 데이터조작어(DML)
use hr;

-- 데이터조작어(DML)란?
-- 테이블에 데이터를 삽입, 수정, 삭제하는 명령어
-- DML 종류: insert, update, delete

-- (1) 데이터를 삽입 - insert
-- 테이블에 특정 행을 삽입하는 명령어
-- [문법] insert into 테이블명[(컬럼명1, 컬럼명2, 컬럼명3, ..)]
--       values (값1, 값2, 값3, ...);

-- 테이블명 뒤에 컬럼리스트 생략한 경우 경우에는 반드시 values절 뒤에 기본 컬럼 순서대로
-- 모든 값을 나열해야함.
insert into departments
values (280, 'Java', 107, 1700);

-- 테이블명 뒤에 컬럼리스트를 작성한 경우 values절 뒤에 값리스트와 짝이 맞아야함.
insert into departments(department_name, location_id,
                        manager_id, department_id)
values ('Jsp', 1700, 108, 290);                        

-- null값을 자동으로 삽입하는 방법 : 생략된 컬럼에 자동으로 null값 들어감.
insert into departments(department_id, department_name)
values (300, 'Mysql');

-- null값을 수동으로 삽입하는 방법
insert into departments
values (310, 'Oracle', null, null);

select *
from departments
order by department_id desc;

-- subquery가 사용된 insert 구문 : 다른 테이블로부터 데이터를 복사해서 삽입함.
-- [insert + subquery] 예제1
-- sales_reps 테이블 생성
create table sales_reps
(id int,
name varchar(20),
salary int,
commission_pct double(22,2));

desc sales_reps;

-- employees 테이블에서 REP란 문구가 포함된 업무 담당자 정보를 
-- sales_reps 테이블로 복사하시오.
insert into sales_reps(id, name, salary, commission_pct)
select employee_id, last_name, salary, commission_pct
from employees
where job_id like '%rep%';

select *
from sales_reps;

-- [insert + subquery] 예제2
-- copy_emp 테이블 생성(employees 테이블과 구조가 동일한 테이블)
create table copy_emp
as select *
   from employees
   where 1=2;
   
desc copy_emp;

select *
from copy_emp;

-- employees 테이블의 모든 데이터를 copy_emp 테이블로 복사하시오. 
insert into copy_emp
select *
from employees;  

select *
from copy_emp;

-- 다중행 삽입하기(MySQL DBMS 문법)
insert into departments
values (320, 'HTML', 200, 1700),
	   (330, 'Javascript', null , 1700),
       (340, 'Linux', 201, null);

select *
from departments
order by department_id desc;

-- (2) 데이터 수정 - update
-- 테이블의 특정 행(데이터)을 수정하는 명령어
-- [문법] update 테이블명
--       set 컬럼명 = 값
--      [where 조건문];

-- where절 작성 시 특정 행 수정됨.
-- employees 테이이블로부터 113번 사원의 부서를 50으로 변경하시오.
select employee_id, last_name, department_id
from employees
where employee_id = 113;

update employees
set department_id = 50
where employee_id = 113;

-- where절 생략 시 모든 행 수정됨.
-- copy_emp 테이블에서 전 직원의 급여를 10% 인상하시오.
select employee_id, last_name, salary
from copy_emp;

update copy_emp
set salary = salary * 1.1;

select employee_id, last_name, salary
from copy_emp;

select employee_id, last_name, job_id, salary
from copy_emp
where employee_id = 113;

-- [subquery + update] 예제1
update copy_emp
set job_id = (select job_id
              from employees
              where employee_id = 205),
     salary = ( select salary
               from employees
		       where employee_id = 205)
where employee_id = 113;               

select employee_id, last_name, job_id, salary
from copy_emp
where employee_id = 113;

update copy_emp
set salary = salary * 1.1
where department_id = (select department_id
                       from departments
                       where location_id = 1800);
                       
select employee_id, last_name, salary, department_id
from copy_emp
where department_id = ( select department_id
                        from departments
						where location_id = 1800);
                        
-- (3) 데이터 삭제(delete)
-- 테이블의 특정 행을 삭제하는 명령어
-- [문법] delete from 테이블명
--      [where 조건문];                        

-- where절 작성 시 특정 행 삭제됨.
-- departments 테이블로부터 320번 부서를 삭제하시오.
delete from departments
where department_id = 320;

select *
from departments
order by department_id desc;

-- where절 생략 시 모든 행 삭제됨.
-- copy_emp 테이블로부터 모든 행을 삭제하시오.

delete from copy_emp;

select * 
from copy_emp;

-- employees 테이블 사용해서 copy_emp 테이블로 데이터 복사하기
insert into copy_emp
    select *
    from employees;

select * 
from copy_emp;

delete from copy_emp
where department_id = (select department_id
                       from departments
                       where location_id = 1800);

-- (4) 트랜잭션 제어어(TCL)
-- 트랜잭션이란? 하나의 논리적인 작업 단위로 여러개의 DML이 모여서 하나의 
--           트랜잭션이 구성됨.
-- 트랜잭션 제어명령어 종류 : commit(작업저장) 
--                     rollback(작업취소)
--                     savepoint(트랜잭션 진행 중 되돌아갈 지점 생성)

-- MySQL Workbench의 트랜잭션 설정하기
-- [Auto-Commit] 활성화
-- DML 발생 시 자동으로 commit이 실행됨.
-- 장점 : DML 작업 시 자동 저장되므로 편함.
-- 단점 : DML 작업 실수 시 되돌릴 수 없음.

-- [Auto-Commit] 비활성화
-- DML 작업 후 commit, rollback 명령어로 트랜잭션을 마무리 해야함.
-- 장점 : DML 작업 후 select 구문을 사용해서 미리보기를 하고 저장, 취소를 결정함.
--       그러므로 작업 실수 시 되돌릴 수 있음.
-- 단점 : DML 작업 후 저장, 취소를 결정해야함.

-- 상단 메뉴 [Query] - [Auto-commit] 체크 해제 후 작업하기
-- 트랜잭션 시작
update copy_emp
set salary = 29000
where employee_id = 100;
-- 미리보기
select employee_id, last_name, salary, department_id
from copy_emp
where employee_id = 100;

update copy_emp
set salary = 27000
where employee_id = 102;

update copy_emp
set department_id = 50
where employee_id = 107;

select employee_id, last_name, salary, department_id
from copy_emp
where employee_id in (102, 107);
-- 저장
commit;
-- 트랜잭션 종료

-- 트랜잭션 시작
delete from copy_emp;
-- 미리보기
select *
from copy_emp;
-- 작업 취소
rollback;
-- 트랜잭션 종료
select *
from copy_emp;

-- 트랜잭션 시작
update copy_emp
set department_id = 80
where employee_id = 100;
-- 미리보기
select employee_id, last_name, department_id
from copy_emp
where employee_id = 100;

update copy_emp
set salary = salary * 1.2
where employee_id = 200;
-- 미리보기
select employee_id, last_name, salary, department_id
from copy_emp
where employee_id in (100, 200);
-- 되돌아올 저장점 생성
savepoint test1;

update copy_emp
set salary = salary + 5000
where employee_id = 205;
-- 미리보기
select employee_id, last_name, salary
from copy_emp
where employee_id = 205;
-- test1 저장점으로 되돌리기
rollback to test1;
-- 미리보기

select employee_id, last_name, salary,department_id
from copy_emp
where employee_id in (100,200,205);
-- 작업 저장
commit;

-- <연습문제>
-- • MySQL Workbench - [Query] - [Auto-Commit Transactions] 해제 후 작업하기

-- 1.테이블 생성
create table my_employee
(id int primary key,
last_name varchar(25),
first_name varchar(25),
userid varchar(8),
salary int);
-- 2.테이블 구조 확인하기
desc my_employee;
-- 트랜잭션 시작
insert my_employee 
values(1, 'Patel', 'Ralph', 'rpatel', 895);
insert my_employee
values(2, 'Dancs', 'Betty', 'bdancs', 860);
insert my_employee
values(3, 'Biri', 'Ben', 'bbiri', 1100);
insert my_employee
values(4, 'Newman', 'Chad', 'cnewman', 150);
-- 미리보기
select id, last_name, first_name, userid, salary
from my_employee;
commit;
-- 트랜잭션 종료

-- 트랜잭션 시작
update my_employee
set last_name = 'Drexler'
where id = 3;

update my_employee
set salary = 1000
where salary < 900;
-- 미리보기
select id, last_name, first_name, userid, salary
from my_employee;

delete from my_employee
where last_name = 'Dancs';
-- 미리보기
select id, last_name, first_name, userid, salary
from my_employee;
commit;
-- 트랜잭션 종료

-- 트랜잭션 시작
insert my_employee 
values(5, 'Ropeburn', 'Audrey', 'aropebur', 1550);
-- 미리보기
select id, last_name, first_name, userid, salary
from my_employee;

savepoint test1;

delete from my_employee;

select id, last_name, first_name, userid, salary
from my_employee;

rollback to test1;

select id, last_name, first_name, userid, salary
from my_employee;

commit;
-- 트랜잭션 종료

