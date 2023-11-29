-- [SQL문법] 5-2. 단일행함수 - 숫자함수, 날짜함수
use hr;

-- (1) 숫자함수
-- round(숫자, 반올림할자리) : 숫자를 반올림할 자리까지 반올림을 해주는 함수
-- truncate(숫자, 버림할자리) : 숫자를 버림할 자리까지 남기고 버림을 해주는 함수
-- 숫자 : 1   2   3  .  4   5   6
-- 자리 :-2  -1   0     1   2   3
select round(45.923, 2), round(45.923, 0), round(45.923, -1);
select truncate(45.923, 2), truncate(45.923,0), truncate(45.923,-1);

-- ceil(숫자) : 일의 자리로 올림을 해주는 함수
-- floor(숫자) : 일의 자리까지 버림을 해주는 함수
select ceil(45.923), ceil(52.1);
select floor(45.923), floor(52.1);
-- (==)
select truncate(45.923, 0), truncate(52.1, 0);

-- mod(숫자1, 숫자2) : 숫자1을 숫자2로 나눈 나머지를 반환해 주는 함수
select mod(157, 10), 157 mod 10, 157 % 10, 157 / 10;
select employee_id, last_name, salary, mod(salary, 5000)
from employees
where job_id= 'SA_REP';

-- abs(숫자) : 숫자의 절대값을 반환해 주는 함수

select abs(-5), abs(5), abs(-4.5);

-- power(숫자, 제곱값) = pow(숫자, 제곱값) : 
select power(2, 3), power(8, 3);

-- sign(숫자) : 숫자가 양수면 1, 음수이면 –1, 0이면 0을 반환해 주는 함수
select sign(3), sign(-3), sign(0),sign(4.26), sign(-4.26);

-- (2) 날짜함수
-- now() = sysdate() = current_timestamp() : 현재 날짜/시간을 반환함.
--                                           (년/월/일/시/분/초)
select now(), sysdate(), current_timestamp();

-- current_date() = curdate() : 현재 날짜를 반환함.(년/월/일)
-- current_time() = curtime() : 현재 시간를 반환함.(시/분/초)
 select current_date(), curdate();
 select current_time(), curtime();
 
 -- year(날짜) : 날짜/시간에서 년도를 반환함.
 -- month(날짜) : 날짜/시간에서 월을 반환함.
 -- day(날짜) : 날짜/시간에서 일을 반환함.
 -- hour(시간) : 날짜/시간에서 시를 반환함.
 -- minute(시간) : 날짜/시간에서 분을 반환함.
 -- second(시간) : 날짜/시간에서 초을 반환함.
select year(now()), month(now()), day(now()),
       hour(now()), minute(now()), second(now());
select last_name, hire_date,
		year(hire_date), month(hire_date), day(hire_date)
from employees
where department_id = 90;
  
  -- (예제) 
  
select employee_id, last_name, hire_date, salary
from employees
where year(hire_date) = 1990;
   
-- date(날짜와시간) : 날짜와 시간에서 날짜를 반환함(년/월/일)
-- time(날짜와시간) : 날짜와 시간에서 시간을 반환함(시/분/초)
select date(now()), time(now());
use shopdb;
select * 
from orders;
   
select order_num, member_id, prod_id, date(order_date) as "주문일자"
from orders;
use hr;
   
-- adddate(날짜, 기간) = date_add(날짜, 기간) : 날짜에서 기간을 더한 날짜 반환함.
-- subdate(날짜, 기간) = date_sub(날짜, 기간) : 날짜에서 기간을 뺀 날짜 반환함.
select adddate('2022-01-01', interval 35 day),
       adddate('2022-01-01', interval 2 month),
       date_add('2022-01-01', interval 1 year);
       
select subdate('2022-01-01',interval 35 day),
       subdate('2022-01-01',interval 2 month),
       date_sub('2022-01-01',interval 1 year);
       
select last_name, hire_date, 
 adddate(hire_date, interval 6 month) as "입사 6개월 후", 
 subdate(hire_date, interval 7 day) as "입사 7일전"
from employees
where department_id = 60;       
   
-- addtime(날짜와시간, 시간) : 날짜/시간에서 시간을 더한 결과 반환함.
-- subtime(날짜와시간, 시간) : 날짜/시간에서 시간을 뺀 결과 반환함.   
select addtime('2022-01-01 23:59:59', '1:1:1'),
       addtime('15:00:00', '2:10:10'); 
   
select subtime('2022-01-01 23:59:59', '1:1:1'),
       subtime('15:00:00', '2:10:10'); 
   
-- datediff(날짜1, 날짜2) : 날짜1에서 날짜2를 뺀 결과 반환함.
-- timediff(시간1, 시간2) : 시간1에서 시간2를 뺀 결과 반환함. 
select datediff('2023-12-31', now());
 select abs(datediff(now(),'2023-12-31'));
select datediff('2024-04-19', now());  
select timediff('23:23:59', '12:11:10');

select last_name, hire_date, datediff(now( ), hire_date) as "근무한 일수" 
from employees;  

-- dayofweek(날짜) : 날짜의 요일값을 반환해 주는 함수
--                 (1-일, 2-월, 3-화, 4-수, 5-목, 6-금, 7-토)
-- monthname(날짜) : 날짜의 월의 영문 이름을 반환함.
-- dayofyear(날짜) : 날짜가 1년 중 몇 번째 날짜인지 반환함.
select dayofweek(now());
select monthname(now());
select dayofyear(now());
-- (예제) 금요일에 입사한 직원만 출력하시오.
select employee_id, last_name, hire_date
from employees
where dayofweek(hire_date) = 6;

-- last_day(날짜) : 해당 날짜가 속한 월의 마지막 날짜를 반환함.   
select last_day(now());
select last_day('2022-02-13');
select employee_id, last_name, hire_date, last_day(hire_date)
from employees;

-- quarter(날짜) : 날짜가 4분기 중에서 몇 분기인지 반환함.
select quarter('2023-01-28'),quarter('2023-02-02'), quarter('2023-03-24'),
       quarter('2023-04-10'),quarter('2023-05-05'), quarter('2023-06-13'),
       quarter('2023-07-08'),quarter('2023-08-09'), quarter('2023-09-30'),
       quarter('2023-10-01'),quarter('2023-11-24'), quarter('2023-12-25');
-- 1.
select employee_id, last_name, salary, round(salary*1.155,0) as "New salary" 
from employees;

-- 2.
select employee_id, last_name, salary , round(salary*1.155,0) as "New salary",
round(salary*0.155,0) as "Increase"
from employees;

-- 3.
select employee_id, last_name, job_id ,hire_date, department_id
from employees
where month(hire_date) = 02;

-- 4.
select employee_id, last_name, hire_date, salary, department_id
from employees
where year(hire_date) between 1990 and 1995;


-- 5.
select last_name, hire_date, date(now()),datediff(now( ), hire_date) as "근무한 일수",
floor(datediff(now(), hire_date)/7) as "근무한 주수"
from employees;

-- 6.
select employee_id, last_name, hire_date, quarter(hire_date) as "입사한 분기"
from employees;





















   
   
   
   
   