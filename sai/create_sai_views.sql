
-- ADMISSION
-- drop view stage_sai.v_admission;

create view stage_sai.v_admission as
select 
socsecno, arrivaldate, releasedate, hospitalname, 
ward, wardname, specialty, periodid, resource,
"timestamp" as sai_admission_update_ts
from stage_sai.admission_export;


-- INFECTION
-- drop view stage_sai.v_infection;

create view stage_sai.v_infection as
select
a.socsecno, a.arrivaldate, a.releasedate, a.hospitalname, 
a.ward, a.wardname, a.specialty, a.periodid, a.resource,
a.sai_admission_update_ts,
infectionno, infectiontypename, 
infectionclass, infectionclassname, postinfection, postinfectiontime, 
diagmemo, observationtype, observationtypename, approovedname, 
siro, websaisubmission, registeredby
from stage_sai.v_admission as a
inner join stage_sai.infection_export as i on a.socsecno = i.socsecno and a.arrivaldate = i.arrivaldate;


-- MICROBEFIND
-- drop view stage_sai.v_microbe;

create view stage_sai.v_microbe as
select 
i.socsecno, i.arrivaldate, i.releasedate, i.hospitalname, 
i.ward, i.wardname, i.specialty, i.periodid, i.resource,
i.sai_admission_update_ts,
i.infectionno, i.infectiontypename, 
i.infectionclass, i.infectionclassname, i.postinfection, i.postinfectiontime, 
i.diagmemo, i.observationtype, i.observationtypename, i.approovedname, 
i.siro, i.websaisubmission, i.registeredby,
microbefindno, testdate, 
sampletype, sampletypename, microbe, microbename, resist,
sampleno, samplefindno
from stage_sai.v_infection as i
inner join stage_sai.microbefind_export as m on i.socsecno = m.socsecno and i.arrivaldate = m.arrivaldate and i.infectionno = m.infectionno;


-- ANTIBTREAT
-- drop view stage_sai.v_antibiotic;

create view stage_sai.v_antibiotic as
select 
i.socsecno, i.arrivaldate, i.releasedate, i.hospitalname, 
i.ward, i.wardname, i.specialty, i.periodid, i.resource,
i.sai_admission_update_ts,
i.infectionno, i.infectiontypename, 
i.infectionclass, i.infectionclassname, i.postinfection, i.postinfectiontime, 
i.diagmemo, i.observationtype, i.observationtypename, i.approovedname, 
i.siro, i.websaisubmission, i.registeredby,
antibiotic, antibstartdate, 
antibenddate, antibduration, antibroute, antibcode, antibdosetype, 
antibward
from stage_sai.v_infection as i
inner join stage_sai.antibtreat_export as m on i.socsecno = m.socsecno and i.arrivaldate = m.arrivaldate and i.infectionno = m.infectionno;


-- OPERATION
-- drop view stage_sai.v_operation;

create view stage_sai.v_operation as
select 
a.socsecno, a.arrivaldate, a.releasedate, a.hospitalname, 
a.ward, a.wardname, a.specialty, a.periodid, a.resource,
a.sai_admission_update_ts,
opid, action1, actionname1, action2, actionname2, 
action3, actionname3, action4, actionname4, action5, actionname5, 
action6, actionname6, action7, actionname7, action8, actionname8, 
action9, actionname9, anetype1, anetypename1, anetype2, anetypename2, 
anetype3, anetypename3
FROM stage_sai.v_admission as a
inner join stage_sai.operation_export as e on a.socsecno = e.socsecno and a.arrivaldate = e.arrivaldate;

