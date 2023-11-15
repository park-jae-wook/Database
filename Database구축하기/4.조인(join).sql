-- [SQL문법] 4. 조인(join)
use hr;

-- 조인(join)이란?
-- 여러 테이블의 정보(컬럼)를 함께 출력하기 위해서 사용하는 구문
-- [문법] select 컬럼1, 컬럼2, 컬럼3,...
--       from 테이블A join 테이블B
--       on 테이블A.컬럼 = 테이블B.컬럼
--       [where 조건문]
--       [order by 컬럼명];

-- [예제1] employees 테이블과 departments 테이블 사용해서
-- 직원 정보(employee_id, last_name, job_id, salary)와
-- 직원이 소속된 부서 정보(department_id, department_name)를
-- 함께 출력하시오.
select employee_id, last_name, job_id, salary,
      departments.department_id, department_name
from employees join departments
on employees.department_id = departments.department_id
order by employee_id;

select employees.employee_id,employees.last_name, 
employees.job_id, employees.salary,
departments.department_id, departments.department_name
from employees join departments
on employees.department_id = departments.department_id
order by employees.employee_id;
-- (==)
select e.employee_id,e.last_name, 
e.job_id, e.salary,
d.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id
order by e.employee_id;

-- [예제2] departments 테이블과 locations 테이블을 사용해서
-- 부서 정보(department_id, department_name, manager_id)와 
-- 부서의 위치 정보(location_id, city)를 함께 출력하시오.
select d.department_id, d.department_name, d.manager_id,
       l.location_id, l.city
from departments d join locations l
on d.location_id = l.location_id
order by d.department_id;

-- [예제3] employees 테이블과 departments 테이블을 사용해서
-- 부서 정보(department_id, department_name, manager_id)와
-- 부서의 매니저 이름(last_name)을 출력하시오. 
select d.department_id, d.department_name, d.manager_id as "매니저 ID",
       e.last_name as "매니저 이름"
from departments d join employees e
on d.manager_id = e.employee_id; 

-- [예제4] employees 테이블과 jobs 테이블을 사용해서
-- 직원 정보(employee_id, last_name, email, job_id)와
-- 직원의 담당 업무명(job_title)을 함께 출력하시오.
select e.employee_id, e.last_name, e.email, e.job_id,
j.job_title
from employees e join jobs j
on e.job_id = j.job_id
order by e.employee_id;

-- N개 테이블 조인하기 
-- 테이블수 | 조인조건수 
-- ----------------    
--    2       1
--    3       2
--    N      N-1

-- [예제5] employees, departments, locations 테이블을 사용해서 
-- 직원 정보(employee_id, last_name, salary)와
-- 직원이 소속된 부서 정보(department_id, department_name)와
-- 부서의 위치 정보(location_id, city)를 함께 출력하시오.
select e.employee_id, e.last_name,e.salary ,d.department_id, 
d.department_name, l.location_id, l.city
from employees e join departments d join locations l
on d.location_id = l.location_id
order by e.employee_id;
-- (==)
select e.employee_id, e.last_name,e.salary ,d.department_id, 
d.department_name, l.location_id, l.city
from employees e join departments d join locations l
on e.department_id = d.department_id and d.location_id = l.location_id
order by e.employee_id;

-- self-join(자체조인)
-- 자기 자신 테이블과 조인하는 유형
-- 하나의 테이블을 마치 다른 테이블인듯 테이블 alias를 다르게 부여해서 조인하는 방법

-- [예제6] employees 테이블로부터 직원의 정보(employee_id, last_name,
-- salary, manager_id)와 직원의 매니저 이름(last_name)을 함께 출력하시오.
select e1.employee_id, e1.last_name ,e1.salary, 
e1.manager_id as "매니저 ID", e2.last_name as "매니저이름"
from employees e1 join employees e2
on e1.manager_id = e2.employee_id
order by e1.employee_id;

-- [예제7] employees 테이블과 departments 테이블을 사용해서
-- 직원 정보(employee_id, last_name, salary, hire_date)와
-- 직원이 소속된 부서 정보(department_name)를 함께 출력하되alter
-- 급여가 8000이상인 사원만 출력하고, 사번을 기준으로 오름차순 정렬하시오.
select e.employee_id, e.last_name, e.salary, e.hire_date,
d.department_name
from employees e join departments d
on e.department_id = d.department_id
where salary >= 8000
order by e.employee_id;

-- 1. employees 테이블과 departments 테이블을 조인하여 모든 사원의 
-- 정보와 함께 부서 정보를 함께 출력하시오.

select e.employee_id, e.last_name, e.salary, d.department_id,
d.department_name
from employees e join departments d
on e.department_id = d.department_id
order by e.employee_id;


-- 2. employees 테이블로부터 모든 사원의 last_name, employee_id, 매니저 이름, manager_id를 
-- 함께 출력하시오.
select e1.last_name as "Employee", e1.employee_id as "Emp#",
       e2.last_name as "Manager", e1.manager_id as "Mgr#"
from employees e1 join employees e2
on e1.manager_id = e2.employee_id;
-- (==)
select e1.last_name as "Employee", e1.employee_id as "Emp#",
       e2.last_name as "Manager", e2.employee_id as "Mgr#"
from employees e1 join employees e2
on e1.manager_id = e2.employee_id;

-- [오답] 사원 정보와 사원의 매니저 이름과 매니저의 매니저 ID가 출력됨!
select e1.last_name as "Employee", e1.employee_id as "Emp#",
       e2.last_name as "Manager", e2.manager_id as "Mgr#"
from employees e1 join employees e2
on e1.manager_id = e2.employee_id;

