CREATE OR REPLACE PACKAGE Arm_Load_Txn_Hist_Pkg IS
------------------------------------------------------------------------------------------------
-- This package is used to load data from the staging tables into the base tables.
------------------------------------------------------------------------------------------------
TYPE  RECORD_TYPE_TYPE IS TABLE OF ARM_STG_TXN_HIST.RECORD_TYPE%TYPE;
TYPE  TRANSACTION_ID_TYPE IS TABLE OF ARM_STG_TXN_HIST.TRANSACTION_ID%TYPE;
TYPE  TRANSACTION_TYPE_TYPE IS TABLE OF ARM_STG_TXN_HIST.TRANSACTION_TYPE%TYPE;
TYPE  TRANSACTION_DATE_TYPE IS TABLE OF ARM_STG_TXN_HIST.TRANSACTION_DATE%TYPE;
TYPE  STORE_ID_TYPE IS TABLE OF ARM_STG_TXN_HIST.STORE_ID%TYPE;
TYPE  REGISTER_NO_TYPE IS TABLE OF ARM_STG_TXN_HIST.REGISTER_NO%TYPE;
TYPE  OPERATOR_ID_TYPE IS TABLE OF ARM_STG_TXN_HIST.OPERATOR_ID%TYPE;
TYPE  SALES_ASSOCIATE_ID_TYPE IS TABLE OF ARM_STG_TXN_HIST.ASSOCIATE_ID%TYPE;
TYPE  TRANSACTION_NET_AMOUNT_TYPE IS TABLE OF ARM_STG_TXN_HIST.TXN_NET_AMOUNT%TYPE;
TYPE  LINE_ITEM_TYPE_TYPE IS TABLE OF ARM_STG_TXN_HIST.LINE_ITEM_TYPE%TYPE;
TYPE  ITEM_ID_TYPE IS TABLE OF ARM_STG_TXN_HIST.ITEM_ID%TYPE;
TYPE  MISC_ITEM_ID_TYPE IS TABLE OF ARM_STG_TXN_HIST.MISC_ITEM_ID%TYPE;
TYPE  QUANTITY_TYPE IS TABLE OF ARM_STG_TXN_HIST.QUANTITY%TYPE;
TYPE  CURRENCY_CODE_TYPE IS TABLE OF ARM_STG_TXN_HIST.CURRENCY_CD%TYPE;
TYPE  RETAIL_PRICE_TYPE IS TABLE OF ARM_STG_TXN_HIST.RETAIL_PRICE%TYPE;
TYPE  SELLING_PRICE_TYPE IS TABLE OF ARM_STG_TXN_HIST.SELLING_PRICE%TYPE;
TYPE  MANUAL_MARKDOWN_AMT_TYPE IS TABLE OF ARM_STG_TXN_HIST.MANUAL_MARKDOWN_AMT%TYPE;
TYPE  MANUAL_UNIT_PRICE_TYPE IS TABLE OF ARM_STG_TXN_HIST.MANUAL_UNIT_PRICE%TYPE;
TYPE  REDUCTION_AMT_TYPE IS TABLE OF ARM_STG_TXN_HIST.REDUCTION_AMT%TYPE;
TYPE  REDUCTION_REASON_TYPE IS TABLE OF ARM_STG_TXN_HIST.REDUCTION_REASON%TYPE;
TYPE  LN_ITM_NET_AMT_TYPE IS TABLE OF ARM_STG_TXN_HIST.LN_ITM_NET_AMT%TYPE;
TYPE  LN_ITM_TAX_AMT_TYPE IS TABLE OF ARM_STG_TXN_HIST.LN_ITM_TAX_AMT%TYPE;
TYPE  TAX_EXEMPT_ID_TYPE IS TABLE OF ARM_STG_TXN_HIST.TAX_EXEMPT_ID%TYPE;
TYPE  MANUAL_TAX_AMT_TYPE IS TABLE OF ARM_STG_TXN_HIST.MANUAL_TAX_AMT%TYPE;
TYPE  RETURN_REASON_ID_TYPE IS TABLE OF ARM_STG_TXN_HIST.RETURN_REASON_ID%TYPE;
TYPE  RETURN_COMMENTS_TYPE IS TABLE OF ARM_STG_TXN_HIST.RETURN_COMMENTS%TYPE;
TYPE  ORIG_TRANSACTION_ID_TYPE IS TABLE OF ARM_STG_TXN_HIST.ORIG_TRANSACTION_ID%TYPE;
TYPE  ORIG_STORE_ID_TYPE IS TABLE OF ARM_STG_TXN_HIST.ORIG_STORE_ID%TYPE;
TYPE  ORIG_PROCESS_DT_TYPE IS TABLE OF ARM_STG_TXN_HIST.ORIG_PROCESS_DT%TYPE;
TYPE  ORIG_OPERATOR_ID_TYPE IS TABLE OF ARM_STG_TXN_HIST.ORIG_OPERATOR_ID%TYPE;
TYPE  ORIG_REGISTER_ID_TYPE IS TABLE OF ARM_STG_TXN_HIST.ORIG_REGISTER_ID%TYPE;
TYPE  CUSTOMER_ROLE_TYPE IS TABLE OF ARM_STG_TXN_HIST.CUST_ROLE%TYPE;
TYPE  CUSTOMER_ID_TYPE IS TABLE OF ARM_STG_TXN_HIST.EXT_CUST_ID%TYPE;
TYPE  CUST_FIRST_NAME_TYPE IS TABLE OF ARM_STG_TXN_HIST.CUST_FIRST_NAME%TYPE;
TYPE  CUST_LAST_NAME_TYPE IS TABLE OF ARM_STG_TXN_HIST.CUST_LAST_NAME%TYPE;
TYPE  CUST_ADDRRESS_LINE_1_TYPE IS TABLE OF ARM_STG_TXN_HIST.CUST_ADDR_LINE_1%TYPE;
TYPE  CUST_ADDRRESS_LINE_2_TYPE IS TABLE OF ARM_STG_TXN_HIST.CUST_ADDR_LINE_2%TYPE;
TYPE  CUST_CITY_TYPE IS TABLE OF ARM_STG_TXN_HIST.CUST_CITY%TYPE;
TYPE  CUST_STATE_TYPE IS TABLE OF ARM_STG_TXN_HIST.CUST_STATE%TYPE;
TYPE  CUST_COUNTRY_TYPE IS TABLE OF ARM_STG_TXN_HIST.CUST_COUNTRY%TYPE;
TYPE  CUST_PCODE_TYPE IS TABLE OF ARM_STG_TXN_HIST.CUST_PCODE%TYPE;
TYPE  CUST_PHONE_1_TYPE IS TABLE OF ARM_STG_TXN_HIST.CUST_PHONE_1%TYPE;
TYPE  CUST_PHONE_2_TYPE IS TABLE OF ARM_STG_TXN_HIST.CUST_PHONE_2%TYPE;
TYPE  TND_TYPE_TYPE IS TABLE OF ARM_STG_TXN_HIST.TND_TYPE%TYPE;
TYPE  TND_AMOUNT_TYPE IS TABLE OF ARM_STG_TXN_HIST.TND_AMOUNT%TYPE;
TYPE  TND_ID_ACNT_NMB_TYPE IS TABLE OF ARM_STG_TXN_HIST.TND_ID_ACNT_NMB%TYPE;
TYPE  TND_RESP_AUTH_TYPE IS TABLE OF ARM_STG_TXN_HIST.TND_RESP_AUTH%TYPE;
TYPE  TND_APPROVAL_DATE_TYPE IS TABLE OF ARM_STG_TXN_HIST.TND_APPROVAL_DATE%TYPE;
TYPE  TND_EXPIRATION_DT_TYPE IS TABLE OF ARM_STG_TXN_HIST.TND_EXPIRATION_DT%TYPE;
TYPE  TND_HOLDER_NAME_TYPE IS TABLE OF ARM_STG_TXN_HIST.TND_HOLDER_NAME%TYPE;
TYPE  CC_CVV_CODE_TYPE IS TABLE OF ARM_STG_TXN_HIST.CC_CVV_CODE%TYPE;
TYPE  CC_AMEX_CID_NUM_TYPE IS TABLE OF ARM_STG_TXN_HIST.CC_AMEX_CID_NUM%TYPE;
TYPE  TND_SWIPE_IND_TYPE IS TABLE OF ARM_STG_TXN_HIST.TND_SWIPE_IND%TYPE;
TYPE  TND_RESP_ADDRESS_VERIF_TYPE IS TABLE OF ARM_STG_TXN_HIST.TND_RESP_ADDRESS_VERIF%TYPE;
TYPE  TND_RESP_JOURNAL_KEY_TYPE IS TABLE OF ARM_STG_TXN_HIST.TND_RESP_JOURNAL_KEY%TYPE;
TYPE  TND_RESP_MSG_TYPE IS TABLE OF ARM_STG_TXN_HIST.TND_RESP_MSG%TYPE;
TYPE  TND_RESP_MSG_NUM_TYPE IS TABLE OF ARM_STG_TXN_HIST.TND_RESP_MSG_NUM%TYPE;
TYPE  TND_MERCHANT_ID_TYPE IS TABLE OF ARM_STG_TXN_HIST.TND_MERCHANT_ID%TYPE;
TYPE  TND_CARD_IDNFR_TYPE IS TABLE OF ARM_STG_TXN_HIST.TND_CARD_IDNFR%TYPE;
TYPE  CC_CARD_PLAN_TYPE IS TABLE OF ARM_STG_TXN_HIST.CC_CARD_PLAN%TYPE;
TYPE  TND_MANUAL_OVERRIDE_TYPE IS TABLE OF ARM_STG_TXN_HIST.TND_MANUAL_OVERRIDE%TYPE;
TYPE  CHK_ABA_NUM_TYPE IS TABLE OF ARM_STG_TXN_HIST.CHK_ABA_NUM%TYPE;
TYPE  CHK_ROUTING_NUM_TYPE IS TABLE OF ARM_STG_TXN_HIST.CHK_ROUTING_NUM%TYPE;
TYPE  CHK_BANK_TYPE IS TABLE OF ARM_STG_TXN_HIST.CHK_BANK%TYPE;
TYPE  CHK_IS_SCANNED_TYPE IS TABLE OF ARM_STG_TXN_HIST.CHK_IS_SCANNED%TYPE;
TYPE  RDM_TYPE_TYPE IS TABLE OF ARM_STG_TXN_HIST.RDM_TYPE%TYPE;
TYPE  RDM_CONTROL_NUMBER_TYPE IS TABLE OF ARM_STG_TXN_HIST.RDM_CONTROL_NUMBER%TYPE;
TYPE  RDM_TND_ID_STR_RT_TYPE IS TABLE OF ARM_STG_TXN_HIST.RDM_TND_ID_STR_RT%TYPE;
TYPE  RDM_DC_CPN_SCAN_CODE_TYPE IS TABLE OF ARM_STG_TXN_HIST.RDM_DC_CPN_SCAN_CODE%TYPE;
TYPE  RDM_TND_PRM_CODE_TYPE IS TABLE OF ARM_STG_TXN_HIST.RDM_TND_PRM_CODE%TYPE;
TYPE  RDM_EXPIRATION_DATE_TYPE IS TABLE OF ARM_STG_TXN_HIST.RDM_EXPIRATION_DATE%TYPE;
TYPE  STG_EVENT_ID_TYPE IS TABLE OF ARM_STG_TXN_HIST.STG_EVENT_ID%TYPE;
TYPE  STG_STATUS_TYPE IS TABLE OF ARM_STG_TXN_HIST.STG_STATUS%TYPE;
TYPE  STG_ERROR_MESSAGE_TYPE IS TABLE OF ARM_STG_TXN_HIST.STG_ERROR_MESSAGE%TYPE;
TYPE  STG_LOAD_DATE_TYPE IS TABLE OF ARM_STG_TXN_HIST.STG_LOAD_DATE%TYPE;
TYPE  STG_PROCESS_DATE_TYPE IS TABLE OF ARM_STG_TXN_HIST.STG_LOAD_DATE%TYPE;

