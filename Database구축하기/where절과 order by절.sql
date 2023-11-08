-- [SQL문법] 2. where절과 order by절
use hr;

-- 2-1. where절(조건절)
-- [문법] select 컬럼명1, 컬럼명2, 컬럼명3, ...
--       from 테이블명                     (필수)
--       where   좌변     =      우변  ;   (옵션)
--             (컬럼명)(비교연산자)(비교할 값) -> 숫자, '문자', '날짜'

-- [비교연산자1] 단일행 비교연산자
-- 단일행 비교연산자란 우변에 단일 값이 올 수 있는 연산자
-- 단일행 비교연산자 종류 : =, >, >=, <, <=, <>, !=
select employee_id, last_name, job_id, department_id
from employees
where department_id = 90;

-- MySQL에서는 문자 데이터 값 검색 시 대소문자 구분하지 않음.
select employee_id, last_name, job_id, department_id
from employees
where last_name = 'whalen';

-- MySQL에서는 날짜 데이터 값 검색 시 년-월-일 순서로 작성해야함.
select employee_id, last_name, hire_date
from employees
where hire_date = '1996-02-17';

select employee_id, last_name, job_id, department_id
from employees
where salary <= 3000;

-- [비교연산자2] between A and B
-- A이상 B이하의 값을 비교해주는 연산자로 범위검색 시 활용됨.
-- 모든 데이터타입에 활용 가능함.
select employee_id, last_name, salary, job_id, department_id
from employees
where salary between 2500 and 3500;

select employee_id, last_name, salary, hire_date
from employees
where hire_date between '1990-01-01'and '1991-12-31';

select employee_id, last_name, department_id
from employees
where last_name between 'bell' and 'dehaan';

-- [비교연산자3] in
-- 우변에 값리스트가 올 수 있는 다중행 비교연산자로 값리스트와 비교해서 
-- 하나이상 동일(=)하면 true를 반환함.
-- (=,OR) 성격을 내포하고 있음.
select employee_id, last_name, manager_id, salary, department_id
from employees
where manager_id in (100, 101, 201);

select employee_id, last_name, hire_date, department_id
from employees
where hire_date in ('1990-01-03', '1994-06-07', '1989-09-21');

select employee_id, last_name, job_id
from employees
where job_id in ('ad_vp', 'sa_rep', 'it_prog', 'st_man');

-- [비교연산자4] like
-- 패턴일치 여부를 비교해주는 연산자
-- 검색하고자 하는 값을 다 알지 못하고 일부분만 아는 경우 활용될 수 있음.
-- like 비교연산자 우변에 패턴 작성 시 활용되는 기호
-- 1) % : 0개 또는 여러개의 문자가 올 수 있음. 
-- 2) _ : 반드시 하나의 문자가 와야함.
-- (예) a로 시작되는 문자열 : 'a%'
--      a가 포함된 문자열 : '%a%'
--      a로 끝나는 문자열 : '%a'
--      두번째 문자가 a인 문자열 : '_a%'
--      끝에서 세번째 문자가 a인 문자열 : '%a__'
-- employees테이블에서 last_name이 'a'로 시작되는 사원들 출력하시오.
select employee_id, last_name, job_id, department_id
 from employees
 where last_name like 'a%';
 
 -- employee_id, last_name의 두번째 문자가 'o'인 사원들 출력하시오.
 select employee_id, last_name, job_id, department_id
 from employees
 where last_name like '_o%';
 
  -- employee_id, last_name의 두번째 문자가 'o'인 사원들 출력하시오.
 select employee_id, last_name, job_id
 from employees
 where job_id like '%rep';
 
 -- employees 테이블에서 입사일 날짜가(hire_date) 1일인 사원들 출력하시오.
 select employee_id, last_name, hire_date
 from employees
 where hire_date like '%01';
 
 -- employees 테이블에서 입사한 날짜가(hire_date) 1월인 사원들 출력하시오.
 select employee_id, last_name, hire_date
 from employees
 where hire_date like '%-01-%';
 
 -- [예제] employees 테이블에서 last_name에 순서는 상관없이 'a'와 'e'가
 -- 모두 포함된 사원들 출력하시오.
 select employee_id, last_name, salary, department_id
 from employees
 where last_name like '%a%e%' or last_name like '%e%a%';

 select employee_id, last_name, salary, department_id
 from employees
 where last_name like '%a%' or last_name like '%e%';
-- [비교연산자5] is null
-- 값이 null인지를 비교해주는 연산자
-- employees 테이블에서 부서가 결정되지 않아서 null값이 저장된 신입사원을 출력하시오.
select employee_id, last_name, salary, job_id, department_id
from employees
where department_id is null;

-- employees 테이블에서 매니저가 없는 사장의 정보를 출력하시오.
select *
where manager_id is null;

-- employees 테이블에서 커미션을 받지 않는 사원들을 출력하시오.
select employee_id, last_name, salary, commission_pct
from employees
where commission_pct is null;

