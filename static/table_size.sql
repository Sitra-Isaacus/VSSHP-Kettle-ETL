
-- Find table sizes in PostgreSQL
-- Arho Virkki / VTT 2016
--
-- Adapted from: 
-- http://pilif.github.io/2011/02/find-relation-sizes-in-postgresql/
--

DROP VIEW IF EXISTS static.ktp_table_size CASCADE;


CREATE VIEW static.ktp_table_size AS (
SELECT
  n.nspname AS "schema",
  c.relname AS "name",
  CASE c.relkind
     WHEN 'r' THEN 'table'
     WHEN 'v' THEN 'view'
     WHEN 'i' THEN 'index'
     WHEN 'S' THEN 'sequence'
     WHEN 's' THEN 'special'
  END AS "type",
  pg_catalog.pg_get_userbyid(c.relowner) AS "owner",
  pg_catalog.pg_size_pretty(pg_catalog.pg_relation_size(c.oid)) AS "size"
FROM pg_catalog.pg_class c
 left join pg_catalog.pg_namespace n ON n.oid = c.relnamespace
WHERE c.relkind IN ('r', 'v', 'i')
ORDER by pg_catalog.pg_relation_size(c.oid) DESC);

CREATE VIEW static.ktp_table_size_stage AS (
	SELECT schema, name, type, size
	FROM ktp_table_size
	WHERE schema LIKE 'stage_%' AND type = 'table');

CREATE VIEW static.ktp_table_size_main AS (
	SELECT name, type, size
	FROM ktp_table_size
	WHERE schema = 'main' AND type = 'table');

CREATE VIEW static.ktp_table_size_temp AS (
	SELECT name, type, size
	FROM ktp_table_size
	WHERE schema = 'temp' AND type = 'table');
