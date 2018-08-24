CREATE OR REPLACE PACKAGE GA_CONS_OVERSHORT_REPORT_PKG

AS

/*=================================================================================
|	get net sales by store and register for a date range
|==================================================================================*/
FUNCTION GET_NETSALES_BY_REGID( ARG_STORE_ID   IN VARCHAR2,
                                ARG_DATE_BEGIN IN DATE,
                                ARG_DATE_END   IN DATE ) RETURN GA_COMMON_PKG.REF_CURSOR;

/*=================================================================================
|	get end-of-day data by store and register for a date range
|==================================================================================*/
FUNCTION GET_EOD_BY_REGID( ARG_STORE_ID   IN VARCHAR2,
                           ARG_DATE_BEGIN IN DATE,
                           ARG_DATE_END   IN DATE ) RETURN GA_COMMON_PKG.REF_CURSOR;

/*=================================================================================
|	get start-of-session(day) data by store and register for a date range
|==================================================================================*/
FUNCTION GET_SOS_BY_REGID( ARG_STORE_ID   IN VARCHAR2,
                           ARG_DATE_BEGIN IN DATE,
                           ARG_DATE_END   IN DATE ) RETURN GA_COMMON_PKG.REF_CURSOR;

END GA_CONS_OVERSHORT_REPORT_PKG;
/