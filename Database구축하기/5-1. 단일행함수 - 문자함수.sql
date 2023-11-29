-- [SQL문법] 5-1. 단일행함수 - 문자함수
use hr;

-- 함수란?
-- 인수를 받아서 정해진 조작을 한 후 반드시 하나의 결과값을 반환함.
-- SQL함 유형 : 단일행함수, 다중행함수(그룹함수)

-- 단일행함수란?
-- 행당 조작해서 하나의 결과값을 반환하는 함수 유형

-- ascii(문자) : 해당 문자의 아스키코드값을 반환함.
-- char(숫자) : 아스키코드값(숫자)에 해당하는 문자를 반환함.
select ascii('A'), ascii('a');
select char(65), char(97);

-- length(문자열) : 문자열의 bytes 수를 반환함.
-- bit_length(문자열) : 문자열의 bit 수를 반환함.
-- char_length(문자열) : 문자열의 문자의 개수를 반환함.
select length('java'), bit_length('java'), char_length('java');
select length('가나다'), bit_length('가나다'), char_length('가나다');
select last_name, length(last_name)
from employees;

-- concat(인수1, 인수2, ..., 인수n) : 인수를 연결해서 하나의 문자열로 반환함.
-- concat_ws(인수1, 인수2, ..., 인수n) : 구분자와 함께 인수를 연결함.
select employee_id, concat(first_name, last_name) as "이름"
from employees;

select employee_id, concat(first_name,'',last_name) as "이름"
from employees;

select concat('A','/','B','/','C','/','D','/','E') as value;
-- (==)
select concat_ws('/','A','B','C','D','E') as value;

select concat_ws('--',last_name, job_id, salary) as value
from employees;

-- instr(문자열, 특정문자) : 문자열로부터 특정문자의 첫번째 위치값을 반환함.
select instr('daceaes','a'), instr('하나둘셋', '둘');
select last_name,instr(last_name,'a') as "a의 첫번째 위치는?"
from employees;

-- upper(문자열) : 문자열을 대문자로 변환함.
-- lower(문자열) : 문자열을 소문자로 변환함.
select employee_id, upper(last_name) as "L-name",
       lower(job_id) as "Job", lower(email) as "E-mail"
from employees;

select concat('The job id for',upper(last_name),'is',lower(job_id))
       as value
from employees;

-- left(문자열, 길이) : 문자열로부터 왼쪽부터 해당 길이만큼 반환함.
-- right(문자열, 길이) : 문자열로부터 오른쪽부터 해당 길이만큼 반환함.
select left('abcdefg',3), right('abcdefg',3);
select left('9012231122334', 6) as "생년월일";
select concat(left('010-1234-5678', 3), '-****-',right('010-1234-5678',4))
       as "당첨자 전화번호";
select last_name, left(last_name, 2), right(last_name, 2)
from employees;       

-- lpad(문자열, 전체자리수, 채울문자) : 전체자리수만큼 잡아서 문자열을 출력하되
--                                   남는 공간이 있다면 왼쪽부터 채울문자로 채워주는 함수
--                                    오른쪽 정렬 함수
-- rpad(문자열, 전체자리수, 채울문자) : 전체자리수만큼 잡아서 문자열을 출력하되
--                                남는 공간이 있다면 오른쪽부터 채울문자로 채워주는 함수
--                                왼쪽 정렬 함수
select lpad('가나다', 10, '#'), rpad('가나다',10, '#');
select lpad(last_name, 20, ' ')as "L-name",
	   rpad(first_name, 20, ' ')as "F-name"
from employees;

-- ltrim(문자열) : 문자열의 왼쪽 공백을 제거함.
-- rtrim(문자열) : 문자열의 오른쪽 공백을 제거함.
-- trim(문자열) : 문자열의 왼쪽/오른쪽(앞/뒤) 공백을 모두 제거함.
-- trim(방향 제거문자 from 문자열) : 방향 - leading(앞), trailling(뒤), both(양쪽)
--                               문자열로부터 해당 방향에 있는 제거문자를 삭제함.
select ltrim('             SQL 문법'), rtrim('       SQL 문법');
select concat(trim('              SQL 문법       '), 'abc');
select trim(both '_'from '___SQL_문법_________');
select trim(leading '0' from '08');

-- replace(문자열, 기존문자, 바꿀문자) : 문자열에서 기존문자를 바꿀문자로 교체함.
select employee_id, last_name, 
replace(phone_number, '.', '-') as phone
from employees;

-- space(길이) : 길이만큼의 공백을 반환해 주는 함수 
select concat('A','                            ','B') as "결과";
-- (==)
select concat('A', space(30), 'B') as "결과";

-- substr(문자열, 시작위치, 반환할문자수) : 문자열의 일부분을 반환해 주는 함수
--                                   문자열을 시작위치부터 반환할 문자수만큼 반환함.
select substr('대한민국만세', 3, 2);

select last_name, substr(last_name, 2, 3)
from employees;

select last_name, substr(last_name, 1, 2)
from employees;
-- (==)
select last_name, left(last_name,  2)
from employees;

select last_name, right(last_name,  2)
from employees;
-- (==)
select last_name, substr(last_name, -2, 2)
from employees;

-- <연습 문제>

-- 1.
select last_name,length(last_name) as "Length"
from employees
where left(last_name, 1) in ('J','M','A')
order by last_name;
-- (==)
select last_name as "Name", length(last_name) as "Length"
from employees
where substr(last_name,1, 1) in ('J','M','A')
order by last_name;
-- (==)
SELECT last_name as "Name", LENGTH(last_name) as "Length"
FROM employees
WHERE last_name LIKE 'J%'
OR last_name LIKE 'M%'
OR last_name LIKE 'A%'
ORDER BY last_name;


-- 2.
select last_name, LPAD(salary, 15,'$') as salary
from employees;

-- 3.
-- [오답] rpad함수 두번째 인수가 실수인 경우 백의 자리는 반올림해서 처리하는 방식
select salary, CONCAT(last_name, rpad(' ', salary/1000+1, '*')) 
       as EMPLOYEES_AND_THEIR_SALARIES
from employees
order by salary desc;


select salary, concat(last_name,rpad(' ', truncate(salary/1000,0)+1, '*')) as "EMPLOYEES_AND_THEIR_SALARIES"
from employees
order by salary desc;