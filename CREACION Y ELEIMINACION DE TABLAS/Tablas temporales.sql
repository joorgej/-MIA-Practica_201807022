CREATE DATABASE IF NOT EXISTS PRACTICA3;
USE PRACTICA3;

CREATE TABLE COUNTRY_CODE_TEMP(
    `name` varchar(50),
    iso2 varchar(50),
    name_aiddata_code integer,
    name_aiddata_name varchar(50),
    name_cow_alpha varchar(50),
    name_cow_numeric integer,
    name_fao_code varchar(50),
    name_fips varchar(50),
    name_geonames_id varchar(50),
    name_imf_code varchar(50),
    name_iso2 varchar(5),
    name_iso3 varchar(5),
    name_iso_numeric integer,
    name_oecd_code integer,
    name_oecd_name varchar(50),
    name_un_code integer,
    name_wb_code varchar(25)
);

CREATE TABLE PROJECT_TEMP(
    project_id varchar(50),
    is_geocoded integer,
    project_title varchar(75),
    start_actual_isodate date,
    end_actual_isodate date,
    donors varchar(50),
    donors_iso3 varchar(50),
    recipients varchar(50),
    recipients_iso3 varchar(10),
    ad_sector_codes varchar(100),
    ad_sector_names varchar(300),
    `status` varchar(50),
    transactions_start_year integer,
    transactions_end_year integer,
    total_commitments float,
    total_disbursements float
);

CREATE TABLE TRANSACTION_TEMP(
    transaction_id varchar(50),
    project_id varchar(50),
    transaction_isodate date,
    transaction_year integer,
    transaction_value_code varchar(50),
    transaction_currency varchar(100),
    transaction_value float
);

CREATE TABLE LOCATION_TEMP(
    location_type_code varchar(50),
    location_type_name varchar(50)
);

CREATE TABLE GEONAME_TEMP(
    geoname_id integer,
    place_name varchar(50),
    latitude float,
    longitude float,
    location_type_code varchar(10),
    location_type_name varchar(100),
    gazetteer_adm_code varchar(50),
    gazetteer_adm_name varchar(50),
    location_class integer,
    geographic_exactness integer
);

CREATE TABLE  LEVEL_1A_TEMP(
    project_id varchar(20),
    project_location_id varchar(60),
    geoname_id integer ,
    transactions_start_year integer,
    transactions_end_year integer,
    even_split_commitments double,
    even_split_disbursements double
);