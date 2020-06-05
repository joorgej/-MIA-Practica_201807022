CREATE DATABASE IF NOT EXISTS PRACTICA3;
USE PRACTICA3;
CREATE TABLE CURRENCY(
    currency_id integer auto_increment,
    currency_description varchar(20),

    CONSTRAINT PK_CURRENCY_ID PRIMARY KEY(currency_id)
);

CREATE TABLE TYPE_STATUS(
    status_id integer auto_increment,
    status_description varchar(50),

    CONSTRAINT PK_ID_STATUS PRIMARY KEY(status_id)
);

CREATE TABLE COUNTRY_CODE(
    country_id integer auto_increment,
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
    name_wb_code varchar(25),

    CONSTRAINT PK_COUNTRY_ID PRIMARY KEY(country_id)
);

CREATE TABLE PROJECT(
	id integer auto_increment,
    project_id varchar(50),
    is_geocoded integer,
    project_title varchar(75),
    start_actual_isodate date,
    end_actual_isodate date,
    donors varchar(50),
    donors_iso3 varchar(50),
    country_id integer,
    ad_sector_codes varchar(100),
    ad_sector_names varchar(300),
    status_id integer,
    transactions_start_year integer,
    transactions_end_year integer,
    total_commitments float,
    total_disbursements float,

    CONSTRAINT PK_PROJECT_ID PRIMARY KEY(id),
    CONSTRAINT FK_STATUS_ID FOREIGN KEY(status_id) REFERENCES TYPE_STATUS (status_id),
    CONSTRAINT FK_COUNTRY_ID FOREIGN KEY(country_id) REFERENCES COUNTRY_CODE (country_id)
);

CREATE TABLE `TRANSACTION`(
	id integer auto_increment,
    transaction_id varchar(50),
    project_id integer,
    transaction_isodate date,
    transaction_year integer,
    transaction_value_code varchar(50),
    transaction_currency_id integer,
    transaction_value float,

    CONSTRAINT PK_TRANSACTION_ID PRIMARY KEY(id),
    CONSTRAINT FK_CURRENCY_ID FOREIGN KEY(transaction_currency_id) REFERENCES CURRENCY (currency_id),
    CONSTRAINT FK_PROJECT_ID FOREIGN KEY(project_id) REFERENCES PROJECT (id)
);

CREATE TABLE `LOCATION`(
    location_id integer auto_increment,
    location_type_code varchar(50),
    location_type_name varchar(50),

    CONSTRAINT PK_LOCATION_ID PRIMARY KEY(location_id)
);

CREATE TABLE GEONAME(
	geoname_code integer auto_increment,
    geoname_id integer,
    place_name varchar(50),
    latitude float,
    longitude float,
    location_id integer,
    gazetteer_adm_code varchar(50),
    gazetteer_adm_name varchar(50),
    location_class integer,
    geographic_exactness integer,

    CONSTRAINT FK_LOCATION_ID FOREIGN KEY(location_id) REFERENCES LOCATION (location_id),
    CONSTRAINT PK_GEONAME_ID PRIMARY KEY(geoname_code)
    
);

CREATE TABLE  LEVEL_1A(
	id_level integer auto_increment,
    project_id varchar(50),
    project_location_id varchar(50),
    geoname_id integer,
    transactions_start_year integer,
    transactions_end_year integer,
    even_split_commitments double,
    even_split_disbursements double,
    CONSTRAINT PK_LEVEL_ID PRIMARY KEY(id_level)
);