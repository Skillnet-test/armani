CREATE OR REPLACE PACKAGE BODY GA_CSG_SUMMARY_REPORT_PKG

AS


/*=================================================================================
|	get consignment summary data by customer
|==================================================================================*/
FUNCTION GET_CSG_SUMMARY_BY_CUST( ARG_STORE_ID   IN VARCHAR2,
                                  ARG_DATE_BEGIN IN DATE,
                                  ARG_DATE_END   IN DATE ) RETURN GA_COMMON_PKG.REF_CURSOR
IS
SUMM_CURSOR GA_COMMON_PKG.REF_CURSOR;
BEGIN
	OPEN SUMM_CURSOR FOR
	SELECT P.ID_PRTY_PRS          CUSTOMER_ID,
	       P.FN_PRS               FIRST_NAME,
		    P.LN_PRS               LAST_NAME,
		    R.CONSULTANT_ID        SALES_ASSOCIATE_ID,
		    A.ID_CONSIGNMENT       CONSIGNMENT_ID,
		    T.TS_TRN_CRT           CREATION_DATE,
		    T.AI_TRN               TRANSACTION_ID,
		    DECODE(  DATE_IN_RANGE(T.TS_TRN_CRT, (SYSDATE - 16), SYSDATE),        1, 1, 0 ) AGED_0_15,
		    DECODE(  DATE_IN_RANGE(T.TS_TRN_CRT, (SYSDATE - 16), (SYSDATE - 31)), 1, 1, 0 ) AGED_16_30,
		    DECODE(  DATE_IN_RANGE(T.TS_TRN_CRT, (SYSDATE - 31), (SYSDATE - 61)), 1, 1, 0 ) AGED_31_60,
		    DECODE(  DATE_IN_RANGE(T.TS_TRN_CRT, NULL, (SYSDATE - 61)),           1, 1, 0 ) AGED_61,
		    COUNT(L.AI_TRN)        ITEM_COUNT,
		    SUM(GA_REPORTS_UTILS_PKG.GET_CURRENCY_VALUE(L.ITM_RETAIL_PRICE)) TOTAL_AMOUNT
	FROM   PA_PRS P, PA_CT C, ARM_POS_CSG A, TR_TRN T, TR_RTL R, TR_LTM_RTL_TRN L
	WHERE  A.AI_TRN      = T.AI_TRN
	AND    A.AI_TRN      = R.AI_TRN
	AND    T.AI_TRN      = R.AI_TRN
	AND    T.AI_TRN      = L.AI_TRN
	AND    L.AI_TRN      = R.AI_TRN
	AND    L.AI_TRN      = A.AI_TRN
	AND    T.ID_VOID IS NULL
   AND    T.ID_STR_RT   = ARG_STORE_ID
   AND    T.TS_TRN_CRT >= ARG_DATE_BEGIN
   AND    T.TS_TRN_CRT < (ARG_DATE_END + 1)
	AND    R.ID_CT       = P.ID_PRTY_PRS
	AND    R.ID_CT       = C.ID_PRTY
	AND    P.ID_PRTY_PRS = C.ID_PRTY
	GROUP BY P.ID_PRTY_PRS,
	       P.FN_PRS,
		   P.LN_PRS,
		   R.CONSULTANT_ID,
		   A.ID_CONSIGNMENT,
		   T.TS_TRN_CRT,
		   T.AI_TRN
	ORDER BY P.LN_PRS, P.FN_PRS;
	RETURN SUMM_CURSOR;
END	GET_CSG_SUMMARY_BY_CUST;


/*=================================================================================
|	check to see if a date falls within a range; returns 1 if true, 0 otherwise
|==================================================================================*/
FUNCTION DATE_IN_RANGE( ARG_DATE       IN DATE,
                        ARG_DATE_BEGIN IN DATE,
                        ARG_DATE_END   IN DATE ) RETURN NUMBER
IS
RC NUMBER := 0;
BEGIN
   IF ARG_DATE_BEGIN IS NULL
   THEN
		IF ARG_DATE < ARG_DATE_END
		THEN
			RC := 1;
		END IF;
   ELSIF ARG_DATE_END IS NULL
   THEN
		IF ARG_DATE >= ARG_DATE_BEGIN
		THEN
			RC := 1;
		END IF;
	ELSIF (ARG_DATE >= ARG_DATE_BEGIN) AND (ARG_DATE < ARG_DATE_END)
	THEN
		RC := 1;
	END IF;
	RETURN RC;
END	DATE_IN_RANGE;


END	GA_CSG_SUMMARY_REPORT_PKG;
/