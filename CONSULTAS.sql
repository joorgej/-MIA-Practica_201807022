USE PRACTICA3;


#---------1-----------
SELECT COUNT(id) FROM PROJECT WHERE transactions_start_year='2011';

#---------2-----------
SELECT project_id, project_title, start_actual_isodate, end_actual_isodate 
FROM PROJECT 
WHERE TIMESTAMPDIFF(DAY,start_actual_isodate,end_actual_isodate) = (SELECT MAX(TIMESTAMPDIFF(DAY,start_actual_isodate,end_actual_isodate)) FROM PROJECT);

#---------3-----------
SELECT project_id, project_title, start_actual_isodate, end_actual_isodate 
FROM PROJECT 
WHERE TIMESTAMPDIFF(DAY,start_actual_isodate,end_actual_isodate) = (SELECT MIN(TIMESTAMPDIFF(DAY,start_actual_isodate,end_actual_isodate)) FROM PROJECT);

#---------4-----------
SELECT `name`,cuenta 
FROM (SELECT country_id, COUNT(*) AS cuenta from PROJECT WHERE country_id IS NOT NULL group by country_id  ORDER BY COUNT(*) DESC limit 0, 5) AS CONTEO 
INNER JOIN COUNTRY_CODE 
ON  CONTEO.country_id = COUNTRY_CODE.country_id
ORDER BY cuenta DESC;

#---------5-----------
SELECT `name`,cuenta 
FROM (SELECT country_id, COUNT(*) AS cuenta from PROJECT WHERE country_id IS NOT NULL group by country_id  ORDER BY COUNT(*) limit 0, 5) AS CONTEO 
INNER JOIN COUNTRY_CODE 
ON  CONTEO.country_id = COUNTRY_CODE.country_id
ORDER BY cuenta;

#---------6-----------
SELECT project_id, project_title, total_disbursements AS gastos
FROM PROJECT 
WHERE total_disbursements IS NOT NULL
ORDER BY gastos DESC 
limit 0, 1;

#---------7-----------
SELECT project_id, project_title, total_disbursements AS gastos
FROM PROJECT 
WHERE total_disbursements IS NOT NULL
ORDER BY gastos  
limit 0, 1;

#---------8-----------
SELECT project_id, project_title, total_disbursements AS gastos
FROM PROJECT 
WHERE total_disbursements IS NOT NULL
ORDER BY gastos DESC 
limit 0, 5;

#---------9-----------
SELECT SUM(total_disbursements) AS GASTO_TOTAL
FROM PROJECT;

#---------10----------
SELECT transaction_id,transaction_value 
FROM (SELECT transaction_id, transaction_value, project_id  FROM  TRANSACTION ORDER BY transaction_value) AS TRANSACCION
INNER JOIN PROJECT
ON TRANSACCION.project_id = PROJECT.id
WHERE PROJECT.project_title = 'AFCC2/RI-East Africa Public Health Laboratory Networking Project'
ORDER BY transaction_value DESC
LIMIT 0,3;
