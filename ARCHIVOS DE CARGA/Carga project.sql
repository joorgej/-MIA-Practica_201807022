USE PRACTICA3;
LOAD DATA LOCAL INFILE '/home/joorge/Descargas/ArchivosCSV/projects.csv'
INTO TABLE PROJECT_TEMP
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(project_id,is_geocoded,project_title,@FECHAINI,@FECHAEND,donors,donors_iso3,recipients,recipients_iso3,ad_sector_codes,ad_sector_names,`status`,transactions_start_year,transactions_end_year,total_commitments,total_disbursements)
SET start_actual_isodate=STR_TO_DATE(@FECHAINI,'%d/%m/%Y'), end_actual_isodate=STR_TO_DATE(@FECHAEND,'%d/%m/%Y');