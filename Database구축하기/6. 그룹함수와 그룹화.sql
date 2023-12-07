-- [SQL문법] 6. 그룹함수와 그룹화
use hr;

-- (1) 그룹함수
-- 그룹함수(=다중행함수)란?
-- 행그룹을 조작해서 하나의 결과값을 반환하는 함수
-- 그룹함수 종류 : sum, avg, max, min, count
-- 그룹함수 특징 : null값은 제외하고 작업함.

-- min(행그룹) : 행그룹에서 최소값을 반환함. 
--             모든 데이터타입에 사용 가능함.
-- max(행그룹) : 행그룹에서 최대값을 반환함.
--             모든 데이터타입에 사용 가능함.
select min(salary) as "최소급여", max(salary) as "최대급여"
from employees;

 select min(hire_date) as "가장 예전 입사일",
        max(hire_date) as "가장 최근 입사일"
 from employees;
 
 select min(last_name), max(last_name)
 from employees;
 
-- sum(행그룹) : 행그룹의 합계를 구해주는 함수
-- avg(행그룹) : 행그룹의 평균을 구해주는 함수
select sum(salary) as "급여 합계", avg(salary) as "급여 평균"
from employees;

select sum(salary) as "급여 합계", avg(salary) as "평균 급여"
from employees
where job_id like '%REP%';

-- count(*) : 모든 컬럼을 기준으로 행의 개수를 반환하는 함수
--            (null값 포함, 중복값 포함)
-- count(행그룹) : 특정 컬럼을 기준으로 행의 개수를 반환하는 함수
--               (null값 제외, 중복값 포함)
-- count(distinct 행그룹) : 특정 컬럼을 기준으로 중복값 제외하고
--                         행의 개수를 반환하는 함수
--                         (null값 제외, 중복값 제외)
                          
select count(*)
from employees;     -- 전체 직원 수 
-- (==)
select count(employee_id)
from employees;     -- 전체 직원 수 

select count(commission_pct)
from employees;     -- 커미션을 받는 직원 수

select count(department_id)
from employees;     -- 부서가 있는 직원 수

select count(distinct department_id)
from employees;             -- 직원들이 소속된 부서의 수

-- (예제) employees 테이블에서 전체 직원의 커미션 평균을 구하시오.
-- [결과] avg_comm
select avg(ifnull(commission_pct,0)) as avg_comm
from employees;

-- (2) group by절 - 그룹화
-- 테이블 내에서 작은 그룹화를 나눠서 그룹함수를 적용할때 사용되는 절
-- [문법] select 컬럼명1, 그룹함수(컬럼)
--       from 테이블명
--      [where 조건문]
--      [group by 컬럼명]
--      [order by 컬럼명];

select department_id, avg(salary)
from employees
group by department_id
order by department_id;

-- (3) having절 - 그룹에 대한 조건문
-- [문법] select 컬럼명1, 그룹함수(컬럼)
--       from 테이블명
--      [where 조건문]     --> 행 제한 조건문 작성
--      [group by 조건문]     
--      [having 조건문]    --> 행그룹 제한 조건문 작성(그룹함수가 포함된 조건문)
--      [order by 컬럼명]

select job_id, sum(salary) payroll
from employees
where job_id not like '%rep%'
group by job_id
having sum(salary) > 13000
order by sum(salary);

-- 1.
select round(avg(ifnull(commission_pct,0)),2) as avg_comm
from employees;

-- 2. 
select job_id, max(salary) as Maximum, min(salary) as Minimum, 
sum(salary) as Sum, avg(salary) as Average
from employees 
group by job_id;

-- 3.
select job_id, count(*)
from employees
group by job_id;

-- 4. 
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000
order by manager_id desc;

-- 5.
select max(salary) - min(salary)  difference
from employees;

-- 6.
select count(*) total,count(if(year(hire_date)=1995, 1, null)) "1995",
                      count(if(year(hire_date)=1996, 1, null)) "1996",
                      count(if(year(hire_date)=1997, 1, null)) "1997",
					  count(if(year(hire_date)=1998, 1, null)) "1998"
from employees;
-- (==)
select count(*) total,sum(if(year(hire_date)=1995, 1, 0)) "1995",
                      sum(if(year(hire_date)=1996, 1, 0)) "1996",
                      sum(if(year(hire_date)=1997, 1, 0)) "1997",
					  sum(if(year(hire_date)=1998, 1, 0)) "1998"
from employees;


