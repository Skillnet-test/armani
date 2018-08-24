WHENEVER SQLERROR CONTINUE
REM ..............................
REM Execute these as "ARMANI_ext" user
REM ..............................

DROP SYNONYM &&2..ARM_STG_CURRENCY_RT; 

DROP SYNONYM &&2..ARM_STG_EMPLOYEE; 

DROP SYNONYM &&2..ARM_STG_PRM;

DROP SYNONYM &&2..ARM_STG_REGISTER;

DROP SYNONYM &&2..ARM_STG_STORE;

DROP SYNONYM &&2..ARM_OUT_STG_TIMECARD;

DROP SYNONYM &&2..ARM_OUT_STG_TIMECARD_MODS;

DROP SYNONYM &&2..ARM_MISC_LOOKUP;

DROP SYNONYM &&2..ARM_PROCESS_LOG;

DROP SYNONYM &&2..STG_EVENT_ID_S;


CREATE SYNONYM &&2..ARM_STG_CURRENCY_RT FOR &&1..ARM_STG_CURRENCY_RT;

CREATE SYNONYM &&2..ARM_STG_EMPLOYEE FOR &&1..ARM_STG_EMPLOYEE;

CREATE SYNONYM &&2..ARM_STG_PRM FOR &&1..ARM_STG_PRM;

CREATE SYNONYM &&2..ARM_STG_REGISTER FOR &&1..ARM_STG_REGISTER;

CREATE SYNONYM &&2..ARM_STG_STORE FOR &&1..ARM_STG_STORE;

CREATE SYNONYM &&2..ARM_OUT_STG_TIMECARD FOR &&1..ARM_OUT_STG_TIMECARD;

CREATE SYNONYM &&2..ARM_OUT_STG_TIMECARD_MODS FOR &&1..ARM_OUT_STG_TIMECARD_MODS;

CREATE SYNONYM &&2..ARM_MISC_LOOKUP FOR &&1..ARM_MISC_LOOKUP;

CREATE SYNONYM &&2..ARM_PROCESS_LOG FOR &&1..ARM_PROCESS_LOG;

CREATE SYNONYM &&2..STG_EVENT_ID_S FOR &&1..STG_EVENT_ID_S;
	
