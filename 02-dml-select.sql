--���� ���� ���� �� ���̺� Ȯ��
SELECT * FROM tab;
--employees ���̺� ���� Ȯ��
DESC employees;

--select : dmal

--�⺻���� select��: ��ü �������� ��ȸ
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

--projection�� ����: ���ϴ� �÷��� ��Ϥ��� select�� ����
--����� �̸�()�� ��ȭ��ȣ,�Ի���,�޿� ���
SELECT FIRST_NAME, PHONE_NUMBER, HIRE_DATE, SALARY
FROM employees;

--�������: �⺻���� ��� ���� ����
SELECT 3.14159 * 10 * 10 FROM DUAL;
SELECT 3.14159 * 10 * 10 
FROM EMPLOYEES;
--Ư�� ���̺� ���� ���� ���� ����� DUAL���� ��������
--��� ������ �� �� Ư�� �÷��� ��꿡 ���Խ�ų �� �ִ�
SELECT FIRST_NAME, 
    SALARY,
    SALARY * 12
FROM EMPLOYEES;

--��������� �����Ҷ� �÷��� ������ Ÿ���� NUMBER���� �Ѵ�
SELECT FIRST_NAME, JOB_ID * 12 FROM employees;
--ERROR: JOB_ID�� NUMBER�� �ƴ϶� ������� �Ұ�

--���ڿ� ����
SELECT FIRST_NAME + ' ' + LAST_NAME FROM employees;
--ERROR :���ڿ��� +�� ������ ������
SELECT FIRST_NAME ||' '||  LAST_NAME FULL_NAME
FROM EMPLOYEES;
--�÷� Ȥ�� ǥ���Ŀ� ������ ���� �� �ִ�

--Ŀ�̼Ǳ��� �����ؼ� �޿� ����
SELECT FIRST_NAME, 
    SALARY, COMMISSION_PCT,
    SALARY + SALARY * COMMISSION_PCT
FROM employees;    
--���������� �����Ҷ� NULL�� ���ԵǾ� ������
--����� NULL

--NVL(EXPR1,EXPR2):EXPRL üũ NULL�� �ƴϸ� EXPR1
--NULL�̸� EXPR2
SELECT FIRST_NAME,
    SALARY,
    SALARY + SALARY * NVL(commission_pct,0) PAID
FROM employees;    

--WHERE(SELECTION)
--�޿��� 15000�̻��� ����� �̸�, �޿� ���
SELECT FIRST_NAME, SALARY
FROM employees
WHERE SALARY >= 15000;

--��¥�� �񱳿����� ����
--�Ի����� 85/01/01 ������ ����� �̸�, �Ի���, �޿�
SELECT FIRST_NAME, HIRE_DATE, SALARY
FROM employees
WHERE HIRE_DATE >= '07/01/01';

--�̸��� LEX�� ����� �̸�. �Ի���, �޿� ���
SELECT FIRST_NAME, HIRE_DATE, SALARY
FROM employees
WHERE FIRST_NAME = 'Lex';

--������ or
--SALARY 14000�����̰ų� 17000�̻��ΰų�
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY <= 14000 OR SALARY >= 17000;

--AND 
--SALARY�� 14000�̰� 17000������ ����� ���
SELECT FIRST_NAME,SALARY
FROM EMPLOYEES
WHERE SALARY >= 14000 AND SALARY <= 17000;

--BETWEEN ������
--SALARY14000�̻��̰� 17000������ ��� ���
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES 
WHERE SALARY BETWEEN 14000 AND 17000;

