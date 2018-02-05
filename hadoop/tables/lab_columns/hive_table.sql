--
-- define the lab table
-- 
-- To source this file from command line, issue:
--   beeline -u jdbc:hive2://ktphadoop.vsshp.net:10000/ktp
--   !run hive_table.sql

DROP TABLE IF EXISTS lab_columns;

CREATE EXTERNAL TABLE IF NOT EXISTS lab_columns (
  ColumnName STRING,
  ColumnDescription STRING,
  Codetable  STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n' 
LOCATION '/user/hive/warehouse/ktp/lab_columns';
