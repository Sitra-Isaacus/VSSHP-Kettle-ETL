-- ##################################################
-- create main_dev.mv_patologia_vastaus_vsshp

drop materialized view if exists main_dev.mv_patologia_vastaus_vsshp;

create materialized view main_dev.mv_patologia_vastaus_vsshp as
SELECT v.patologia_vastaus_id,
a.hetu as henkilotunnus, v.naytenumero,   v.pyynto, v.vastaus, v.versio, 
v.naytteenottohetki,
v.saapunut, v.tallennettu, v.kuitattu, v.naytetyyppi, 
v.blokkien_maara_max, 
v.lasien_maara_max,
v.lahettaja, v.vastaanottaja, 
v.projekti, 
regexp_replace(v.kliiniset_esitiedot, E'\\r|\\n+','','g') as kliiniset_esitiedot,
regexp_replace(v.lausuntoteksti, E'\\r|\\n+','','g') as lausuntoteksti,
v.qpati_export_time, 
v.paivityshetki as ktp_paivityshetki

FROM main_dev.patologia_vastaus as v
inner join main_dev.potilas_asia as a on v.potilas_asia_id = a.id
where v.vastaus_kuuluu_vsshp = TRUE;





-- ##################################################
-- create main_dev.mv_patologia_elin_diagnoosi_vsshp

drop materialized view if exists main_dev.mv_patologia_elin_diagnoosi_vsshp;

create materialized view main_dev.mv_patologia_elin_diagnoosi_vsshp as
SELECT patologia_elin_diagnoosi_id, e.patologia_vastaus_id,
a.hetu as henkilotunnus, e.naytenumero,e.pyynto, e.vastaus, e.rivinumero,
e.elin_etuliite, e.elin, e.elin_takaliite,
e.diagnoosi, e.diagnoosi_takaliite, 
e.t_snomed, e.m_snomed,  e.paivityshetki as ktp_paivityshetki
FROM main_dev.patologia_elin_diagnoosi as e
inner join main_dev.patologia_vastaus as v on e.patologia_vastaus_id = v.patologia_vastaus_id
inner join main_dev.potilas_asia as a on v.potilas_asia_id = a.id
where v.vastaus_kuuluu_vsshp = TRUE;


-- ##################################################
-- create main_dev.mv_patologia_tutkimus_vsshp

drop materialized view if exists main_dev.mv_patologia_tutkimus_vsshp;

create materialized view main_dev.mv_patologia_tutkimus_vsshp as
SELECT t.patologia_tutkimus_id, t.patologia_vastaus_id, 
a.hetu as henkilotunnus, t.naytenumero, t.pyynto, t.vastaus,t.naytetyyppi, t.rivinumero,
t.tutkimus, t.lkm, t.hinta, t.paivityshetki as ktp_paivityshetki   
FROM main_dev.patologia_tutkimus as t
inner join main_dev.patologia_vastaus as v on t.patologia_vastaus_id = v.patologia_vastaus_id
inner join main_dev.potilas_asia as a on v.potilas_asia_id = a.id
where v.vastaus_kuuluu_vsshp = TRUE;



-- ##################################################
-- create main_dev.mv_patologia_taulukkoarvo_vsshp

drop materialized view if exists main_dev.mv_patologia_taulukkoarvo_vsshp;

create materialized view main_dev.mv_patologia_taulukkoarvo_vsshp as
SELECT t.patologia_taulukkoarvo_id, t.patologia_vastaus_id,
a.hetu as henkilotunnus, t.naytenumero, t.pyynto, t.vastaus,
t.taulukon_nimi, t.suure, t.arvo,
t.paivityshetki as ktp_paivityshetki
FROM main_dev.patologia_taulukkoarvo as t
inner join main_dev.patologia_vastaus as v on t.patologia_vastaus_id = v.patologia_vastaus_id
inner join main_dev.potilas_asia as a on v.potilas_asia_id = a.id
where v.vastaus_kuuluu_vsshp = TRUE;


