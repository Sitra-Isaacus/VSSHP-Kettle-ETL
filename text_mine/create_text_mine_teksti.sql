-- Table: text_mine.teksti

-- DROP TABLE text_mine.teksti;

CREATE TABLE text_mine.teksti
(
  henkilotunnus character varying(40),
  potilasnumero character varying(18),
  teksti_muoto text,
  hoitotapahtuma_numero character varying(18),
  hoitotapahtuma_tunnus character varying(18),
  hoitotapahtuma_alkuhetki timestamp without time zone,
  hoitotapahtuma_alkuhetki_arvio timestamp without time zone,
  hoitotapahtuma_loppuhetki timestamp without time zone,
  potilaskertomus_numero character varying(18) NOT NULL,
  toimipiste_koodi character varying(20),
  toimipiste_nimi character varying(70),
  yksikko_nimi character varying(70),
  nakyma_selite character varying(250),
  tila character varying(18),
  teksti_numero character varying(18) NOT NULL,
  teksti text,
  kertomus_paivityshetki_s timestamp without time zone,
  kertomus_paivityshetki_ods timestamp without time zone,
  teksti_paivityshetki_ods timestamp without time zone,
  teksti_aika timestamp without time zone,
  paivityshetki_stage timestamp without time zone,
  paivityshetki_mine timestamp without time zone,
  CONSTRAINT teksti_pkey PRIMARY KEY (teksti_numero, potilaskertomus_numero)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE text_mine.teksti
  OWNER TO ktp;
GRANT ALL ON TABLE text_mine.teksti TO ktp;
GRANT SELECT ON TABLE text_mine.teksti TO auria;


begin;
alter table text_mine.teksti add CONSTRAINT teksti_pkey PRIMARY KEY (teksti_numero, potilaskertomus_numero);
commit;

begin;
CREATE INDEX teksti_hetu_pvm_idx
  ON text_mine.teksti
  USING btree
  (henkilotunnus COLLATE pg_catalog."default", hoitotapahtuma_alkuhetki_arvio);
commit;


begin;
CREATE INDEX teksti_nakyma_selite_idx
  ON text_mine.teksti
  USING btree
  (nakyma_selite COLLATE pg_catalog."default");
commit;
