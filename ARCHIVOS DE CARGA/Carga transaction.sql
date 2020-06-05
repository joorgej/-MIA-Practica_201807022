USE PRACTICA3;
LOAD DATA LOCAL INFILE '/home/joorge/Descargas/ArchivosCSV/transactions.csv'
INTO TABLE TRANSACTION_TEMP
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(transaction_id,project_id,@FECHAINI,transaction_year,transaction_value_code,transaction_currency,transaction_value)
SET transaction_isodate = STR_TO_DATE(@FECHAINI,'%d/%m/%Y');