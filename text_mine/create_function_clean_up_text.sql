-- Function: map.clean_up_text(text)

-- DROP FUNCTION map.clean_up_text(text);



CREATE OR REPLACE FUNCTION map.clean_up_text(v_input text)
  RETURNS text AS
$BODY$
DECLARE result TEXT DEFAULT NULL;
BEGIN
	result := v_input;
	result := replace(result, '&lt;', '<');
	result := replace(result, '&gt;', '>');
	result := replace(result, '<space/>', ' ');
	result := regexp_replace(result, '(<section>|<content>|<paragraph>)', 'RIVINVAIHTO', 'g');
	result := regexp_replace(result, '<.*?>', '', 'g');
	result := regexp_replace(result, 'RIVINVAIHTO', '<br>', 'g');
	result := regexp_replace(result, '\r?\n\t* *', '<br>', 'g');
	result := regexp_replace(result, '\t* *\r?\n', '<br>', 'g');
	result := regexp_replace(result, '\s+$', '', 'g');
	result := regexp_replace(result, '^\s+', '', 'g');
	result := regexp_replace(result, '^(<br>)+', '');
	result := regexp_replace(result, '(<br>)+$', '');
	result := regexp_replace(result, '(<br>){3,}', '<br><br>', 'g');
	result := map.unencode_html(result);
	RETURN result;
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION map.clean_up_text(text)
  OWNER TO ktp;


   
