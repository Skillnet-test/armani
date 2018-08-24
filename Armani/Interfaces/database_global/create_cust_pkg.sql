CREATE OR REPLACE PACKAGE Arm_Load_Cust_Pkg IS
------------------------------------------------------------------------------------------------
-- This package is used to load data from the staging tables into the base tables.
------------------------------------------------------------------------------------------------
TYPE  RECORD_TYPE_TYPE IS TABLE OF ARM_STG_CUST_IN.RECORD_TYPE%TYPE;
TYPE  CUSTOMER_ID_TYPE IS TABLE OF ARM_STG_CUST_IN.CUSTOMER_ID%TYPE;
TYPE  CUST_BARCODE_TYPE IS TABLE OF ARM_STG_CUST_IN.CUST_BARCODE%TYPE;
TYPE  TITLE_TYPE IS TABLE OF ARM_STG_CUST_IN.TITLE%TYPE;
TYPE  FIRST_NM_TYPE IS TABLE OF ARM_STG_CUST_IN.FIRST_NM%TYPE;
TYPE  LAST_NM_TYPE IS TABLE OF ARM_STG_CUST_IN.LAST_NM%TYPE;
TYPE  MIDDLE_NM_TYPE IS TABLE OF ARM_STG_CUST_IN.MIDDLE_NM%TYPE;
TYPE  SUFFIX_TYPE IS TABLE OF ARM_STG_CUST_IN.SUFFIX%TYPE;
TYPE  DBYTE_FIRST_NM_TYPE IS TABLE OF ARM_STG_CUST_IN.DBYTE_FIRST_NM%TYPE;
TYPE  DBYTE_LAST_NM_TYPE IS TABLE OF ARM_STG_CUST_IN.DBYTE_LAST_NM%TYPE;
TYPE  GENDER_TYPE IS TABLE OF ARM_STG_CUST_IN.GENDER%TYPE;
TYPE  CUST_TYPE_TYPE IS TABLE OF ARM_STG_CUST_IN.CUST_TYPE%TYPE;
TYPE  LOYALTY_PROGRAM_TYPE IS TABLE OF ARM_STG_CUST_IN.LOYALTY_PROGRAM%TYPE;
TYPE  VIP_PERCENT_TYPE IS TABLE OF ARM_STG_CUST_IN.VIP_PERCENT%TYPE;
TYPE  PRIVACY_TYPE IS TABLE OF ARM_STG_CUST_IN.PRIVACY%TYPE;
TYPE  NO_MAIL_TYPE IS TABLE OF ARM_STG_CUST_IN.NO_MAIL%TYPE;
TYPE  NO_CALL_TYPE IS TABLE OF ARM_STG_CUST_IN.NO_CALL%TYPE;
TYPE  NO_EMAIL_TYPE IS TABLE OF ARM_STG_CUST_IN.NO_EMAIL%TYPE;
TYPE  NO_SMS_TYPE IS TABLE OF ARM_STG_CUST_IN.NO_SMS%TYPE;
TYPE  EMAIL1_TYPE IS TABLE OF ARM_STG_CUST_IN.EMAIL1%TYPE;
TYPE  EMAIL2_TYPE IS TABLE OF ARM_STG_CUST_IN.EMAIL2%TYPE;
TYPE  VAT_NUM_TYPE IS TABLE OF ARM_STG_CUST_IN.VAT_NUM%TYPE;
TYPE  FISCAL_CD_TYPE IS TABLE OF ARM_STG_CUST_IN.FISCAL_CD%TYPE;
TYPE  ID_TYPE_TYPE IS TABLE OF ARM_STG_CUST_IN.ID_TYPE%TYPE;
TYPE  DOC_NUM_TYPE IS TABLE OF ARM_STG_CUST_IN.DOC_NUM%TYPE;
TYPE  PLACE_OF_ISSUE_TYPE IS TABLE OF ARM_STG_CUST_IN.PLACE_OF_ISSUE%TYPE;
TYPE  ISSUE_DT_TYPE IS TABLE OF ARM_STG_CUST_IN.ISSUE_DT%TYPE;
TYPE  PAY_TYPE_TYPE IS TABLE OF ARM_STG_CUST_IN.PAY_TYPE%TYPE;
TYPE  COMPANY_ID_TYPE IS TABLE OF ARM_STG_CUST_IN.COMPANY_ID%TYPE;
TYPE  INTER_CMY_CD_TYPE IS TABLE OF ARM_STG_CUST_IN.INTER_CMY_CD%TYPE;
TYPE  STATUS_TYPE IS TABLE OF ARM_STG_CUST_IN.STATUS%TYPE;
TYPE  ACCT_NUM_TYPE IS TABLE OF ARM_STG_CUST_IN.ACCT_NUM%TYPE;
TYPE  BIRTH_DAY_TYPE IS TABLE OF ARM_STG_CUST_IN.BIRTH_DAY%TYPE;
TYPE  BIRTH_MONTH_TYPE IS TABLE OF ARM_STG_CUST_IN.BIRTH_MONTH%TYPE;
TYPE  REAL_BIRTHDAY_TYPE IS TABLE OF ARM_STG_CUST_IN.REAL_BIRTHDAY%TYPE;
TYPE  AGE_TYPE IS TABLE OF ARM_STG_CUST_IN.AGE%TYPE;
TYPE  REFERRED_BY_TYPE IS TABLE OF ARM_STG_CUST_IN.REFERRED_BY%TYPE;
TYPE  PROFESSION_TYPE IS TABLE OF ARM_STG_CUST_IN.PROFESSION%TYPE;
TYPE  EDUCATION_TYPE IS TABLE OF ARM_STG_CUST_IN.EDUCATION%TYPE;
TYPE  NOTES_1_TYPE IS TABLE OF ARM_STG_CUST_IN.NOTES_1%TYPE;
TYPE  NOTES_2_TYPE IS TABLE OF ARM_STG_CUST_IN.NOTES_2%TYPE;
TYPE  PNTR_FMLY_NM_TYPE IS TABLE OF ARM_STG_CUST_IN.PNTR_FMLY_NM%TYPE;
TYPE  PNTR_NM_TYPE IS TABLE OF ARM_STG_CUST_IN.PNTR_NM%TYPE;
TYPE  BIRTH_PLACE_TYPE IS TABLE OF ARM_STG_CUST_IN.BIRTH_PLACE%TYPE;
TYPE  SPL_EVT_TYPE_TYPE IS TABLE OF ARM_STG_CUST_IN.SPL_EVT_TYPE%TYPE;
TYPE  SPL_EVT_DT_TYPE IS TABLE OF ARM_STG_CUST_IN.SPL_EVT_DT%TYPE;
TYPE  CHILDREN_NAMES_TYPE IS TABLE OF ARM_STG_CUST_IN.CHILDREN_NAMES%TYPE;
TYPE  NUM_OF_CHILDREN_TYPE IS TABLE OF ARM_STG_CUST_IN.NUM_OF_CHILDREN%TYPE;
TYPE  CR_CARD_NUM_1_TYPE IS TABLE OF ARM_STG_CUST_IN.CR_CARD_NUM_1%TYPE;
TYPE  CR_CARD_TYPE_1_TYPE IS TABLE OF ARM_STG_CUST_IN.CR_CARD_TYPE_1%TYPE;
TYPE  CR_CARD_NUM_2_TYPE IS TABLE OF ARM_STG_CUST_IN.CR_CARD_NUM_2%TYPE;
TYPE  CR_CARD_TYPE_2_TYPE IS TABLE OF ARM_STG_CUST_IN.CR_CARD_TYPE_2%TYPE;
TYPE  COUNTRY_TYPE IS TABLE OF ARM_STG_CUST_IN.COUNTRY%TYPE;
TYPE  POST_CODE_TYPE IS TABLE OF ARM_STG_CUST_IN.POST_CODE%TYPE;
TYPE  STATE_TYPE IS TABLE OF ARM_STG_CUST_IN.STATE%TYPE;
TYPE  CITY_TYPE IS TABLE OF ARM_STG_CUST_IN.CITY%TYPE;
TYPE  ADDRESS_LINE_1_TYPE IS TABLE OF ARM_STG_CUST_IN.ADDRESS_LINE_1%TYPE;
TYPE  ADDRESS_LINE_2_TYPE IS TABLE OF ARM_STG_CUST_IN.ADDRESS_LINE_2%TYPE;
TYPE  UNIT_NAME_TYPE IS TABLE OF ARM_STG_CUST_IN.UNIT_NAME%TYPE;
TYPE  ADDRESS_TYPE_TYPE IS TABLE OF ARM_STG_CUST_IN.ADDRESS_TYPE%TYPE;
TYPE  PHONE_TYPE_1_TYPE IS TABLE OF ARM_STG_CUST_IN.PHONE_TYPE_1%TYPE;
TYPE  PHONE_NUMBER_1_TYPE IS TABLE OF ARM_STG_CUST_IN.PHONE_NUMBER_1%TYPE;
TYPE  PHONE_TYPE_2_TYPE IS TABLE OF ARM_STG_CUST_IN.PHONE_TYPE_2%TYPE;
TYPE  PHONE_NUMBER_2_TYPE IS TABLE OF ARM_STG_CUST_IN.PHONE_NUMBER_2%TYPE;
TYPE  PHONE_TYPE_3_TYPE IS TABLE OF ARM_STG_CUST_IN.PHONE_TYPE_3%TYPE;
TYPE  PHONE_NUMBER_3_TYPE IS TABLE OF ARM_STG_CUST_IN.PHONE_NUMBER_3%TYPE;
TYPE  USE_AS_PRIMARY_ADDR_TYPE IS TABLE OF ARM_STG_CUST_IN.USE_AS_PRIMARY_ADDR%TYPE;
TYPE  STORE_ID_TYPE IS TABLE OF ARM_STG_CUST_IN.STORE_ID%TYPE;
TYPE  COMPANY_CODE_TYPE IS TABLE OF ARM_STG_CUST_IN.COMPANY_CODE%TYPE;
TYPE  BRAND_TYPE IS TABLE OF ARM_STG_CUST_IN.BRAND%TYPE;
TYPE  ASSOCIATE_ID_TYPE IS TABLE OF ARM_STG_CUST_IN.ASSOCIATE_ID%TYPE;
TYPE  CREATE_DATE_TYPE IS TABLE OF ARM_STG_CUST_IN.CREATE_DATE%TYPE;
TYPE  COMMENTS_TYPE IS TABLE OF ARM_STG_CUST_IN.COMMENTS%TYPE;
TYPE  OLD_CUSTOMER_ID_TYPE IS TABLE OF ARM_STG_CUST_IN.OLD_CUSTOMER_ID%TYPE;
TYPE  STG_EVENT_ID_TYPE IS TABLE OF ARM_STG_CUST_IN.STG_EVENT_ID%TYPE;
TYPE  STG_STATUS_TYPE IS TABLE OF ARM_STG_CUST_IN.STG_STATUS%TYPE;
TYPE  STG_ERROR_MESSAGE_TYPE IS TABLE OF ARM_STG_CUST_IN.STG_ERROR_MESSAGE%TYPE;
TYPE  STG_LOAD_DATE_TYPE IS TABLE OF ARM_STG_CUST_IN.STG_LOAD_DATE%TYPE;
TYPE  STG_PROCESS_DATE_TYPE IS TABLE OF ARM_STG_CUST_IN.STG_LOAD_DATE%TYPE;
TYPE  ID_ADS_TYPE IS TABLE OF LO_ADS.ID_ADS%TYPE;
TYPE customer_rec_type IS RECORD (
  record_type record_type_type,
  customer_id customer_id_type,
  cust_barcode cust_barcode_type,
  title title_type,
  first_nm first_nm_type,
  last_nm last_nm_type,
  middle_nm middle_nm_type,
  suffix suffix_type,
  dbyte_first_nm dbyte_first_nm_type,
  dbyte_last_nm dbyte_last_nm_type,
  gender gender_type,
  cust_type cust_type_type,
  loyalty_program loyalty_program_type,
  vip_percent vip_percent_type,
  privacy privacy_type,
  no_mail no_mail_type,
  no_call no_call_type,
  no_email no_email_type,
  no_sms no_sms_type,
  email1 email1_type,
  email2 email2_type,
  vat_num vat_num_type,
  fiscal_cd fiscal_cd_type,
  id_type id_type_type,
  doc_num doc_num_type,
  place_of_issue place_of_issue_type,
  issue_dt issue_dt_type,
  pay_type pay_type_type,
  company_id company_id_type,
  inter_cmy_cd inter_cmy_cd_type,
  status status_type,
  acct_num acct_num_type,
  birth_day birth_day_type,
  birth_month birth_month_type,
  real_birthday real_birthday_type,
  age age_type,
  referred_by referred_by_type,
  profession profession_type,
  education education_type,
  notes_1 notes_1_type,
  notes_2 notes_2_type,
  pntr_fmly_nm pntr_fmly_nm_type,
  pntr_nm pntr_nm_type,
  birth_place birth_place_type,
  spl_evt_type spl_evt_type_type,
  spl_evt_dt spl_evt_dt_type,
  children_names children_names_type,
  num_of_children num_of_children_type,
  cr_card_num_1 cr_card_num_1_type,
  cr_card_type_1 cr_card_type_1_type,
  cr_card_num_2 cr_card_num_2_type,
  cr_card_type_2 cr_card_type_2_type,
  country country_type,
  post_code post_code_type,
  state state_type,
  city city_type,
  address_line_1 address_line_1_type,
  address_line_2 address_line_2_type,
  unit_name unit_name_type,
  address_type address_type_type,
  phone_type_1 phone_type_1_type,
  phone_number_1 phone_number_1_type,
  phone_type_2 phone_type_2_type,
  phone_number_2 phone_number_2_type,
  phone_type_3 phone_type_3_type,
  phone_number_3 phone_number_3_type,
  use_as_primary_addr use_as_primary_addr_type,
  store_id store_id_type,
  company_code company_code_type,
  brand brand_type,
  associate_id associate_id_type,
  create_date create_date_type,
  comments comments_type,
  ca_store_id store_id_type,
  ca_company_code  company_code_type,
  ca_brand brand_type,
  ca_associate_id associate_id_type,
  old_customer_id old_customer_id_type,
  stg_event_id stg_event_id_type,
  stg_status stg_status_type,
  stg_error_message stg_error_message_type,
  stg_load_date stg_load_date_type,
  stg_process_date stg_load_date_type
);

    TYPE t_address_id IS TABLE OF VARCHAR2(50) INDEX BY VARCHAR2(100);

    address_id t_address_id;

    DEBUG PLS_INTEGER := 1;
        errors NUMBER;
        dml_errors EXCEPTION;
        PRAGMA EXCEPTION_INIT(dml_errors, -24381);
  -- Following procedure is called to initiate loading
  -- of all record types
  FUNCTION load_customer_data
  (
    in_interface_key IN VARCHAR2,
    in_start_time  IN VARCHAR2,
    in_file_name     IN  VARCHAR2  ) RETURN INTEGER;
