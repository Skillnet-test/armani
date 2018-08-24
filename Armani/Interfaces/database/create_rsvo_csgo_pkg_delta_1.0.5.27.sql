CREATE OR REPLACE PACKAGE Arm_Load_Rsvo_Csgo_Pkg IS
------------------------------------------------------------------------------------------------
-- This package is used to load data from the staging tables into the base tables.
------------------------------------------------------------------------------------------------
TYPE  RECORD_TYPE_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.RECORD_TYPE%TYPE;
TYPE  TRANSACTION_ID_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.TRANSACTION_ID%TYPE;
TYPE  ADD_NO_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.ADD_NO%TYPE;
TYPE  EXPIRATION_DATE_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.EXPIRATION_DATE%TYPE;
TYPE  TRANSACTION_TYPE_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.TRANSACTION_TYPE%TYPE;
TYPE  TRANSACTION_DATE_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.TRANSACTION_DATE%TYPE;
TYPE  STORE_ID_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.STORE_ID%TYPE;
TYPE  REGISTER_NO_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.REGISTER_NO%TYPE;
TYPE  OPERATOR_ID_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.OPERATOR_ID%TYPE;
TYPE  SALES_ASSOCIATE_ID_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.SALES_ASSOCIATE_ID%TYPE;
TYPE  TRANSACTION_NET_AMOUNT_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.TRANSACTION_NET_AMOUNT%TYPE;
TYPE  LINE_ITEM_TYPE_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.LINE_ITEM_TYPE%TYPE;
TYPE  ITEM_ID_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.ITEM_ID%TYPE;
TYPE  MISC_ITEM_ID_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.MISC_ITEM_ID%TYPE;
TYPE  IS_PROCESSED_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.IS_PROCESSED%TYPE;
TYPE  QUANTITY_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.QUANTITY%TYPE;
TYPE  CURRENCY_CODE_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.CURRENCY_CODE%TYPE;
TYPE  RETAIL_PRICE_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.RETAIL_PRICE%TYPE;
TYPE  SELLING_PRICE_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.SELLING_PRICE%TYPE;
TYPE  CUSTOMER_ROLE_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.CUSTOMER_ROLE%TYPE;
TYPE  CUSTOMER_ID_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.CUSTOMER_ID%TYPE;
TYPE  CUST_FIRST_NAME_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.CUST_FIRST_NAME%TYPE;
TYPE  CUST_LAST_NAME_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.CUST_LAST_NAME%TYPE;
TYPE  CUST_ADDRRESS_LINE_1_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.CUST_ADDRRESS_LINE_1%TYPE;
TYPE  CUST_ADDRRESS_LINE_2_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.CUST_ADDRRESS_LINE_2%TYPE;
TYPE  CUST_CITY_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.CUST_CITY%TYPE;
TYPE  CUST_STATE_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.CUST_STATE%TYPE;
TYPE  CUST_COUNTRY_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.CUST_COUNTRY%TYPE;
TYPE  CUST_PCODE_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.CUST_PCODE%TYPE;
TYPE  CUST_PHONE_1_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.CUST_PHONE_1%TYPE;
TYPE  CUST_PHONE_2_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.CUST_PHONE_2%TYPE;
TYPE  TND_TYPE_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.TND_TYPE%TYPE;
TYPE  TND_AMOUNT_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.TND_AMOUNT%TYPE;
TYPE  STG_EVENT_ID_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.STG_EVENT_ID%TYPE;
TYPE  STG_STATUS_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.STG_STATUS%TYPE;
TYPE  STG_ERROR_MESSAGE_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.STG_ERROR_MESSAGE%TYPE;
TYPE  STG_LOAD_DATE_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.STG_LOAD_DATE%TYPE;
TYPE  STG_PROCESS_DATE_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.STG_LOAD_DATE%TYPE;
TYPE  LN_ITM_NET_AMT_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.LN_ITM_NET_AMT%TYPE;
TYPE  LN_ITM_TAX_AMT_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.LN_ITM_TAX_AMT%TYPE;
TYPE  TAX_EXEMPT_ID_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.TAX_EXEMPT_ID%TYPE;
TYPE  MANUAL_TAX_AMT_TYPE IS TABLE OF ARM_STG_RSVO_CSGO.MANUAL_TAX_AMT%TYPE;


