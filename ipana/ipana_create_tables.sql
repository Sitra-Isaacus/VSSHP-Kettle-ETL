-- create schema
create schema stage_ipana;


-- stax_uniques_with_counts
CREATE TABLE stage_ipana.stax_uniques_with_counts
(
  xml_data_type_description character varying(8000),
  xml_path character varying(8000),
  xml_data_name character varying(8000),
  max_occurrences_per_file integer,
  row_updated timestamp without time zone
)
WITH (
  OIDS=FALSE
);
ALTER TABLE stage_ipana.stax_uniques_with_counts
  OWNER TO ktp;


-- stax_log
CREATE TABLE stage_ipana.stax_log
(
  filename character varying(8000),
  stax_processing_finished timestamp without time zone
)
WITH (
  OIDS=FALSE
);
ALTER TABLE stage_ipana.stax_log
  OWNER TO ktp;


-- zz_stax_aggregated
CREATE TABLE stage_ipana.zz_stax_aggregated
(
  xml_data_type_description character varying(8000),
  xml_path character varying(8000),
  xml_data_name character varying(8000),
  max_occurrences_per_file integer
)
WITH (
  OIDS=FALSE
);
ALTER TABLE stage_ipana.zz_stax_aggregated
  OWNER TO ktp;


-- zz_stax_aggregated_keys
CREATE INDEX zz_stax_aggregated_keys
  ON stage_ipana.zz_stax_aggregated
  USING btree
  (xml_data_type_description COLLATE pg_catalog."default", xml_path COLLATE pg_catalog."default", xml_data_name COLLATE pg_catalog."default");


-- zz_stax_all
CREATE TABLE stage_ipana.zz_stax_all
(
  xml_filename character varying(8000),
  xml_data_type_description character varying(8000),
  xml_parent_element_id integer,
  xml_path character varying(8000),
  xml_data_name character varying(8000)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE stage_ipana.zz_stax_all
  OWNER TO ktp;

-- zz_stax_log
CREATE TABLE stage_ipana.zz_stax_log
(
  filename character varying(8000),
  stax_processing_finished timestamp without time zone
)
WITH (
  OIDS=FALSE
);
ALTER TABLE stage_ipana.zz_stax_log
  OWNER TO ktp;

-- file_io_log
CREATE TABLE stage_ipana.file_io_log
(
  filename character varying(500) NOT NULL,
  io bigint,
  cdc_load_time timestamp without time zone,
  CONSTRAINT file_io_log_pk PRIMARY KEY (filename)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE stage_ipana.file_io_log
  OWNER TO ktp;


CREATE INDEX file_io_log_cdc_load_time_idx
  ON stage_ipana.file_io_log
  USING btree
  (cdc_load_time);

-- cdc_time
CREATE TABLE stage_ipana.cdc_time
(
  cdc_time_id bigserial NOT NULL,
  process_name character varying,
  last_load timestamp without time zone,
  current_load timestamp without time zone,
  CONSTRAINT cdc_time_pkey PRIMARY KEY (cdc_time_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE stage_ipana.cdc_time
  OWNER TO ktp;

-- insert into stage_ipana.cdc_time (process_name) values ('doc_info');
-- insert into stage_ipana.cdc_time (process_name) values ('file_io_log');


-- #####################
-- DELETE STATEMENTS

-- delete from stage_ipana.stax_uniques_with_counts;
-- delete from stage_ipana.stax_log;
-- delete from stage_ipana.zz_stax_aggregated;
-- delete from stage_ipana.zz_stax_all;
-- delete from stage_ipana.zz_stax_log;



select * from text_mine.teksti where nakyma_selite = 'SYN'
and extract(year from hoitotapahtuma_alkuhetki_arvio) = 2004
limit 200;
