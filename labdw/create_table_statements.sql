-- Table: stage_labdw.labdw_transform

-- DROP TABLE stage_labdw.labdw_transform;

CREATE TABLE stage_labdw.labdw_transform
(
  testid text,
  testp text,
  test text,
  testt text,
  urgency text,
  sampleid text,
  cost double precision,
  fee double precision,
  outcomet text,
  outcomen double precision,
  unit text,
  microbe text,
  refmin double precision,
  refmax double precision,
  refval text,
  outsour text,
  weekday text,
  custorg0 text,
  custorg1 text,
  custorg2 text,
  custorg3 text,
  custorgt text,
  projid text,
  payer1 text,
  payer2 text,
  provorg1 text,
  labspecd text,
  labspec text,
  provorg2 text,
  testorg text,
  datetime1 timestamp without time zone,
  yy1 text,
  mm1 text,
  dd1 text,
  hh1 text,
  datetime2 timestamp without time zone,
  yy2 text,
  mm2 text,
  dd2 text,
  hh2 text,
  datetime3 timestamp without time zone,
  yy3 text,
  mm3 text,
  dd3 text,
  hh3 text,
  datetime4 timestamp without time zone,
  yy4 text,
  mm4 text,
  dd4 text,
  hh4 text,
  datetime5 timestamp without time zone,
  yy5 text,
  mm5 text,
  dd5 text,
  hh5 text,
  datetime6 timestamp without time zone,
  yy6 text,
  mm6 text,
  dd6 text,
  hh6 text,
  datetime7 timestamp without time zone,
  yy7 text,
  mm7 text,
  dd7 text,
  hh7 text,
  delay1 double precision,
  delay2 double precision,
  delay3 double precision,
  delay4 double precision,
  delay5 double precision,
  delay6 double precision,
  macid text,
  batchid text,
  patidcode text,
  agedays double precision,
  ageyear double precision,
  sex text,
  patarea1 text,
  spec text,
  agecat1 text,
  autoack text,
  dayt1 text,
  dayt2 text,
  dayt3 text,
  dayt4 text,
  dayt5 text,
  dayt6 text,
  dayt7 text,
  dayt8 text,
  macgrp text,
  testgrp text,
  agecat2 text,
  agecat3 text,
  hetu text,
  mergeid text,
  datetime8 timestamp without time zone,
  yy8 text,
  mm8 text,
  dd8 text,
  hh8 text,
  servstat text,
  weekday2 text,
  status text,
  outlier text,
  custgrp1 text,
  custgrp2 text,
  custgrp3 text,
  custgrp4 text,
  custgrp5 text,
  custgrp6 text,
  custgrp7 text,
  delay7 double precision,
  ovthl7 text,
  testorg0 text,
  testorg1 text,
  testorg2 text,
  samorg1 text,
  etlstamp text,
  patarea2 text,
  source_table character varying(200),
  recordid text
)
WITH (
  OIDS=FALSE
);
ALTER TABLE stage_labdw.labdw_transform
  OWNER TO ktp;



-- Table: stage_labdw.columns

-- DROP TABLE stage_labdw.columns;

CREATE TABLE stage_labdw.columns
(
  columns_id serial NOT NULL,
  columnname character varying(8000),
  columndescription character varying(8000),
  codetables character varying(8000),
  row_retrieved timestamp without time zone,
  valid boolean,
  CONSTRAINT columns_pkey PRIMARY KEY (columns_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE stage_labdw.columns
  OWNER TO ktp;

-- Index: stage_labdw.idx_columns_lookup

-- DROP INDEX stage_labdw.idx_columns_lookup;

CREATE INDEX idx_columns_lookup
  ON stage_labdw.columns
  USING btree
  (columnname COLLATE pg_catalog."default", columndescription COLLATE pg_catalog."default");




-- Table: stage_labdw.codetables

-- DROP TABLE stage_labdw.codetables;

CREATE TABLE stage_labdw.codetables
(
  codetable_id bigserial NOT NULL,
  codetable character varying(8000),
  code character varying(8000),
  text_value character varying(8000),
  row_retrieved timestamp without time zone,
  valid boolean,
  CONSTRAINT codetables_pkey PRIMARY KEY (codetable_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE stage_labdw.codetables
  OWNER TO ktp;

-- Index: stage_labdw.idx_codetables_lookup

-- DROP INDEX stage_labdw.idx_codetables_lookup;

CREATE INDEX idx_codetables_lookup
  ON stage_labdw.codetables
  USING btree
  (codetable COLLATE pg_catalog."default", code COLLATE pg_catalog."default");



-- Table: stage_labdw.cdc_time

-- DROP TABLE stage_labdw.cdc_time;

CREATE TABLE stage_labdw.cdc_time
(
  cdc_time_id integer NOT NULL DEFAULT nextval('cdc_time_id_seq'::regclass),
  process_name character varying,
  last_load timestamp without time zone,
  current_load timestamp without time zone,
  CONSTRAINT labdw_cdc_time_pkey PRIMARY KEY (cdc_time_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE stage_labdw.cdc_time
  OWNER TO ktp;