TYPE txn_rec_type IS RECORD (
		record_type RECORD_TYPE_TYPE,
		transaction_id TRANSACTION_ID_TYPE,
		add_no ADD_NO_TYPE,
		expiration_date EXPIRATION_DATE_TYPE,
		transaction_type TRANSACTION_TYPE_TYPE,
		transaction_date TRANSACTION_DATE_TYPE,
		store_id STORE_ID_TYPE,
		register_no REGISTER_NO_TYPE,
		operator_id OPERATOR_ID_TYPE,
		sales_associate_id SALES_ASSOCIATE_ID_TYPE,
		transaction_net_amount TRANSACTION_NET_AMOUNT_TYPE,
		line_item_type LINE_ITEM_TYPE_TYPE,
		item_id ITEM_ID_TYPE,
		misc_item_id MISC_ITEM_ID_TYPE,
		is_process IS_PROCESSED_TYPE,
		quantity QUANTITY_TYPE,
		currency_code CURRENCY_CODE_TYPE,
		retail_price RETAIL_PRICE_TYPE,
		selling_price SELLING_PRICE_TYPE,
		LN_ITM_NET_AMT LN_ITM_NET_AMT_TYPE,
		LN_ITM_TAX_AMT LN_ITM_TAX_AMT_TYPE,
		TAX_EXEMPT_ID TAX_EXEMPT_ID_TYPE,
		MANUAL_TAX_AMT MANUAL_TAX_AMT_TYPE,
		customer_role CUSTOMER_ROLE_TYPE,
		customer_id CUSTOMER_ID_TYPE,
		cust_first_name CUST_FIRST_NAME_TYPE,
		cust_last_name CUST_LAST_NAME_TYPE,
		cust_address_line_1 CUST_ADDRRESS_LINE_1_TYPE,
		cust_address_line_2 CUST_ADDRRESS_LINE_2_TYPE,
		cust_city CUST_CITY_TYPE,
		cust_state CUST_STATE_TYPE,
		cust_country CUST_COUNTRY_TYPE,
		cust_pcode CUST_PCODE_TYPE,
		cust_phone_1 CUST_PHONE_1_TYPE,
		cust_phone_2 CUST_PHONE_2_TYPE,
		tnd_type TND_TYPE_TYPE,
		tnd_amount TND_AMOUNT_TYPE,
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
	in_file_name 	 IN  VARCHAR2  ) RETURN INTEGER;
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

