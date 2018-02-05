
-- ###############################################################
-- VALITAAN STAGESTA LABRATAULUSTA TIETYT SARAKKEET KÄYTETTÄVIKSI

drop table if exists lab_temp.temp_lab;

create table lab_temp.temp_lab as
select id, trim(both from testid) testid, trim(both from testp) testp, trim(both from test) test,
trim(both from outcomet) outcomet, refmin,
refmax, refval,
trim(both from unit) unit, trim(both from microbe) microbe, trim(both from custorg0) custorg0, 
trim(both from custorg1) custorg1,
trim(both from custorg2) custorg2, trim(both from custorg3) custorg3,
datetime3, trim(both from hetu) hetu, 
dt, rank() over (partition by trim(both from testid), trim(both from test) order by dt desc) as rank
from stage_hadoop.lab;
-- Query returned successfully: 150264039 rows affected, 01:10:3612 hours execution time.




-- select * from lab_temp.temp_lab_vsshp_joined where tutkimusriviavain = '2aAgXDE00';



-- select * from lab_temp.temp_lab  where rank > 1 limit 10;

-- tarkistus
-- select count(*) from lab_temp.temp_lab; -- 150264039




-- ###########################################################
-- TAHDÄÄN LABRA-JOIN-TAULU JOSSA SEKÄ SISÄISET ETTÄ ULKOISET TILAAJAT

drop table if exists lab_temp.temp_lab_joined;

select
distinct
-- l.id as stage_lab_taulun_id,
l.testid as Tutkimusriviavain,
l.Hetu as Henkilotunnus,
l.testp,
ldwtx1_test.Text as Paatutkimuspaketti,
l.test,
ldwtx1_test1.Text as Tutkimus, 
l.datetime3 as Naytteenotto,
l.custorg0,
ldwtx1_o0.Text as Tilaaja_taso_0,
l.custorg1,
ldwtx1_o1.Text as Tilaaja_taso_1,
l.custorg2,
ldwtx1_o2.Text as Tilaaja_taso_2,
l.custorg3,
ldwtx1_o3.Text as Tilaaja_taso_3,
l.outcomet as Tulos_teksti,
l.unit as Tuloksen_mittayksikko,
l.refmin as Viitearvo_min,
l.refmax as Viitearvo_max,
l.refval,
refval_taulu.Text as Viitearvojen_ulkopuolella,
l.microbe,
ldwtx1_md.Text as Tarkein_mikrobi,
dt

into lab_temp.temp_lab_joined
from lab_temp.temp_lab as l
left outer join lab_temp.temp_codetables_korjattu as ldwtx1_test on (l.testp = ldwtx1_test.Code and ldwtx1_test.Codetable = 'ldwtx1_test')
left outer join lab_temp.temp_codetables_korjattu as ldwtx1_test1 on (l.test = ldwtx1_test1.Code and ldwtx1_test1.Codetable = 'ldwtx1_test1')
left outer join lab_temp.temp_codetables_korjattu as ldwtx1_o0 on (l.custorg0 = ldwtx1_o0.Code and ldwtx1_o0.Codetable = 'ldwtx1_o0')
left outer join lab_temp.temp_codetables_korjattu as ldwtx1_o1 on (l.custorg1 = ldwtx1_o1.Code and ldwtx1_o1.Codetable = 'ldwtx1_o1')
left outer join lab_temp.temp_codetables_korjattu as ldwtx1_o2 on (l.custorg2 = ldwtx1_o2.Code and ldwtx1_o2.Codetable = 'ldwtx1_o2')
left outer join lab_temp.temp_codetables_korjattu as ldwtx1_o3 on (l.custorg3 = ldwtx1_o3.Code and ldwtx1_o3.Codetable = 'ldwtx1_o3')
left outer join lab_temp.temp_codetables_korjattu as refval_taulu on (cast(l.refval as text) = refval_taulu.Code and refval_taulu.Codetable = 'refval')
left outer join lab_temp.temp_codetables_korjattu as ldwtx1_md on (l.microbe = ldwtx1_md.Code and ldwtx1_md.Codetable = 'ldwtx1_md')
where l.rank = 1;
-- Query returned successfully: 147542915 rows affected, 43:36 minutes execution time.
-- vanha jossa oli vielä muuttuneet tutkimukset tuplana: Query returned successfully: 147545966 rows affected, 44:39 minutes execution time.
-- VANHA ilman distinct-sanaa: Query returned successfully: 147669789 rows affected, 19:16 minutes execution time.

