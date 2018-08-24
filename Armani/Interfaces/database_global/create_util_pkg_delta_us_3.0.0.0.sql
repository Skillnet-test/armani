CREATE OR REPLACE PACKAGE Arm_Util_Pkg IS

 FUNCTION convert_to_currency(data NUMBER, curr_cd VARCHAR2, fl_null CHAR)
 RETURN VARCHAR2;

 FUNCTION Generate_N_Record(COUNTER INTEGER)
 RETURN T_COUNTER_TABLE;

 FUNCTION Convert_To_Number(data VARCHAR2, curr_cd VARCHAR2)
 RETURN NUMBER;

    number_format_mask VARCHAR2(20) := '99999999999990.99';
END Arm_Util_Pkg;
/
CREATE OR REPLACE PACKAGE BODY Arm_Util_Pkg  IS
	FUNCTION convert_to_currency(data NUMBER, curr_cd VARCHAR2, FL_NULL CHAR)
	RETURN VARCHAR2
	AS
		   result VARCHAR2(20) := NULL;
		   nls_char VARCHAR2(100);
		   nls_number_format VARCHAR2(100);
	BEGIN
			 IF (TO_NUMBER(NVL(data, 0)) = 0) THEN
			 		IF (fl_null = '0') THEN
					   RETURN curr_cd||'0';
					ELSE
					   RETURN NULL;
					END IF;
			 END IF;
		BEGIN
			SELECT lookup_code
			INTO   nls_char
			FROM   arm_misc_lookup
			WHERE  lookup_type = 'NLS_NUMERIC_CHARACTERS'
			AND arm_misc_lookup.CURRENCY_CD=CURR_CD;
		--
		EXCEPTION
			WHEN OTHERS THEN RETURN NULL;
		END;
		BEGIN
			SELECT lookup_code
			INTO   nls_number_format
			FROM   arm_misc_lookup
			WHERE  lookup_type = 'NLS_CURRENCY_FORMAT'
			AND arm_misc_lookup.CURRENCY_CD=CURR_CD;
		--
		EXCEPTION
			WHEN OTHERS THEN RETURN NULL;
		END;

--		 result := currency_cd||TRIM(TO_CHAR(ROUND(data, 6), number_format_mask));
		 result := curr_cd||TO_CHAR(ROUND(data, 6), nls_number_format, 'nls_numeric_characters='||nls_char||'''');
		 RETURN result;
	EXCEPTION
			 WHEN OTHERS THEN
			 		IF (fl_null = '0') THEN
					   RETURN curr_cd||'0';
				  END IF;
			 	  RETURN NULL;
	END convert_to_currency;

	FUNCTION Convert_To_Number(data VARCHAR2, curr_cd VARCHAR2)
	RETURN NUMBER
	AS
	   result NUMBER := 0;
	   nls_char VARCHAR2(100);
	   nls_number_format VARCHAR2(100);
	BEGIN
	    BEGIN
		    SELECT lookup_code
		INTO   nls_char
		FROM   arm_misc_lookup
		WHERE  lookup_type = 'NLS_NUMERIC_CHARACTERS'
		AND arm_misc_lookup.CURRENCY_CD=CURR_CD;
		--
            EXCEPTION
		    WHEN OTHERS THEN RETURN NULL;
	    END;
	    BEGIN
	        SELECT lookup_code
		INTO   nls_number_format
		FROM   arm_misc_lookup
		WHERE  lookup_type = 'NLS_NUMBER_FORMAT'
		AND arm_misc_lookup.CURRENCY_CD=CURR_CD;
		--
	     EXCEPTION
		    WHEN OTHERS THEN RETURN NULL;
	     END;
--		 result := TO_NUMBER(REPLACE(data, currency_cd, ''),number_format_mask);
		 result := TO_NUMBER(REPLACE(data, curr_cd, ''), nls_number_format, 'nls_numeric_characters='||nls_char||'''');
		 RETURN result;
	EXCEPTION
			 WHEN OTHERS THEN
			 	  RETURN 0;
	END Convert_To_Number;


	FUNCTION Generate_N_Record(COUNTER INTEGER)
	RETURN T_COUNTER_TABLE AS
		   V_RET T_COUNTER_TABLE;
	BEGIN
		 V_RET := T_COUNTER_TABLE();
		FOR i IN 1..COUNTER LOOP
			v_ret.extend;
			V_RET(i) := i;
		END LOOP;
		RETURN V_RET;
	END Generate_N_Record;
END Arm_Util_Pkg;
/