--NULLüũ : IS NULL, IS NOT NULL
--Ŀ�̼��� �޴� ����� ���
SELECT FIRST_NAME, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;
--Ŀ�̼� �����ʴ� ���
SELECT FIRST_NAME, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;
--�μ� ID�� 10�̰ų� 20�̰ų� 40�� ������ ���
SELECT FIRST_NAME, department_ID
FROM EMPLOYEES
WHERE department_id = 10 OR
    department_id = 20 OR
    DEPARTMENT_ID = 30;
 --IN�����ڸ� Ȱ��
 SELECT FIRST_NAME, DEPARTMENT_ID
 FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN (10,20,30);
 --ANY������ Ȱ��
 SELECT FIRST_NAME, DEPARTMENT_ID
 FROM EMPLOYEES
 WHERE DEPARTMENT_ID = ANY(10,20,30);
 --����� �� DEPARTMENT_ID 10,20,30�� �ƴ� �����
 SELECT FIRST_NAME, DEPARTMENT_ID
 FROM EMPLOYEES
 WHERE DEPARTMENT_ID NOT IN(10,20,30);
 --LIKE������
 --���ϵ�ī�� % : ���̰� �������� ���� ���ڿ�
 --���ϵ�ī�� _ : 1������ �������� ���� ����
 
 --FIRST_NAME�� AM�� ���Ե� ������ ���
 SELECT FIRST_NAME, LAST_NAME
 FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '%am%';
 --first_name�� �� ��° ���ڰ� a�� ����
 SELECT FIRST_NAME, LAST_NAME
 FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '_a%';
 --selection �� �������� ����
 --ASC(��������)
 --DESC(��������)
 --�μ� ��ȣ ������������ �����ϰ� �̸�, �μ���ȣ, �޿�
 SELECT FIRST_NAME, DEPARTMENT_ID, SALARY
 FROM EMPLOYEES
 ORDER BY DEPARTMENT_ID; -- ASC�� ��������(�⺻��)
 --�޿��� 15000 �̻��� ������ ���� �޿��� ����
 SELECT FIRST_NAME, SALARY
 FROM EMPLOYEES
 WHERE SALARY >= 15000
 ORDER BY SALARY DESC;
 --�μ� ��ȣ ������������ ������ �� �޿��� �������� ����
 SELECT FIRST_NAME, DEPARTMENT_ID, SALARY
 FROM EMPLOYEES
 ORDER BY DEPARTMENT_ID ASC, SALARY DESC;
 --�������Լ�
 --���ڿ� ������ �Լ�
 SELECT FIRST_NAME, LAST_NAME,
    FIRST_NAME ||' '||LAST_NAME,
    CONCAT(FIRST_NAME, CONCAT(' ', LAST_NAME), --��ħ
    LOWER(FIRST_NAME), UPPER(FIRST_NAME)--��ȯ
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
--��ġ�� ������ �Լ�
select abs(-3.14), --���밪
    ceil(3.14), --�ø�(õ��)
    floor(3.14),--�Ҽ��� ������
    mod(7,3),--������
    power(2,4),--�����Լ�
    round(3.5),--�ݿø�
    round(3.14159,3), -- �Ҽ��� 3°�ڸ����� ǥ���̻󿡼� �ݿø�
    trunc(3.14159,3) --�Ҽ��� 3°�ڸ����� ǥ�� ���� �ڸ��� ����
FROM DUAL;    
 
 
--QUIZ01

--Q1
SELECT FIRST_NAME, LAST_NAME, SALARY
    PHONE_NUMBER, HIRE_DATE
FROM EMPLOYEES;    

SELECT FIRST_NAME ||' '||  LAST_NAME "�̸�",
     SALARY "�޿�",
     PHONE_NUMBER "��ȭ��ȣ",
     HIRE_DATE "�Ի���"
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

--2019/9/20����
--DATE �⺻ ���� Ȯ��
SELECT * FROM nls_session_parameters
WHERE parameter='NLS_DATE_FORMAT';

--���� ��¥ ���ϱ�
SELECT sysdate FROM dual; --���� �ý��� ��¥
SELECT sysdate FROM employees;

--��¥ ���� ����
--DATE +(-) NUMBER -> ����¥�� �ϼ� ���ϱ� ����
--DATE - DATE -> ��¥ �ϼ� ����(NUMBER)
SELECT sysdate + 1,
    sysdate - 1,
    sysdate - TO_DATE('1999-12-31'),
    sysdate + 12/24 --0.5�� ���Ѱ�
    FROM DUAL;
--��¥ ���� �Լ�
SELECT sysdate,
    ADD_MONTHS(sysdate, 2),
    LAST_DAY(sysdate),
    MONTHS_BETWEEN(TO_DATE('1999-12-31', 'YYYY-MM-DD'),
    sysdate),
    ROUND(sysdate, 'MONTH'),
    TRUNC(sysdate, 'MONTH')
FROM dual;    

--���� ��¥�� �������� EMPLOYEES ���̺���
--�Ի����� �� ������ �������� Ȯ��
SELECT FIRST_NAME, HIRE_DATE,
    ROUND(
    MONTHS_BETWEEN(sysdate, hire_date)
    )
FROM employees;    

--��ȯ �Լ�
--TO_CHAR : ��¥, ���� -> ���ڿ���
--TO_DATE : ���ڿ�->����
--TO_NUMBER : ���ڿ�->����
--��ȯ ������ �� �����ؾ��Ѵ�


--EMPLYEES ���̺��� �Ի����� YYYY-MM-DD HH24:MI:SS
SELECT first_name, hire_date,
    TO_CHAR(hire_date, 'YYYY-MM-DD HH24:MI:SS')
FROM employees;


--employees���̺��� salry������->����
SELECT first_name, 
    TO_CHAR(salary * 12, '$999,999.99') SAL
FROM employees;

--TO_NUMBER : ���ڿ�->����
SELECT TO_NUMBER('1999'),
    TO_NUMBER('$1,234.567', '$999,999.999')
FROM dual;

--TO_DATE:���ڿ�->DATE
SELECT TO_DATE('1999-12-31 23:59:59','YYYY-MM-DD HH24:MI:SS')
FROM DUAL;

SELECT TO_CHAR(3000000, 'L999,999,999')
FROM DUAL;

--NULL����
--NVL(expr1,expr2)-> expr1dl null�̸� expr1


SELECT first_name, salary, 
    salary * nvl(commission_pct, 0) commission
FROM employees;   

--nvl2(expr1,expr2,expr3)
-- 1�� null���� üũ
--not null-> 2
--null->3
SELECT first_name, salary, 
    NVL2(commission_pct,commission_pct * salary,0) commission
FROM employees;    

--CASE�Լ�
--���ʽ� ���� ����
--AD���� �������Դ� 20%, SA���� �������Դ� 10%, IT���� �������Դ� 8%,
--������ �������Դ� 5%����
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

--DECODE�Լ�
SELECT first_name, job_id, salary,
    DECODE(SUBSTR(job_id, 1, 2),
        'AD', salary * 0.2,
        'SA', salary * 0.1,
        'IT', salary * 0.08,
        0.05) bonus
FROM employees;  


--��������
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











    

        


    





    
 


