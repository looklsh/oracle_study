--현재 접속 계정 내 테이블 확인
SELECT * FROM tab;
--employees 테이블 구조 확인
DESC employees;

--select : dmal

--기본적인 select문: 전체 데이터의 조회
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

--projection의 제한: 원하는 컬럼의 목록ㅇ을 select에 지정
--사원의 이름()과 전화번호,입사일,급여 출력
SELECT FIRST_NAME, PHONE_NUMBER, HIRE_DATE, SALARY
FROM employees;

--산술연산: 기본적인 산술 연산 가능
SELECT 3.14159 * 10 * 10 FROM DUAL;
SELECT 3.14159 * 10 * 10 
FROM EMPLOYEES;
--특정 테이블에 연관 없는 단일 결과는 DUAL에서 수행하자
--산술 연산을 할 때 특정 컬럼을 계산에 포함시킬 수 있다
SELECT FIRST_NAME, 
    SALARY,
    SALARY * 12
FROM EMPLOYEES;

--산술연산을 수행할때 컬럼의 데이터 타입은 NUMBER여야 한다
SELECT FIRST_NAME, JOB_ID * 12 FROM employees;
--ERROR: JOB_ID는 NUMBER가 아니라서 산술연산 불가

--문자열 연결
SELECT FIRST_NAME + ' ' + LAST_NAME FROM employees;
--ERROR :문자열은 +로 연결할 수없다
SELECT FIRST_NAME ||' '||  LAST_NAME FULL_NAME
FROM EMPLOYEES;
--컬럼 혹은 표현식에 별명을 붙일 수 있다

--커미션까지 포함해서 급여 지급
SELECT FIRST_NAME, 
    SALARY, COMMISSION_PCT,
    SALARY + SALARY * COMMISSION_PCT
FROM employees;    
--산술연산식을 수행할때 NULL이 포함되어 있으면
--결과는 NULL

--NVL(EXPR1,EXPR2):EXPRL 체크 NULL이 아니면 EXPR1
--NULL이면 EXPR2
SELECT FIRST_NAME,
    SALARY,
    SALARY + SALARY * NVL(commission_pct,0) PAID
FROM employees;    

--WHERE(SELECTION)
--급여가 15000이상인 사원의 이름, 급여 출력
SELECT FIRST_NAME, SALARY
FROM employees
WHERE SALARY >= 15000;

--날짜도 비교연산이 가능
--입사일이 85/01/01 이후인 사원의 이름, 입사일, 급여
SELECT FIRST_NAME, HIRE_DATE, SALARY
FROM employees
WHERE HIRE_DATE >= '07/01/01';

--이름이 LEX인 사원의 이름. 입사일, 급여 출력
SELECT FIRST_NAME, HIRE_DATE, SALARY
FROM employees
WHERE FIRST_NAME = 'Lex';

--논리연산 or
--SALARY 14000이하이거나 17000이상인거나
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY <= 14000 OR SALARY >= 17000;

--AND 
--SALARY가 14000이고 17000이하인 사원의 목록
SELECT FIRST_NAME,SALARY
FROM EMPLOYEES
WHERE SALARY >= 14000 AND SALARY <= 17000;

--BETWEEN 연산자
--SALARY14000이상이고 17000이하인 사원 목록
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES 
WHERE SALARY BETWEEN 14000 AND 17000;

