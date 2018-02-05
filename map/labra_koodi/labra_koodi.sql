--
-- Read and clean labra codes from the original LabDW code tables.
-- The script can be called from Kettle or run as such.
-- This script assumes the columns of stage_labdw.codetables to be trimmed.
-- 
-- Arho Virkki / VTT 2016 & Anna Hammais
--


DROP TABLE IF EXISTS map.labra_koodi;

CREATE TABLE map.labra_koodi (
	id SERIAL PRIMARY KEY,
	koodisto VARCHAR NOT NULL,
	koodi VARCHAR,
	koodin_selite VARCHAR NOT NULL,
	luontihetki TIMESTAMP WITHOUT TIME ZONE NOT NULL);


-- ###########################################################
-- inserting into map.labra_koodi


insert into map.labra_koodi (koodisto, koodi, koodin_selite, luontihetki)
select codetable, code, text_value, paivityshetki_stage
from stage_labdw.codetables as k1
where valid = TRUE
and code is not null
and trim(both from code) != '';

-- set explanation = code if explanation doesn't exist
update map.labra_koodi
set koodin_selite = koodi
where koodin_selite is null or koodin_selite = '';


-- add codes that are missing from the code table but found in the data
insert into map.labra_koodi (koodisto, koodi, koodin_selite, luontihetki) values 
('ldwtx1_md', '0', 'Tieto puuttuu', current_timestamp),
('ldwtx1_o0', 'VSSHP', 'VSSHP', current_timestamp),
('ldwtx1_o3', 'PARBADD', 'PARBADD-Länsi-Turunmaan tk', current_timestamp),
('ldwtx1_o2', 'RAISTKY', 'Raision tk/yleinen', current_timestamp),
('ldwtx1_o2', 'RAISTKR', 'Ruskon tk', current_timestamp);


-- add codes where some faulty special characters have been fixed to match those found in the data

insert into map.labra_koodi
(koodisto, koodi, koodin_selite, luontihetki)
select  koodisto,
regexp_replace(regexp_replace(regexp_replace(koodi, 'Ä', '-', 'g'), 'Å', '+', 'g'), 'Ö', 'Í', 'g') as koodi,
koodin_selite, luontihetki
from map.labra_koodi
where koodisto in ('ldwtx1_o0','ldwtx1_o1','ldwtx1_o2','ldwtx1_o3')
and koodi ~ '[ÄÖÅ]';



-- create index on code table
CREATE INDEX map_labra_koodi_koodisto_koodi_idx
  ON map.labra_koodi
  USING btree
  (koodisto COLLATE pg_catalog."default", koodi COLLATE pg_catalog."default");







