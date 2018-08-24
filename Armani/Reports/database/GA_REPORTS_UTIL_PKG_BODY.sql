CREATE OR REPLACE PACKAGE BODY GA_REPORTS_UTILS_PKG

AS

--
-- parse transaction ID for the register ID and return the register ID
-- the transaction ID contains 3 fields: storeID, registerID, and trans number
-- currently they are of lengths 4-3-4 encoded either with '*' separator (old
-- format, or packed without a separator (new format)
--
FUNCTION GET_REGISTER_ID( AI_TRN IN VARCHAR2 ) RETURN VARCHAR2
IS
   POS_ASTERISK            NUMBER := 0;
   REGISTER_ID_LENGTH      NUMBER := GA_REPORTS_UTILS_PKG.REGISTER_ID_LENGTH;
   REGISTER_ID_START_INDEX NUMBER := GA_REPORTS_UTILS_PKG.REGISTER_ID_START_INDEX;
   REGISTER_ID_END_INDEX   NUMBER := GA_REPORTS_UTILS_PKG.REGISTER_ID_START_INDEX +
                                     GA_REPORTS_UTILS_PKG.REGISTER_ID_LENGTH;
BEGIN
   IF AI_TRN IS NULL OR ( LENGTH(AI_TRN) = 0 )
	THEN
      RETURN '';
   END IF;
   -- check for astersik ('*') deliimiters. if asterisk delimiters are present, take
	-- all characteds betweeen delimters and ignore default register ID length
   POS_ASTERISK := INSTR( AI_TRN, '*' );
   IF POS_ASTERISK > 1
	THEN
      REGISTER_ID_START_INDEX := POS_ASTERISK + 1;
      REGISTER_ID_END_INDEX   := INSTR( AI_TRN, '*', REGISTER_ID_START_INDEX, 1 );
      REGISTER_ID_LENGTH      := REGISTER_ID_END_INDEX - REGISTER_ID_START_INDEX;
		DBMS_OUTPUT.PUT_LINE( 'START=' || REGISTER_ID_START_INDEX );
		DBMS_OUTPUT.PUT_LINE( 'END='   || REGISTER_ID_END_INDEX );
		DBMS_OUTPUT.PUT_LINE( 'LENGTH='|| REGISTER_ID_LENGTH );
   END IF;
   RETURN SUBSTR( AI_TRN, REGISTER_ID_START_INDEX, REGISTER_ID_LENGTH );
END GET_REGISTER_ID;



--
-- parse transaction ID for the store ID and return the store ID
-- the transaction ID contains 3 fields: storeID, registerID, and trans number
-- currently they are of lengths 4-3-4 encoded either with '*' separator (old
-- format, or packed without a separator (new format)
--
FUNCTION GET_STORE_ID( AI_TRN IN VARCHAR2 ) RETURN VARCHAR2
IS
   POS_ASTERISK         NUMBER := 0;
   STORE_ID_LENGTH      NUMBER := GA_REPORTS_UTILS_PKG.STORE_ID_LENGTH;
   STORE_ID_START_INDEX NUMBER := GA_REPORTS_UTILS_PKG.STORE_ID_START_INDEX;
   STORE_ID_END_INDEX   NUMBER := GA_REPORTS_UTILS_PKG.STORE_ID_START_INDEX +
                                     GA_REPORTS_UTILS_PKG.STORE_ID_LENGTH;
BEGIN
   IF AI_TRN IS NULL OR ( LENGTH(AI_TRN) = 0 )
	THEN
      RETURN '';
   END IF;
   -- check for astersik ('*') deliimiters. if asterisk delimiters are present, take
	-- all characteds betweeen delimters and ignore default register ID length
   POS_ASTERISK := INSTR( AI_TRN, '*' );
   IF POS_ASTERISK > 1
	THEN
      STORE_ID_END_INDEX   := POS_ASTERISK;
      STORE_ID_LENGTH      := STORE_ID_END_INDEX - STORE_ID_START_INDEX;
		DBMS_OUTPUT.PUT_LINE( 'START=' || STORE_ID_START_INDEX );
		DBMS_OUTPUT.PUT_LINE( 'END='   || STORE_ID_END_INDEX );
		DBMS_OUTPUT.PUT_LINE( 'LENGTH='|| STORE_ID_LENGTH );
   END IF;
   RETURN SUBSTR( AI_TRN, STORE_ID_START_INDEX, STORE_ID_LENGTH );
END GET_STORE_ID;


--
-- returns currency symbol prefix from an RPOS currency column
--
FUNCTION GET_CURRENCY_SYMBOL( CURRENCY IN VARCHAR2 ) RETURN VARCHAR2
IS
BEGIN
   IF ( CURRENCY IS NULL OR
      ( LENGTH(CURRENCY) <= GA_REPORTS_UTILS_PKG.CURRENCY_SYMBOL_LENGTH ) )
	THEN
      RETURN '';
   END IF;
   RETURN SUBSTR( CURRENCY,
                  GA_REPORTS_UTILS_PKG.CURRENCY_SYMBOL_START_INDEX,
                  GA_REPORTS_UTILS_PKG.CURRENCY_SYMBOL_LENGTH );
END GET_CURRENCY_SYMBOL;


--
-- returns currency value as a string from an RPOS currency column
--
FUNCTION GET_CURRENCY_VALUE_STRING( CURRENCY IN VARCHAR2 ) RETURN VARCHAR2
IS
BEGIN
   IF ( CURRENCY IS NULL OR
      ( LENGTH(CURRENCY) <= GA_REPORTS_UTILS_PKG.CURRENCY_SYMBOL_LENGTH ) )
	THEN
      RETURN '';
   END IF;
   RETURN SUBSTR( CURRENCY, GA_REPORTS_UTILS_PKG.CURRENCY_VALUE_START_INDEX );
END GET_CURRENCY_VALUE_STRING;

--
-- returns currency value as a number from an RPOS currency column
--
FUNCTION GET_CURRENCY_VALUE( CURRENCY IN VARCHAR2 ) RETURN NUMBER
IS
BEGIN
   RETURN GET_CURRENCY_VALUE( CURRENCY, GA_REPORTS_UTILS_PKG.DEFAULT_CURRENCY_FORMAT );
END GET_CURRENCY_VALUE;


--
-- returns currency value as a number from an RPOS currency column using the specified format
--
FUNCTION GET_CURRENCY_VALUE( CURRENCY IN VARCHAR2, FMT IN VARCHAR2 )
RETURN NUMBER
IS
   VALUE NUMBER := 0;
BEGIN
   IF ( CURRENCY IS NULL OR
      ( LENGTH(CURRENCY) <= GA_REPORTS_UTILS_PKG.CURRENCY_SYMBOL_LENGTH ) )
	THEN
      RETURN '';
   END IF;
   DECLARE VALUE_STR VARCHAR2(10);
   BEGIN
      VALUE_STR := GET_CURRENCY_VALUE_STRING( CURRENCY );
      VALUE := TO_NUMBER( VALUE_STR, FMT );
      EXCEPTION
         WHEN OTHERS
			THEN
            VALUE := 0;
   END;
   RETURN VALUE;
END GET_CURRENCY_VALUE;


/*==================================================================================================
|
|===================================================================================================*/
FUNCTION GET_CURRENCY_VALUE( ARG_STRING  IN VARCHAR2,
                                 ARG_GET_USD IN NUMBER,
                                 ARG_DEL     IN VARCHAR2 := JPY_CASH_DEL_DEFAULT )
RETURN NUMBER
IS
   POS_DEL     NUMBER := 0;
	START_INDEX NUMBER := 0;
	SLENGTH     NUMBER := 0;
	NVALUE      NUMBER := 0;
	STR_VALUE   VARCHAR2(20);
BEGIN
   POS_DEL := INSTR( ARG_STRING, ARG_DEL );
   IF POS_DEL > 1
	THEN
		IF ARG_GET_USD = 1
		THEN
			START_INDEX := 1;
			SLENGTH      := POS_DEL - 1;
		ELSE
			START_INDEX := POS_DEL + 1;
			SLENGTH      := LENGTH( ARG_STRING ) - START_INDEX;
		END IF;
		STR_VALUE := SUBSTR( ARG_STRING, START_INDEX, SLENGTH );
		NVALUE    := GET_CURRENCY_VALUE( STR_VALUE );
	ELSE
		NVALUE := GET_CURRENCY_VALUE( ARG_STRING );
	END IF;
	RETURN NVALUE;
END	GET_CURRENCY_VALUE;


END GA_REPORTS_UTILS_PKG;
/