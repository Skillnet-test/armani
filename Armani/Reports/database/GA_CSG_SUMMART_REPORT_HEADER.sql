CREATE OR REPLACE PACKAGE GA_CSG_SUMMARY_REPORT_PKG

AS


/*=================================================================================
|	get consignment summary data by customer
|==================================================================================*/
FUNCTION GET_CSG_SUMMARY_BY_CUST( ARG_STORE_ID   IN VARCHAR2,
                                  ARG_DATE_BEGIN IN DATE,
                                  ARG_DATE_END   IN DATE ) RETURN GA_COMMON_PKG.REF_CURSOR;


/*=================================================================================
|	check to see if a date falls within a range; returns 1 if true, 0 otherwise
|==================================================================================*/
FUNCTION DATE_IN_RANGE( ARG_DATE       IN DATE,
                        ARG_DATE_BEGIN IN DATE,
                        ARG_DATE_END   IN DATE ) RETURN NUMBER;


END	GA_CSG_SUMMARY_REPORT_PKG;
/