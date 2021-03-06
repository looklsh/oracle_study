--JOIN
DESC employees;
DESC departments;

--두 테이블로부터 레코드들을 불러와봅시다
SELECT first_name, department_name
    FROM employees, departments;
--두 테이블의 모든 행의 조합이 출력
--(CROSS JOIN, 카티젼 프로덕트)


--SIMPLE JOIN
SELECT first_name, department_name
FROM employees emp, departments dept
WHERE emp.department_id = 
    dept.department_id;
    
--THETA JOIN, EQUI-JOIN    

--ANSI SQL
SELECT first_name, department_name
FROM employees emp JOIN departments
                    USING (department_id);
                    

--LEFT OUTER JOIN
--모든 직원의 정보를 부서 정보와 함께 출력해 주세요
SELECT first_name, 
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id (+);
--OUTER JOIN에서 NULL이 올 수 있을 쪽 필드에 (+) 사인
SELECT * FROM employees WHERE department_id IS NULL;

--ANSI SQL
SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp LEFT OUTER JOIN departments dept
                    ON emp.department_id = dept.department_id
WHERE emp.department_id IS NULL; 

--RIGHT OUTER JOIN
--모든 부서를 출력에 참여
SELECT first_name, 
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp, departments dept
WHERE emp.department_id (+)= dept.department_id
    AND emp.department_id IS NULL;
    
--ANSI SQL
SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp
    RIGHT OUTER JOIN departments dept
        ON emp.department_id = dept.department_id
WHERE emp.department_id IS NULL;     

--FULL OUTER JOIN
SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp
    FULL OUTER JOIN departments dept
        ON emp.department_id = dept.department_id
WHERE emp.department_id IS NULL OR
    dept.department_id IS NULL;
    

--DEPARTMENTS,LOCATION,COUNTRIES 세 개 JOIN
--DEPARTMENT_ID, DEPARTMENT_NAME, CITY, COUNTRY_NAME출력

SELECT department_id,
    department_name,
    loc.city,
    con.country_name
FROM departments dept 
    JOIN locations loc
        JOIN countries con
        ON loc.country_id = con.country_id
    ON dept.location_id = loc.location_id
ORDER BY con.country_name, loc.city, department_id;

--simple join
SELECT department_id,
    department_name,
    loc.city,
    con.country_name
FROM departments dept, locations loc, countries con
WHERE dept.location_id = loc.location_id AND
    loc.country_id = con.country_id
ORDER BY con.country_name, loc.city, department_id; 


--self join : 자기자신과 join
-- 자기 자신의 PK와 다른 컬럼을 JOIN
--사번, 이름, 매니저 ID, 매니저 이름 출력
SELECT * FROM employees; -- 107명
SELECT emp.employee_id, emp.first_name,
    mgr.employee_id 매니저사번, mgr.first_name 매니저이름
FROM employees emp 
    JOIN employees mgr
    ON emp.manager_id = mgr.employee_id;
    
    
--
SELECT emp.employee_id, emp.first_name,
    mgr.employee_id 매니저아이디, mgr.first_name 매니저이름
FROM employees emp, employees mgr
WHERE emp.manager_id = mgr.employee_id;

--매니저가 없는 직원은 누구인가?
SELECT employee_id, first_name, manager_id
FROM employees
WHERE manager_id IS NULL;

--매니저가 없는 직원도 함께 출력하자(OUTER JOIN)
--ANSI
SELECT emp.employee_id, emp.first_name,
    mgr.employee_id, mgr.first_name
FROM employees emp
    LEFT OUTER JOIN employees mgr
    ON emp.manager_id = mgr.employee_id
ORDER BY emp.employee_id; 

--ORACLE SQL
SELECT emp.employee_id, emp.first_name,
    mgr.employee_id, mgr.first_name
FROM employees emp, employees mgr
WHERE emp.manager_id = mgr.employee_id (+)
ORDER BY emp.employee_id;

--Aggregation
--여러 행으로부터 데이터 수집 하나의 행을 추출
--COUNT
SELECT COUNT(*) FROM  employees; -- *는 null도 포함
SELECT COUNT(MANAGER_ID) FROM employees; --null은 제외

--여러가지 집계함수들
SELECT MAX(salary), MIN(salary),
    AVG(salary), MEDIAN(salary)
FROM employees;

