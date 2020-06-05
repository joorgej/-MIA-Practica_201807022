/*----------CARGA LOCATIONS------------------------*/
INSERT INTO LOCATION (location_type_code,location_type_name)
SELECT location_type_code, location_type_name 
FROM LOCATION_TEMP;





/*----------CARGA COUNTRY_CODE---------------------*/
INSERT INTO COUNTRY_CODE (`name`,iso2,name_aiddata_code,name_aiddata_name,name_cow_alpha,name_cow_numeric,name_fao_code,name_fips,name_geonames_id,name_imf_code,name_iso2,name_iso3,name_iso_numeric,name_oecd_code,name_oecd_name,name_un_code,name_wb_code)
SELECT `name`,iso2,name_aiddata_code,name_aiddata_name,name_cow_alpha,name_cow_numeric,name_fao_code,name_fips,name_geonames_id,name_imf_code,name_iso2,name_iso3,name_iso_numeric,name_oecd_code,name_oecd_name,name_un_code,name_wb_code 
FROM COUNTRY_CODE_TEMP
WHERE COUNTRY_CODE_TEMP.name != 'Unspecified';





/*----------CARGA TYPE_STATUS----------------------*/
CREATE VIEW TYPE_STATUS_AUX
AS SELECT DISTINCT `status` 
FROM PROJECT_TEMP ;

INSERT INTO TYPE_STATUS (status_description)
SELECT `status` 
FROM TYPE_STATUS_AUX;

DROP VIEW TYPE_STATUS_AUX;





/*----------CARGA CURRENCY-------------------------*/
CREATE VIEW CURRENCY_AUX
AS SELECT DISTINCT transaction_currency 
FROM TRANSACTION_TEMP;

INSERT INTO CURRENCY (currency_description)
SELECT transaction_currency 
FROM CURRENCY_AUX;

DROP VIEW CURRENCY_AUX;





/*----------CARGA PROJECT--------------------------*/
CREATE VIEW PROJECT_AUX1
AS SELECT * 
FROM PROJECT_TEMP p
LEFT JOIN COUNTRY_CODE c 
ON p.recipients = c.`name` && p.recipients_iso3 = c.name_iso3;
    
CREATE VIEW PROJECT_AUX2
AS SELECT * 
FROM PROJECT_AUX1 p
LEFT JOIN TYPE_STATUS ts ON p.`status`= ts.status_description;

INSERT INTO PROJECT (project_id,is_geocoded,project_title,start_actual_isodate,end_actual_isodate,donors,donors_iso3,country_id,ad_sector_codes,
					ad_sector_names,status_id,transactions_start_year,transactions_end_year,total_commitments,total_disbursements)
SELECT project_id,is_geocoded,project_title,start_actual_isodate,end_actual_isodate,donors,donors_iso3,country_id,ad_sector_codes,
		ad_sector_names,status_id,transactions_start_year,transactions_end_year,total_commitments,total_disbursements 
FROM PROJECT_AUX2;

DROP VIEW PROJECT_AUX1;
DROP VIEW PROJECT_AUX2;





/*----------CARGA GEONAME--------------------------*/
CREATE VIEW GEONAME_AUX
AS SELECT g.geoname_id,g.place_name,g.latitude,g.longitude,l.location_id,g.gazetteer_adm_code,g.gazetteer_adm_name,g.location_class,g.geographic_exactness 
FROM GEONAME_TEMP g
LEFT JOIN LOCATION l
ON g.location_type_code = l.location_type_code && g.location_type_name = l.location_type_name;

INSERT INTO GEONAME (geoname_id,place_name,latitude,longitude,location_id,gazetteer_adm_code,gazetteer_adm_name,location_class,geographic_exactness)
SELECT geoname_id,place_name,latitude,longitude,location_id,gazetteer_adm_code,gazetteer_adm_name,location_class,geographic_exactness 
FROM GEONAME_AUX; 

DROP VIEW GEONAME_AUX;





/*----------CARGA TRANSACTION------------------------*/
CREATE VIEW TRANSACTION_AUX1
AS SELECT t.transaction_id,t.project_id,t.transaction_isodate,t.transaction_year,t.transaction_value_code,c.currency_id,t.transaction_value
FROM TRANSACTION_TEMP t
LEFT JOIN CURRENCY c
ON t.transaction_currency= c.currency_description;

CREATE VIEW TRANSACTION_AUX2
AS SELECT t.transaction_id,p.id,t.transaction_isodate,t.transaction_year,t.transaction_value_code,t.currency_id,t.transaction_value 
FROM TRANSACTION_AUX1 t
LEFT JOIN PROJECT p
ON t.project_id = p.project_id;

INSERT INTO `TRANSACTION` (transaction_id,project_id,transaction_isodate,transaction_year,transaction_value_code,transaction_currency_id,transaction_value)
SELECT transaction_id,id,transaction_isodate,transaction_year,transaction_value_code,currency_id,transaction_value
FROM TRANSACTION_AUX2;

DROP VIEW TRANSACTION_AUX1;
DROP VIEW TRANSACTION_AUX2;





/*----------CARGA LEVEL 1A------------------------*/
INSERT INTO LEVEL_1A (project_id,project_location_id,geoname_id,transactions_start_year,transactions_end_year,even_split_commitments,even_split_disbursements)
SELECT project_id,project_location_id,geoname_id,transactions_start_year,transactions_end_year,even_split_commitments,even_split_disbursements
FROM LEVEL_1A_TEMP;