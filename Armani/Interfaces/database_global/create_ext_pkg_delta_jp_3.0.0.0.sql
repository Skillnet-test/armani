CREATE OR REPLACE FUNCTION Arm_To_Number (
      in_number_string IN VARCHAR2,
   curr_cd IN VARCHAR2
)
RETURN
NUMBER
AS
BEGIN
DECLARE
    nls_char VARCHAR2(100);
    nls_number_format VARCHAR2(100);
BEGIN
    BEGIN
     SELECT lookup_code
        INTO   nls_char
        FROM   ARM_MISC_LOOKUP
        WHERE  lookup_type = 'NLS_NUMERIC_CHARACTERS'
  AND currency_cd=NVL(curr_cd,'JPY');
        --
        EXCEPTION
            WHEN OTHERS THEN RETURN NULL;
 END;
    BEGIN
     SELECT lookup_code
        INTO   nls_number_format
        FROM   ARM_MISC_LOOKUP
        WHERE  lookup_type = 'NLS_NUMBER_FORMAT'
  AND currency_cd=NVL(curr_cd,'JPY');
        --
        EXCEPTION
            WHEN OTHERS THEN RETURN NULL;
 END;
 RETURN TO_NUMBER(in_number_string, nls_number_format, 'nls_numeric_characters='||nls_char||'''');
END;
END;
/
