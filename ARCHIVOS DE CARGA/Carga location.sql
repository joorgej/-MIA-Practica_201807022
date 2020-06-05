USE PRACTICA3;
LOAD DATA LOCAL INFILE '/home/joorge/Descargas/ArchivosCSV/locations.csv'
INTO TABLE LOCATION_TEMP
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(location_type_code,location_type_name);