END Arm_Load_Rsvo_Csgo_Pkg;
/
CREATE OR REPLACE PACKAGE BODY Arm_Load_Rsvo_Csgo_Pkg IS
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
		RETURN status;
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
	SELECT record_type,
				transaction_id,
				add_no,
				expiration_date,
				transaction_type,
				transaction_date,
				store_id,
				register_no,
				operator_id,
				sales_associate_id,
				transaction_net_amount,
				line_item_type,
				item_id,
				misc_item_id,
				is_processed,
				quantity,
				currency_code,
				retail_price,
				selling_price,
				LN_ITM_NET_AMT,
				LN_ITM_TAX_AMT,
				TAX_EXEMPT_ID,
				MANUAL_TAX_AMT,
				customer_role,
				customer_id,
				cust_first_name,
				cust_last_name,
				cust_addrress_line_1,
				cust_addrress_line_2,
				cust_city,
				cust_state,
				cust_country,
				cust_pcode,
				cust_phone_1,
				cust_phone_2,
				tnd_type,
				tnd_amount,
				stg_event_id,
				stg_status,
				stg_error_message,
				stg_load_date,
				stg_process_date
	FROM   arm_stg_rsvo_csgo
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
			INTO   	txn_rec.record_type,
				txn_rec.transaction_id,
				txn_rec.add_no,
				txn_rec.expiration_date,
				txn_rec.transaction_type,
				txn_rec.transaction_date,
				txn_rec.store_id,
				txn_rec.register_no,
				txn_rec.operator_id,
				txn_rec.sales_associate_id,
				txn_rec.transaction_net_amount,
				txn_rec.line_item_type,
				txn_rec.item_id,
				txn_rec.misc_item_id,
				txn_rec.is_process,
				txn_rec.quantity,
				txn_rec.currency_code,
				txn_rec.retail_price,
				txn_rec.selling_price,
				txn_rec.LN_ITM_NET_AMT,
				txn_rec.LN_ITM_TAX_AMT,
				txn_rec.TAX_EXEMPT_ID,
				txn_rec.MANUAL_TAX_AMT,
				txn_rec.customer_role,
				txn_rec.customer_id,
				txn_rec.cust_first_name,
				txn_rec.cust_last_name,
				txn_rec.cust_address_line_1,
				txn_rec.cust_address_line_2,
				txn_rec.cust_city,
				txn_rec.cust_state,
				txn_rec.cust_country,
				txn_rec.cust_pcode,
				txn_rec.cust_phone_1,
				txn_rec.cust_phone_2,
				txn_rec.tnd_type,
				txn_rec.tnd_amount,
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
					   		  				DECODE(TRANSACTION_TYPE, 'RSVO', 'TRNRSO', 'CSGO', 'TRNCGO'))
					   INTO TR_RTL( ID_CT, AI_TRN,  CONSULTANT_ID, NET_AMOUNT,
													  REGISTER_ID)
						VALUES (CUSTOMER_ID, TRANSACTION_ID, SALES_ASSOCIATE_ID, TRANSACTION_NET_AMOUNT,
							   				 REGISTER_NO)
					   SELECT txn_rec.record_type(i) RECORD_TYPE,	txn_rec.transaction_id(i) TRANSACTION_ID,	txn_rec.add_no(i) ADD_NO,
					   		  			    txn_rec.expiration_date(i) EXPIRATION_DATE, txn_rec.transaction_type(i) TRANSACTION_TYPE,
											txn_rec.transaction_date(i) TRANSACTION_DATE, txn_rec.store_id(i) STORE_ID, txn_rec.register_no(i) REGISTER_NO,
											EMPLOYEE.ID_EM OPERATOR_ID, ASSOCIATE.ID_EM SALES_ASSOCIATE_ID,
											Arm_Util_Pkg.convert_to_currency(txn_rec.transaction_net_amount(i), txn_rec.currency_code(i), '0') TRANSACTION_NET_AMOUNT,
											txn_rec.line_item_type(i) LINE_ITEM_TYPE,
											txn_rec.customer_role(i) CUSTOMER_ROLE, txn_rec.customer_id(i) CUSTOMER_ID
						FROM DUAL INNER JOIN PA_EM EMPLOYEE ON  txn_rec.OPERATOR_ID(i)=EMPLOYEE.ARM_EXTERNAL_ID
						 LEFT OUTER JOIN PA_EM ASSOCIATE ON txn_rec.SALES_ASSOCIATE_ID(i)=ASSOCIATE.ARM_EXTERNAL_ID;
		-- Exception section
		EXCEPTION
				WHEN DML_ERRORS THEN
					errors := SQL%BULK_EXCEPTIONS.COUNT;
					l_cnt := l_cnt + errors;
					return_code := 1;
					FOR i IN 1..errors LOOP
						error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
						error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
						UPDATE arm_stg_CUST_IN
						SET      stg_status = 1
						, stg_error_message = stg_error_message  || '|' || '  Error INSERTING/UPDATING	TR_TRN/TR_RTL/RK_PAY_TRN - ' || error_code
						, stg_process_date = SYSDATE
						WHERE  stg_event_id = txn_rec.stg_event_id(error_index);
					END LOOP;
		END;
  	   BEGIN
	 			FORALL i IN 1..txn_rec.record_type.COUNT()	SAVE EXCEPTIONS
					   INSERT INTO ARM_POS_CSG (AI_TRN, ID_CONSIGNMENT,  EXP_DT)
					   SELECT txn_rec.transaction_id(i) TRANSACTION_ID,	txn_rec.add_no(i) ADD_NO,
					   		  			    txn_rec.expiration_date(i) EXPIRATION_DATE FROM DUAL
						WHERE txn_rec.transaction_type(i) IN ('TRNCGO');
		-- Exception section
		EXCEPTION
				WHEN DML_ERRORS THEN
					errors := SQL%BULK_EXCEPTIONS.COUNT;
					l_cnt := l_cnt + errors;
					return_code := 1;
					FOR i IN 1..errors LOOP
						error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
						error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
						UPDATE arm_stg_CUST_IN
						SET      stg_status = 1
						, stg_error_message = stg_error_message  || '|' || '  Error INSERTING	ARM_POS_CSG - ' || error_code
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
			ELSE
						arr_ship_seq_num(i) := 	0;
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
						   VALUES (SHIP_SEQ_NUM, FIRST_NAME, LAST_NAME, CUST_ADDRESS_LINE_1,
						   					   CUST_ADDRESS_LINE_2, CUST_CITY, CUST_STATE, CUST_PCODE,
											   CUST_COUNTRY, CUST_PHONE_1, TRANSACTION_ID)
						WHEN (1 = 1) THEN
					   		INTO TR_LTM_RTL_TRN (  AI_LN_ITM, AI_TRN,  ID_ITM,  POS_LN_ITM_TY_ID,
					   					   	  			 		   	  		    ADD_CONSULTANT_ID,  ITM_SEL_PRICE, ITM_RETAIL_PRICE,
																				MISC_ITEM_ID,  SHIP_REQ_SEQ_NUM,  QUANTITY)
					   		VALUES (LINE_ID, TRANSACTION_ID,  ITEM_ID, line_item_type, SALES_ASSOCIATE_ID,
					   		  				SELLING_PRICE, RETAIL_PRICE, MISC_ITEM_ID,  DECODE(CUSTOMER_ROLE, '2', SHIP_SEQ_NUM, NULL), QUANTITY)
					   SELECT txn_rec.transaction_id(i) TRANSACTION_ID, ASSOCIATE.ID_EM SALES_ASSOCIATE_ID,
											DECODE(txn_rec.line_item_type(i), '1', '5', '2', '6','1') LINE_ITEM_TYPE,
											txn_rec.item_id(i) ITEM_ID, txn_rec.misc_item_id(i) MISC_ITEM_ID,	txn_rec.is_process(i) IS_PROCESS,
											txn_rec.quantity(i) QUANTITY, txn_rec.currency_code(i) CURRENCY_CODE,
											Arm_Util_Pkg.convert_to_currency(txn_rec.retail_price(i), txn_rec.currency_code(i),'0') RETAIL_PRICE,
											Arm_Util_Pkg.convert_to_currency(txn_rec.selling_price(i), txn_rec.currency_code(i),'0') SELLING_PRICE,
											txn_rec.customer_role(i) CUSTOMER_ROLE, txn_rec.customer_id(i) CUSTOMER_ID,
											txn_rec.cust_first_name(i) FIRST_NAME,	txn_rec.cust_last_name(i) LAST_NAME,
											txn_rec.cust_address_line_1(i) CUST_ADDRESS_LINE_1,
											txn_rec.cust_address_line_2(i) CUST_ADDRESS_LINE_2, txn_rec.cust_city(i) CUST_CITY,
											txn_rec.cust_state(i) CUST_STATE, txn_rec.cust_country(i) CUST_COUNTRY,	txn_rec.cust_pcode(i) CUST_PCODE,
											txn_rec.cust_phone_1(i) CUST_PHONE_1, txn_rec.cust_phone_2(i) CUST_PHONE_2, txn_rec.tnd_type(i) TND_TYPE,
											Arm_Util_Pkg.convert_to_currency(txn_rec.tnd_amount(i), txn_rec.currency_code(i),'0') TND_AMOUNT,
											arr_line_id(i) LINE_ID, arr_ship_seq_num(i) SHIP_SEQ_NUM  
											FROM DUAL  LEFT OUTER JOIN PA_EM ASSOCIATE ON txn_rec.SALES_ASSOCIATE_ID(i)=ASSOCIATE.ARM_EXTERNAL_ID ;
	   		-- Exception section
		EXCEPTION
				WHEN DML_ERRORS THEN
					errors := SQL%BULK_EXCEPTIONS.COUNT;
					l_cnt := l_cnt + errors;
					return_code := 1;
					FOR i IN 1..errors LOOP
						error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
						error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
						UPDATE arm_stg_CUST_IN
						SET      stg_status = 1
						, stg_error_message = stg_error_message  || '|' || '  Error INSERTING	TR_LTM_RTL_TRN/RK_SHIP_REQ - ' || error_code
						, stg_process_date = SYSDATE
						WHERE  stg_event_id = txn_rec.stg_event_id(error_index);
					END LOOP;

	   END;
  	   BEGIN
	 			FORALL i IN 1..txn_rec.record_type.COUNT()	SAVE EXCEPTIONS
					   INSERT INTO RK_POS_LN_ITM_DTL (SEQUENCE_NUMBER,FL_PROCESSED,NET_AMT,
					   		  	   					 									   			TAX_AMT,MANUAL_TAX_AMT, AI_TRN,AI_LN_ITM)
					   SELECT ROWNUM, txn_rec.is_process(i),
					   					Arm_Util_Pkg.convert_to_currency(txn_rec.LN_ITM_NET_AMT(i)/txn_rec.QUANTITY(i), txn_rec.CURRENCY_CODE(i),'0') LN_ITM_DTL_NET_AMT,
										Arm_Util_Pkg.convert_to_currency(txn_rec.LN_ITM_TAX_AMT(i)/txn_rec.QUANTITY(i), txn_rec.CURRENCY_CODE(i),'0') LN_ITM_DTL_TAX_AMT,
										Arm_Util_Pkg.convert_to_currency(txn_rec.MANUAL_TAX_AMT(i)/txn_rec.QUANTITY(i), txn_rec.CURRENCY_CODE(i),'1') MANUAL_TAX_AMT,
                                       txn_rec.transaction_id(i) TRANSACTION_ID, arr_line_id(i) LINE_ID
					   FROM  TABLE(cast(Arm_Util_Pkg.Generate_N_Record(txn_rec.quantity(i)) AS T_COUNTER_TABLE)) counter;
	   		-- Exception section
		EXCEPTION
				WHEN DML_ERRORS THEN
					errors := SQL%BULK_EXCEPTIONS.COUNT;
					l_cnt := l_cnt + errors;
					return_code := 1;
					FOR i IN 1..errors LOOP
						error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
						error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
						UPDATE arm_stg_CUST_IN
						SET      stg_status = 1
						, stg_error_message = stg_error_message  || '|' || '  Error INSERTING	RK_POS_LN_ITM_DTL - ' || error_code
						, stg_process_date = SYSDATE
						WHERE  stg_event_id = txn_rec.stg_event_id(error_index);
					END LOOP;
	   END;
	   RETURN return_code;
  END process_txn_rec_type_l;
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
			EXCEPTION
					WHEN NO_DATA_FOUND THEN
						BEGIN
							SELECT MAX(AI_LN_ITM) INTO l_pay_line_id FROM TR_LTM_TND WHERE AI_TRN = txn_rec.transaction_id(i);