PROCEDURE process_cust_rec
(
    l_record_type IN VARCHAR2,
    l_total_records_processed OUT NUMBER,
    return_code OUT VARCHAR2
);
  -- Following procedure is called by "LOAD_CUSTOMER_DATA"
  -- to load record_type "B"
  FUNCTION process_cust_rec_type_b
  (
        custOMER_rec customer_rec_type
  ) RETURN INTEGER;
  -- Following procedure is called by "LOAD_CUSTOMER_DATA"
  -- to load record_type "D"
  FUNCTION process_cust_rec_type_d
  (
    customer_rec customer_rec_type
  ) RETURN INTEGER;
  -- Following procedure is called by "LOAD_CUSTOMER_DATA"
  -- to load record_type "A"
   FUNCTION process_cust_rec_type_a
   (
    customer_rec customer_rec_type
   ) RETURN INTEGER;
  -- Following procedure is called by "LOAD_CUSTOMER_DATA"
  -- to load record_type "CC"
  FUNCTION process_cust_rec_type_cc
  (
    customer_rec customer_rec_type
  ) RETURN INTEGER;
  -- Following procedure is called by "LOAD_CUSTOMER_DATA"
  -- to load record_type "CA"
  FUNCTION process_cust_rec_type_ca
  (
    customer_rec customer_rec_type
  ) RETURN INTEGER;
  -- Following procedure is called by "LOAD_CUSTOMER_DATA"
  -- to load record_type "M"
  FUNCTION process_cust_rec_type_m
  (
    customer_rec customer_rec_type
  ) RETURN INTEGER;

