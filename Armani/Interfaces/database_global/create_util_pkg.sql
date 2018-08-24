CREATE OR REPLACE PACKAGE Arm_Util_Pkg IS

	FUNCTION convert_to_currency(data NUMBER, currency_cd VARCHAR2, fl_null CHAR)
	RETURN VARCHAR2;

	FUNCTION Generate_N_Record(COUNTER INTEGER)
	RETURN T_COUNTER_TABLE;

	FUNCTION Convert_To_Number(data VARCHAR2, currency_cd VARCHAR2)
	RETURN NUMBER;

    number_format_mask VARCHAR2(20) := '99999999999990.99';

END Arm_Util_Pkg;
/
CREATE OR REPLACE PACKAGE BODY Arm_Util_Pkg  IS
	FUNCTION convert_to_currency(data NUMBER, currency_cd VARCHAR2, FL_NULL CHAR)
	RETURN VARCHAR2
	AS
		   result VARCHAR2(20) := NULL;
	BEGIN
			 IF (TO_NUMBER(NVL(data, 0)) = 0) THEN
			 		IF (fl_null = '0') THEN
					   RETURN currency_cd||'0.0';
					ELSE
					   RETURN NULL;
					END IF;
			 END IF;
		 result := currency_cd||TRIM(TO_CHAR(ROUND(data, 6), number_format_mask));
		 RETURN result;
	EXCEPTION
			 WHEN OTHERS THEN
			 		IF (fl_null = '0') THEN
					   RETURN currency_cd||'0.0';
				  END IF;
			 	  RETURN NULL;
	END convert_to_currency;

	FUNCTION Convert_To_Number(data VARCHAR2, currency_cd VARCHAR2)
	RETURN NUMBER
	AS
		   result NUMBER := 0;
	BEGIN
		 result := TO_NUMBER(REPLACE(data, currency_cd, ''),number_format_mask);
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
