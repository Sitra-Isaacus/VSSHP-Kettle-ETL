
-- delete from company where compid >= 154
-- delete from person where personid >= 130
-- delete from projektit where projectid > 40

-- organisaatiot company-tauluun
insert into company (appid, compid,compname, createdate)
select 1, null, nimi, CURRENT_TIMESTAMP
from ktp_organisaatio as o
where o.nimi not in
(select compname from company);

-- toimialueet company-tauluun, jos eivät ole jo
insert into company (appid, compid, compname,mastercompid, createdate) select 1, null, t.nimi,c.compid, CURRENT_TIMESTAMP
from ktp_toimialue as t
inner join ktp_organisaatio as o on t.organisaatio_id_fk = o.organisaatio_id
inner join company as c on o.nimi = c.compname
where t.nimi not in (select distinct compname from company); -- ne joissa toimialue ei itsessään jo ole olemassa organisaationa

-- yksikot company-tauluun, jos eivät ole jo
insert into company (appid, compid, compname,mastercompid, createdate) select 1, null, y.nimi,c.compid, CURRENT_TIMESTAMP
from ktp_yksikko as y
inner join ktp_toimialue as t on y.toimialue_id_fk = t.toimialue_id
inner join ktp_organisaatio as o on t.organisaatio_id_fk = o.organisaatio_id
inner join company as c on t.nimi = c.compname
where y.nimi not in (select distinct compname from company); -- ne joissa yksikko ei itsessään jo ole olemassa organisaationa


-- tutkijat person-tauluun jos eivät ole jo
insert into person (appid, personid, surname, firstname, email, compid)
select 1, null, sukunimi, etunimi, sahkoposti, c.compid
from ktp_tutkija as t
inner join ktp_yksikko as y on t.yksikko_id_fk = y.yksikko_id
inner join company as c on y.nimi = c.compname
where not exists
(select * from person as p where p.surname = t.sukunimi and p.firstname = t.etunimi);


insert into person (appid, personid, surname, firstname, email, compid)
select 1, null, 'Laitinen', 'Tarja', 'tarja.helena.laitinen@tyks.fi', (select compid from company where compname = 'TO5J Keuhkosairaudet');



-- ###############################################
-- LINKITYKSIÄ



insert into projektit (projectid, appid, state, projectnum, projektin_nimi)
select null, 1, '', tutkimusnumero, nimi
from ktp_tutkimus



-- select * from projektit where projektin_nimi LIKE 'KeuSyö%' -- projectid = 42

select * from itemrelations where masteritemid = 42
-- masteritemfieldname c_company tarkoittaa yhteyshenkilöön liittyviä tietoja
-- masteritem 8

-- item 381 itemtype 1 Tarja Laitisen company ID, joka viittaa keuhkolle
-- item 460 itemtype 2 Tarja Laitisen ID


-- masteritemfieldname r_company tarkoittaa tutkimuksesta vastaavan henkilön tietoja
-- masteritem 8
-- muuten samanlaiset rivit eli 381 ja 460, kuten yllä

-- eli tutkimuksesta vastaavat henkilöt syötetään seuraavasti:

insert into itemrelations (relationid, appid, masteritem, masteritemid, masteritemfieldname, itemtype, itemid)
select null, 1, 8, projectid, 'r_company', 1, c.compid
from projektit as pr
inner join ktp_tutkimus as t on pr.projectnum = t.tutkimusnumero
inner join ktp_tutkija as tu on t.vastuullinen_tutkija_id_fk = tu.tutkija_id
inner join  ktp_yksikko as y on tu.yksikko_id_fk = y.yksikko_id
inner join person as pe on (pe.surname = tu.sukunimi and pe.firstname = tu.etunimi)
inner join company as c on pe.compid = c.compid;


insert into itemrelations (relationid, appid, masteritem, masteritemid, masteritemfieldname, itemtype, itemid)
select null, 1, 8, projectid, 'r_company', 2, pe.personid
from projektit as pr
inner join ktp_tutkimus as t on pr.projectnum = t.tutkimusnumero
inner join ktp_tutkija as tu on t.vastuullinen_tutkija_id_fk = tu.tutkija_id
inner join  ktp_yksikko as y on tu.yksikko_id_fk = y.yksikko_id
inner join person as pe on (pe.surname = tu.sukunimi and pe.firstname = tu.etunimi)
inner join company as c on pe.compid = c.compid;