--집계함수의 경우, null값은 계산에서제외
--직원들이 받은 commission_pct통계
SELECT AVG(commission_pct) FROM employees;

--집계에서 commission_pct null인 직원은 0으로 결정
SELECT AVG(NVL(commission_pct, 0)) FROM employees; 

--employees 테이블로부터 부서별 급여의 평균
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
    HAVING AVG(salary) >= 7000
ORDER BY department_id;
--집계 결과의 조건 비교는 where절이 ㅏ니라 having절에서 해야함
--집계 이후의 조건을 판별하려면 WHERE
--집계 이후의 조건을 판별하려면 HAVING

--ROLLUP
--GROUP BY와 함께 사용
--그룹지어진 결과에 대한 상세 정보(ITEM TOTAL) 요약정보를 제공한다
SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY ROLLUP(department_id, job_id)
ORDER BY department_id;

--CUBE
--CROSSTAB SUMMARY
--ITEM TOTAL + COLUMN TOTAL 추출
SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY CUBE (department_id, job_id)
ORDER BY department_id;

--subquery
--질의문 내에서 또다른 질의문을 포함하는 형태
--서브쿼리는 임시테이블

--employees 테이블로부터 급여의 중앙값보다 많이 받는 사람들
--1.급여의 중앙값
SELECT MEDIAN(salary) FROM employees;
--2.중앙값보다 많이 받는 직원의 목록
SELECT first_name, salary FROM employees
WHERE SALARY > 6200;
--3.두 쿼리를 합친다
SELECT first_name, salary 
FROM employees
WHERE SALARY > (SELECT MEDIAN(salary) FROM employees)
ORDER BY salary DESC;

--
SELECT * FROM employees;
--직원 중에서 ISMAEL보다 늦게 입사한 사람들의 목록
--1.ISMAEL의 입사일 확인
SELECT hire_date FROM employees
WHERE first_name = 'Ismael';
--2. 이 날자보다 늦게 입사한 사람의 목록
SELECT first_name, hire_date FROM employees
WHERE hire_date > '05/09/30';
--3. 두 쿼리를 합쳐봅시다
SELECT first_name, hire_date 
FROM employees
WHERE hire_date > (SELECT hire_date FROM employees
                    WHERE first_name = 'Ismael')
ORDER BY hire_date;

--susan보다 늦게 입사했는데 평균급여보다 많이 받는 직원의 목록
--subquery로 susan의 hire_date , 평균 급여를 확인해야 함
SELECT first_name, hire_date, salary
FROM employees
WHERE hire_date > (SELECT hire_date FROM employees
                    WHERE first_name='susan')
    AND salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;


--QUIZ02
--Q1
SELECT emp.employee_id, emp.first_name,
    department_name, 
    dept.department_id, mgr.first_name
FROM employees emp, employees mgr, departments dept
WHERE emp.department_id = dept.department_id AND emp.manager_id = mgr.employee_id;

--Q2
SELECT region_name, country_name
FROM regions reg
    JOIN countries cou
    ON reg.region_id = cou.region_id
ORDER BY region_name, country_name;

--Q3
SELECT department_id, department_name, city, 
    country_name, region_name
FROM departments dept, locations loc,
    countries cou, regions reg
WHERE dept.location_id = loc.location_id 
AND loc.country_id = cou.country_id
AND cou.region_id = reg.region_id;

--Q4
SELECT emp.employee_id, first_Name, last_name , 
    first_name ||' '||  last_name full_name, job_title,
    jh.end_date
FROM employees emp, job_history jh, jobs jb
WHERE emp.employee_id = jh.employee_id
AND jh.job_id = jb.job_id
AND job_title LIKE 'Pu%';



--Q5
SELECT employee_id, first_name, 
    last_name, department_name
FROM employees emp 
    JOIN departments dept
    ON emp.department_id = dept.department_id
ORDER BY last_name;   

--Q6
SELECT emp.employee_id, emp.last_name, mgr.hire_date
FROM employees emp, employees mgr
WHERE emp.manager_id = mgr.employee_id;
    
--09/23수업
--다중행 서브쿼리
--서브쿼리의 결과 레코드가 둘 이상일 경우
--단순 비교 연산자(=, < , >, <> )드은 사용할 수 없음
--집합 관련 연산자(in, any,all,exists)를 이용해야 함
SELECT salary FROM employees WHERE department_id=110;

