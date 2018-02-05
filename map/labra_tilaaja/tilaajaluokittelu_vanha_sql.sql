



-- ###########################################################
-- LUOKITELLAAN TILAAJAT


drop table if exists lab_temp.tilaajat;

select 
distinct custorg0, custorg1, custorg2, custorg3
into lab_temp.tilaajat
from lab_temp.temp_lab;
-- Query returned successfully: 6787 rows affected, 02:23:7216 hours execution time.


alter table lab_temp.tilaajat add column Tilaaja_taso_0 text;
alter table lab_temp.tilaajat add column Tilaaja_taso_1 text;
alter table lab_temp.tilaajat add column Tilaaja_taso_2 text;
alter table lab_temp.tilaajat add column Tilaaja_taso_3 text;
alter table lab_temp.tilaajat add column on_vsshp boolean;




-- päivitetään tilaajatasojen selitteet

-- taso 0
update lab_temp.tilaajat as t
set tilaaja_taso_0 = c.text
from lab_temp.temp_codetables_korjattu as c
where t.custorg0 = c.code and c.codetable = 'ldwtx1_o0';
-- 6784 riviä

-- taso 1
update lab_temp.tilaajat as t
set tilaaja_taso_1 = c.text
from lab_temp.temp_codetables_korjattu as c
where t.custorg1 = c.code and c.codetable = 'ldwtx1_o1';
-- 6781


-- taso 2
update lab_temp.tilaajat as t
set tilaaja_taso_2 = c.text
from lab_temp.temp_codetables_korjattu as c
where t.custorg2 = c.code and c.codetable = 'ldwtx1_o2';
-- 6781

-- taso 3
update lab_temp.tilaajat as t
set tilaaja_taso_3 = c.text
from lab_temp.temp_codetables_korjattu as c
where t.custorg3 = c.code and c.codetable = 'ldwtx1_o3';
-- 6779

-- onko tilaajia, joissa koodi ei osu kooditauluun?
select * from lab_temp.tilaajat
where (custorg0 != '' and tilaaja_taso_0 is null)
or (custorg1 != '' and tilaaja_taso_1 is null)
or (custorg2 != '' and tilaaja_taso_2 is null)
or (custorg3 != '' and tilaaja_taso_3 is null);



-- labradatassa 131 134 riviä, joilla ei mitään tietoa tilaajasta
-- select count(*) from lab_temp.temp_lab where custorg0 = '' and custorg1 = ''
-- and custorg2 = '' and custorg3 = '';

-- luokitellaan labratilaajat vanhan tiedon perusteella

update  lab_temp.tilaajat as t1
set on_vsshp = t2.vsshp_boolean
from map.labra_tilaaja as t2
where t1.custorg0 = t2.taso_0_koodi
and t1.custorg1 = t2.taso_1_koodi
and t1.custorg2 = t2.taso_2_koodi
and t1.custorg3 = t2.taso_3_koodi;
-- Query returned successfully: 6529 rows affected, 484 msec execution time.


-- 3919
-- select count(*) from lab_temp.tilaajat where on_vsshp = '1';

-- 2610
-- select count(*) from lab_temp.tilaajat where on_vsshp = '0';

-- 258 uutta tilaajaa, jotka pitää luokitella
-- select count(*) from lab_temp.tilaajat where on_vsshp is null;

-- katselmointi
-- select custorg0, tilaaja_taso_0, custorg3, tilaaja_taso_3 from lab_temp.tilaajat where on_vsshp is null
-- order by custorg0, tilaaja_taso_3;

-- 
-- select custorg0, tilaaja_taso_0, custorg3, tilaaja_taso_3, on_vsshp
-- from lab_temp.tilaajat order by custorg0;
-- 
-- select * from lab_temp.tilaajat where custorg0 = 'VSSHPM' and on_vsshp is not null
-- order by on_vsshp;



-- PÄIVITETÄÄN TARKISTUSTEN JÄLKEEN

-- sisäiset
update lab_temp.tilaajat set on_vsshp = '1'
where on_vsshp is null
and custorg0 in ('AL-ESH', 'EPLL', 'KO-HTR', 'OP-HTR', 'PATO',
'PSY-TA','TYKS', 'VSKK', 'VSSHP', 'VSSHPM', 'VSV')
and custorg3 != '207';

-- yksi poikkkeus (TTH)
update lab_temp.tilaajat set on_vsshp = '0'
where on_vsshp is null
and custorg3 = '207';

-- ulkoiset
update lab_temp.tilaajat set on_vsshp = '0'
where on_vsshp is null
and custorg0 in ('','ATTEND', 'KEMTK', 'LABULK', 'LAITK', 'LOITK', 'MASTK', 'MUUT',
'MYNTK', 'PAITK', 'PARTK', 'PÖYTK', 'SAIRUL', 'TKU', 'TKULKO', 'UKITK', 'VALTIO', 'VEHTK', 'YKSIT','TYKSMG');

-- tällä taso 0 oli tyhjä mutta taso 3 ei
update lab_temp.tilaajat set on_vsshp = '0'
where on_vsshp is null
and custorg3 = 'YLIVIE';



-- katselmointi uudelleen
-- select custorg0, tilaaja_taso_0, custorg3, tilaaja_taso_3 from lab_temp.tilaajat where on_vsshp is null
-- order by custorg0, tilaaja_taso_3;


-- ei millään tilaaja_taso_3:lla sekä sisäisiä että ulkoisia merkintöjä (paitsi null)
-- select tilaaja_taso_3, count(distinct on_vsshp) from lab_temp.tilaajat
-- group by tilaaja_taso_3
-- having count(distinct on_vsshp) > 1;




