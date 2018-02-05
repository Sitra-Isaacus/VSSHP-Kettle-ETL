
DROP  TABLE IF EXISTS "map".labra_potilas_asia;
CREATE TABLE "map".labra_potilas_asia
(
  potilas_id INTEGER
, naytteenotto_hetki  TIMESTAMP
, tilaaja_taso_0_koodi VARCHAR
, tilaaja_taso_1_koodi VARCHAR
, tilaaja_taso_2_koodi VARCHAR
, tilaaja_taso_3_koodi VARCHAR
, potilas_asia_id BIGINT
);

CREATE INDEX labra_potilas_asia_potilas_id_index ON labra_potilas_asia( potilas_id );
CREATE INDEX labra_potilas_asia_naytteenotto_hetki_index ON labra_potilas_asia( naytteenotto_hetki );
CREATE INDEX labra_potilas_asia_tilaaja_taso_0_koodi_index ON labra_potilas_asia( tilaaja_taso_0_koodi );
CREATE INDEX labra_potilas_asia_tilaaja_taso_1_koodi_index ON labra_potilas_asia( tilaaja_taso_0_koodi );
CREATE INDEX labra_potilas_asia_tilaaja_taso_2_koodi_index ON labra_potilas_asia( tilaaja_taso_0_koodi );
CREATE INDEX labra_potilas_asia_tilaaja_taso_3_koodi_index ON labra_potilas_asia( tilaaja_taso_0_koodi );
CREATE INDEX labra_potilas_asia_potilas_asia_id_index ON labra_potilas_asia( potilas_asia_id );
