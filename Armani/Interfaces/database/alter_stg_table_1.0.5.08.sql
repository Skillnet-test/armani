ALTER TABLE ARM_STG_ITEM
ADD (SIZE_ID VARCHAR2(6));

ALTER TABLE ARM_STG_ITEM
MODIFY (
	MODEL VARCHAR2(50),
	FABRIC VARCHAR2(50)
);