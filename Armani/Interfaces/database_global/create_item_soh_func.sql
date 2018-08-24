CREATE OR REPLACE FUNCTION ARM_GET_ITEM_SOH(ASOFDATE DATE, STORE VARCHAR2, ITEM VARCHAR2)
RETURN NUMBER
AS
	   result NUMBER := 0;
BEGIN
	 IF (ASOFDATE != NULL) THEN
		SELECT SUM(DISTINCT NVL(DECODE(LN_ITM.POS_LN_ITM_TY_ID, 1, -1, 2, 1, 3, -1, 4,- 1, 5, -1, 6, -1, 7, 1, 1) *
		DECODE(HDR.ID_VOID, NULL, 1, -1)*DECODE(LN_ITM_DTL.POS_LN_ITM_TY_ID, NULL, 1, -1)*QUANTITY,0)) QUANTITY
		INTO result
		FROM 
		TR_TRN HDR INNER JOIN 
		(
			   TR_LTM_RTL_TRN LN_ITM INNER JOIN RK_POS_LN_ITM_DTL LN_ITM_DTL ON LN_ITM.AI_TRN = LN_ITM_DTL.AI_TRN
											AND LN_ITM.AI_LN_ITM = LN_ITM_DTL.AI_LN_ITM
		)
		ON HDR.AI_TRN = LN_ITM.AI_TRN
		WHERE HDR.TS_TRN_PRC > ASOFDATE
		AND HDR.ID_STR_RT = STORE
		AND LN_ITM.ID_ITM=ITEM;
		RETURN result;
	ELSE
		RETURN 0;	
	END IF;	
EXCEPTION
		 WHEN NO_DATA_FOUND THEN
			RETURN 0;
		 WHEN OTHERS THEN
			RETURN 0;
END ARM_GET_ITEM_SOH;
/
