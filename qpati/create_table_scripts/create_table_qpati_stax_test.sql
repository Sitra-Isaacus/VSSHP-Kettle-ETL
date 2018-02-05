create table temp.qpati_stax_test
(xml_filename varchar(8000),
xml_row_number integer,
xml_data_type_numeric integer,
xml_data_type_description varchar(8000),
xml_location_line integer,
xml_location_column integer,
xml_element_id integer,
xml_parent_element_id integer,
xml_element_level integer,
xml_path varchar(8000),
xml_parent_path varchar(8000),
xml_data_name varchar(8000),
xml_data_value varchar(8000));



select * from temp.qpati_stax_test;

delete from temp.qpati_stax_test;