-- [논리연산자1] and
-- employees 테이블로부터 50번 부서에 소속되어 있으면서 5000이상의 급여를
-- 받는 사원을 출력하시오.
select employee_id, last_name, salary, department_id
from employees
where department_id = 50
and salary >= 5000;
-- employees 테이블로부터 급여가 5000 이상이면서 8000 이하인 사원을 출력하시오.
select employee_id, last_name, salary, department_id
from employees
where salary >= 5000
and salary <=8000;
-- (==)
select employee_id, last_name, salary, department_id
from employees
where salary between 5000 and 8000;

-- [논리연산자2] or
-- employees 테이블로부터 10000 이상의 급여를 받거나 또는 30번 부서에 소속된 
-- 사원들을 출력하시오.
select employee_id, last_name, department_id
from employees
where salary >= 10000
or    department_id = 30;

-- employees 테이블로부터 20번 또는 50번 부서에 소속된 사원들 출력하시오.
select employee_id, last_name, department_id
from employees
where department_id = 20
or    department_id = 50;
-- (==)
select employee_id, last_name, department_id
from employees
where department_id in (20, 50);

-- where절에 and와 or가 함께 사용된 경우 우선순위 : and(높) >> or(낮)
-- (예1)
select employee_id, last_name, salary, job_id, department_id
from employees
where department_id = 20
or    department_id = 50
and   salary > 7000;
-- (예2)
select employee_id, last_name, salary, job_id, department_id
from employees
where (department_id = 20
or    department_id = 50)
and   salary > 7000;
-- [논리연산자3] not
-- <비교연산자 종류>
-- =                 <--->  <>, !=
-- >, >=             <--->  <,  <=
-- between A and B   <--->  not between A and B
-- in                <--->  not in : (<>, AND)
-- like              <--->  not like
-- is null           <--->  is not null

-- employees 테이블로부터 5000 미만 10000 초과의 급여를 받는 사원들 출력하시오.
select employee_id, last_name, salary
from employees
where salary not between 5000 and 10000;

-- employees 테이브로부터 담당업무가 'sa_rep', 'it_prog', 'st_man'이
-- 아닌 사원들만 출력하시오.
select employee_id, last_name, job_id, department_id
from employees
where job_id not in ('sa_rep', 'it_prog', 'st_man');

-- employees 테이블로부터 clerk으로 끝나지 않는 업무 담당자를 출력하시오.
select employee_id, last_name, job_id
from employees
where job_id not like '%clerk';

-- employees 테이블로부터 커미션을 받는 사원들을 출력하시오.
select employee_id, last_name, salary, commission_pct
from employees
where commission_pct is not null;

-- 2-2. order by절(정렬)
-- [문법] select 컬럼명1, 컬럼명2, 컬럼명3
--       from 테이블명
--      [where 조건문]
--      [order by 정렬에 기준이될 컬럼명 [asc(기본) | desc]];
--  컬럼명을 기준으로 정렬하기
select employee_id, last_name, salary, job_id, department_id
from employees
order by salary;

select employee_id, last_name, salary, job_id, department_id
from employees
order by salary desc;

select employee_id, last_name, hire_date , job_id, department_id
from employees
order by hire_date desc;

select employee_id, last_name
from employees
order by last_name;

-- 표현식 또는 컬럼 alias를 기준으로 정렬하기
select employee_id, last_name, salary, salary*12 as ann_sal
from employees
order by salary*12 desc;

select employee_id, last_name, salary, salary*12 as ann_sal
from employees
order by ann_sal  desc;

-- 위치표기법을 기준으로 정렬하기
select employee_id, last_name, salary, department_id, job_id
from employees
order by 4 desc;

-- 여러 컬럼을 기준으로 정렬하기
select employee_id, last_name, salary, job_id, department_id
from employees
order by department_id, salary desc;

-- <연습문제>
select last_name, hire_date 
from employees
 where hire_date like '2000%';
 -- (==)
 select last_name, hire_date 
from employees
 where hire_date between '2000-01-01' and '2000-12-31';
 
 select last_name, salary, commission_pct 
from employees
 where commission_pct is null
 order by salary desc;
 
 -- <추가 연습문제>
 -- 1. employees 테이블에서 $5,000 ~ $12,000의 급여를 받으면서
-- 부서 20 또는 50에 속하는 사원의 employee_id, last_name, salary, 
-- department_id를 출력하시오.(6명 출력)
select employee_id, last_name, salary, department_id
from employees
where salary between 5000 and 12000 and
department_id in ('20','50');

-- 2. employees 테이블에서 커미션 금액이 20%인 사원의 employee_id, last_name, 
-- salary, commission_pct를 출력하되 salary를 기준으로 내림차순 정렬하시오.(8명 출력)
select employee_id,last_name, salary, commission_pct
from employees 
where commission_pct= 0.20
order by salary desc;


