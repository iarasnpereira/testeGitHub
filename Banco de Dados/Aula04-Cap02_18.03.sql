--AULA 04 - Cap03
--FUNÇÕES DE UMA ÚNICA LINHA
--NVL: converte valor nulo em um valor real, muito útil em cálculo
SELECT last_name, 
       salary, NVL(commission_pct, 0) COMISSION,
       (salary*12)+(salary*12*commission_pct) ANUAL_SALARY,
       (salary*12) + (salary*12*NVL(commission_pct, 0)) "ANUAL_SALARY COM NVL"
FROM   employees;

--exemplo com caracter
SELECT   last_name, 
         NVL(TO_CHAR(commission_pct), 'Not applicable')"COMMISSION" 
FROM     employees
WHERE    last_name LIKE 'B%'
ORDER BY last_name;


--NVL2: 
SELECT last_name,  
       salary, 
       commission_pct,
       NVL2(commission_pct, 
       'SALARY + COMMISSION', 'SALARY') income --=vencimento do salário
FROM   employees WHERE department_id IN (50, 80);


SELECT last_name,  
       salary, 
       commission_pct,
       NVL2(commission_pct, 
       salary+(salary*commission_pct), salary) income --=vencimento do salário
FROM   employees
WHERE last_name LIKE 'B%'
ORDER BY last_name;


--NULLIF: compara duas expressões de forem, iguais retorna null e se diferentes retorna a primeira
SELECT first_name, 
       LENGTH(first_name) "expr1", 
       last_name,  
       LENGTH(last_name)  "expr2",
       NULLIF(LENGTH(first_name), 
       LENGTH(last_name)) result
FROM   employees;

--exemplo funcional: retona o histórico de promoções 
SELECT e.last_name,
        NULLIF(e.job_id,j.job_id) "NEW JOB ID"
FROM employees e JOIN job_history j
ON e.employee_id = j.employee_id
ORDER BY last_name;

--exemplo funcional: retona o cargo antigo *porque as regras de negócio permitem
--Taylor aparece duas vezes, foi promovido depois regrediu
SELECT e.last_name,
        NULLIF(j.job_id,e.job_id) "OLD JOB ID"
FROM employees e JOIN job_history j
ON e.employee_id = j.employee_id
ORDER BY last_name;


--COALESCE: faz uma pesquisa se tiver valor ela retorna o argumento 1,retorna o argumento 2 se a primeira não for nula e senão o argumento 3
SELECT last_name, manager_id, commission_pct,
       COALESCE(manager_id,commission_pct, -1) commission 
FROM   employees 
ORDER BY commission_pct; 


--CASE = estrutura de seleção switch 
SELECT last_name, job_id, salary,
       CASE job_id WHEN 'IT_PROG'  THEN  1.10*salary
                   WHEN 'ST_CLERK' THEN  1.15*salary
                   WHEN 'SA_REP'   THEN  1.20*salary
       ELSE      salary END     "REVISED SALARY"
FROM   employees;


--DECODE
SELECT last_name, job_id, salary,
       DECODE(job_id, 'IT_PROG',  1.10*salary,
                      'ST_CLERK', 1.15*salary,
                      'SA_REP',   1.20*salary,
              salary) REVISED_SALARY
FROM   employees;


SELECT last_name, salary,
       DECODE (TRUNC(salary/2000, 0),
                         0, 0.00,
                         1, 0.09,
                         2, 0.20,
                         3, 0.30,
                         4, 0.40,
                         5, 0.42,
                         6, 0.44,
                            0.45) TAX_RATE
FROM   employees
WHERE  department_id = 80;

--*CASE ou DECODE? em performance fazem a mesma coisa. 
--Grandes bases de dados no caso do exemplo o Barcelos criaria uma tabela aumento (cargo e aumento) e daria o aumento nela com NO EQUIJOIN

SELECT e.last_name, 
       NULLIF(e.job_id, j.job_id) "NEW JOB ID"
FROM    employees e JOIN job_history j
ON e.employee_id = j.employee_id
ORDER BY last_name;
