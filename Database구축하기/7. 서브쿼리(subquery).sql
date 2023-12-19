-- [SQL문법] 7. 서브쿼리(subquery)
use hr;

-- 서브쿼리(subquery)란?
-- 쿼리구문 안에 또다시 쿼리구문이 들어가 있는 형태
-- 서브쿼리가 먼저 실행되고 그 결과값을 활용해서 메인쿼리가 실행됨.
-- [문법] select 컬럼명1, 컬럼명2, 컬럼명3
--       from 테이블명
--       where 컬럼명 = (select 컬럼명
--                      from 테이블명                       
--                      where 조건문)
--        group by 컬럼명
--        having 조건문
--        order by 컬럼명;

-- 서브쿼리 사용 가능한 곳 : select절, from절, where절, having절,
--                    order by절, DML, DDL 등 사용 가능함.
--                    (group by절을 제외)
-- 서브쿼리 유형 : 단일행 서브쿼드, 다중행 서브쿼리

-- employees 테이블에서 last_name이 Abel인 직원보다 급여를 더 많이
-- 받는 사원을 출력하시오.
select employee_id, last_name, salary, department_id
from employees
where salary > (select salary      
                from employees
                where last_name = 'Abel');
                
-- (1) 단일행 서브쿼리                 
-- 서브쿼리로부터 단일행(단일값)이 반환되는 유형
-- 단일행 서브쿼리인 경우 메인쿼리에 단일행 비교연산자 필요함.
-- 단일행 비교연산자 : =, >, >=, <, <=, <>, !=           

    
select last_name, job_id
from employees
where job_id = (select job_id
				from employees
				where employee_id = 141);      
                
select last_name, job_id, salary
from employees
where salary = (select min(salary)
	           from employees);
               
select last_name, job_id, salary
from employees
where job_id = (select job_id
                from employees
                where last_name = 'Lee')
and salary > (select salary
              from employees
              where last_name = 'Lee');
              
select department_id, min(salary)
from employees
where department_id is not null
group by department_id
having min(salary) > (select min(salary)
                      from employees
                      where department_id = 30);
-- 오류                      
select employee_id, last_name
from employees
where salary = (select min(salary)
                from employees
                group by department_id);
                
select employee_id, last_name
from employees
where salary in (select min(salary)
                from employees
                group by department_id);
               
-- 'Hass'와 동일한 업무를 담당하는 직원을 출력하시오.
-- 결과가 나오지 않는 이유 : Haas 직원이 존재하지 않음.               
select last_name, job_id
from employees
where job_id = (select job_id
                from employees
                where last_name = 'Hass');
                
select job_id
                from employees
                where last_name = 'Hass';               
               
-- (2) 다중행 서브쿼리 
-- 서브쿼리로부터 메인쿼리로 다중행(다중값)이 반환되는 유형              
-- 메인쿼리에는 우변에 값리스트가 올 수 있는 다중행 비교연산자가 필요함.
-- 다중행 비교연산자 종류 : in, not in, any, all
-- =any         : (=, OR)  (==)    in     : (=, OR)  
-- >any         : (>, OR)   : 최소값보다 크면 된다.
-- >=any        : (>=, OR)  : 최소값보다 크거나 같으면 된다.
-- <any         : (<, OR)   : 최대값보다 작으면 된다.
-- <=any        : (<=, OR)  : 최대값보다 작거나 같으면 된다.
-- <>any        : (<>, OR)  : 활용도가 낮음.
-- =all         : (=, AND)  : 활용도가 낮음.
-- >all         : (>, AND)  : 최대값보다 크면 된다.
-- >=all        : (>=, AND) : 최대값보다 크거나 같으면 된다.
-- <all         : (<, AND) : 최소값보다 작으면 된다.
-- <=all        : (<=, AND) :최소값보다 작거나 같으면 된다. 
-- <>all        : (<>, AND)  (==)  not in : (<>, AND) 

select employee_id, last_name, manager_id, department_id
from employees
where manager_id in (select manager_id
                     from employees
					 where employee_id in (174, 141))
and department_id in (select department_id
                     from employees
					 where employee_id in (174, 141))         
and employee_id not in (174, 141);                
               
select employee_id, last_name, job_id, salary
from employees
where salary < ANY (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <>  'IT_PROG';                   

select employee_id, last_name, job_id, salary
from employees
where salary < ALL (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <>  'IT_PROG';                    

-- 부서별 최소급여를 받는 사원의 정보를 출력하시오.
select employee_id, first_name, department_id, salary
from employees
where (department_id, salary) in (select department_id, min(salary)
                                 from employees
                                 group by department_id)
order by department_id;      

-- 자기 밑에 부하직원이 없는 즉, 자기자신이 매니저가 아닌 사원 출력하시오!
-- 결과값이 없음(null값 출력됨)
-- 원인 : 다중행 서브쿼드인 경우 넘어오는 값리스트에 null값이 포함되어 있는데
--       메인쿼리에 and의 성격을 가지는 비교연산자를 사용하면 전체 결과는 null이다!
select employee_id, last_name, job_id
from employees
where employee_id not in (select manager_id
				          from employees);
                          
-- 수정
select employee_id, last_name, job_id
from employees
where employee_id not in (select manager_id
				          from employees
                          where manager_id is not null);
                          
-- 1.
select last_name, hire_date
from employees
where department_id in (select department_id
                     from employees
                     where last_name = 'Abel')
and last_name <> 'Abel';
                   
-- 2.
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary)
                from employees)
 order by salary;
 
 -- 3.
 select employee_id, last_name
 from employees
 where department_id = any (select department_id
                           from employees
						   where last_name like '%u%');
                
-- 4.
select employee_id, last_name, department_id, job_id
from employees
where department_id in (select department_id
                       from departments
					   where location_id = 1700);
-- 5.
select employee_id, last_name, salary
from employees;


-- 6.

-- 7.
select department_id, department_name
from departments
where department_id not in (select department_id
                            from employees
                            where department_id is not null);


















               
               
               
               
               
               
               
               
               
               
               