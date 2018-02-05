-- Table: main_dev.labra

-- DROP TABLE main_dev.labra;

CREATE TABLE main_dev.labra
(
  labra_id bigint NOT NULL DEFAULT nextval('main_dev.labra_v7_labra_id_seq'::regclass),
  tutkimusriviavain text,
  henkilotunnus text,
  naytetunnus text,
  putkien_lkm text,
  naytteenotto timestamp without time zone,
  paatutkimuspaketti character varying(8000),
  tutkimus character varying(8000),
  tutkimuksen_tyyppi character varying(8000),
  tulos_teksti text,
  tuloksen_mittayksikko text,
  tarkein_mikrobi character varying(8000),
  viitearvo_min double precision,
  viitearvo_max double precision,
  viitearvojen_ulkopuolella character varying(8000),
  tilaaja_taso_0 character varying(8000),
  tilaaja_taso_1 character varying(8000),
  tilaaja_taso_2 character varying(8000),
  tilaaja_taso_3 character varying(8000),
  ulkoinen_asiakas character varying(8000),
  kiireellinen_tutkimus character varying(8000),
  ulkopuolella_teetetty character varying(8000),
  projektin_tunnus character varying(8000),
  sisainen_kustannus double precision,
  laskutettu_hinta double precision,
  paivityshetki_main timestamp without time zone,
  stage_labdw_transform_id bigint,
  potilas_asia_id bigint,
  lahde_koodi_id integer,
  tiedon_omistaja_koodi_id integer,
  tiedon_omistaja character varying(8000),
  potilas_id bigint,
  vastaus_kuuluu_vsshp boolean,
  CONSTRAINT labra_v7_pk PRIMARY KEY (labra_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE main_dev.labra
  OWNER TO ktp;
GRANT ALL ON TABLE main_dev.labra TO ktp;
GRANT SELECT ON TABLE main_dev.labra TO auria;

-- Index: main_dev.labra_henkilotunnus_ix

-- DROP INDEX main_dev.labra_henkilotunnus_ix;

CREATE INDEX labra_henkilotunnus_ix
  ON main_dev.labra
  USING btree
  (henkilotunnus COLLATE pg_catalog."default");

-- Index: main_dev.labra_naytteenotto_ix

-- DROP INDEX main_dev.labra_naytteenotto_ix;

CREATE INDEX labra_naytteenotto_ix
  ON main_dev.labra
  USING btree
  (naytteenotto);

-- Index: main_dev.labra_paatutkimuspaketti_ix

-- DROP INDEX main_dev.labra_paatutkimuspaketti_ix;

CREATE INDEX labra_paatutkimuspaketti_ix
  ON main_dev.labra
  USING btree
  (paatutkimuspaketti COLLATE pg_catalog."default");

-- Index: main_dev.labra_tilaaja_ix

-- DROP INDEX main_dev.labra_tilaaja_ix;

CREATE INDEX labra_tilaaja_ix
  ON main_dev.labra
  USING btree
  (tilaaja_taso_3 COLLATE pg_catalog."default");

-- Index: main_dev.labra_tutkimus_tutkimusriviavain_ix

-- DROP INDEX main_dev.labra_tutkimus_tutkimusriviavain_ix;

CREATE INDEX labra_tutkimus_tutkimusriviavain_ix
  ON main_dev.labra
  USING btree
  (tutkimus COLLATE pg_catalog."default", tutkimusriviavain COLLATE pg_catalog."default");

