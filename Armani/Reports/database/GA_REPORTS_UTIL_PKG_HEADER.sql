CREATE OR REPLACE PACKAGE GA_REPORTS_UTILS_PKG

AS

REGISTER_ID_START_INDEX        NUMBER        := 5;

REGISTER_ID_LENGTH             NUMBER        := 3;

STORE_ID_START_INDEX           NUMBER        := 1;

STORE_ID_LENGTH                NUMBER        := 3;

TRANSACTION_NUMBER_LENGTH      NUMBER        := 4;

CURRENCY_SYMBOL_START_INDEX    NUMBER        := 1;

CURRENCY_SYMBOL_LENGTH         NUMBER        := 3;

CURRENCY_VALUE_START_INDEX     NUMBER        := CURRENCY_SYMBOL_START_INDEX + CURRENCY_SYMBOL_LENGTH ;

DEFAULT_CURRENCY_FORMAT        VARCHAR2(10)  := '9999999D99';

JPY_CASH_DEL_DEFAULT           VARCHAR2(1)   := '|';


FUNCTION GET_REGISTER_ID( AI_TRN IN VARCHAR2 ) RETURN VARCHAR2;

FUNCTION GET_STORE_ID( AI_TRN IN VARCHAR2 ) RETURN VARCHAR2;

FUNCTION GET_CURRENCY_SYMBOL( CURRENCY IN VARCHAR2 ) RETURN VARCHAR2;

FUNCTION GET_CURRENCY_VALUE_STRING( CURRENCY IN VARCHAR2 ) RETURN VARCHAR2;

FUNCTION GET_CURRENCY_VALUE( CURRENCY IN VARCHAR2 ) RETURN NUMBER;

FUNCTION GET_CURRENCY_VALUE( CURRENCY IN VARCHAR2, FMT IN VARCHAR2 ) RETURN NUMBER;

FUNCTION GET_CURRENCY_VALUE( ARG_STRING  IN VARCHAR2,
                             ARG_GET_USD IN NUMBER,
                             ARG_DEL     IN VARCHAR2 := JPY_CASH_DEL_DEFAULT ) RETURN NUMBER;

END GA_REPORTS_UTILS_PKG;
/