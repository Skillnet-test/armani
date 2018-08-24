CREATE OR REPLACE FUNCTION arm_to_number (
      in_number_string IN VARCHAR2
)
RETURN
number
AS
BEGIN
DECLARE
    nls_char VARCHAR2(100);
    nls_number_format varchar2(100);
BEGIN
    BEGIN
	    SELECT lookup_code
        INTO   nls_char
        FROM   arm_misc_lookup
        WHERE  lookup_type = 'NLS_NUMERIC_CHARACTERS';
        --
        EXCEPTION
            WHEN OTHERS THEN RETURN NULL;
	END;
    BEGIN
	    SELECT lookup_code
        INTO   nls_number_format
        FROM   arm_misc_lookup
        WHERE  lookup_type = 'NLS_NUMBER_FORMAT';
        --
        EXCEPTION
            WHEN OTHERS THEN RETURN NULL;
	END;
	return to_number(in_number_string, nls_number_format, 'nls_numeric_characters='||nls_char||'''');
END;
END;
/