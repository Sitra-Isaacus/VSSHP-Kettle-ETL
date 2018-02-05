--
-- Indices are used to substantially speed up the 
-- insert and update operations
--

-- Patient specific indices
--
DROP INDEX IF EXISTS potilas_yhd_viite_index;
CREATE INDEX potilas_yhd_viite_index ON main.potilas (yhd_viite);

DROP INDEX IF EXISTS henkilon_identiteetti_potilas_id_index;
CREATE INDEX henkilon_identiteetti_potilas_id_index 
ON main.henkilon_identiteetti (potilas_id);

DROP INDEX IF EXISTS potilastieto_potilas_id_index;
CREATE INDEX potilastieto_potilas_id_index
ON main.potilas_tieto (potilas_id);

DROP INDEX IF EXISTS potilasnumero_potilas_id_index;
CREATE INDEX potilasnumero_potilas_id_index
ON main.potilasnumero (potilas_id);

DROP INDEX IF EXISTS henkilon_identiteetti_hetu_index;
CREATE INDEX henkilon_identiteetti_hetu_index
ON main.henkilon_identiteetti (hetu);



