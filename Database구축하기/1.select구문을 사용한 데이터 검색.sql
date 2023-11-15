-- [SQL문법] 1. select구문을 사용한 데이터 검색
use hr;

-- 테이블 리스트 조회하기
show tables;

-- 테이블 구조 조회하기
-- [문법] desc[ribe] 테이블명;
desc employees;
desc departments;
desc locations;

-- 테이블로부터 데이터 검색하기
-- [문법] select * | 컬럼명1, 컬럼명2, 컬럼명3, ...
--       from 테이블명;

select *
from employees;

select *
from departments;

select department_id, location_id
from departments;

-- select 구문에 산술식이 사용된 예제
-- 산술식이란? 산술연산자가 활용된 계산식
-- 산술연산자 종류 : +, -, *, /
-- 산술연산자 우선순위 : (*, /)[높] >> (+,-)[낮]
-- 우선순위를 지정하고 싶은 경우 괄호로 묶어야 함.
select employee_id, last_name, salary, 12*salary+100
from employees;

select employee_id, last_name, salary, 12*(salary+100)
from employees;

-- null값이란?
-- 모르는 값, 알 수 없는 값, 아직 정의되지 않은 값, 알려지지 않은 값 등등...
-- null은 0(숫자)나 공백(문자)과는 다른 특수한 값, 모든 데이터 타입에 사용 가능함.

-- 커미션을 받지 않는 사원들은 null값이 저장됨.
select employee_id, last_name, job_id, salary, commission_pct
from employees;

-- 부서를 배정 받지 못한 사원은 null값이 저장됨.
select employee_id, last_name, department_id
from employees;

-- employees 테이블에서 사번, 이름, 급여, 수당비율, 연봉을 출력하시오.
-- 100 + null = null
-- 100 - null = null
-- 100 * null = null
-- 100 / null = null
-- 12*240000 + null / 7 + 3000 = null
-- 산술식에 null값이 포함된 경우 결과는 무조건 null이다!!!
select employee_id, last_name, salary, commission_pct,
       (12*salary)+(12*salary*commission_pct)
from employees;
-- => 수당을 받는 사원은 연봉이 정상 출력되나,
--    수당을 받지 않는 사원은 null값때문에 연봉이 출력되지 않음!

-- Column Alias
-- 컬럼명이나 산술식으로 작성된 컬럼의 제목을 원하는 이름으로 출력하는 방법
-- [문법1] 컬럼명 as alias
-- [문법2] 컬럼명 alis
-- [문법3] 컬럼명 [as] "별칭" => 공백, (_, #, $)를 제외한 특수문자(한글 포함)를 포함한 경우

select employee_id, last_name, salary, salary*12 as "연간 급여" 
from employees;

select employee_id as emp_number, last_name as "이름",
      salary "급여", commission_pct "수당 비율"
from employees;

-- distinct 키워드
-- 컬럼에서 중복값을 제거하고 한번만 출력해주는 키워드 

-- employees테이블에서 사원들이 소속된 부서의 종류(부서리스트)를 출력하시오.
select distinct department_id
from employees; 

-- employees 테이블에서 사원들의 부서 내 담당업무 종류를 출력하시오.
select distinct department_id, job_id
from employees;    

-- <연습문제>
-- 1.
select employee_id "Emp #", last_name "Employee", job_id "Job", hire_date "Hire Date"
from employees;

-- 2.
select distinct job_id
from employees;