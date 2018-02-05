insert into stage_sai.cdc_time (process_name, last_load ,  current_load )
values 
('admission', '1900-01-01', null),
('infection', '1900-01-01', null),
('antibtreat', '1900-01-01', null),
('microbefind', '1900-01-01', null);

select * from stage_sai.cdc_time;

select * from stage_sai.admission;
select * from stage_sai.infection;
select * from stage_sai.antibtreat;
select * from stage_sai.microbefind;

truncate table stage_sai.admission;
truncate table stage_sai.infection;
truncate table stage_sai.antibtreat;
truncate table stage_sai.microbefind;

update stage_sai.cdc_time
set last_load = '1900-01-01'
where process_name in ('admission', 'infection','antibtreat','microbefind');

select * from stage_sai.admission as a
inner join stage_sai.infection as i on a.socsecno = i.socsecno and a.arrivaldate = i.arrivaldate limit 100;

