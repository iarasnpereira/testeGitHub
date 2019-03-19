--AULA 04 - Cap04
--SUBCONSULTAS ou SUBQUERYS
--Usadas para responder quest�es que �s vezes podem ser resolvidas com JOIN  
--ORDER BY n�o � necess�rio nelas
SELECT employee_id, last_name, salary
FROM employees 
WHERE salary > (SELECT salary FROM employees WHERE last_name='Abel'); 

--*NAC 03) Quantas vezes a query principal � executada? S� UMA!
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = (SELECT job_id FROM employees WHERE employee_id=141) 
    AND salary > (SELECT salary FROM employees WHERE employee_id=143);

--exemplo usando fun��es de grupo
SELECT last_name, job_id, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees); --ou MIN(salary)

--*NAC 05) Quando usar HAVING? Filtro de grupos de fun��o (pr�tica e te�rica)
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (SELECT MIN(salary) FROM departments WHERE department_id=50);


--SUBCONSULTAS DE V�RIAS LINHAS
--Retornam mais de uma linha
--Usam operadores de compara��o:IN, ANY, ALL *ANY e ALL sempre vem com operadores matem�ticos
--exemplo com IN
SELECT employee_id, last_name
FROM employees
WHERE department_id IN (10,20,30);
--==
SELECT employee_id, last_name
FROM employees
WHERE department_id =10 OR department_id =20 OR department_id =30;

--exemplo com IN retona os sal�rios iguais aos de programadores menos os deles
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary IN (SELECT salary FROM employees WHERE job_id='IT_PROG') AND job_id <> 'IT_PROG'; 

--exemplo com ANY retona os sal�rios menores que os programadores menos os programadores
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary< ANY (SELECT salary FROM employees WHERE job_id='IT_PROG') AND job_id <> 'IT_PROG';

--exemplo com ALL retona todos os sal�rios menores que os programadores menos os programadores
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary< ALL (SELECT salary FROM employees WHERE job_id='IT_PROG') AND job_id <> 'IT_PROG';
