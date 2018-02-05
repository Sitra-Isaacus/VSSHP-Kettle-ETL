--
-- Create a mapping table for labra_tilaaja plus indices
-- 
-- Arho Virkki & Anna Hammais, TYKS, 2016
--


CREATE TABLE map.labra_tilaaja_tasot (
    id integer PRIMARY KEY,
    tiedon_omistaja_koodi_id integer,
    vsshp_boolean boolean,
    taso_0 character varying,
    taso_1 character varying,
    taso_2 character varying,
    taso_3 character varying,
    taso_0_koodi character varying,
    taso_1_koodi character varying,
    taso_2_koodi character varying,
    taso_3_koodi character varying
);

CREATE INDEX labra_tilaaja_tasot_index
  ON map.labra_tilaaja
  USING btree
  (taso_3 COLLATE pg_catalog."default",
  taso_2 COLLATE pg_catalog."default",
  taso_1 COLLATE pg_catalog."default",
  taso_0 COLLATE pg_catalog."default");


-- INSERT into map.labra_tilaaja_tasot FROM TEXT FILE Tilaajat_lab_2015-08-27.txt.

-- Create new table with only unique level 3 customers.

CREATE TABLE map.labra_tilaaja (
    labra_tilaaja_id serial PRIMARY KEY,
    tiedon_omistaja_koodi_id integer,
    vsshp_boolean boolean,
    taso_3 character varying,
    taso_3_koodi character varying
);

CREATE INDEX labra_tilaaja_index
  ON map.labra_tilaaja
  USING btree
  (taso_3 COLLATE pg_catalog."default");

CREATE INDEX labra_tilaaja_koodi_index
  ON map.labra_tilaaja
  USING btree
  (taso_3_koodi COLLATE pg_catalog."default");

-- Fill map.labra_tilaajat with:

insert into map.labra_tilaaja (tiedon_omistaja_koodi_id, vsshp_boolean, taso_3, taso_3_koodi)
select distinct case when vsshp_boolean = TRUE then 17 else 16 end,
vsshp_boolean, taso_3, taso_3_koodi
from map.labra_tilaaja_tasot;