TYPE txn_rec_type IS RECORD (
	RECORD_TYPE RECORD_TYPE_TYPE,
	TRANSACTION_ID TRANSACTION_ID_TYPE,
	TRANSACTION_TYPE TRANSACTION_TYPE_TYPE,
	TRANSACTION_DATE TRANSACTION_DATE_TYPE,
	STORE_ID STORE_ID_TYPE,
	REGISTER_NO REGISTER_NO_TYPE,
	OPERATOR_ID OPERATOR_ID_TYPE,
	SALES_ASSOCIATE_ID SALES_ASSOCIATE_ID_TYPE,
	TRANSACTION_NET_AMOUNT TRANSACTION_NET_AMOUNT_TYPE,
	LINE_ITEM_TYPE LINE_ITEM_TYPE_TYPE,
	ITEM_ID ITEM_ID_TYPE,
	MISC_ITEM_ID MISC_ITEM_ID_TYPE,
	QUANTITY QUANTITY_TYPE,
	CURRENCY_CODE CURRENCY_CODE_TYPE,
	RETAIL_PRICE RETAIL_PRICE_TYPE,
	SELLING_PRICE SELLING_PRICE_TYPE,
	MANUAL_MARKDOWN_AMT MANUAL_MARKDOWN_AMT_TYPE,
	MANUAL_UNIT_PRICE MANUAL_UNIT_PRICE_TYPE,
	REDUCTION_AMT REDUCTION_AMT_TYPE,
	REDUCTION_REASON REDUCTION_REASON_TYPE,
	LN_ITM_NET_AMT LN_ITM_NET_AMT_TYPE,
	LN_ITM_TAX_AMT LN_ITM_TAX_AMT_TYPE,
	TAX_EXEMPT_ID TAX_EXEMPT_ID_TYPE,
	MANUAL_TAX_AMT MANUAL_TAX_AMT_TYPE,
	RETURN_REASON_ID RETURN_REASON_ID_TYPE,
	RETURN_COMMENTS RETURN_COMMENTS_TYPE,
	ORIG_TRANSACTION_ID ORIG_TRANSACTION_ID_TYPE,
	ORIG_STORE_ID ORIG_STORE_ID_TYPE,
	ORIG_PROCESS_DT ORIG_PROCESS_DT_TYPE,
	ORIG_OPERATOR_ID ORIG_OPERATOR_ID_TYPE,
	ORIG_REGISTER_ID ORIG_REGISTER_ID_TYPE,
	CUSTOMER_ROLE CUSTOMER_ROLE_TYPE,
	CUSTOMER_ID CUSTOMER_ID_TYPE,
	CUST_FIRST_NAME CUST_FIRST_NAME_TYPE,
	CUST_LAST_NAME CUST_LAST_NAME_TYPE,
	CUST_ADDRRESS_LINE_1 CUST_ADDRRESS_LINE_1_TYPE,
	CUST_ADDRRESS_LINE_2 CUST_ADDRRESS_LINE_2_TYPE,
	CUST_CITY CUST_CITY_TYPE,
	CUST_STATE CUST_STATE_TYPE,
	CUST_COUNTRY CUST_COUNTRY_TYPE,
	CUST_PCODE CUST_PCODE_TYPE,
	CUST_PHONE_1 CUST_PHONE_1_TYPE,
	CUST_PHONE_2 CUST_PHONE_2_TYPE,
	TND_TYPE TND_TYPE_TYPE,
	TND_AMOUNT TND_AMOUNT_TYPE,
	TND_ID_ACNT_NMB TND_ID_ACNT_NMB_TYPE,
	TND_RESP_AUTH TND_RESP_AUTH_TYPE,
	TND_APPROVAL_DATE TND_APPROVAL_DATE_TYPE,
	TND_EXPIRATION_DT TND_EXPIRATION_DT_TYPE,
	TND_HOLDER_NAME TND_HOLDER_NAME_TYPE,
	CC_CVV_CODE CC_CVV_CODE_TYPE,
	CC_AMEX_CID_NUM CC_AMEX_CID_NUM_TYPE,
	TND_SWIPE_IND TND_SWIPE_IND_TYPE,
	TND_RESP_ADDRESS_VERIF TND_RESP_ADDRESS_VERIF_TYPE,
	TND_RESP_JOURNAL_KEY TND_RESP_JOURNAL_KEY_TYPE,
	TND_RESP_MSG TND_RESP_MSG_TYPE,
	TND_RESP_MSG_NUM TND_RESP_MSG_NUM_TYPE,
	TND_MERCHANT_ID TND_MERCHANT_ID_TYPE,
	TND_CARD_IDNFR TND_CARD_IDNFR_TYPE,
	CC_CARD_PLAN CC_CARD_PLAN_TYPE,
	TND_MANUAL_OVERRIDE TND_MANUAL_OVERRIDE_TYPE,
	CHK_ABA_NUM CHK_ABA_NUM_TYPE,
	CHK_ROUTING_NUM CHK_ROUTING_NUM_TYPE,
	CHK_BANK CHK_BANK_TYPE,
	CHK_IS_SCANNED CHK_IS_SCANNED_TYPE,
	RDM_TYPE RDM_TYPE_TYPE,
	RDM_CONTROL_NUMBER RDM_CONTROL_NUMBER_TYPE,
	RDM_TND_ID_STR_RT RDM_TND_ID_STR_RT_TYPE,
	RDM_DC_CPN_SCAN_CODE RDM_DC_CPN_SCAN_CODE_TYPE,
	RDM_TND_PRM_CODE RDM_TND_PRM_CODE_TYPE,
	RDM_EXPIRATION_DATE RDM_EXPIRATION_DATE_TYPE,
	stg_event_id stg_event_id_type,
	stg_status stg_status_type,
	stg_error_message stg_error_message_type,
	stg_load_date stg_load_date_type,
	stg_process_date stg_load_date_type
);

	TYPE t_line_id IS TABLE OF INTEGER INDEX BY VARCHAR2(50);
	TYPE t_ship_seq_num IS TABLE OF NUMBER INDEX BY VARCHAR2(50);		
	TYPE t_pay_line_id IS TABLE OF INTEGER INDEX BY VARCHAR2(50);
	
	line_id t_line_id;
	pay_line_id t_pay_line_id;
	ship_seq_num t_ship_seq_num;
	

	DEBUG PLS_INTEGER := 1;
	errors NUMBER;
	dml_errors EXCEPTION;
	PRAGMA EXCEPTION_INIT(dml_errors, -24381);
  -- Following procedure is called to initiate loading
  -- of all record types
