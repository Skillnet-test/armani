ALTER TABLE ARM_CT_COMMENTS
MODIFY COMMENTS VARCHAR2(200);

ALTER TABLE ARMUS_EX.ARM_STG_CUST_OUT 
MODIFY COMMENTS VARCHAR2(200);

COMMIT;