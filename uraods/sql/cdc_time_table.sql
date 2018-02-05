--
-- Create Change Data Capture table for uraods updates in PostgreSQL
--
-- Author(s)     : Arho Virkki
-- Copyright     : VTT Technical Reseach Centre of Finland Ltd
-- Original date : 2015-12-01

DROP TABLE IF EXISTS stage_uraods.cdc_time;

CREATE TABLE stage_uraods.cdc_time (
	id SERIAL PRIMARY KEY,
	table_name VARCHAR,
	last_load TIMESTAMP,
	current_load TIMESTAMP);

INSERT INTO stage_uraods.cdc_time 
	(table_name, last_load, current_load) 
VALUES
  ('alatoimenpide', '2016-02-17 03:00:00', NULL),
  ('asiakas', '2016-02-17 03:00:00', NULL),
  ('diagnoosi', '2016-02-17 03:00:00', NULL),
  ('hilmo', '2016-02-17 03:00:00', NULL),
  ('hoitokokonaisuus', '2016-02-17 03:00:00', NULL),
  ('hoitotaulukko', '2016-02-17 03:00:00', NULL),
  ('huomautus', '2016-02-17 03:00:00', NULL),
  ('jonovaraus', '2016-02-17 03:00:00', NULL),
  ('kaynti', '2016-02-17 03:00:00', NULL),
  ('koodisto', '2016-02-17 03:00:00', NULL),
  ('koodisto_tiedot', '2016-02-17 03:00:00', NULL),
  ('koodisto_versio', '2016-02-17 03:00:00', NULL),
  ('laakerekisteri', '2016-02-17 03:00:00', NULL),
  ('laakerekisteri_lisatiedot', '2016-02-17 03:00:00', NULL),
  ('laakitys_antokirjaus', '2016-02-17 03:00:00', NULL),
  ('laakitys_laakemaarays', '2016-02-17 03:00:00', NULL),
  ('laakitys_resepti', '2016-02-17 03:00:00', NULL),
  ('laakitys_resepti_vaik_aine', '2016-02-17 03:00:00', NULL),
  ('lahete', '2016-02-17 03:00:00', NULL),
  ('lisatoimenpide', '2016-02-17 03:00:00', NULL),
  ('muu_palvelu', '2016-02-17 03:00:00', NULL),
  ('osastohoito', '2016-02-17 03:00:00', NULL),
  ('pitkaaikaisdiagnoosi', '2016-02-17 03:00:00', NULL),
  ('potilaan_haittavaikutukset', '2016-02-17 03:00:00', NULL),
  ('potilaan_hoitokuurit', '2016-02-17 03:00:00', NULL),
  ('potilaan_muualla_annetut', '2016-02-17 03:00:00', NULL),
  ('potilaan_oheislaakkeet', '2016-02-17 03:00:00', NULL),
  ('potilaan_syopal_antok', '2016-02-17 03:00:00', NULL),
  ('potilaan_syopalaakkeet', '2016-02-17 03:00:00', NULL),
  ('resurssi', '2016-02-17 03:00:00', NULL),
  ('riskit', '2016-02-17 03:00:00', NULL),
  ('riskitieto', '2016-02-17 03:00:00', NULL),
  ('suorite', '2016-02-17 03:00:00', NULL),
  ('toimenpide', '2016-02-17 03:00:00', NULL),
  ('uraods_primarykeys', '2016-02-17 03:00:00', NULL),
  ('varaus', '2016-02-17 03:00:00', NULL),
  ('yksikko', '2016-02-17 03:00:00', NULL),
  ('yksikko_luokittelut', '2016-02-17 03:00:00', NULL),
  ('yksikko_osapuolet', '2016-02-17 03:00:00', NULL);
