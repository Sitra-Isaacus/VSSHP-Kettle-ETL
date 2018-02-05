DROP VIEW IF EXISTS static.ktp_jobs;

CREATE VIEW static.ktp_jobs AS (
SELECT pid, query 
FROM (
  SELECT
    pid, substring(query from 1 for 65) AS query
  FROM pg_stat_activity 
  WHERE state = 'active') AS T
WHERE query NOT LIKE '%ktp_jobs%');

-- Remember, jobs can be cancelled with
-- SELECT pg_cancel_backend(pid of the postgres process);