--NULL체크 : IS NULL, IS NOT NULL
--커미션을 받는 사원의 목록
SELECT FIRST_NAME, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;
--커미션 받지않는 사람
SELECT FIRST_NAME, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;
--부서 ID가 10이거나 20이거나 40인 직원의 목록
SELECT FIRST_NAME, department_ID
FROM EMPLOYEES
WHERE department_id = 10 OR
    department_id = 20 OR
    DEPARTMENT_ID = 30;
 --IN연산자를 활용
 SELECT FIRST_NAME, DEPARTMENT_ID
 FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN (10,20,30);
 --ANY연산자 활용
 SELECT FIRST_NAME, DEPARTMENT_ID
 FROM EMPLOYEES
 WHERE DEPARTMENT_ID = ANY(10,20,30);
 --사원들 중 DEPARTMENT_ID 10,20,30이 아닌 사원들
 SELECT FIRST_NAME, DEPARTMENT_ID
 FROM EMPLOYEES
 WHERE DEPARTMENT_ID NOT IN(10,20,30);
 --LIKE연산자
 --와일드카드 % : 길이가 정해지지 않은 문자열
 --와일드카드 _ : 1글자의 정해지지 않은 문자
 
 --FIRST_NAME에 AM이 모함된 직원의 목록
 SELECT FIRST_NAME, LAST_NAME
 FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '%am%';
 --first_name의 두 번째 글자가 a인 직원
 SELECT FIRST_NAME, LAST_NAME
 FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '_a%';
 --selection 된 데이터의 정렬
 --ASC(오름차순)
 --DESC(내림차순)
 --부서 번호 오름차순으로 정렬하고 이름, 부서번호, 급여
 SELECT FIRST_NAME, DEPARTMENT_ID, SALARY
 FROM EMPLOYEES
 ORDER BY DEPARTMENT_ID; -- ASC는 생략가능(기본값)
 --급여가 15000 이상인 직원을 추출 급여의 역순
 SELECT FIRST_NAME, SALARY
 FROM EMPLOYEES
 WHERE SALARY >= 15000
 ORDER BY SALARY DESC;
 --부서 번호 오름차순으로 정렬한 후 급여의 역순으로 정렬
 SELECT FIRST_NAME, DEPARTMENT_ID, SALARY
 FROM EMPLOYEES
 ORDER BY DEPARTMENT_ID ASC, SALARY DESC;
 --단일행함수
 --문자열 단일행 함수
 SELECT FIRST_NAME, LAST_NAME,
    FIRST_NAME ||' '||LAST_NAME,
    CONCAT(FIRST_NAME, CONCAT(' ', LAST_NAME), --합침
    LOWER(FIRST_NAME), UPPER(FIRST_NAME)--변환
    ,INITCAP(FIRST_NAME)
FROM EMPLOYEES;    

SELECT LPAD(FIRST_NAME, 20, '*'),
    RPAD(FIRST_NAME, 20, '*')
FROM EMPLOYEES;    

SELECT LTRIM('        ORACLE        '),
    RTRIM('        ORACLE         ')
   TRIM('#' FROM '######Database#####'),
   SUBSTR('Oracle Database', 8, 4),
   SUBSTR('Oracle Database', -8, 4),
   length('Oracle Database')
    
FROM dual;
--수치형 단일행 함수
select abs(-3.14), --절대값
    ceil(3.14), --올림(천장)
    floor(3.14),--소수점 내리기
    mod(7,3),--나머지
    power(2,4),--제곱함수
    round(3.5),--반올림
    round(3.14159,3), -- 소수점 3째자리까지 표시이상에서 반올림
    trunc(3.14159,3) --소수점 3째자리까지 표시 이하 자리는 버림
FROM DUAL;    
 
 
--QUIZ01

--Q1
SELECT FIRST_NAME, LAST_NAME, SALARY
    PHONE_NUMBER, HIRE_DATE
FROM EMPLOYEES;    

SELECT FIRST_NAME ||' '||  LAST_NAME "이름",
     SALARY "급여",
     PHONE_NUMBER "전화번호",
     HIRE_DATE "입사일"
FROM EMPLOYEES;

--Q2
SELECT JOB_TITLE, MAX_SALARY
FROM JOBS
ORDER BY MAX_SALARY;

--Q3
SELECT FIRST_NAME, EMPLOYEE_ID, 
    COMMISSION_PCT, SALARY
FROM EMPLOYEES
WHERE SALARY >  3000 AND COMMISSION_PCT IS NULL;


--Q4
SELECT JOB_TITLE, MAX_SALARY
FROM JOBS
WHERE MAX_SALARY >=10000;

--Q5
SELECT FIRST_NAME, SALARY,
    COMMISSION_PCT
    FROM EMPLOYEES
WHERE SALARY < 14000 AND SALARY >= 10000
ORDER BY SALARY DESC;

--Q6
SELECT * FROM DEPARTMENTS
ORDER BY LENGTH(DEPARTMENT_NAME); 

--Q7
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE REGEXP_LIKE(FIRST_NAME,'S%|s%');
    
--Q8
SELECT COUNTRY_NAME
UPPER(COUNTRY_NAME)
FROM COUNTRIES;

--Q9
SELECT FIRST_NAME, SALARY,
    PHONE_NUMBER, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE > '03/12/31';

--2019/9/20수업
--DATE 기본 포맷 확인
SELECT * FROM nls_session_parameters
WHERE parameter='NLS_DATE_FORMAT';

--현재 날짜 구하기
SELECT sysdate FROM dual; --현재 시스템 날짜
SELECT sysdate FROM employees;

--날짜 관련 연산
--DATE +(-) NUMBER -> ㄴㄹ짜에 일수 더하기 빼기
--DATE - DATE -> 날짜 일수 차이(NUMBER)
SELECT sysdate + 1,
    sysdate - 1,
    sysdate - TO_DATE('1999-12-31'),
    sysdate + 12/24 --0.5일 더한거
    FROM DUAL;
--날짜 관련 함수
SELECT sysdate,
    ADD_MONTHS(sysdate, 2),
    LAST_DAY(sysdate),
    MONTHS_BETWEEN(TO_DATE('1999-12-31', 'YYYY-MM-DD'),
    sysdate),
    ROUND(sysdate, 'MONTH'),
    TRUNC(sysdate, 'MONTH')
FROM dual;    

--현재 날짜를 기준으로 EMPLOYEES 테이블에서
--입사한지 몇 개월이 지났는지 확인
SELECT FIRST_NAME, HIRE_DATE,
    ROUND(
    MONTHS_BETWEEN(sysdate, hire_date)
    )
FROM employees;    

--변환 함수
--TO_CHAR : 날짜, 숫자 -> 문자열로
--TO_DATE : 문자열->날자
--TO_NUMBER : 문자열->숫자
--변환 포맷을 잘 지정해야한다


--EMPLYEES 테이블에서 입사일을 YYYY-MM-DD HH24:MI:SS
SELECT first_name, hire_date,
    TO_CHAR(hire_date, 'YYYY-MM-DD HH24:MI:SS')
FROM employees;


--employees테이블에서 salry정보를->연봉
SELECT first_name, 
    TO_CHAR(salary * 12, '$999,999.99') SAL
FROM employees;

--TO_NUMBER : 문자열->숫자
SELECT TO_NUMBER('1999'),
    TO_NUMBER('$1,234.567', '$999,999.999')
FROM dual;

--TO_DATE:문자열->DATE
SELECT TO_DATE('1999-12-31 23:59:59','YYYY-MM-DD HH24:MI:SS')
FROM DUAL;

SELECT TO_CHAR(3000000, 'L999,999,999')
FROM DUAL;

--NULL관련
--NVL(expr1,expr2)-> expr1dl null이면 expr1


SELECT first_name, salary, 
    salary * nvl(commission_pct, 0) commission
FROM employees;   

--nvl2(expr1,expr2,expr3)
-- 1이 null인지 체크
--not null-> 2
--null->3
SELECT first_name, salary, 
    NVL2(commission_pct,commission_pct * salary,0) commission
FROM employees;    

--CASE함수
--보너스 지급 결정
--AD관련 직원에게는 20%, SA관련 직원에게는 10%, IT관련 직원에게는 8%,
--나머지 직원에게는 5%지급
SELECT job_id 
FROM EMPLOYEES;

SELECT first_name, job_id, salary,
    CASE SUBSTR(job_id, 1, 2)
    WHEN 'AD' THEN salary * 0.2
    WHEN 'SA' THEN salary * 0.1
    WHEN 'IT' THEN salary * 0.08
    ELSE salary * 0.05 
END bonus
FROM employees;

--DECODE함수
SELECT first_name, job_id, salary,
    DECODE(SUBSTR(job_id, 1, 2),
        'AD', salary * 0.2,
        'SA', salary * 0.1,
        'IT', salary * 0.08,
        0.05) bonus
FROM employees;  


--연습문제
SELECT first_name, department_id,
    CASE WHEN department_id <= 30 THEN 'A-GROUP'
        WHEN department_id <= 50 THEN 'B-GROUP'
         WHEN department_id <= 100 THEN 'C-GROUP'
         ELSE 'REMAINDER'
     END team
FROM employees
ORDER BY team ASC;

--------------------------------------------------------------------------------------------------------------
--1. 
SELECT last_name, salary, department_name,commission_pct
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id(+)
AND commission_pct IS NOT NULL;



--2. 
SELECT emp.last_name, emp.salary, emp.job_id
FROM employees emp JOIN employees man
ON emp.manager_id = man.employee_id
WHERE man.last_name = 'King';



--3.
SELECT emp.last_name, emp.salary
FROM employees emp JOIN employees man ON emp.manager_id = man.employee_id
WHERE emp.salary > man.salary;

--4. 
SELECT MIN(salary), MAX(salary), SUM(salary), CEIL(AVG(salary))
FROM employees;

--5.
SELECT last_name, salary
FROM employees outer
WHERE salary < (SELECT AVG(salary) FROM employees WHERE department_id = outer.department_id);











    

        


    





    
 