--							l_pay_line_id := l_pay_line_id+1;
--							pay_line_id(txn_rec.transaction_id(i)) := l_pay_line_id;
--							arr_pay_line_id(i) := l_pay_line_id;					
						EXCEPTION
							WHEN NO_DATA_FOUND THEN
								pay_line_id(txn_rec.transaction_id(i)) := 0;
								arr_pay_line_id(i) := 0;
						END;
						pay_line_id(txn_rec.transaction_id(i)) := 0;
						arr_pay_line_id(i) := 0;
					WHEN OTHERS THEN
						pay_line_id(txn_rec.transaction_id(i)) := 0;
						arr_pay_line_id(i) := 0;
			END;
				l_pay_line_id := l_pay_line_id+1;
				pay_line_id(txn_rec.transaction_id(i)) := l_pay_line_id;
				arr_pay_line_id(i) := l_pay_line_id;					
		END LOOP;

		 BEGIN
	 			FORALL i IN 1..txn_rec.record_type.COUNT()	SAVE EXCEPTIONS
					   INSERT ALL
					   		INTO TR_LTM_TND ( AI_TRN,  AI_LN_ITM,  TY_TND,  MO_ITM_LN_TND,
								 			  		   			   		  LU_CLS_TND)
						VALUES (TRANSACTION_ID,  LINE_ID, TND_TYPE,TND_AMOUNT, TND_TYPE)
					   SELECT txn_rec.transaction_id(i) TRANSACTION_ID, arr_pay_line_id(i) line_id, txn_rec.tnd_type(i) TND_TYPE,
               					   Arm_Util_Pkg.convert_to_currency(txn_rec.tnd_amount(i), txn_rec.currency_code(i),'0') TND_AMOUNT  FROM DUAL;
	   		-- Exception section
		EXCEPTION
				WHEN DML_ERRORS THEN
					errors := SQL%BULK_EXCEPTIONS.COUNT;
					l_cnt := l_cnt + errors;
					return_code := 1;
					FOR i IN 1..errors LOOP
						error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
						error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
						UPDATE arm_stg_CUST_IN
						SET      stg_status = 1
						, stg_error_message = stg_error_message  || '|' || '  Error INSERTING	TR_LTM_TND - ' || error_code
						, stg_process_date = SYSDATE
						WHERE  stg_event_id = txn_rec.stg_event_id(error_index);
					END LOOP;
			END;
			RETURN return_code;
	END  process_txn_rec_type_a;
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
				  INTO PA_PRTY (  ID_PRTY,  TY_PRTY)
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
					VALUES(ADDR_ID, CUSTOMER_ID, 'CU', 'HOME')
					INTO LO_ADS_NSTD(ID_ADS, CO_NM, PC_NM, TE_NM, MU_NM,
						 					 						A1_ADS, A2_ADS,	FL_PRMY_ADS)
					VALUES(	ADDR_ID, CUST_COUNTRY, CUST_PCODE, CUST_STATE,CUST_CITY,
									 	CUST_ADDRESS_LINE_1,CUST_ADDRESS_LINE_2, 1)
				   INTO ARM_ADS_PH(ID_ADS, ID_PH_TYP,TL_PH)
				   VALUES(ADDR_ID, 'HOME',  CUST_PHONE_1)
				   INTO ARM_ADS_PH(ID_ADS, ID_PH_TYP,TL_PH)
				   VALUES(ADDR_ID, 'ALTERNATE',  CUST_PHONE_2)
			  	  SELECT txn_rec.customer_id(i) CUSTOMER_ID, txn_rec.cust_first_name(i) FIRST_NAME,	txn_rec.cust_last_name(i) LAST_NAME, txn_rec.cust_address_line_1(i) CUST_ADDRESS_LINE_1,
									txn_rec.cust_address_line_2(i) CUST_ADDRESS_LINE_2, txn_rec.cust_city(i) CUST_CITY,
									txn_rec.cust_state(i) CUST_STATE, txn_rec.cust_country(i) CUST_COUNTRY,	txn_rec.cust_pcode(i) CUST_PCODE,
									txn_rec.cust_phone_1(i) CUST_PHONE_1, txn_rec.cust_phone_2(i) CUST_PHONE_2, arr_ads_id(i) addr_id  FROM DUAL;
		   		-- Exception section
			EXCEPTION
					WHEN DML_ERRORS THEN
						errors := SQL%BULK_EXCEPTIONS.COUNT;
						l_cnt := l_cnt + errors;
						return_code := 1;
						FOR i IN 1..errors LOOP
							error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
							error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
							UPDATE arm_stg_CUST_IN
							SET      stg_status = 1
							, stg_error_message = stg_error_message  || '|' || '  Error INSERTING	PA_PRTY/PA_PRS/PA_CT - ' || error_code
							, stg_process_date = SYSDATE
							WHERE  stg_event_id = txn_rec.stg_event_id(error_index);
						END LOOP;
				END;
				RETURN return_code;
	 END process_txn_rec_type_c;
END Arm_Load_Rsvo_Csgo_Pkg;
/
