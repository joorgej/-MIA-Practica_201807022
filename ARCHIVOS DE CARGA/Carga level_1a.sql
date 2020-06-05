USE PRACTICA3;
LOAD DATA LOCAL INFILE '/home/joorge/Descargas/ArchivosCSV/level_1a.csv'
INTO TABLE LEVEL_1A_TEMP
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(project_id,project_location_id,geoname_id,transactions_start_year,transactions_end_year,even_split_commitments,even_split_disbursements);