--149823010
-- tarkistus
--select count(*) from lab_temp.temp_lab_joined; -- 150264039

-- tarkistus (ennen oli 28 kappaletta tätä riviä)
--select * from lab_temp.temp_lab_joined where Tutkimusriviavain = '2aAgXDE00';



--select * from lab_temp.temp_lab_joined limit 10;

 
-- ###########################################################
-- PÄIVITETÄÄN LABRA-JOIN-TAULUUN TILAAJAN VSSHP-STATUS

alter table lab_temp.temp_lab_joined add column on_vsshp boolean;

drop table if exists lab_temp.temp_tilaajat_simple;

select distinct custorg3, tilaaja_taso_3, on_vsshp
into lab_temp.temp_tilaajat_simple
from lab_temp.tilaajat;


update lab_temp.temp_lab_joined as l
set on_vsshp = t.on_vsshp
from lab_temp.temp_tilaajat_simple as t
where l.tilaaja_taso_3 = t.tilaaja_taso_3;
-- Query returned successfully: 147102188 rows affected, 50:25 minutes execution time.
-- vanha ennen distinct: Query returned successfully: 147228769 rows affected, 57:39 minutes execution time.





-- tarkistus
-- select
-- distinct custorg0, Tilaaja_taso_0,
-- custorg1, Tilaaja_taso_1,
-- custorg2, Tilaaja_taso_2,
-- custorg3, Tilaaja_taso_3
-- into lab_temp.temp_tilaajat_ongelmat
-- from lab_temp.temp_lab_joined
-- where on_vsshp is null;
-- 
-- select * from lab_temp.temp_tilaajat_ongelmat;


-- tulos:
-- Ensiavun ja päivystyksen ll	Ensiavun ja päivystyksen ll	(PÄI   )	<NULL>
-- Muut	Yksityinen	<NULL>	<NULL>
-- Operatiivisen hoidon tr	Ensiavun tulosyksikkö	<NULL>	<NULL>
-- Operatiivisen hoidon tr	OP-PÄI	(PÄI   )	<NULL>
-- Paraisten tk	Paraisten tk	<NULL>	<NULL>
-- Turun hyvinvointitoimiala	<NULL>	<NULL>	<NULL>
-- <NULL>	<NULL>	(2     )	<NULL>
-- <NULL>	<NULL>	<NULL>	<NULL>


-- ###########################################################
-- TEHDÄÄN LAB_VSSHP-TAULU

drop table if exists lab_temp.temp_lab_vsshp_joined;

select *
into lab_temp.temp_lab_vsshp_joined
from lab_temp.temp_lab_joined
where on_vsshp='1';
-- Query returned successfully: 86559852 rows affected, 07:06 minutes execution time.
-- Vanha ennen distinct: Query returned successfully: 88180882 rows affected, 09:01 minutes execution time.

-- INDEKSOIDAAN

CREATE INDEX temp_lab_vsshp_joined_henkilotunnus_idx
ON lab_temp.temp_lab_vsshp_joined
USING btree
(henkilotunnus COLLATE pg_catalog."default");
COMMIT;


CREATE INDEX temp_lab_vsshp_joined_tutkimus
ON lab_temp.temp_lab_vsshp_joined
USING btree
(tutkimus COLLATE pg_catalog."default");
COMMIT;

-- Query returned successfully with no result in 40:45 minutes.



CREATE INDEX temp_lab_vsshp_joined_paatutkimuspaketti_idx
ON lab_temp.temp_lab_vsshp_joined
USING btree
(paatutkimuspaketti COLLATE pg_catalog."default");
COMMIT;

-- Query returned successfully with no result in 01:11:3600 hours.


CREATE INDEX temp_lab_vsshp_joined_naytteenotto_idx
ON lab_temp.temp_lab_vsshp_joined
USING btree
(naytteenotto);
COMMIT;

-- Query returned successfully with no result in 04:01 minutes.
