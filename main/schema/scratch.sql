--
-- Create a list of redundant 'potilas_id's and select a replacement values to
-- make the values unique.
-- 
SELECT 
	potilas_id,
	new_potilas_id
FROM henkilon_identiteetti
JOIN (
	--
  -- Patients with multiple 'potilas_id' with the same 'hetu' 
  --
	SELECT hetu, n, new_potilas_id
	FROM (
		SELECT
		hetu,
		count(DISTINCT potilas_id) AS n,
		--
		-- Choose the minimum of potilas_id as the new id
		--
		min( potilas_id ) AS new_potilas_id
		FROM henkilon_identiteetti
		GROUP BY hetu) AS T
	WHERE n > 1 ) AS multiple_potilas_id
ON henkilon_identiteetti.hetu = multiple_potilas_id.hetu
WHERE potilas_id != new_potilas_id;

