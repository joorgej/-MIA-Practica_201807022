USE PRACTICA3;
LOAD DATA LOCAL INFILE '/home/joorge/Descargas/ArchivosCSV/country_codes.tsv'
INTO TABLE COUNTRY_CODE_TEMP
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`name`,iso2,@dummy,name_aiddata_code,name_aiddata_name,name_cow_alpha,name_cow_numeric,name_fao_code,name_fips,name_geonames_id,name_imf_code,name_iso2,name_iso3,name_iso_numeric,name_oecd_code,name_oecd_name,name_un_code,name_wb_code);
