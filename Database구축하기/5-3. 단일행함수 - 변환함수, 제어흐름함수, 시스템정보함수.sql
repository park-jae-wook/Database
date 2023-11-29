-- [SQL문법] 5-3. 단일행함수 - 변환함수, 제어흐름함수, 시스템정보함수
use hr;

-- (1) 변환함수
-- date_format(날짜, 형식) : 날짜를 형식에 맞게 출력해주는 함수
select date_format(now(),'%y/%M/%d')as"Now";
select date_format(now(),'%Y/%b/%d %H:%i %W')as"Now";
select employee_id, date_format(hire_date,'%Y-%M-%d %W')as "입사일"
from employees;

-- cast(값 as 데이터타입) : 값을 지정된 데이터타입으로 변환하는 함수
select cast('123' as signed), cast('-123.45' as signed);
select cast('123' as unsigned), cast('123.45' as unsigned);
select cast('2022@03@18' as date);

select cast('2022-01-02 21:24:33.123' as date) as "DATE",
       cast('2022-01-02 21:24:33.123' as time) as "TIME",
       cast('2022-01-02 21:24:33.123' as datetime) as "DATETIME";
       
-- (2) 제어흐름함수       
-- if(조건문, 참일때 반환할 값, 거짓일때 반환할 값) : 조건문이 참이면 두번째 인수, 
--                                         거짓이면 세번째 인수 반환함.               
select if(100>200, '참', '거짓') as "결과";

select employee_id, salary, if(salary>10000, '1등급','2등급') as "급여 등급"
from employees;

-- ifnull(인수1, 인수2) : null값을 실제값으로 변환해주는 함수
--                     인수1이 null이 아니면 인수1이 반환되고,
--                     인수1이 null이면 인수2가 반환되는 함수
select ifnull(null, '널이군요') as "결과1",
	   ifnull(100, '널이군요') as "결과2";

select employee_id, last_name, ifnull(department_id, '부서 미정') as "부서"
from employees;

select employee_id, last_name, salary, ifnull(commission_pct, 0) as com_pct
from employees;
-- (예제) employees 테이블에서  전 직원들의 employee_id, last_name, salary,
-- commission_pct, 연봉을 출력하시오.
-- 연봉 공식 : (12 * salary) + (12 * salary * commission_pct)
select employee_id, last_name, last_name, salary, commission_pct,
(12 *salary) + (12 * salary * ifnull(commission_pct, 0)) as "연봉"
from employees;

-- nullif(인수1, 인수2) : 인수1과 인수2가 같으면 null 반환, 다르면 인수1 반환함.
select nullif(100, 100) as "결과1", nullif(100, 200) as "결과2";

select employee_id, first_name, last_name,
       nullif(length(first_name), length(last_name)) as "결과"
from employees;

-- case 구문 : SQL구문에 if
select case 10 when 1 then '일'
               when 5 then '오'
               when 10 then '십'
               else '모름'
end as "case예제";

select employee_id, last_name, department_id,
       case department_id when 10 then '부서 10'
                          when 50 then '부서 50'
                          when 100 then '부서 100'
                          when 150 then '부서 150'
                          when 200 then '부서 200'
                          else '기타 부서'
       end as "부서 정보"                   
from employees;

-- (3) 시스템정보함수
-- user() = current_user() = session_user() : 현재 사용자 정보 반환함.
select user(), current_user(), session_user();

-- database() = schema() : 현재 데이터베이스 정보를 반환함.
select database(), schema();

-- version() : 현재 MySQL 버전 정보를 반환함.
select version();     

-- 연습 문제 
-- 1.
select last_name,ifnull(commission_pct, 'No Commission') as COMM
from employees;

-- 2.
select employee_id, last_name, job_id,
       case job_id when 'AD_PRES' then 'A'
                   when 'ST_MAN' then 'B'
                   when 'IT_PROG' then 'C'
                   when 'SA_REP' then 'D'
                   when 'ST_CLERK' then 'E'
                   else 'O'
         end as 'grade'          
from employees;                    