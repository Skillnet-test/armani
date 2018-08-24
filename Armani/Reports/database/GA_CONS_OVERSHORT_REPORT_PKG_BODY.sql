CREATE OR REPLACE PACKAGE BODY GA_CONS_OVERSHORT_REPORT_PKG

AS


/*=================================================================================
|	get net sales by store and register for a date range
|==================================================================================*/
FUNCTION GET_NETSALES_BY_REGID( ARG_STORE_ID   IN VARCHAR2,
                                ARG_DATE_BEGIN IN DATE,
                                ARG_DATE_END   IN DATE ) RETURN GA_COMMON_PKG.REF_CURSOR
IS
SALES_CURSOR GA_COMMON_PKG.REF_CURSOR;
BEGIN
	OPEN SALES_CURSOR FOR
	SELECT
		GA_REPORTS_UTILS_PKG.GET_REGISTER_ID( X.AI_TRN )   REGISTER_ID,
		X.TY_GUI_TRN   GUI_TRANS_TYPE,
		T.LU_CLS_TND       TENDER_TYPE,
		DECODE( GA_REPORTS_UTILS_PKG.GET_CURRENCY_SYMBOL(T.MO_ITM_LN_TND),
		       'USD', GA_REPORTS_UTILS_PKG.GET_CURRENCY_VALUE(T.MO_ITM_LN_TND))  DOLLARS,
		DECODE( GA_REPORTS_UTILS_PKG.GET_CURRENCY_SYMBOL(T.MO_ITM_LN_TND),
		       'JPY', GA_REPORTS_UTILS_PKG.GET_CURRENCY_VALUE(T.MO_ITM_LN_TND))  YEN
		FROM  TR_LTM_TND T, TR_TRN X
		WHERE T.AI_TRN       = X.AI_TRN
		AND   X.ID_STR_RT    = ARG_STORE_ID
		AND   X.TY_TRN       = 'TRNPAY'
		AND   X.ID_VOID IS NULL
		AND   X.TY_GUI_TRN  IN ( 'SALE', 'RETN' )
		AND   X.TS_TRN_PRC  >= ARG_DATE_BEGIN
		AND   X.TS_TRN_PRC  <= ARG_DATE_END
		AND   T.LU_CLS_TND  IN ( 'CASH',
                               'CHECK',
                               'TRAVELLERS_CHECK',
                               'JPY_CASH',
                               'MAIL_CHECK' )
		ORDER BY   REGISTER_ID, X.TY_GUI_TRN, T.TY_TND;
	RETURN SALES_CURSOR;
END	GET_NETSALES_BY_REGID;

/*=================================================================================
|	get end-of-day data by store and register for a date range
|==================================================================================*/
FUNCTION GET_EOD_BY_REGID( ARG_STORE_ID   IN VARCHAR2,
                           ARG_DATE_BEGIN IN DATE,
                           ARG_DATE_END   IN DATE ) RETURN GA_COMMON_PKG.REF_CURSOR
IS
EOD_CURSOR GA_COMMON_PKG.REF_CURSOR;
BEGIN
	OPEN EOD_CURSOR FOR
	SELECT
		GA_REPORTS_UTILS_PKG.GET_REGISTER_ID(X.AI_TRN) REGISTER_ID,
		E.MGR_SAYS_CASH_LIST EOD_CASH_LIST,
		E.MGR_SAYS_CHEK_LIST EOD_CHECK_LIST,
		GA_REPORTS_UTILS_PKG.GET_CURRENCY_VALUE(E.MGR_SAYS_TR_CHKS) EOD_TRAV_CHECKS
		FROM   RK_EOD E, TR_TRN X
		WHERE  E.AI_TRN = X.AI_TRN
		AND    X.ID_VOID IS NULL
		AND    X.ID_STR_RT    = ARG_STORE_ID
		AND    X.TY_TRN       = 'TRNEOD'
		AND   X.TS_TRN_PRC   >= ARG_DATE_BEGIN
		AND   X.TS_TRN_PRC   <= ARG_DATE_END
		ORDER  BY   REGISTER_ID, X.TS_TRN_PRC;
	RETURN EOD_CURSOR;
END	GET_EOD_BY_REGID;

/*=================================================================================
|	get start-of-session(day) data by store and register for a date range
|==================================================================================*/
FUNCTION GET_SOS_BY_REGID( ARG_STORE_ID   IN VARCHAR2,
                           ARG_DATE_BEGIN IN DATE,
                           ARG_DATE_END   IN DATE ) RETURN GA_COMMON_PKG.REF_CURSOR
IS
SOS_CURSOR GA_COMMON_PKG.REF_CURSOR;
BEGIN
	OPEN SOS_CURSOR FOR
	SELECT
		GA_REPORTS_UTILS_PKG.GET_REGISTER_ID( X.AI_TRN )   REGISTER_ID,
		DECODE( GA_REPORTS_UTILS_PKG.GET_CURRENCY_SYMBOL( DRAWER_FUND ),
		       'USD', GA_REPORTS_UTILS_PKG.GET_CURRENCY_VALUE( DRAWER_FUND )) SOS_CASH_START
		FROM   RK_SOS S, TR_TRN X
		WHERE  S.AI_TRN = X.AI_TRN
		AND    X.ID_VOID IS NULL
		AND    GA_REPORTS_UTILS_PKG.GET_STORE_ID( X.AI_TRN ) = ARG_STORE_ID
		AND    X.TY_TRN      = 'TRNSOS'
		AND    X.TS_TRN_CRT >= ARG_DATE_BEGIN
		AND    X.TS_TRN_CRT <= ARG_DATE_END
		ORDER  BY REGISTER_ID, X.TS_TRN_CRT;
	RETURN SOS_CURSOR;
END	GET_SOS_BY_REGID;


END	GA_CONS_OVERSHORT_REPORT_PKG;
/