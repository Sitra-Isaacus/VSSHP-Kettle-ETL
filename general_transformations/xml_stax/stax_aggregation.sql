truncate table stage_qpati.temp_stax_aggregated;
drop index if exists stage_qpati.temp_stax_aggregated_keys;

-- aggregate data from temp_stax_all to temp_stax_aggregated
-- (first aggregate per parent element id, then aggregate those per file)

insert into stage_qpati.temp_stax_aggregated (xml_data_type_description, xml_path, xml_data_name, max_occurrences_per_file)
select xml_data_type_description,  xml_path, xml_data_name, max(occurrences_per_file) as max_occurrences_per_file

from (
select xml_filename, xml_data_type_description, xml_data_name, xml_path, max(count_per_parent) as occurrences_per_file
from
(select xml_filename, xml_data_type_description, xml_data_name, xml_path, xml_parent_element_id, count(*) as count_per_parent
from stage_qpati.temp_stax_all
where xml_path is not null and xml_data_name is not null and xml_data_type_description != 'END_ELEMENT'
group by xml_filename, xml_data_type_description, xml_data_name, xml_path, xml_parent_element_id) as grouped_per_file_and_parent
group by xml_filename, xml_data_type_description, xml_data_name, xml_path) as grouped_by_file

group by xml_data_type_description, xml_data_name, xml_path;


create index temp_stax_aggregated_keys on stage_qpati.temp_stax_aggregated
(xml_data_type_description, xml_path, xml_data_name);

insert into stage_qpati.temp_stax_log (filename)
select distinct xml_filename
from stage_qpati.temp_stax_all;



-- update row (if exists)

update stage_qpati.stax_uniques_with_counts as s
set max_occurrences_per_file = t.max_occurrences_per_file, row_updated = now()
from stage_qpati.temp_stax_aggregated as t
where s.xml_data_type_description = t.xml_data_type_description
and s.xml_data_name = t.xml_data_name
and s.xml_path = t.xml_path
and t.max_occurrences_per_file > s.max_occurrences_per_file;

-- insert row is does not exist yet

insert into stage_qpati.stax_uniques_with_counts (xml_data_type_description, xml_path, xml_data_name, max_occurrences_per_file, row_updated)
select xml_data_type_description, xml_path, xml_data_name, max_occurrences_per_file, now()
from stage_qpati.temp_stax_aggregated as t
where not exists
(select *
from stage_qpati.stax_uniques_with_counts as s
where s.xml_data_type_description = t.xml_data_type_description
and s.xml_data_name = t.xml_data_name
and s.xml_path = t.xml_path);


-- log the files that have been processed

insert into stage_qpati.stax_log
select filename, now() from stage_qpati.temp_stax_log;