FUNCTION load_txn_data
(
	in_interface_key IN VARCHAR2, 
	in_start_time  IN VARCHAR2, 
	in_file_name 	 IN  VARCHAR2  
) RETURN INTEGER;
PROCEDURE process_txn_rec
(
	l_record_type IN VARCHAR2, 
	l_total_records_processed OUT NUMBER, 
	return_code OUT VARCHAR2
);

-- Following procedure is called by "LOAD_TXN_DATA"
-- to load record_type "H"
FUNCTION process_txn_rec_type_h
(
	txn_rec txn_rec_type
) RETURN INTEGER;
-- Following procedure is called by "LOAD_TXN_DATA"
-- to load record_type "L"
FUNCTION process_txn_rec_type_l
(
	txn_rec txn_rec_type
) RETURN INTEGER;
-- Following procedure is called by "LOAD_TXN_DATA"
-- to load record_type "A"
FUNCTION process_txn_rec_type_a
(
	txn_rec txn_rec_type
) RETURN INTEGER;
-- Following procedure is called by "LOAD_TXN_DATA"
-- to load record_type "C"
FUNCTION process_txn_rec_type_c
(
	txn_rec txn_rec_type
) RETURN INTEGER;

END Arm_Load_Txn_Hist_Pkg;
/
CREATE OR REPLACE PACKAGE BODY Arm_Load_Txn_Hist_Pkg IS
	------------------------------------------------------------------------------------------------
	-- Package body --
	------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------
	FUNCTION load_txn_data
	------------------------------------------------------------------------------------------------
	(
		in_interface_key IN VARCHAR2, 
		in_start_time  IN VARCHAR2, 
		in_file_name 	 IN  VARCHAR2 
	) 
	RETURN INTEGER
	IS
		return_code   		PLS_INTEGER	:= 0;
		status			VARCHAR2(1)	:= '0';
		l_processed_records	NUMBER		:= 0;
		total_processed_records	NUMBER		:= 0;
		TYPE T_Rec_Type_List IS VARRAY(6) OF VARCHAR2(2);
		rec_list T_Rec_Type_List := T_Rec_Type_List('C','H','L','A');
	------------------------------------------------------------------------------------------------
	-- execution --
	------------------------------------------------------------------------------------------------
	BEGIN
		FOR i IN 1.. rec_list.COUNT LOOP
			process_txn_rec(rec_list(i), l_processed_records, return_code);
			total_processed_records := total_processed_records + l_processed_records;
			l_processed_records := 0;
			IF (return_code = 1) THEN
				status := '1';
			END IF;
			COMMIT;
		END LOOP;
		BEGIN
			INSERT INTO ARM_PROCESS_LOG
			(
				interface_key
				, start_time
				, end_time
				, status
				, record_num
				, file_name
			)
			VALUES
			(
				in_interface_key
				, TO_DATE(in_start_time, 'YYYYMMDDHH24:MI:SS')
				, SYSDATE
				, status
				, NVL(total_processed_records,0)
				, in_file_name
			);
		END;
		RETURN return_code;
	END load_txn_data;
	------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------
	PROCEDURE process_txn_rec
	------------------------------------------------------------------------------------------------
	(
		l_record_type IN VARCHAR2, 
		l_total_records_processed OUT NUMBER, 
		return_code OUT VARCHAR2
	)
	IS
	------------------------------------------------------------------------------------------------
	-- Load Customer by Record Type declarations --
	------------------------------------------------------------------------------------------------
	CURSOR txn_cur
	IS
	SELECT RECORD_TYPE,
							TRANSACTION_ID,
							TRANSACTION_TYPE,
							TRANSACTION_DATE,
							STORE_ID,
							REGISTER_NO,
							OPERATOR_ID,
							ASSOCIATE_ID,
							NVL(TXN_NET_AMOUNT,0),
							LINE_ITEM_TYPE,
							ITEM_ID,
							MISC_ITEM_ID,
							NVL(QUANTITY, 0),
							CURRENCY_CD,
							NVL(RETAIL_PRICE, 0),
							NVL(SELLING_PRICE,0),
							NVL(MANUAL_MARKDOWN_AMT,0),
							NVL(MANUAL_UNIT_PRICE,0),
							NVL(REDUCTION_AMT,0),
							REDUCTION_REASON,
							NVL(LN_ITM_NET_AMT,0),
							NVL(LN_ITM_TAX_AMT,0),
							TAX_EXEMPT_ID,
							NVL(MANUAL_TAX_AMT,0),
							RETURN_REASON_ID,
							RETURN_COMMENTS,
							ORIG_TRANSACTION_ID,
							ORIG_STORE_ID,
							ORIG_PROCESS_DT,
							ORIG_OPERATOR_ID,
							ORIG_REGISTER_ID,
							CUST_ROLE,
							EXT_CUST_ID,
							CUST_FIRST_NAME,
							CUST_LAST_NAME,
							CUST_ADDR_LINE_1,
							CUST_ADDR_LINE_2,
							CUST_CITY,
							CUST_STATE,
							CUST_COUNTRY,
							CUST_PCODE,
							CUST_PHONE_1,
							CUST_PHONE_2,
							TND_TYPE,
							NVL(TND_AMOUNT,0),
							TND_ID_ACNT_NMB,
							TND_RESP_AUTH,
							TND_APPROVAL_DATE,
							TND_EXPIRATION_DT,
							TND_HOLDER_NAME,
							CC_CVV_CODE,
							CC_AMEX_CID_NUM,
							TND_SWIPE_IND,
							TND_RESP_ADDRESS_VERIF,
							TND_RESP_JOURNAL_KEY,
							TND_RESP_MSG,
							TND_RESP_MSG_NUM,
							TND_MERCHANT_ID,
							TND_CARD_IDNFR,
							CC_CARD_PLAN,
							TND_MANUAL_OVERRIDE,
							CHK_ABA_NUM,
							CHK_ROUTING_NUM,
							CHK_BANK,
							CHK_IS_SCANNED,
							RDM_TYPE,
							RDM_CONTROL_NUMBER,
							RDM_TND_ID_STR_RT,
							RDM_DC_CPN_SCAN_CODE,
							RDM_TND_PRM_CODE,
							RDM_EXPIRATION_DATE,
							stg_event_id,
							stg_status,
							stg_error_message,
							stg_load_date,
							stg_process_date
	FROM   ARM_STG_TXN_HIST
	WHERE  ((NVL(stg_status, 0) = 0 AND stg_process_date IS NULL) OR
	(stg_status=2 AND stg_process_date IS NOT NULL))
	AND TRIM(record_type) =TRIM( l_record_type);
	i  PLS_INTEGER;
	j  PLS_INTEGER;
	l_error_index PLS_INTEGER;
	l_error_code VARCHAR2(255);
	l_error_stg_event_id PLS_INTEGER;
	l_record_count PLS_INTEGER;
	errors 				 PLS_INTEGER;
	--dml_errors 			 EXCEPTION;
	ret_code 			 PLS_INTEGER := 0;
	txn_rec 			 txn_rec_type;
	------------------------------------------------------------------------------------------------
	-- execution --
	------------------------------------------------------------------------------------------------
	BEGIN
		OPEN  txn_cur;
		LOOP
			FETCH txn_cur BULK COLLECT
			INTO   	 txn_rec.RECORD_TYPE,
							txn_rec.TRANSACTION_ID,
							txn_rec.TRANSACTION_TYPE,
							txn_rec.TRANSACTION_DATE,
							txn_rec.STORE_ID,
							txn_rec.REGISTER_NO,
							txn_rec.OPERATOR_ID,
							txn_rec.SALES_ASSOCIATE_ID,
							txn_rec.TRANSACTION_NET_AMOUNT,
							txn_rec.LINE_ITEM_TYPE,
							txn_rec.ITEM_ID,
							txn_rec.MISC_ITEM_ID,
							txn_rec.QUANTITY,
							txn_rec.CURRENCY_CODE,
							txn_rec.RETAIL_PRICE,
							txn_rec.SELLING_PRICE,
							txn_rec.MANUAL_MARKDOWN_AMT,
							txn_rec.MANUAL_UNIT_PRICE,
							txn_rec.REDUCTION_AMT,
							txn_rec.REDUCTION_REASON,
							txn_rec.LN_ITM_NET_AMT,
							txn_rec.LN_ITM_TAX_AMT,
							txn_rec.TAX_EXEMPT_ID,
							txn_rec.MANUAL_TAX_AMT,
							txn_rec.RETURN_REASON_ID,
							txn_rec.RETURN_COMMENTS,
							txn_rec.ORIG_TRANSACTION_ID,
							txn_rec.ORIG_STORE_ID,
							txn_rec.ORIG_PROCESS_DT,
							txn_rec.ORIG_OPERATOR_ID,
							txn_rec.ORIG_REGISTER_ID,
							txn_rec.CUSTOMER_ROLE,
							txn_rec.CUSTOMER_ID,
							txn_rec.CUST_FIRST_NAME,
							txn_rec.CUST_LAST_NAME,
							txn_rec.CUST_ADDRRESS_LINE_1,
							txn_rec.CUST_ADDRRESS_LINE_2,
							txn_rec.CUST_CITY,
							txn_rec.CUST_STATE,
							txn_rec.CUST_COUNTRY,
							txn_rec.CUST_PCODE,
							txn_rec.CUST_PHONE_1,
							txn_rec.CUST_PHONE_2,
							txn_rec.TND_TYPE,
							txn_rec.TND_AMOUNT,
							txn_rec.TND_ID_ACNT_NMB,
							txn_rec.TND_RESP_AUTH,
							txn_rec.TND_APPROVAL_DATE,
							txn_rec.TND_EXPIRATION_DT,
							txn_rec.TND_HOLDER_NAME,
							txn_rec.CC_CVV_CODE,
							txn_rec.CC_AMEX_CID_NUM,
							txn_rec.TND_SWIPE_IND,
							txn_rec.TND_RESP_ADDRESS_VERIF,
							txn_rec.TND_RESP_JOURNAL_KEY,
							txn_rec.TND_RESP_MSG,
							txn_rec.TND_RESP_MSG_NUM,
							txn_rec.TND_MERCHANT_ID,
							txn_rec.TND_CARD_IDNFR,
							txn_rec.CC_CARD_PLAN,
							txn_rec.TND_MANUAL_OVERRIDE,
							txn_rec.CHK_ABA_NUM,
							txn_rec.CHK_ROUTING_NUM,
							txn_rec.CHK_BANK,
							txn_rec.CHK_IS_SCANNED,
							txn_rec.RDM_TYPE,
							txn_rec.RDM_CONTROL_NUMBER,
							txn_rec.RDM_TND_ID_STR_RT,
							txn_rec.RDM_DC_CPN_SCAN_CODE,
							txn_rec.RDM_TND_PRM_CODE,
							txn_rec.RDM_EXPIRATION_DATE,
							txn_rec.stg_event_id,
							txn_rec.stg_status,
							txn_rec.stg_error_message,
							txn_rec.stg_load_date,
							txn_rec.stg_process_date
			LIMIT 1000;
			l_total_records_processed := l_total_records_processed + NVL(txn_rec.record_type.COUNT,0);
			DBMS_OUTPUT.PUT_LINE('TOTAL RECORDS PROCESSED = '||L_TOTAL_RECORDS_PROCESSED);
			IF (txn_rec.record_type.COUNT > 0) THEN
				CASE
					WHEN (l_record_type IN ('H')) THEN
						ret_code :=	process_txn_rec_type_H(txn_rec);
					WHEN (l_record_type IN ('L')) THEN
						ret_code := process_txn_rec_type_L(txn_rec);
					WHEN (l_record_type IN ('A')) THEN
						ret_code := process_txn_rec_type_A(txn_rec);
					WHEN (l_record_type IN ('C')) THEN
						ret_code := process_txn_rec_type_C(txn_rec);
				END CASE;
				IF (ret_code = 1) THEN
					return_code := 1;
				END IF;
			END IF;
			COMMIT;
			EXIT WHEN txn_cur%NOTFOUND;
		END LOOP;
		CLOSE txn_cur;
		COMMIT;
	END process_txn_rec;
	------------------------------------------------------------------------------------------------
  FUNCTION process_txn_rec_type_h
  (
		txn_rec txn_rec_type
  ) RETURN INTEGER
  IS
  	l_cnt  		  PLS_INTEGER := 0;
	error_msg 	  VARCHAR2(1000) := NULL;
	error_index   PLS_INTEGER := 0;
	error_code 	  VARCHAR2(10) := NULL;
	msg VARCHAR2(100);
	return_code   PLS_INTEGER := 0;
  BEGIN
  	   BEGIN
	 			FORALL i IN 1..txn_rec.record_type.COUNT()	SAVE EXCEPTIONS
					   INSERT ALL
					   INTO TR_TRN ( AI_TRN, ID_OPR, TY_TRN, TS_TM_SRT, TS_TRN_BGN,
					   								  TS_TRN_END, TS_TRN_PST, TS_TRN_SBM,  TS_TRN_CRT, TS_TRN_PRC, TY_GUI_TRN,
													   ID_RPSTY_TND, ID_STR_RT)
					   VALUES (TRANSACTION_ID, OPERATOR_ID, 'TRNPAY', TRANSACTION_DATE, TRANSACTION_DATE, TRANSACTION_DATE,
					   TRANSACTION_DATE, TRANSACTION_DATE, TRANSACTION_DATE, TRANSACTION_DATE, TRANSACTION_TYPE, REGISTER_NO,
					   STORE_ID)
					   INTO RK_PAY_TRN ( TOTAL_AMT,  CUST_ID,  AI_TRN,  TYPE_ID)
					   VALUES (TRANSACTION_NET_AMOUNT, CUSTOMER_ID, TRANSACTION_ID, 
					   		  				'TRNPOS')								   													   
					   INTO TR_RTL(ID_CT, AI_TRN,  CONSULTANT_ID, NET_AMOUNT,
													  REGISTER_ID)
						VALUES (CUSTOMER_ID, TRANSACTION_ID, SALES_ASSOCIATE_ID, TRANSACTION_NET_AMOUNT,
							   				 REGISTER_NO)							  													  
					   SELECT txn_rec.RECORD_TYPE(i) RECORD_TYPE,	txn_rec.TRANSACTION_ID(i) TRANSACTION_ID,	
					   		  			txn_rec.TRANSACTION_TYPE(i) TRANSACTION_TYPE, txn_rec.TRANSACTION_DATE(i) TRANSACTION_DATE,
		   		  						txn_rec.STORE_ID(i) STORE_ID, txn_rec.REGISTER_NO(i) REGISTER_NO,	
										txn_rec.OPERATOR_ID(i) OPERATOR_ID, txn_rec.SALES_ASSOCIATE_ID(i) SALES_ASSOCIATE_ID,
										Arm_Util_Pkg.convert_to_currency(txn_rec.TRANSACTION_NET_AMOUNT(i), txn_rec.CURRENCY_CODE(i)) TRANSACTION_NET_AMOUNT,	
										txn_rec.CURRENCY_CODE(i) CURRENCY_CODE,	txn_rec.CUSTOMER_ROLE(i) CUSTOMER_ROLE,	
										txn_rec.CUSTOMER_ID(i) CUSTOMER_ID
						FROM DUAL;																	  		
		-- Exception section
		EXCEPTION
				WHEN DML_ERRORS THEN
					errors := SQL%BULK_EXCEPTIONS.COUNT;
					l_cnt := l_cnt + errors;
					return_code := 1;
					FOR i IN 1..errors LOOP
						error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
						error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
						UPDATE ARM_STG_TXN_HIST
						SET      stg_status = 1
						, stg_error_message = stg_error_message  || '|' || '  Error INSERTING/UPDATING	TR_TRN/TR_RTL/RK_PAY_TRN - ' || error_code
						, stg_process_date = SYSDATE
						WHERE  stg_event_id = txn_rec.stg_event_id(error_index);
					END LOOP;
				WHEN OTHERS THEN
					errors := SQL%BULK_EXCEPTIONS.COUNT;
					l_cnt := l_cnt + errors;
					return_code := 1;
					FOR i IN 1..errors LOOP
						error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
						error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
						UPDATE ARM_STG_TXN_HIST
						SET      stg_status = 1
						, stg_error_message = stg_error_message  || '|' || '  Error INSERTING/UPDATING	TR_TRN/TR_RTL/RK_PAY_TRN - ' || error_code
						, stg_process_date = SYSDATE
						WHERE  stg_event_id = txn_rec.stg_event_id(error_index);
					END LOOP;
					
		END;
					RETURN return_code;		
  END process_txn_rec_type_h;
  FUNCTION process_txn_rec_type_l
  (
		txn_rec txn_rec_type
  ) RETURN INTEGER
  IS
  	l_line_id NUMBER := 0;
	l_ship_seq_num NUMBER := 0;
  	l_cnt  		  PLS_INTEGER := 0;
	error_msg 	  VARCHAR2(1000) := NULL;
	error_index   PLS_INTEGER := 0;
	error_code 	  VARCHAR2(10) := NULL;
	msg VARCHAR2(100);
	return_code   PLS_INTEGER := 0;	
	TYPE t_arr_LINE_ID IS TABLE OF INTEGER INDEX BY BINARY_INTEGER;	
    TYPE t_arr_ship_seq_num IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
	arr_line_id t_arr_line_id;		
	arr_ship_seq_num t_arr_ship_seq_num;		
  BEGIN
	FOR i IN 1 .. txn_rec.record_type.COUNT LOOP
		BEGIN	
			l_line_id := 0;
			l_line_id := line_id(txn_rec.transaction_id(i));
			l_line_id := l_line_id+1;
			line_id(txn_rec.transaction_id(i)) := l_line_id;
			arr_line_id(i) := l_line_id;				
		EXCEPTION
				WHEN NO_DATA_FOUND THEN
					line_id(txn_rec.transaction_id(i)) := 0;
					arr_line_id(i) := 0;
				WHEN OTHERS THEN
					line_id(txn_rec.transaction_id(i)) := 0;
					arr_line_id(i) := 0;
					
		END;
		BEGIN
			l_ship_seq_num := 0;				
			IF (txn_rec.customer_role(i) = '2') THEN
						l_ship_seq_num := ship_seq_num(txn_rec.transaction_id(i));
						l_ship_seq_num := l_ship_seq_num+1;			
						ship_seq_num(txn_rec.transaction_id(i)) := l_ship_seq_num;
						arr_ship_seq_num(i) := 	l_ship_seq_num;						
			END IF;
		EXCEPTION
				WHEN NO_DATA_FOUND THEN
					ship_seq_num(txn_rec.transaction_id(i)) := 0;
					arr_ship_seq_num(i) := 	0;
				WHEN OTHERS THEN
					ship_seq_num(txn_rec.transaction_id(i)) := 0;
					arr_ship_seq_num(i) := 	0;
		END;
		
		
	END LOOP;
 	   BEGIN
	 			FORALL i IN 1..txn_rec.record_type.COUNT()	SAVE EXCEPTIONS	   
					   INSERT ALL
					   WHEN (CUSTOMER_ROLE = '2') THEN
						   INTO RK_SHIP_REQ ( SEQ_NUM,  FIRST_NAME,  LAST_NAME,  ADDRESS,
						   					  						   APARTMENT,  CITY,  STATE,  ZIP_CODE,  COUNTRY,
																	   PHONE,   AI_TRN)
						   VALUES (SHIP_SEQ_NUM, CUST_FIRST_NAME, CUST_LAST_NAME, CUST_ADDRESS_LINE_1,
						   					   CUST_ADDRESS_LINE_2, CUST_CITY, CUST_STATE, CUST_PCODE,
											   CUST_COUNTRY, CUST_PHONE_1, TRANSACTION_ID)
						WHEN (1 = 1) THEN					   											   
					   		INTO TR_LTM_RTL_TRN ( AI_LN_ITM, AI_TRN,  ID_ITM,  POS_LN_ITM_TY_ID,
					   					   	  			 		   	  		    ADD_CONSULTANT_ID,  ITM_SEL_PRICE, ITM_RETAIL_PRICE,				
																				MISC_ITEM_ID,  SHIP_REQ_SEQ_NUM,  QUANTITY, MANUAL_UNIT_PRICE,
																				MANUAL_MD_AMT, VALID_NET_AMT_FL, RETURN_COMMENTS, RETURN_REASON_ID)
							VALUES (LINE_ID, TRANSACTION_ID,  ITEM_ID, DECODE(line_item_type, '1', '5', '2', '6','1'), SALES_ASSOCIATE_ID,
					   		  				SELLING_PRICE, RETAIL_PRICE, MISC_ITEM_ID,  DECODE(CUSTOMER_ROLE, '2', SHIP_SEQ_NUM, NULL), QUANTITY,
											MANUAL_UNIT_PRICE, MANUAL_MARKDOWN_AMT, 1, RETURN_COMMENT, RETURN_REASON_ID)
						WHEN (CUSTOMER_ID IS NOT NULL) THEN																
							 INTO ARM_CUST_SALE_SUMMARY(ID_CT,  ID_STR_RT,  TXN_TYPE,  TXN_DATE,
							 	  						  		  			  			 		  		  TXN_AMOUNT)
							VALUES (CUSTOMER_ID, STORE_ID, DECODE(LINE_ITEM_TYPE, '1', 'SALE', '2', 'RETN', 'UNKNOWN'), TRANSACTION_DATE,
								   				 LN_ITM_NET_AMT)
					   SELECT txn_rec.RECORD_TYPE(i) RECORD_TYPE,	txn_rec.TRANSACTION_ID(i) TRANSACTION_ID,	
					   		  			txn_rec.TRANSACTION_TYPE(i) TRANSACTION_TYPE, txn_rec.TRANSACTION_DATE(i) TRANSACTION_DATE,
		   		  						txn_rec.STORE_ID(i) STORE_ID, txn_rec.REGISTER_NO(i) REGISTER_NO,	
										txn_rec.OPERATOR_ID(i) OPERATOR_ID, txn_rec.SALES_ASSOCIATE_ID(i) SALES_ASSOCIATE_ID,
										Arm_Util_Pkg.convert_to_currency(txn_rec.TRANSACTION_NET_AMOUNT(i), txn_rec.CURRENCY_CODE(i)) TRANSACTION_NET_AMOUNT,	
										txn_rec.LINE_ITEM_TYPE(i) LINE_ITEM_TYPE,
										txn_rec.ITEM_ID(i) ITEM_ID, txn_rec.MISC_ITEM_ID(i) MISC_ITEM_ID, txn_rec.QUANTITY(i) QUANTITY,
										txn_rec.CURRENCY_CODE(i) CURRENCY_CODE,	
										Arm_Util_Pkg.convert_to_currency(txn_rec.RETAIL_PRICE(i), txn_rec.CURRENCY_CODE(i)) RETAIL_PRICE, 
										Arm_Util_Pkg.convert_to_currency(txn_rec.SELLING_PRICE(i), txn_rec.CURRENCY_CODE(i)) SELLING_PRICE,	
										Arm_Util_Pkg.convert_to_currency(txn_rec.MANUAL_MARKDOWN_AMT(i), txn_rec.CURRENCY_CODE(i)) MANUAL_MARKDOWN_AMT, 
										Arm_Util_Pkg.convert_to_currency(txn_rec.MANUAL_UNIT_PRICE(i), txn_rec.CURRENCY_CODE(i)) MANUAL_UNIT_PRICE, 
										Arm_Util_Pkg.convert_to_currency(txn_rec.LN_ITM_NET_AMT(i), txn_rec.CURRENCY_CODE(i)) LN_ITM_NET_AMT, 
										txn_rec.RETURN_REASON_ID(i) RETURN_REASON_ID,
										txn_rec.RETURN_COMMENTS(i) RETURN_COMMENT, txn_rec.ORIG_TRANSACTION_ID(i) ORIG_TRANSACTION_ID, 
										txn_rec.CUSTOMER_ROLE(i) CUSTOMER_ROLE,	txn_rec.CUSTOMER_ID(i) CUSTOMER_ID, 
										txn_rec.CUST_FIRST_NAME(i) CUST_FIRST_NAME,	txn_rec.CUST_LAST_NAME(i) CUST_LAST_NAME, 
										txn_rec.CUST_ADDRRESS_LINE_1(i) CUST_ADDRESS_LINE_1, txn_rec.CUST_ADDRRESS_LINE_2(i) CUST_ADDRESS_LINE_2,
										txn_rec.CUST_CITY(i) CUST_CITY,	txn_rec.CUST_STATE(i) CUST_STATE,	
										txn_rec.CUST_COUNTRY(i) CUST_COUNTRY, txn_rec.CUST_PCODE(i) CUST_PCODE,
										txn_rec.CUST_PHONE_1(i) CUST_PHONE_1, txn_rec.CUST_PHONE_2(i) CUST_PHONE_2,	
										arr_line_id(i) LINE_ID, arr_ship_seq_num(i) SHIP_SEQ_NUM  FROM DUAL;																	  		
	   		-- Exception section
		EXCEPTION
				WHEN DML_ERRORS THEN
					errors := SQL%BULK_EXCEPTIONS.COUNT;
					l_cnt := l_cnt + errors;
					return_code := 1;
					FOR i IN 1..errors LOOP
						error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
						error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
						UPDATE ARM_STG_TXN_HIST
						SET      stg_status = 1
						, stg_error_message = stg_error_message  || '|' || '  Error INSERTING	TR_LTM_RTL_TRN - ' || error_code
						, stg_process_date = SYSDATE
						WHERE  stg_event_id = txn_rec.stg_event_id(error_index);
					END LOOP;
				WHEN OTHERS THEN
					errors := SQL%BULK_EXCEPTIONS.COUNT;
					l_cnt := l_cnt + errors;
					return_code := 1;
					FOR i IN 1..errors LOOP
						error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
						error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
						UPDATE ARM_STG_TXN_HIST
						SET      stg_status = 1
						, stg_error_message = stg_error_message  || '|' || '  Error INSERTING	TR_LTM_RTL_TRN - ' || error_code
						, stg_process_date = SYSDATE
						WHERE  stg_event_id = txn_rec.stg_event_id(error_index);
					END LOOP;
	   END;
 	   BEGIN
	 			FORALL i IN 1..txn_rec.record_type.COUNT()	SAVE EXCEPTIONS
					   UPDATE TR_RTL
					   SET ITEMS_IDS=DECODE(ITEMS_IDS, NULL, '*', NULL)||txn_rec.ITEM_ID(i)||'*'
					   WHERE AI_TRN=txn_rec.TRANSACTION_ID(i);	   
	   		-- Exception section
		EXCEPTION
				WHEN DML_ERRORS THEN
					errors := SQL%BULK_EXCEPTIONS.COUNT;
					l_cnt := l_cnt + errors;
					return_code := 1;
					FOR i IN 1..errors LOOP
						error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
						error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
						UPDATE ARM_STG_TXN_HIST
						SET      stg_status = 1
						, stg_error_message = stg_error_message  || '|' || '  Error UPDATING	TR_LTM_RTL_TRN - ' || error_code
						, stg_process_date = SYSDATE
						WHERE  stg_event_id = txn_rec.stg_event_id(error_index);
					END LOOP;
	   END;
	   
  	   BEGIN
	 			FORALL i IN 1..txn_rec.record_type.COUNT()	SAVE EXCEPTIONS	   
					   INSERT ALL
					   		INTO RK_POS_LN_ITM_DTL (SEQUENCE_NUMBER,NET_AMT,TAX_AMT,MANUAL_TAX_AMT,
								 				    SALE_RETURNED,AI_TRN,AI_LN_ITM)							
							VALUES (ROWNUM,LN_ITM_DTL_NET_AMT,LN_ITM_DTL_TAX_AMT,MANUAL_TAX_AMT,
								   '0', TRANSACTION_ID, LINE_ID)
					   		INTO RK_REDUCTION(DETAIL_SEQ_NUMBER, AMOUNT, REASON,
								 	 	     AI_TRN,  AI_LN_ITM)
							VALUES (ROWNUM, REDUCTION_AMT, REDUCTION_REASON,TRANSACTION_ID, LINE_ID) 			 
					   SELECT txn_rec.transaction_id(i) TRANSACTION_ID, arr_line_id(i) LINE_ID, 
					   		  			Arm_Util_Pkg.convert_to_currency(txn_rec.REDUCTION_AMT(i)/txn_rec.QUANTITY(i), txn_rec.CURRENCY_CODE(i)) REDUCTION_AMT,
										DECODE(txn_rec.REDUCTION_REASON(i), 'M', 'Item Markdown', 'D', 'Discount', 'P', 'Deal Markdown', 'Item Markdown') REDUCTION_REASON, 
										Arm_Util_Pkg.convert_to_currency(txn_rec.LN_ITM_NET_AMT(i)/txn_rec.QUANTITY(i), txn_rec.CURRENCY_CODE(i)) LN_ITM_DTL_NET_AMT, 
										Arm_Util_Pkg.convert_to_currency(txn_rec.LN_ITM_TAX_AMT(i)/txn_rec.QUANTITY(i), txn_rec.CURRENCY_CODE(i)) LN_ITM_DTL_TAX_AMT, 
										txn_rec.TAX_EXEMPT_ID(i) TAX_EXEMPT_ID,	
										Arm_Util_Pkg.convert_to_currency(txn_rec.MANUAL_TAX_AMT(i)/txn_rec.QUANTITY(i), txn_rec.CURRENCY_CODE(i)) MANUAL_TAX_AMT   
					   FROM TABLE(cast(Arm_Util_Pkg.Generate_N_Record(txn_rec.quantity(i)) AS T_COUNTER_TABLE)) counter;																	  		
	   		-- Exception section
		EXCEPTION
				WHEN DML_ERRORS THEN
					errors := SQL%BULK_EXCEPTIONS.COUNT;
					l_cnt := l_cnt + errors;
					return_code := 1;
					FOR i IN 1..errors LOOP
						error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
						error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
						UPDATE ARM_STG_TXN_HIST
						SET      stg_status = 1
						, stg_error_message = stg_error_message  || '|' || '  Error INSERTING	RK_POS_LN_ITM_DTL/RK_REDUCTION - ' || error_code
						, stg_process_date = SYSDATE
						WHERE  stg_event_id = txn_rec.stg_event_id(error_index);
					END LOOP;
				WHEN OTHERS THEN
					errors := SQL%BULK_EXCEPTIONS.COUNT;
					l_cnt := l_cnt + errors;
					return_code := 1;
					FOR i IN 1..errors LOOP
						error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
						error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
						UPDATE ARM_STG_TXN_HIST
						SET      stg_status = 1
						, stg_error_message = stg_error_message  || '|' || '  Error INSERTING	RK_POS_LN_ITM_DTL/RK_REDUCTION - ' || error_code
						, stg_process_date = SYSDATE
						WHERE  stg_event_id = txn_rec.stg_event_id(error_index);
					END LOOP;

	   END;
    	RETURN return_code;	   
 END process_txn_rec_type_l;  
	 FUNCTION process_txn_rec_type_c
	 (
		txn_rec txn_rec_type
	 ) RETURN INTEGER
	 IS
	   	l_cnt  		  PLS_INTEGER := 0;	 
		error_msg 	  VARCHAR2(1000) := NULL;
		error_index   PLS_INTEGER := 0;
		error_code 	  VARCHAR2(10) := NULL;
		msg VARCHAR2(100);
		return_code   PLS_INTEGER := 0;	
		TYPE t_arr_ads_id IS TABLE OF VARCHAR2(128) INDEX BY BINARY_INTEGER;
		arr_ads_id t_arr_ads_id;
		l_ads_id VARCHAR2(128) := NULL;
	 BEGIN
		FOR i IN 1 .. txn_rec.record_type.COUNT LOOP
			SELECT CHELSEAID.NEXTVAL INTO l_ads_id FROM DUAL;
			arr_ads_id(i) := l_ads_id;
		END LOOP;
	 
	 	 BEGIN
		 	FORALL i IN 1..txn_rec.record_type.COUNT()	SAVE EXCEPTIONS	 
			 	  INSERT ALL
				  INTO PA_PRTY (ID_PRTY,  TY_PRTY)
				  VALUES (CUSTOMER_ID, 'CU')
				  INTO PA_RO_PRTY(ID_PRTY,TY_RO_PRTY)
				  VALUES(CUSTOMER_ID,'CU')
				  INTO PA_PRS( FN_PRS ,  LN_PRS,  ID_PRTY_PRS)
				  VALUES(FIRST_NAME, LAST_NAME, CUSTOMER_ID)
				  INTO PA_CT(id_ct, ty_ro_prty, id_prty)
				  VALUES(CUSTOMER_ID,'CU',CUSTOMER_ID)
					INTO LO_ADS(ID_ADS) 
					VALUES(ADDR_ID)
					INTO LO_ADS_PRTY(ID_ADS, ID_PRTY, TY_RO_PRTY, TY_ADS)
					VALUES(ADDR_ID, CUSTOMER_ID, 'CU', 'PRIMARY_RESIDENCE')
					INTO LO_ADS_NSTD(ID_ADS, CO_NM, PC_NM, TE_NM, MU_NM,
						 					 						A1_ADS, A2_ADS,	FL_PRMY_ADS)
					VALUES(	ADDR_ID, CUST_COUNTRY, CUST_PCODE, CUST_STATE,CUST_CITY,
									 	CUST_ADDRESS_LINE_1,CUST_ADDRESS_LINE_2, 1)
				   INTO ARM_ADS_PH(ID_ADS, ID_PH_TYP,TL_PH)
				   VALUES(ADDR_ID, 'CUSTOMER_HOME',  CUST_PHONE_1)
				   INTO ARM_ADS_PH(ID_ADS, ID_PH_TYP,TL_PH)
				   VALUES(ADDR_ID, 'CUSTOMER_HOME_ALT',  CUST_PHONE_2)
			  	  SELECT txn_rec.customer_id(i) CUSTOMER_ID, txn_rec.CUST_FIRST_NAME(i) FIRST_NAME,	
				  		 				txn_rec.CUST_LAST_NAME(i) LAST_NAME, 
										txn_rec.CUST_ADDRRESS_LINE_1(i) CUST_ADDRESS_LINE_1, txn_rec.CUST_ADDRRESS_LINE_2(i) CUST_ADDRESS_LINE_2,
										txn_rec.CUST_CITY(i) CUST_CITY,	txn_rec.CUST_STATE(i) CUST_STATE,	
										txn_rec.CUST_COUNTRY(i) CUST_COUNTRY, txn_rec.CUST_PCODE(i) CUST_PCODE,
										txn_rec.CUST_PHONE_1(i) CUST_PHONE_1, txn_rec.CUST_PHONE_2(i) CUST_PHONE_2, arr_ads_id(i) addr_id  FROM DUAL;																	  		
		   	-- Exception section
			EXCEPTION
					WHEN DML_ERRORS THEN
						errors := SQL%BULK_EXCEPTIONS.COUNT;
						l_cnt := l_cnt + errors;
						return_code := 1;
						FOR i IN 1..errors LOOP
							error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
							error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
							UPDATE ARM_STG_TXN_HIST
							SET      stg_status = 1
							, stg_error_message = stg_error_message  || '|' || '  Error INSERTING	PA_PRTY/PA_PRS/PA_CT - ' || error_code
							, stg_process_date = SYSDATE
							WHERE  stg_event_id = txn_rec.stg_event_id(error_index);
						END LOOP;
					WHEN OTHERS THEN
						errors := SQL%BULK_EXCEPTIONS.COUNT;
						l_cnt := l_cnt + errors;
						return_code := 1;
						FOR i IN 1..errors LOOP
							error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
							error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
							UPDATE ARM_STG_TXN_HIST
							SET      stg_status = 1
							, stg_error_message = stg_error_message  || '|' || '  Error INSERTING	PA_PRTY/PA_PRS/PA_CT - ' || error_code
							, stg_process_date = SYSDATE
							WHERE  stg_event_id = txn_rec.stg_event_id(error_index);
						END LOOP;
				END;	
					RETURN return_code;					
	 END process_txn_rec_type_c;
   FUNCTION process_txn_rec_type_a
   (
		txn_rec txn_rec_type
   ) RETURN INTEGER
   	IS
	  	l_cnt  		  PLS_INTEGER := 0;
		error_msg 	  VARCHAR2(1000) := NULL;
		error_index   PLS_INTEGER := 0;
		error_code 	  VARCHAR2(10) := NULL;
		msg VARCHAR2(100);
		return_code   PLS_INTEGER := 0;	
		l_pay_line_id NUMBER := 0;		
		TYPE t_arr_pay_LINE_ID IS TABLE OF INTEGER INDEX BY BINARY_INTEGER;	
		arr_pay_line_id t_arr_pay_line_id;		
	BEGIN
		FOR i IN 1 .. txn_rec.record_type.COUNT LOOP
			l_pay_line_id := 0;
			BEGIN
				l_pay_line_id := pay_line_id(txn_rec.transaction_id(i));
				l_pay_line_id := l_pay_line_id+1;
				pay_line_id(txn_rec.transaction_id(i)) := l_pay_line_id;
			EXCEPTION
					WHEN NO_DATA_FOUND THEN
						pay_line_id(txn_rec.transaction_id(i)) := 0;
						arr_pay_line_id(i) := 0;
			END;
		END LOOP;
		 BEGIN
	 			FORALL i IN 1..txn_rec.record_type.COUNT()	SAVE EXCEPTIONS	   
					   INSERT ALL
					   		 WHEN (1=1) THEN
						   		INTO TR_LTM_TND ( AI_TRN,  AI_LN_ITM,  TY_TND,  MO_ITM_LN_TND,
									 			  		   			   		  LU_CLS_TND)
		 						VALUES (TRANSACTION_ID, LINE_ID, TND_TYPE, TND_AMOUNT, TND_TYPE)
							WHEN (txn_rec.tnd_type(i) IN ('CHECK', 'EMPLOYEE_CHECK', 'BANK_CHECK', 'CAD_BANK_CHECK', 'BUSINESS_CHECK', 'CAD_BUSINESS_CHECK')) THEN
						   		INTO TR_LTM_CHK_TND (AI_TRN,  AI_LN_ITM,  ID_BK_CHK,  ID_ACNT_CHK, AI_CHK, LU_CLS_TND, 
									 						  			  			  TRANSIT_NUMBER, TENDER_TYPE, MANUAL_OVERRIDE, 
																					  RSP_AUTH_RESP_CODE,  APPROVAL_DATE, CHECK_SCANNED_IN)
		 						VALUES (TRANSACTION_ID, LINE_ID, CHK_BANK,TND_ID_ACNT_NMB, NULL, 
									   				TND_TYPE, CHK_ROUTING_NUM, '02', TND_MANUAL_OVERRIDE, TND_RESP_AUTH,
													TND_APPROVAL_DATE, CHK_IS_SCANNED)
							WHEN (txn_rec.tnd_type(i) IN ('CREDIT_CARD','AMEX','DISCOVER','MASTER_CARD','VISA','DINER','DEBIT_CARD')) THEN
							   INTO TR_LTM_CRDB_CRD_TN(AI_TRN,  AI_LN_ITM,  ID_ACNT_DB_CR_CRD,LU_CLS_TND,
							   							APPROVAL_DATE, EXPIRATION_DATE, TENDER_TYPE, 
														AMEX_CID_NUMBER,  MANUAL_OVERRIDE, HOLDER_NAME, 
														RESP_ADDRESS_VERIF, RESP_AUTH_RESPONSE,CARD_IDENTIFIER)
								VALUES(TRANSACTION_ID, LINE_ID, TND_ID_ACNT_NMB,TND_TYPE, TND_APPROVAL_DATE,
									   TND_EXPIRATION_DT,'03',CC_AMEX_CID_NUM,TND_MANUAL_OVERRIDE, TND_HOLDER_NAME,
									   TND_RESP_ADDRESS_VERIF,TND_RESP_AUTH,TND_CARD_IDNFR)
							WHEN (txn_rec.tnd_type(i) IN ('DUE_BILL', 'DUE_BILL_ISSUE', 'HOUSE_ACCOUNT', 'STORE_VALUE_CARD')) THEN
								 INTO TR_LTM_GF_CF_TND(AI_TRN,AI_LN_ITM,ID_STR_ISSG,ID_NMB_SRZ_GF_CF,
													 ISSUE_AMOUNT,LU_CLS_TND)
								 VALUES(TRANSACTION_ID, LINE_ID,RDM_TND_ID_STR_RT, RDM_CONTROL_NUMBER,
								 		TND_AMOUNT, TND_TYPE)
								 INTO RK_REDM_HIST(SEQ_NUM,DATE_USED,AMOUNT_USED,TRANS_ID_USED,ID_NMB_SRZ_GF_CF,
												  TY_GF_CF)
								 VALUES(SEQ_NUM,TRANSACTION_DATE, TND_AMOUNT, TRANSACTION_ID, RDM_CONTROL_NUMBER, RDM_TYPE)	   								 			   				  												  		
							WHEN (txn_rec.tnd_type(i) IN ('MFR_COUPON')) THEN
								 INTO TR_LTM_CPN_TND(ID_STR_RT,ID_WS,TY_CPN,DC_CPN_EP,LU_CPN_PRM,
												   AI_TRN,AI_LN_ITM)
								 VALUES(RDM_TND_ID_STR_RT, NULL, RDM_TND_PRM_CODE, RDM_EXPIRATION_DATE,RDM_TND_PRM_CODE,
			 						    TRANSACTION_ID, LINE_ID)														   																	 								 	
					   SELECT txn_rec.transaction_id(i) TRANSACTION_ID, arr_pay_line_id(i) line_id, 
					   		  			txn_rec.TRANSACTION_DATE(i) TRANSACTION_DATE, txn_rec.tnd_type(i) TND_TYPE, 
										Arm_Util_Pkg.convert_to_currency(txn_rec.TND_AMOUNT(i),txn_rec.CURRENCY_CODE(i)) TND_AMOUNT, 
										txn_rec.TND_ID_ACNT_NMB(i) TND_ID_ACNT_NMB, 
										txn_rec.TND_RESP_AUTH(i) TND_RESP_AUTH, txn_rec.TND_APPROVAL_DATE(i) TND_APPROVAL_DATE, 
										txn_rec.TND_EXPIRATION_DT(i) TND_EXPIRATION_DT, txn_rec.TND_HOLDER_NAME(i) TND_HOLDER_NAME, 
										txn_rec.CC_CVV_CODE(i) CC_CVV_CODE,	txn_rec.CC_AMEX_CID_NUM(i) CC_AMEX_CID_NUM, 
										txn_rec.TND_SWIPE_IND(i) TND_SWIPE_IND,	txn_rec.TND_RESP_ADDRESS_VERIF(i) TND_RESP_ADDRESS_VERIF, 
										txn_rec.TND_RESP_JOURNAL_KEY(i) TND_RESP_JOURNAL_KEY, txn_rec.TND_RESP_MSG(i) TND_RESP_MSG,	
										txn_rec.TND_RESP_MSG_NUM(i) TND_RESP_MSG_NUM, txn_rec.TND_MERCHANT_ID(i) TND_MERCHANT_ID, 
										txn_rec.TND_CARD_IDNFR(i) TND_CARD_IDNFR, txn_rec.CC_CARD_PLAN(i) CC_CARD_PLAN, 
										txn_rec.TND_MANUAL_OVERRIDE(i) TND_MANUAL_OVERRIDE,	txn_rec.CHK_ABA_NUM(i) CHK_ABA_NUM, 
										txn_rec.CHK_ROUTING_NUM(i) CHK_ROUTING_NUM,	txn_rec.CHK_BANK(i) CHK_BANK, 
										txn_rec.CHK_IS_SCANNED(i) CHK_IS_SCANNED, txn_rec.RDM_TYPE(i) RDM_TYPE, 
										txn_rec.RDM_CONTROL_NUMBER(i) RDM_CONTROL_NUMBER, txn_rec.RDM_TND_ID_STR_RT(i) RDM_TND_ID_STR_RT,	
										txn_rec.RDM_DC_CPN_SCAN_CODE(i) RDM_DC_CPN_SCAN_CODE, txn_rec.RDM_TND_PRM_CODE(i) RDM_TND_PRM_CODE, 
										txn_rec.RDM_EXPIRATION_DATE(i) RDM_EXPIRATION_DATE, (SELECT SUM(SEQ_NUM) FROM RK_REDM_HIST WHERE TY_GF_CF=txn_rec.RDM_TYPE(i) AND ID_NMB_SRZ_GF_CF=txn_rec.RDM_CONTROL_NUMBER(i)) SEQ_NUM  FROM DUAL;																	  		
	   	-- Exception section
		EXCEPTION
				WHEN DML_ERRORS THEN
					errors := SQL%BULK_EXCEPTIONS.COUNT;
					l_cnt := l_cnt + errors;
					return_code := 1;
					FOR i IN 1..errors LOOP
						error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
						error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
						UPDATE ARM_STG_TXN_HIST
						SET      stg_status = 1
						, stg_error_message = stg_error_message  || '|' || '  Error INSERTING TR_LTM_TND/TR_LTM_CR_DB_TN/TR_LTM_CHK_TND - ' || error_code
						, stg_process_date = SYSDATE
						WHERE  stg_event_id = txn_rec.stg_event_id(error_index);
					END LOOP;
				WHEN OTHERS THEN
					errors := SQL%BULK_EXCEPTIONS.COUNT;
					l_cnt := l_cnt + errors;
					return_code := 1;
					FOR i IN 1..errors LOOP
						error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
						error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
						UPDATE ARM_STG_TXN_HIST
						SET      stg_status = 1
						, stg_error_message = stg_error_message  || '|' || '  Error INSERTING TR_LTM_TND/TR_LTM_CR_DB_TN/TR_LTM_CHK_TND - ' || error_code
						, stg_process_date = SYSDATE
						WHERE  stg_event_id = txn_rec.stg_event_id(error_index);
					END LOOP;
					
		END;
		BEGIN
	 			FORALL i IN 1..txn_rec.record_type.COUNT()	SAVE EXCEPTIONS
					   UPDATE RK_PAY_TRN
					   SET PAY_TYPES=DECODE(PAY_TYPES, NULL, '*', PAY_TYPES)||txn_rec.TND_TYPE(i)||'*'
					   WHERE AI_TRN=txn_rec.TRANSACTION_ID(i);	 
   		-- Exception section
		EXCEPTION
				WHEN DML_ERRORS THEN
					errors := SQL%BULK_EXCEPTIONS.COUNT;
					l_cnt := l_cnt + errors;
					return_code := 1;
					FOR i IN 1..errors LOOP
						error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
						error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
						UPDATE ARM_STG_TXN_HIST
						SET      stg_status = 1
						, stg_error_message = stg_error_message  || '|' || '  Error UPDATING RK_PAY_TRN - ' || error_code
						, stg_process_date = SYSDATE
						WHERE  stg_event_id = txn_rec.stg_event_id(error_index);
					END LOOP;
		END;	
					RETURN return_code;			
	END  process_txn_rec_type_a;
 
END Arm_Load_Txn_Hist_Pkg;
/