SELECT first_name, salary
FROM employees
WHERE salary IN (SELECT salary FROM employees WHERE department_id=110);

--서브 쿼리 안에 포함된 급여보다 많이 받는 직원ㅇ들의 목록
SELECT first_name, salary
FROM employees
WHERE salary > ALL (SELECT salary FROM employees WHERE department_id=110);

--ANY (조건 중 하나만 만족하면 만족
SELECT first_name, salary 
FROM employees
WHERE salary > ANY(SELECT salary FROM employees WHERE department_id=110);

--OUTER SUBQUERY(CORRELATED QUERY)
--바깥쪽 쿼리에 사용된 테이블과 서브쿼리가 연관관계를 갖는 
--서브쿼리
--각 부서별로 평균 급여 추출
SELECT department_id, AVG(salary) FROM employees
GROUP BY department_id
ORDER BY department_id ASC;

--모든 직원을 출력, 자신이 속한 부서의 평균 급여보다 
--많이 받는 직원
SELECT first_name, salary, department_id
FROM employees outer
WHERE salary > (select AVG(salary) 
                FROM employees 
                WHERE department_id = outer.department_id);
                
--서브쿼리 연습
--각 부서별로 최고 급여를 받는 사원을 출력
SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id;

--방법1.where절에서 
SELECT department_id, employee_id, first_name, salary
FROM employees
WHERE (department_id, salary) IN(SELECT department_id, MAX(salary)
                                FROM employees
                                GROUP BY department_id
)
ORDER BY department_id;

--서브 쿼리를 임시테이블로 만들어서 JOIN
SELECT emp.department_id, employee_id, first_name, emp.salary
FROM employees emp, 
    (SELECT DEPARTMENT_ID, MAX(salary) salary
    FROM employees
    GROUP by DEPARTMENT_ID) sal
WHERE emp.department_id = sal.department_id
    AND emp.salary = sal.salary
ORDER BY department_id ASC;

--TOO-K QUERY
--상위 K개의 레코드를 추출(순위)
--PSEUDO column rownum: 레코드의 순서를 반환

--employees 테이블에서 2007년 입사자중 급여 순위 5위까지
SELECT rownum, first_name, salary
FROM (select * from employees
        WHERE hire_date LIKE '07%'
        ORDER BY salary DESC)
WHERE rownum <= 5;

--집합 연산
--2005년 1월1일 이전 입사자의 목록(집합): A
SELECT first_name, salary, hire_date
FROM employees
WHERE hire_date < '05/01/01';
--salary가 12000초과인 직원의 목록 : B
select first_name, salary,hire_date
FROM employees WHERE salary > 12000;
--집합연산자 활용
SELECT  FIRST_NAME, salary, hire_date
FROM employees WHERE hire_date < '05/01/01'
--INTERSECT--교집합
--UNION --합집합
MINUS --차집합
SELECT first_name, salary, hire_date
FROM employees WHERE salary > 12000;

--RANK관련 함수
SELECT first_name, salary,
    RANK() OVER (ORDER BY salary DESC) rank,
    DENSE_RANK() OVER (ORDER BY salary DESC) dense_rank,
    ROW_NUMBER() OVER (ORDER BY salary DESC) row_number
FROM employees;
--RANK함수는 중복 순위가 발생시 건너띄고 표기
--DENSE_RANK : 중복 순위 발생해도 순서대로 표기

--Hierachical QUERY
--트리 형태 구조로 추출
--level pseudo column활용

--employees테이블로부터 조직도를 출력
--level, 직원 이름, 직원의 성, 매니저의 이름, 매니저의 성
--level의 오름차순으로 출력
SELECT level, emp.first_name, emp.last_name,emp.manager_id,
    man.first_name, man.last_name
FROM employees emp LEFT JOIN employees man
                    ON emp.manager_id = man.employee_id
START WITH emp.manager_id IS NULL -- 시작 조건
CONNECT BY PRIOR emp.employee_id = emp.manager_id
ORDER BY level;

----------------------------------------------------------------------------------------
SELECT emp.first_name, emp.last_name, 
        man.first_name, man.last_name, emp.employee_id, man.manager_id
FROM employees emp JOIN employees man ON emp.manager_id = man.employee_id
ORDER BY emp.first_name;