END Arm_Load_Cust_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Arm_Load_Cust_Pkg IS
    ------------------------------------------------------------------------------------------------
    -- Package body --
    ------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------
    FUNCTION load_customer_data
    ------------------------------------------------------------------------------------------------
    (
        in_interface_key IN VARCHAR2,
        in_start_time  IN VARCHAR2,
        in_file_name     IN  VARCHAR2
    )
    RETURN INTEGER
    IS
    ------------------------------------------------------------------------------------------------
        return_code         PLS_INTEGER := 0;
        status          VARCHAR2(1) := '0';
        l_processed_records NUMBER      := 0;
        total_processed_records NUMBER      := 0;
        TYPE T_Rec_Type_List IS VARRAY(6) OF VARCHAR2(2);
        rec_list T_Rec_Type_List := T_Rec_Type_List('B','D','A','CC','CA','M');
    ------------------------------------------------------------------------------------------------
    -- execution --
    ------------------------------------------------------------------------------------------------
    BEGIN
        FOR i IN 1.. rec_list.COUNT LOOP
            process_cust_rec(rec_list(i), l_processed_records, return_code);
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
        --
    END load_customer_data;
    ------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------
    PROCEDURE process_cust_rec
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
    CURSOR customer_cur
    IS
    SELECT   RECORD_TYPE,
  CUSTOMER_ID,
  CUST_BARCODE,
  TITLE,
  FIRST_NM,
  LAST_NM,
  MIDDLE_NM,
  SUFFIX,
  DBYTE_FIRST_NM,
  DBYTE_LAST_NM,
  GENDER,
  CUST_TYPE,
  LOYALTY_PROGRAM,
  VIP_PERCENT,
  PRIVACY,
  NO_MAIL,
  NO_CALL,
  NO_EMAIL,
  NO_SMS,
  EMAIL1,
  EMAIL2,
  VAT_NUM,
  FISCAL_CD,
  ID_TYPE,
  DOC_NUM,
  PLACE_OF_ISSUE,
  ISSUE_DT,
  PAY_TYPE,
  COMPANY_ID,
  INTER_CMY_CD,
  STATUS,
  ACCT_NUM,
  BIRTH_DAY,
  BIRTH_MONTH,
  REAL_BIRTHDAY,
  AGE,
  REFERRED_BY,
  PROFESSION,
  EDUCATION,
  NOTES_1,
  NOTES_2,
  PNTR_FMLY_NM,
  PNTR_NM,
  BIRTH_PLACE,
  SPL_EVT_TYPE,
  SPL_EVT_DT,
  CHILDREN_NAMES,
  NUM_OF_CHILDREN,
  CR_CARD_NUM_1,
  CR_CARD_TYPE_1,
  CR_CARD_NUM_2,
  CR_CARD_TYPE_2,
  COUNTRY,
  POST_CODE,
  STATE,
  CITY,
  ADDRESS_LINE_1,
  ADDRESS_LINE_2,
  UNIT_NAME,
  ADDRESS_TYPE,
  PHONE_TYPE_1,
  PHONE_NUMBER_1,
  PHONE_TYPE_2,
  PHONE_NUMBER_2,
  PHONE_TYPE_3,
  PHONE_NUMBER_3,
  USE_AS_PRIMARY_ADDR,
  STORE_ID,
  COMPANY_CODE,
  BRAND,
  ASSOCIATE_ID,
  CREATE_DATE,
  COMMENTS,
  CA_STORE_ID,
  CA_COMPANY_CODE,
  CA_BRAND,
  CA_ASSOCIATE_ID,  
  OLD_CUSTOMER_ID,
  STG_EVENT_ID,
  STG_STATUS,
  STG_ERROR_MESSAGE,
  STG_LOAD_DATE,
  STG_PROCESS_DATE
    FROM   arm_stg_cust_in
    WHERE  ((NVL(stg_status, 0) = 0 AND stg_process_date IS NULL) OR
    (stg_status=2 AND stg_process_date IS NOT NULL))
    AND TRIM(record_type) =TRIM( l_record_type);
    i  PLS_INTEGER;
    j  PLS_INTEGER;
    l_error_index PLS_INTEGER;
    l_error_code VARCHAR2(255);
    l_error_stg_event_id PLS_INTEGER;
    l_record_count PLS_INTEGER;
    errors               PLS_INTEGER;
    --dml_errors             EXCEPTION;
    ret_code             PLS_INTEGER := 0;
    customer_rec             customer_rec_type;
    ------------------------------------------------------------------------------------------------
    -- execution --
    ------------------------------------------------------------------------------------------------
    BEGIN
        l_total_records_processed := 0;
        OPEN  customer_cur;
        LOOP
            FETCH customer_cur BULK COLLECT
            INTO    customer_rec.record_type
                , customer_rec.customer_id
                , customer_rec.cust_barcode
                , customer_rec.title
                , customer_rec.first_nm
                , customer_rec.last_nm
                , customer_rec.middle_nm
                , customer_rec.suffix
                , customer_rec.dbyte_first_nm
                , customer_rec.dbyte_last_nm
                , customer_rec.gender
                , customer_rec.cust_type
                , customer_rec.loyalty_program
                , customer_rec.vip_percent
                , customer_rec.privacy
                , customer_rec.no_mail
                , customer_rec.no_call
                , customer_rec.no_email
                , customer_rec.no_sms
                , customer_rec.email1
                , customer_rec.email2
                , customer_rec.vat_num
                , customer_rec.fiscal_cd
                , customer_rec.id_type
                , customer_rec.doc_num
                , customer_rec.place_of_issue
                , customer_rec.issue_dt
                , customer_rec.pay_type
                , customer_rec.company_id
                , customer_rec.inter_cmy_cd
                , customer_rec.status
                , customer_rec.acct_num
                , customer_rec.birth_day
                , customer_rec.birth_month
                , customer_rec.real_birthday
                , customer_rec.age
                , customer_rec.referred_by
                , customer_rec.profession
                , customer_rec.education
                , customer_rec.notes_1
                , customer_rec.notes_2
                , customer_rec.pntr_fmly_nm
                , customer_rec.pntr_nm
                , customer_rec.birth_place
                , customer_rec.spl_evt_type
                , customer_rec.spl_evt_dt
                , customer_rec.children_names
                , customer_rec.num_of_children
                , customer_rec.cr_card_num_1
                , customer_rec.cr_card_type_1
                , customer_rec.cr_card_num_2
                , customer_rec.cr_card_type_2
                , customer_rec.country
                , customer_rec.post_code
                , customer_rec.state
                , customer_rec.city
                , customer_rec.address_line_1
                , customer_rec.address_line_2
                , customer_rec.unit_name
                , customer_rec.address_type
                , customer_rec.phone_type_1
                , customer_rec.phone_number_1
                , customer_rec.phone_type_2
                , customer_rec.phone_number_2
                , customer_rec.phone_type_3
                , customer_rec.phone_number_3
                , customer_rec.use_as_primary_addr
                , customer_rec.store_id
                , customer_rec.company_code
                , customer_rec.brand
                , customer_rec.associate_id
                , customer_rec.create_date
                , customer_rec.comments
                , customer_rec.ca_store_id
                , customer_rec.ca_company_code
                , customer_rec.ca_brand
                , customer_rec.ca_associate_id
                , customer_rec.old_customer_id
                , customer_rec.stg_event_id
                , customer_rec.stg_status
                , customer_rec.stg_error_message
                , customer_rec.stg_load_date
                , customer_rec.stg_process_date
            LIMIT 1000;
            l_total_records_processed := l_total_records_processed + NVL(customer_rec.record_type.COUNT,0);
            DBMS_OUTPUT.PUT_LINE('TOTAL RECORDS PROCESSED = '||L_TOTAL_RECORDS_PROCESSED);
            IF (customer_rec.record_type.COUNT > 0) THEN
                CASE
                    WHEN (l_record_type IN ('B')) THEN
                        ret_code := process_cust_rec_type_b(customer_rec);
                    WHEN (l_record_type IN ('D')) THEN
                        ret_code := process_cust_rec_type_D(customer_rec);
                    WHEN (l_record_type IN ('A')) THEN
                        ret_code := process_cust_rec_type_A(customer_rec);
                    WHEN (l_record_type IN ('CC')) THEN
                        ret_code := process_cust_rec_type_CC(customer_rec);
                    WHEN (l_record_type IN ('CA')) THEN
                        ret_code := process_cust_rec_type_CA(customer_rec);
                    WHEN (l_record_type IN ('M')) THEN
                        ret_code := process_cust_rec_type_M(customer_rec);
                END CASE;
                IF (ret_code = 1) THEN
                    return_code := 1;
                END IF;
            END IF;
            COMMIT;
            EXIT WHEN customer_cur%NOTFOUND;
        END LOOP;
        CLOSE customer_cur;
        COMMIT;
    END process_cust_rec;
    ------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------
    FUNCTION  process_cust_rec_type_b
    ------------------------------------------------------------------------------------------------
    (
        customer_rec customer_rec_type
    )
    RETURN INTEGER
    IS
    ------------------------------------------------------------------------------------------------
    l_cnt         PLS_INTEGER := 0;
    error_msg     VARCHAR2(1000) := NULL;
    error_index   PLS_INTEGER := 0;
    error_code    VARCHAR2(10) := NULL;
    msg VARCHAR2(100);
    return_code   PLS_INTEGER := 0;
    ------------------------------------------------------------------------------------------------
    -- execution --
    ------------------------------------------------------------------------------------------------
    BEGIN

        -- Insert / Update into "PA_PRTY" table Begins --
        BEGIN
            FORALL i IN 1..customer_rec.record_type.COUNT()
            SAVE EXCEPTIONS
                MERGE INTO PA_PRTY destination
                USING (SELECT
                    customer_rec.customer_id(i) customer_id
                    , customer_rec.stg_event_id(i) stg_event_id
                    , customer_rec.stg_status(i) stg_status
                    , customer_rec.stg_error_message(i) stg_error_message
                    , customer_rec.stg_load_date(i) stg_load_date
                    , customer_rec.stg_process_date(i) stg_process_date
                FROM   dual) source
                ON (
                    destination.id_prty = source.customer_id
                )
                WHEN MATCHED THEN
                    UPDATE SET ty_prty = 'CU'
                WHEN NOT MATCHED THEN
                    INSERT (
                        id_prty
                        , ty_prty
                    )
                    VALUES (
                        source.customer_id
                        , 'CU'
                    );
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
                        , stg_error_message = stg_error_message  || '|' || '  Error INSERTING/UPDATING  PA_PRTY - ' || error_code
                        , stg_process_date = SYSDATE
                        WHERE  stg_event_id = customer_rec.stg_event_id(error_index);
                    END LOOP;
                WHEN OTHERS THEN
                    errors := SQL%BULK_EXCEPTIONS.COUNT;
                    l_cnt := l_cnt + errors;
                    return_code := 1;
                    FOR i IN 1..errors LOOP
                        error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
                        error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
                        UPDATE arm_stg_CUST_IN
                        SET      stg_status = 1
                        , stg_error_message = stg_error_message  || '|' || '  Error INSERTING/UPDATING  PA_PRTY - ' || error_code
                        , stg_process_date = SYSDATE
                        WHERE  stg_event_id = customer_rec.stg_event_id(error_index);
                    END LOOP;
        END;
        -- Insert/Update  "PA_PRTY"  table Ends --
       BEGIN
            FORALL i IN 1..customer_rec.record_type.COUNT()
            SAVE EXCEPTIONS
                INSERT  INTO PA_RO_PRTY(ID_PRTY,TY_RO_PRTY)
                  VALUES(customer_rec.customer_id(i),'CU');
       EXCEPTION
                WHEN DML_ERRORS THEN
                    errors := SQL%BULK_EXCEPTIONS.COUNT;
                    l_cnt := l_cnt + errors;
                    return_code := 1;
                    FOR i IN 1..errors LOOP
                        error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
                        error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
                        IF (error_code <> 1) THEN
                            UPDATE arm_stg_CUST_IN
                            SET      stg_status = 1
                            , stg_error_message = stg_error_message  || '|' || '  Error INSERTING   PA_RO_PRTY - ' || error_code
                            , stg_process_date = SYSDATE
                            WHERE  stg_event_id = customer_rec.stg_event_id(error_index);
                        END IF;
                    END LOOP;
       END;     
        -- Insert / Update into "PA_PRS" table Begins --
        BEGIN
            FORALL i IN 1..customer_rec.record_type.COUNT()
            SAVE EXCEPTIONS
                MERGE INTO PA_PRS destination
                USING (SELECT
                    customer_rec.customer_id(i) customer_id
                    , customer_rec.title(i) title
                    , customer_rec.first_nm(i) first_nm
                    , customer_rec.last_nm(i) last_nm
                    , customer_rec.middle_nm(i) middle_nm
                    , customer_rec.suffix(i) suffix
                    , customer_rec.dbyte_first_nm(i) dbyte_first_nm
                    , customer_rec.dbyte_last_nm(i) dbyte_last_nm
                    , customer_rec.gender(i) gender
                    , customer_rec.stg_event_id(i) stg_event_id
                    , customer_rec.stg_status(i) stg_status
                    , customer_rec.stg_error_message(i) stg_error_message
                    , customer_rec.stg_load_date(i) stg_load_date
                    , customer_rec.stg_process_date(i) stg_process_date
                FROM   dual) source
                ON (destination.ID_PRTY_PRS = source.customer_id)
                WHEN MATCHED THEN
                    UPDATE SET NM_PRS_SLN = SOURCE.TITLE,
                    FN_PRS = SOURCE.FIRST_NM,
                    LN_PRS = SOURCE.LAST_NM,
                    MN_PRS = SOURCE.MIDDLE_NM,
                    SUFFIX = SOURCE.SUFFIX,
                    DB_FN_PRS = SOURCE.DBYTE_FIRST_NM,
                    DB_LN_PRS = SOURCE.DBYTE_LAST_NM,
                    TY_GND_PRS = SOURCE.GENDER
                WHEN NOT MATCHED THEN
                    INSERT (
                        NM_PRS_SLN,
                        FN_PRS,
                        LN_PRS,
                        MN_PRS,
                        SUFFIX,
                        DB_FN_PRS,
                        DB_LN_PRS,
                        TY_GND_PRS,
                        ID_PRTY_PRS
                    )
                    VALUES (
                        SOURCE.TITLE,
                        SOURCE.FIRST_NM,
                        SOURCE.LAST_NM,
                        SOURCE.MIDDLE_NM,
                        SOURCE.SUFFIX,
                        SOURCE.DBYTE_FIRST_NM,
                        SOURCE.DBYTE_LAST_NM,
                        SOURCE.GENDER,
                        SOURCE.CUSTOMER_ID
                    );
        -- Exception section
        EXCEPTION
            WHEN DML_ERRORS THEN
                FOR j IN 1..SQL%bulk_exceptions.COUNT()
                LOOP
                    error_index := SQL%BULK_EXCEPTIONS(j).ERROR_INDEX;
                    error_code := SQL%BULK_EXCEPTIONS(j).ERROR_CODE;
                    UPDATE arm_stg_cust_in
                    SET stg_status = 1
                    , stg_error_message = stg_error_message  || '|' || ' Error INSERTING/UPDATING PA_PRS - ' || error_code
                    , stg_process_date = SYSDATE
                    WHERE  stg_event_id = customer_rec.stg_event_id(error_index);
                END LOOP;
        END;
        -- Insert/Update  "PA_PRS"  table Ends --
        -- Insert / Update into "PA_CT" table Begins --
        BEGIN
            FORALL i IN 1..customer_rec.record_type.COUNT()
            SAVE EXCEPTIONS
                MERGE INTO PA_CT destination
                USING (SELECT
                    customer_rec.cust_barcode(i) cust_barcode
                    , customer_rec.customer_id(i) customer_id
                    , customer_rec.cust_type(i) cust_type
                    , customer_rec.loyalty_program(i) loyalty_program
                    , customer_rec.vip_percent(i) vip_percent
                    , customer_rec.privacy(i) privacy
                    , customer_rec.no_mail(i) no_mail
                    , customer_rec.no_call(i) no_call
                    , customer_rec.no_email(i) no_email
                    , customer_rec.no_sms(i) no_sms
                    , customer_rec.status(i) status
                    , customer_rec.stg_event_id(i) stg_event_id
                    , customer_rec.stg_status(i) stg_status
                    , customer_rec.stg_error_message(i) stg_error_message
                    , customer_rec.stg_load_date(i) stg_load_date
                    , customer_rec.stg_process_date(i) stg_process_date
                FROM   dual) source
                ON (destination.id_ct = source.customer_id)
                WHEN MATCHED THEN
                    UPDATE SET   cust_barcode = source.cust_barcode
                        , ty_ct = source.cust_type
                        , fl_loyalty = source.loyalty_program
                        , pe_vip_disc = source.vip_percent
                        , cd_privacy = source.privacy
                        , fl_mail = source.no_mail
                        , fl_call = source.no_call
                        , fl_eml = source.no_email
                        , fl_sms = source.no_sms
                WHEN NOT MATCHED THEN
                    INSERT (
                        id_ct
                        , ty_ro_prty
                        , cust_barcode
                        , ty_ct
                        , fl_loyalty
                        , pe_vip_disc
                        , cd_privacy
                        , fl_mail
                        , fl_call
                        , fl_eml
                        , fl_sms
                        , id_prty
                    )
                    VALUES (
                        source.customer_id
                        , 'CU'
                        , source.cust_barcode
                        , source.cust_type
                        , source.loyalty_program
                        , source.vip_percent
                        , source.privacy
                        , source.no_mail
                        , source.no_call
                        , source.no_email
                        , source.no_sms
                        , source.customer_id
                    );
        -- Exception section
        EXCEPTION
            WHEN DML_ERRORS THEN
                FOR j IN 1..SQL%bulk_exceptions.COUNT()
                LOOP
                    error_index := SQL%BULK_EXCEPTIONS(j).ERROR_INDEX;
                    error_code := SQL%BULK_EXCEPTIONS(j).ERROR_CODE;
                    UPDATE arm_stg_cust_in
                    SET      stg_status = 1
                    , stg_error_message = stg_error_message  || '|' || ' Error INSERTING/UPDATING PA_CT - ' || error_code
                    , stg_process_date = SYSDATE
                    WHERE  stg_event_id = customer_rec.stg_event_id(error_index);
                END LOOP;
        END;
        -- Insert/Update  "PA_CT"  table Ends --
        -- Insert / Update into "LO_EML_ADS" table (EMAIL 1) Begins --
        BEGIN
            FORALL i IN 1..customer_rec.record_type.COUNT()
            SAVE EXCEPTIONS
                MERGE INTO LO_EML_ADS destination
                USING (SELECT
                    customer_rec.customer_id(i) customer_id
                    , 'EMAIL_1' EMAIL_TYPE
                    , customer_rec.email1(i) EMAIL_ADS
                    , customer_rec.stg_event_id(i) stg_event_id
                    , customer_rec.stg_status(i) stg_status
                    , customer_rec.stg_error_message(i) stg_error_message
                    , customer_rec.stg_load_date(i) stg_load_date
                    , customer_rec.stg_process_date(i) stg_process_date
                FROM   dual WHERE trim(customer_rec.email1(i)) IS NOT NULL
                ) source
                ON (destination.id_prty = source.customer_id
                AND destination.ty_eml_ads IN ('EMAIL_1'))
                WHEN MATCHED THEN
                    UPDATE SET em_ads = NVL(trim(source.EMAIL_ADS),em_ads)
                WHEN NOT MATCHED THEN
                    INSERT (
                        id_prty
                        , em_ads
                        , ty_eml_ads
                    )
                    VALUES (
                        source.customer_id
                        , source.EMAIL_ADS
                        , SOURCE.EMAIL_TYPE
                    );
        -- Exception section
        EXCEPTION
            WHEN DML_ERRORS THEN
                FOR j IN 1..SQL%bulk_exceptions.COUNT()
                LOOP
                    error_index := SQL%BULK_EXCEPTIONS(j).ERROR_INDEX;
                    error_code := SQL%BULK_EXCEPTIONS(j).ERROR_CODE;
                    UPDATE   arm_stg_cust_in
                    SET      stg_status = 1
                    , stg_error_message = stg_error_message  || '|' || '  Error inserting LO_EML_ADS (EMAIL1)- ' || error_code
                    , stg_process_date = SYSDATE
                    WHERE  stg_event_id = customer_rec.stg_event_id(error_index);
                END LOOP;
        END;
        -- Insert/Update "LO_EML_ADS" table (EMAIL 1) Ends --
        -- Insert / Update into "LO_EML_ADS" table (EMAIL 2) Begins --
        BEGIN
            FORALL i IN 1..customer_rec.record_type.COUNT()
            SAVE EXCEPTIONS
            MERGE INTO LO_EML_ADS destination
            USING (SELECT
                customer_rec.customer_id(i) customer_id
                , 'EMAIL_2' EMAIL_TYPE
                , customer_rec.email2(i) EMAIL_ADS
                , customer_rec.stg_event_id(i) stg_event_id
                , customer_rec.stg_status(i) stg_status
                , customer_rec.stg_error_message(i) stg_error_message
                , customer_rec.stg_load_date(i) stg_load_date
                , customer_rec.stg_process_date(i) stg_process_date
            FROM   dual WHERE trim(customer_rec.email2(i)) IS NOT NULL
            ) source
            ON (destination.id_prty = source.customer_id
            AND destination.ty_eml_ads IN ('EMAIL_2'))
            WHEN MATCHED THEN
                UPDATE SET em_ads = NVL(trim(source.EMAIL_ADS),em_ads)
            WHEN NOT MATCHED THEN
                INSERT (
                    id_prty
                    , em_ads
                    , ty_eml_ads
                )
                VALUES (
                    source.customer_id
                    , source.EMAIL_ADS
                    , SOURCE.EMAIL_TYPE
                );
        -- Exception section
        EXCEPTION
            WHEN DML_ERRORS THEN
                FOR j IN 1..SQL%bulk_exceptions.COUNT()
                LOOP
                    error_index := SQL%BULK_EXCEPTIONS(j).ERROR_INDEX;
                    error_code := SQL%BULK_EXCEPTIONS(j).ERROR_CODE;
                    return_code := 1;
                    UPDATE   arm_stg_cust_in
                    SET      stg_status = 1
                    , stg_error_message = stg_error_message  || '|' || ' Error inserting LO_EML_ADS (EMAIL2)- ' || error_code
                    , stg_process_date = SYSDATE
                    WHERE  stg_event_id = customer_rec.stg_event_id(error_index);
                END LOOP;
        END;
        -- Insert/Update "LO_EML_ADS" table (EMAIL 1) Ends --
         BEGIN
                 FORALL i IN 1..customer_rec.record_type.COUNT
                     UPDATE ARM_STG_CUST_IN
                     SET STG_PROCESS_DATE=SYSDATE,
                     STG_STATUS=0
                     WHERE STG_EVENT_ID=customer_rec.stg_event_id(i)
                     AND STG_STATUS NOT IN (1);
         END;

        RETURN return_CODE;
    END process_cust_rec_type_b;
    ------------------------------------------------------------------------------------------------
    FUNCTION  process_cust_rec_type_d
    ------------------------------------------------------------------------------------------------
    (
        customer_rec customer_rec_type
    )
    RETURN INTEGER
    IS
    ------------------------------------------------------------------------------------------------
    l_cnt         PLS_INTEGER := 0;
    error_msg     VARCHAR2(1000) := NULL;
    error_index   PLS_INTEGER := 0;
    error_code    VARCHAR2(10) := NULL;
    msg VARCHAR2(100);
    return_code   PLS_INTEGER := 0;
    acct_num	  VARCHAR2(50) := null;

    ------------------------------------------------------------------------------------------------
    -- execution --
    ------------------------------------------------------------------------------------------------
    BEGIN
        -- Insert / Update into "ARM_CT_DTL" table Begins --
        BEGIN
        FORALL i IN 1..customer_rec.record_type.COUNT()
        SAVE EXCEPTIONS
            MERGE INTO ARM_CT_DTL destination
            USING (SELECT customer_rec.customer_id(i) customer_id
                , customer_rec.vat_num(i) vat_num
                , customer_rec.fiscal_cd(i) fiscal_cd
                , customer_rec.id_type(i) id_type
                , customer_rec.doc_num(i) doc_num
                , customer_rec.place_of_issue(i) place_of_issue
                , customer_rec.issue_dt(i) issue_dt
                , customer_rec.pay_type(i) pay_type
                , customer_rec.company_id(i) company_id
                , customer_rec.inter_cmy_cd(i) inter_cmy_cd
                , customer_rec.status(i) status
                , customer_rec.acct_num(i) acct_num
                , customer_rec.birth_day(i) birth_day
                , customer_rec.birth_month(i) birth_month
                , customer_rec.real_birthday(i) real_birthday
                , customer_rec.age(i) age
                , customer_rec.referred_by(i) referred_by
                , customer_rec.profession(i) profession
                , customer_rec.education(i) education
                , customer_rec.notes_1(i) notes_1
                , customer_rec.notes_2(i) notes_2
                , customer_rec.pntr_fmly_nm(i) pntr_fmly_nm
                , customer_rec.pntr_nm(i) pntr_nm
                , customer_rec.birth_place(i) birth_place
                , customer_rec.spl_evt_type(i) spl_evt_type
                , customer_rec.spl_evt_dt(i) spl_evt_dt
                , customer_rec.children_names(i) children_names
                , customer_rec.num_of_children(i) num_of_children
                , customer_rec.cr_card_num_1(i) cr_card_num_1
                , customer_rec.cr_card_type_1(i) cr_card_type_1
                , customer_rec.cr_card_num_2(i) cr_card_num_2
                , customer_rec.cr_card_type_2(i) cr_card_type_2
                , customer_rec.stg_event_id(i) stg_event_id
                , customer_rec.stg_status(i) stg_status
                , customer_rec.stg_error_message(i) stg_error_message
                , customer_rec.stg_load_date(i) stg_load_date
                , customer_rec.stg_process_date(i) stg_process_date
            FROM   dual) source
            ON (destination.id_ct = source.customer_id)
            WHEN MATCHED THEN
                UPDATE SET   vat_num = source.vat_num
                , fiscal_code = source.fiscal_cd
                , id_type = source.id_type
                , doc_num = source.doc_num
                , place_of_issue = source.place_of_issue
                , issue_dt = source.issue_dt
                , ty_pay = source.pay_type
                , id_cmy = source.company_id
                , cd_inter_cmy = source.inter_cmy_cd
                , acct_num = source.acct_num
                , age = source.age
                , referred_by = source.referred_by
                , profession = source.profession
                , education = source.education
                , notes1 = source.notes_1
                , notes2 = source.notes_2
                , nm_ptnr_fam = source.pntr_fmly_nm
                , nm_ptnr = source.pntr_nm
                , birth_place = source.birth_place
                , ty_spl_evt = source.spl_evt_type
                , dc_spl_evt = source.spl_evt_dt
                , nm_chld = source.children_names
                , chld_num = source.num_of_children
                , CRDT_CRD_NUM_1=source.cr_card_num_1
                , CRDT_CRD_TYP_1=source.cr_card_type_1
                , CRDT_CRD_NUM_2=source.cr_card_num_2
                , CRDT_CRD_TYP_2=source.cr_card_type_2
            WHEN NOT MATCHED THEN
                INSERT (
                    id_ct
                    , vat_num
                    , fiscal_code
                    , id_type
                    , doc_num
                    , place_of_issue
                    , issue_dt
                    , ty_pay
                    , id_cmy
                    , cd_inter_cmy
                    , acct_num
                    , age
                    , referred_by
                    , profession
                    , education
                    , notes1
                    , notes2
                    , nm_ptnr_fam
                    , nm_ptnr
                    , birth_place
                    , ty_spl_evt
                    , dc_spl_evt
                    , nm_chld
                    , chld_num
                    , CRDT_CRD_NUM_1
                    , CRDT_CRD_TYP_1
                    , CRDT_CRD_NUM_2
                    , CRDT_CRD_TYP_2
                )
                VALUES (
                    source.customer_id
                    , source.vat_num
                    , source.fiscal_cd
                    , source.id_type
                    , source.doc_num
                    , source.place_of_issue
                    , source.issue_dt
                    , source.pay_type
                    , source.company_id
                    , source.inter_cmy_cd
                    , source.acct_num
                    , source.age
                    , source.referred_by
                    , source.profession
                    , source.education
                    , source.notes_1
                    , source.notes_2
                    , source.pntr_fmly_nm
                    , source.pntr_nm
                    , source.birth_place
                    , source.spl_evt_type
                    , source.spl_evt_dt
                    , source.children_names
                    , source.num_of_children
                    , source.cr_card_num_1
                    , source.cr_card_type_1
                    , source.cr_card_num_2
                    , source.cr_card_type_2
                );
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
                    , stg_error_message = stg_error_message  || '|' || '  Error INSERTING/UPDATING  ARM_CT_DTL - ' || error_code
                     , stg_process_date = SYSDATE
                    WHERE  stg_event_id = customer_rec.stg_event_id(error_index);
                END LOOP;
        END;
        -- Insert/Update  "ARM_CT_DTL"  table Ends --
        -- Update into "PA_CT" table Begins --
        BEGIN
            FORALL i IN 1..customer_rec.record_type.COUNT() SAVE EXCEPTIONS
                UPDATE PA_CT
                SET SC_CT=CUSTOMER_REC.STATUS(i)
                WHERE ID_CT=CUSTOMER_REC.CUSTOMER_ID(i);
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
                    SET stg_status = 1
                    , stg_error_message = stg_error_message  || '|' || '  Error UPDATING PA_CT - ' || error_code
                    , stg_process_date = SYSDATE
                    WHERE stg_event_id = customer_rec.stg_event_id(error_index);
                END LOOP;
        END;
        -- Update  "PA_CT" table Ends --
        -- Update into "PA_PRS" table Begins --
        BEGIN
            FORALL i IN 1..customer_rec.record_type.COUNT() SAVE EXCEPTIONS
                UPDATE PA_PRS
                SET DC_PRS_BRT=CUSTOMER_REC.real_birthday(I)
                WHERE ID_PRTY_PRS=CUSTOMER_REC.CUSTOMER_ID(i);
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
                    SET stg_status = 1
                    , stg_error_message = stg_error_message  || '|' || '  Error UPDATING PA_PRS - ' || error_code
                    , stg_process_date = SYSDATE
                    WHERE stg_event_id = customer_rec.stg_event_id(error_index);
                END LOOP;
        END;
        -- Update into "DO_CF_GF" table Begins --
        BEGIN
            FOR i IN 1..customer_rec.record_type.COUNT() LOOP
				  BEGIN	 
					   SELECT ID_NMB_SRZ_GF_CF INTO acct_num FROM DO_CF_GF WHERE ID_NMB_SRZ_GF_CF = customer_rec.acct_num(i)
					   AND TY_GF_CF='HOUSE_ACCOUNT' AND customer_rec.acct_num(i) IS NOT NULL;
					   UPDATE DO_CF_GF
					   SET ID_CT=CUSTOMER_REC.CUSTOMER_ID(i)
					   WHERE ID_NMB_SRZ_GF_CF=customer_rec.acct_num(i)
					   AND TY_GF_CF='HOUSE_ACCOUNT'; 
		        -- Exception section
		        EXCEPTION
		            WHEN NO_DATA_FOUND THEN
		                    UPDATE arm_stg_CUST_IN
		                    SET stg_status = 1
		                    , stg_error_message = stg_error_message  || '|' || '  Error UPDATING DO_CF_GF (Redeemable does not exist)  - ' || error_code
		                    , stg_process_date = SYSDATE
		                    WHERE stg_event_id = customer_rec.stg_event_id(i);
		        END;
			END LOOP;		
	END;			

        -- Update  "ARM_STG_CUST_IN" table Ends --
         BEGIN
                 FORALL i IN 1..customer_rec.record_type.COUNT
                     UPDATE ARM_STG_CUST_IN
                     SET STG_PROCESS_DATE=SYSDATE,
                     STG_STATUS=0
                     WHERE STG_EVENT_ID=customer_rec.stg_event_id(i)
                     AND STG_STATUS NOT IN (1);
         END;

        RETURN return_CODE;
    END process_cust_rec_type_d;
    ------------------------------------------------------------------------------------------------
    FUNCTION  process_cust_rec_type_a
    ------------------------------------------------------------------------------------------------
    (
        customer_rec customer_rec_type
    )
    RETURN INTEGER
    IS
    ------------------------------------------------------------------------------------------------
    l_cnt         PLS_INTEGER := 0;
    error_msg     VARCHAR2(1000) := NULL;
    error_index   PLS_INTEGER := 0;
    error_code    VARCHAR2(10) := NULL;
    msg VARCHAR2(100);
    return_code   PLS_INTEGER := 0;
    TYPE t_arr_ads_id IS TABLE OF VARCHAR2(128) INDEX BY BINARY_INTEGER;
    arr_ads_id t_arr_ads_id;
    l_ads_id VARCHAR2(128) := NULL;

    ------------------------------------------------------------------------------------------------
    -- execution --
    ------------------------------------------------------------------------------------------------
    BEGIN
        FOR i IN 1..customer_rec.record_type.COUNT() LOOP
            l_ads_id := NULL;
            BEGIN
                l_ads_id := address_id(CUSTOMER_REC.CUSTOMER_ID(i)||CUSTOMER_REC.ADDRESS_TYPE(i));          
                arr_ads_id(i) := l_ads_id;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    begin 
                        SELECT LO_ADS_PRTY.id_ADS INTO l_ads_id
                        FROM LO_ADS_PRTY WHERE LO_ADS_PRTY.ID_PRTY=CUSTOMER_REC.CUSTOMER_ID(i)
                        AND TY_RO_PRTY='CU' AND TY_ADS=CUSTOMER_REC.ADDRESS_TYPE(i);
                            arr_ads_id(i) := l_ads_id;
                            address_id(CUSTOMER_REC.CUSTOMER_ID(i)||CUSTOMER_REC.ADDRESS_TYPE(i)) := l_ads_id;
                    exception
                        when no_data_found then                 
                            SELECT CHELSEAID.NEXTVAL INTO l_ads_id FROM DUAL;
                            arr_ads_id(i) := l_ads_id;
                            address_id(CUSTOMER_REC.CUSTOMER_ID(i)||CUSTOMER_REC.ADDRESS_TYPE(i)) := l_ads_id;
                    end;        
            END;
        END LOOP;


        -- Insert / Update into "LO_ADS/LO_ADS_PRTY" table Begins --
        BEGIN
            FORALL i IN 1..customer_rec.record_type.COUNT() SAVE EXCEPTIONS
                INSERT ALL
                    INTO LO_ADS(ID_ADS)
                    VALUES(ADDR_ID)
                    INTO LO_ADS_PRTY(ID_ADS, ID_PRTY, TY_RO_PRTY, TY_ADS)
                    VALUES(ADDR_ID, CUSTOMER_ID, 'CU', ADDRESS_TYPE)
                    SELECT arr_ads_id(i) ADDR_ID, CUSTOMER_REC.CUSTOMER_ID(i) customer_id,
                    CUSTOMER_REC.ADDRESS_TYPE(i) ADDRESS_TYPE FROM DUAL;
            -- Exception section
            EXCEPTION
                WHEN DML_ERRORS THEN
                    errors := SQL%BULK_EXCEPTIONS.COUNT;
                    l_cnt := l_cnt + errors;
                    return_code := 1;
                    FOR i IN 1..errors LOOP
                        error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
                        error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
                        IF (ERROR_CODE <> 1) THEN
                            UPDATE arm_stg_CUST_IN
                            SET      stg_status = 1
                            , stg_error_message = stg_error_message  || '|' || '  Error INSERTING LO_ADS/LO_ADS_PRTY - ' || error_code
                            , stg_process_date = SYSDATE
                            WHERE  stg_event_id = customer_rec.stg_event_id(error_index);
                        END IF;
                    END LOOP;
                WHEN OTHERS THEN
                    errors := SQL%BULK_EXCEPTIONS.COUNT;
                    l_cnt := l_cnt + errors;
                    return_code := 1;
                    FOR i IN 1..errors LOOP
                        error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
                        error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
                        IF (ERROR_CODE <> 1) THEN
                            UPDATE arm_stg_CUST_IN
                            SET      stg_status = 1
                            , stg_error_message = stg_error_message  || '|' || '  Error INSERTING LO_ADS/LO_ADS_PRTY - ' || error_code
                            , stg_process_date = SYSDATE
                            WHERE  stg_event_id = customer_rec.stg_event_id(error_index);
                        END IF;
                    END LOOP;
        END;
        -- Insert/Update  "LO_ADS/LO_ADS_PRTY"  table Ends --
        -- Insert / Update into "LO_ADS_NSTD" table Begins --
        BEGIN
            FORALL i IN 1..customer_rec.record_type.COUNT()
            SAVE EXCEPTIONS
                MERGE INTO LO_ADS_NSTD destination
                USING (SELECT
                    customer_rec.customer_id(i) customer_id
                    , customer_rec.country(i) country
                    , customer_rec.post_code(i) post_code
                    , customer_rec.state(i) state
                    , customer_rec.city(i) city
                    , customer_rec.address_line_1(i) address_line_1
                    , customer_rec.address_line_2(i) address_line_2
                    , customer_rec.unit_name(i) unit_name
                    , customer_rec.address_type(i) address_type
                    , arr_ads_id(i) address_id
                    , customer_rec.use_as_primary_addr(i) use_as_primary_addr
                    , customer_rec.stg_event_id(i) stg_event_id
                    , customer_rec.stg_status(i) stg_status
                    , customer_rec.stg_error_message(i) stg_error_message
                    , customer_rec.stg_load_date(i) stg_load_date
                    , customer_rec.stg_process_date(i) stg_process_date
                FROM   dual) source
                ON (
                    destination.ID_ADS = source.ADDRESS_ID
                )
                WHEN MATCHED THEN
                    UPDATE SET CO_NM=source.country,
                    PC_NM=source.post_code,
                    TE_NM=source.state,
                    MU_NM=source.unit_name,
                    A1_ADS=source.address_line_1,
                    A2_ADS=source.address_line_2,
                    NM_UN=source.city,
                    FL_PRMY_ADS=source.use_as_primary_addr
                WHEN NOT MATCHED THEN
                    INSERT (
                        ID_ADS,
                        CO_NM,
                        PC_NM,
                        TE_NM,
                        MU_NM,
                        A1_ADS,
                        A2_ADS,
                        NM_UN,
                        FL_PRMY_ADS
                    )
                    VALUES (
                        source.address_id,
                        source.country,
                        source.post_code,
                        source.state,
                        source.unit_name,
                        source.address_line_1,
                        source.address_line_2,
                        source.city,
                        source.use_as_primary_addr
                    );
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
                        , stg_error_message = stg_error_message  || '|' || '  Error MERGING LO_ADS_NSTD - ' || error_code
                        , stg_process_date = SYSDATE
                        WHERE  stg_event_id = customer_rec.stg_event_id(error_index);
                    END LOOP;
                WHEN OTHERS THEN
                    errors := SQL%BULK_EXCEPTIONS.COUNT;
                    l_cnt := l_cnt + errors;
                    return_code := 1;
                    FOR i IN 1..errors LOOP
                        error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
                        error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
                        UPDATE arm_stg_CUST_IN
                        SET      stg_status = 1
                        , stg_error_message = stg_error_message  || '|' || '  Error MERGING LO_ADS_NSTD - ' || error_code
                        , stg_process_date = SYSDATE
                        WHERE  stg_event_id = customer_rec.stg_event_id(error_index);
                    END LOOP;

        END;
        -- Insert/Update  "LO_ADS_NSTD"  table Ends --
        -- Insert/Update into "ARM_ADS_PH" table Begins --
        BEGIN
            FORALL i IN 1..customer_rec.record_type.COUNT()
            SAVE EXCEPTIONS
                MERGE INTO ARM_ADS_PH destination
                USING (SELECT
                        customer_rec.customer_id(i) customer_id
                        , customer_rec.PHONE_TYPE_1(i) phone_type
                        , customer_rec.PHONE_NUMBER_1(i) phone_number
                        , arr_ads_id(i) addr_id
                    FROM   dual WHERE TRIM(customer_rec.PHONE_NUMBER_1(i)) IS NOT NULL
                    UNION
                    SELECT
                        customer_rec.customer_id(i) customer_id
                        , customer_rec.PHONE_TYPE_2(i) phone_type
                        , customer_rec.PHONE_NUMBER_2(i) phone_number
                        , arr_ads_id(i) addr_id
                    FROM DUAL WHERE TRIM(customer_rec.PHONE_NUMBER_2(i)) IS NOT NULL
                    UNION
                    SELECT
                        customer_rec.customer_id(i) customer_id
                        , customer_rec.PHONE_TYPE_3(i) phone_type
                        , customer_rec.PHONE_NUMBER_3(i) phone_number
                        , arr_ads_id(i) addr_id
                    FROM DUAL WHERE TRIM(customer_rec.PHONE_NUMBER_3(i)) IS NOT NULL
                    ) source
                ON (
                    destination.ID_ADS = SOURCE.ADDR_ID
                    AND destination.id_ph_typ = SOURCE.PHONE_TYPE
                )
                WHEN MATCHED THEN
                    UPDATE SET TL_PH=SOURCE.PHONE_NUMBER
                WHEN NOT MATCHED THEN
                    INSERT (
                        ID_ADS,
                        ID_PH_TYP,
                        TL_PH
                    )
                    VALUES (
                        SOURCE.ADDR_ID,
                        SOURCE.PHONE_TYPE,
                        SOURCE.PHONE_NUMBER
                    );
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
                        , stg_error_message = stg_error_message  || '|' || '  Error MERGING ARM_ADS_PH - ' || error_code
                        , stg_process_date = SYSDATE
                        WHERE  stg_event_id = customer_rec.stg_event_id(error_index);
                    END LOOP;
        END;
        -- Insert/Update  "ARM_ADS_PH"  table Ends --
         BEGIN
                 FORALL i IN 1..customer_rec.record_type.COUNT
                     UPDATE ARM_STG_CUST_IN
                     SET STG_PROCESS_DATE=SYSDATE,
                     STG_STATUS=0
                     WHERE STG_EVENT_ID=customer_rec.stg_event_id(i)
                     AND STG_STATUS NOT IN (1);
         END;

        RETURN return_CODE;
    END process_cust_rec_type_a;
    ------------------------------------------------------------------------------------------------
    FUNCTION  process_cust_rec_type_CC
    ------------------------------------------------------------------------------------------------
    (
        customer_rec customer_rec_type
    )
    RETURN INTEGER
    IS
    ------------------------------------------------------------------------------------------------
    l_cnt         PLS_INTEGER := 0;
    error_msg     VARCHAR2(1000) := NULL;
    error_index   PLS_INTEGER := 0;
    error_code    VARCHAR2(10) := NULL;
    msg VARCHAR2(100);
    return_code   PLS_INTEGER := 0;
    ------------------------------------------------------------------------------------------------
    -- execution --
    ------------------------------------------------------------------------------------------------
    BEGIN
        -- Insert / Update into "ARM_CT_COMMENTS" table Begins --
        BEGIN
        FORALL i IN 1..customer_rec.record_type.COUNT()
        SAVE EXCEPTIONS
            INSERT INTO ARM_CT_COMMENTS (
                id_ct,
                id_str_rt,
                id_cmy,
                id_brn,
                id_associate,
                create_dt,
                comments,
                ID_CT_COMMENT
            )
            VALUES (
                customer_rec.customer_id(i)
                , customer_rec.store_id(i)
                , customer_rec.company_code(i)
                , customer_rec.brand(i)
                , customer_rec.associate_id(i)
                , customer_rec.create_date(i)
                , customer_rec.comments(i)
                , CHELSEAID.NEXTVAL
            );
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
                    , stg_error_message = stg_error_message  || '|' || '  Error INSERTING ARM_CT_COMMENTS - ' || error_code
                     , stg_process_date = SYSDATE
                    WHERE  stg_event_id = customer_rec.stg_event_id(error_index);
                END LOOP;
        END;
        -- Insert/Update  "ARM_CT_COMMENTS"  table Ends --
         BEGIN
                 FORALL i IN 1..customer_rec.record_type.COUNT
                     UPDATE ARM_STG_CUST_IN
                     SET STG_PROCESS_DATE=SYSDATE,
                     STG_STATUS=0
                     WHERE STG_EVENT_ID=customer_rec.stg_event_id(i)
                     AND STG_STATUS NOT IN (1);
         END;

        RETURN return_code;
    END process_cust_rec_type_CC;
    ------------------------------------------------------------------------------------------------
    FUNCTION  process_cust_rec_type_CA
    ------------------------------------------------------------------------------------------------
    (
        customer_rec customer_rec_type
    )
    RETURN INTEGER
    IS
    ------------------------------------------------------------------------------------------------
    l_cnt         PLS_INTEGER := 0;
    error_msg     VARCHAR2(1000) := NULL;
    error_index   PLS_INTEGER := 0;
    error_code    VARCHAR2(10) := NULL;
    msg VARCHAR2(100);
    return_code   PLS_INTEGER := 0;
    ------------------------------------------------------------------------------------------------
    -- execution --
    ------------------------------------------------------------------------------------------------
    BEGIN
        -- Insert / Update into "ARM_CT_ASSOC" table Begins --
        BEGIN
        FORALL i IN 1..customer_rec.record_type.COUNT()  SAVE EXCEPTIONS
            MERGE INTO ARM_CT_ASSOC destination
            USING (SELECT
                customer_rec.customer_id(i) customer_id
                , customer_rec.CA_store_id(i) store_id
                , customer_rec.CA_associate_id(i) associate_id
            FROM   dual) source
            ON (destination.id_ct = source.customer_id
            AND destination.id_str_rt = source.store_id )
            WHEN MATCHED THEN
                UPDATE SET
                id_associate = source.associate_id
            WHEN NOT MATCHED THEN
                INSERT (
                    id_ct,
                    id_str_rt,
                    id_associate,
                    ID_CT_ASSOCIATE
                )
                VALUES (
                    source.customer_id
                    , source.store_id
                    , source.associate_id
                    ,CHELSEAID.NEXTVAL
                );
        -- Exception section
        EXCEPTION
            WHEN DML_ERRORS THEN
                errors := SQL%BULK_EXCEPTIONS.COUNT;
                l_cnt := l_cnt + errors;
                return_code := 1;
                FOR i IN 1..errors LOOP
                    error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
                    error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
                    UPDATE arm_stg_cust_in
                    SET  stg_status = 1
                    , stg_error_message = stg_error_message  || '|' || '  Error MERGING ARM_CT_ASSOC - ' || error_code
                    , stg_process_date = SYSDATE
                    WHERE  stg_event_id = customer_rec.stg_event_id(error_index);
                END LOOP;
            WHEN OTHERS THEN
                errors := SQL%BULK_EXCEPTIONS.COUNT;
                l_cnt := l_cnt + errors;
                return_code := 1;
                FOR i IN 1..errors LOOP
                    error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
                    error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
                    UPDATE arm_stg_cust_in
                    SET  stg_status = 1
                    , stg_error_message = stg_error_message  || '|' || '  Error MERGING ARM_CT_ASSOC - ' || error_code
                    , stg_process_date = SYSDATE
                    WHERE  stg_event_id = customer_rec.stg_event_id(error_index);
                END LOOP;
        END;
        -- Insert/Update  "ARM_CT_ASSOC"  table Ends --
         BEGIN
                 FORALL i IN 1..customer_rec.record_type.COUNT
                     UPDATE ARM_STG_CUST_IN
                     SET STG_PROCESS_DATE=SYSDATE,
                     STG_STATUS=0
                     WHERE STG_EVENT_ID=customer_rec.stg_event_id(i)
                     AND STG_STATUS NOT IN (1);
         END;

        RETURN return_code;
    END process_cust_rec_type_CA;
    ------------------------------------------------------------------------------------------------
    FUNCTION  process_cust_rec_type_m
    ------------------------------------------------------------------------------------------------
    (
        customer_rec customer_rec_type
    )
    RETURN INTEGER
    IS
    ------------------------------------------------------------------------------------------------
    l_cnt         PLS_INTEGER := 0;
    error_msg     VARCHAR2(1000) := NULL;
    error_index   PLS_INTEGER := 0;
    error_code    VARCHAR2(10) := NULL;
    msg VARCHAR2(100);
    return_code   PLS_INTEGER := 0;
    ------------------------------------------------------------------------------------------------
    -- execution --
    ------------------------------------------------------------------------------------------------
    BEGIN
        -- Update "PA_CT" table Begins --
        BEGIN
        FORALL i IN 1..customer_rec.record_type.COUNT()
        SAVE EXCEPTIONS
            UPDATE PA_CT
            SET SC_CT='D'
            WHERE ID_CT=customer_rec.old_customer_id(i);
        -- Exception section
        EXCEPTION
            WHEN DML_ERRORS THEN
                errors := SQL%BULK_EXCEPTIONS.COUNT;
                l_cnt := l_cnt + errors;
                return_code := 1;
                FOR i IN 1..errors LOOP
                    error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
                    error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
                    UPDATE arm_stg_cust_in
                    SET  stg_status = 1
                    , stg_error_message = stg_error_message  || '|' || '  Error UPDATING PA_CT - ' || error_code
                    , stg_process_date = SYSDATE
                    WHERE  stg_event_id = customer_rec.stg_event_id(error_index);
                END LOOP;
        END;
        -- Update "PA_CT"  table Ends --
        -- Update "TR_RTL" table Begins --
        BEGIN
            FORALL i IN 1..customer_rec.record_type.COUNT()
            SAVE EXCEPTIONS
                UPDATE TR_RTL
                SET ID_CT=customer_rec.customer_id(i)
                WHERE ID_CT=customer_rec.old_customer_id(i);
            -- Exception section
            EXCEPTION
                WHEN DML_ERRORS THEN
                    errors := SQL%BULK_EXCEPTIONS.COUNT;
                    l_cnt := l_cnt + errors;
                    return_code := 1;
                    FOR i IN 1..errors LOOP
                        error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
                        error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
                        UPDATE arm_stg_cust_in
                        SET  stg_status = 1
                        , stg_error_message = stg_error_message  || '|' || '  Error UPDATING TR_RTL - ' || error_code
                        , stg_process_date = SYSDATE
                        WHERE  stg_event_id = customer_rec.stg_event_id(error_index);
                    END LOOP;
        END;
        -- Update "TR_RTL"  table Ends --
        -- Update "RK_PAY_TRN" table Begins --
        BEGIN
            FORALL i IN 1..customer_rec.record_type.COUNT()
            SAVE EXCEPTIONS
                UPDATE RK_PAY_TRN
                SET CUST_ID=customer_rec.customer_id(i)
                WHERE CUST_ID=customer_rec.old_customer_id(i);
            -- Exception section
            EXCEPTION
                WHEN DML_ERRORS THEN
                    errors := SQL%BULK_EXCEPTIONS.COUNT;
                    l_cnt := l_cnt + errors;
                    return_code := 1;
                    FOR i IN 1..errors LOOP
                        error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
                        error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
                        UPDATE arm_stg_cust_in
                        SET  stg_status = 1
                        , stg_error_message = stg_error_message  || '|' || '  Error UPDATING RK_PAY_TRN - ' || error_code
                        , stg_process_date = SYSDATE
                        WHERE  stg_event_id = customer_rec.stg_event_id(error_index);
                    END LOOP;
        END;
        -- Update "RK_PAY_TRN"  table Ends --
        -- Update "ARM_CT_XREF" table Begins --
        BEGIN
            FORALL i IN 1..customer_rec.record_type.COUNT()
                INSERT INTO ARM_CT_XREF(ID_CT, OLD_ID_CT, EFFECTIVE_DT)
                VALUES (CUSTOMER_REC.CUSTOMER_ID(i), CUSTOMER_REC.OLD_CUSTOMER_id(i), SYSDATE);

        END;
        -- Update "ARM_CT_XREF"  table Ends --
         BEGIN
                 FORALL i IN 1..customer_rec.record_type.COUNT
                     UPDATE ARM_STG_CUST_IN
                     SET STG_PROCESS_DATE=SYSDATE,
                     STG_STATUS=0
                     WHERE STG_EVENT_ID=customer_rec.stg_event_id(i)
                     AND STG_STATUS NOT IN (1);
         END;

        RETURN return_code;
    END process_cust_rec_type_m;

END Arm_Load_Cust_Pkg;
/

