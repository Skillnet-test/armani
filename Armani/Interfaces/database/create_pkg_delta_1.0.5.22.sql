CREATE OR REPLACE PACKAGE Arm_Load_Data_Pkg IS
------------------------------------------------------------------------------------------------
-- This package is used to load data from the staging tables into the base tables.
------------------------------------------------------------------------------------------------

l_success VARCHAR2(10) := '0' ;
l_failure VARCHAR2(10) := '1' ;


  -- Following procedure loads currency rates.
  PROCEDURE load_currency_rt
  (
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
  );

  -- Following procedure loads registers.
  PROCEDURE load_register
  (
      in_interface_key  IN  VARCHAR2
    , in_start_time     IN  VARCHAR2
    , in_file_name      IN  VARCHAR2
    ,  return_status OUT VARCHAR2
    , return_message OUT VARCHAR2
  );

  -- Following procedure loads tax rates.
  PROCEDURE load_tax_rate
  (
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
  );

  -- Following procedure loads inventory information for an item.
  PROCEDURE load_inventory
  (
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
  );

PROCEDURE Load_Redeemable
(
    in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
);

-- Following procedure loads tax free.
PROCEDURE load_tax_free
(
      in_interface_key  IN  VARCHAR2
    , in_start_time     IN  VARCHAR2
    , in_file_name      IN  VARCHAR2
    , return_status  OUT VARCHAR2
    , return_message OUT VARCHAR2
);

-- Following procedure loads fiscal doc number
PROCEDURE load_fiscal_doc_no
(
      in_interface_key  IN  VARCHAR2
    , in_start_time     IN  VARCHAR2
    , in_file_name      IN  VARCHAR2
    , return_status  OUT VARCHAR2
    , return_message OUT VARCHAR2
);

END Arm_Load_Data_Pkg;
/
CREATE OR REPLACE PACKAGE BODY Arm_Load_Data_Pkg IS
------------------------------------------------------------------------------------------------
-- Package body --
------------------------------------------------------------------------------------------------

bulk_errors EXCEPTION;
PRAGMA EXCEPTION_INIT ( bulk_errors, -24381 );



------------------------------------------------------------------------------------------------
PROCEDURE load_currency_rt
------------------------------------------------------------------------------------------------
(
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
)
IS
------------------------------------------------------------------------------------------------
-- declarations --
------------------------------------------------------------------------------------------------
CURSOR currency_cur
IS
SELECT   from_currency
       , to_currency
       , currency_rate
       , update_date
       , stg_event_id
FROM   ARM_STG_CURRENCY_RT
WHERE  NVL(stg_status,0) IN (0,2);

TYPE from_currency_type IS TABLE OF ARM_STG_CURRENCY_RT.from_currency%TYPE;
TYPE to_currency_type IS TABLE OF ARM_STG_CURRENCY_RT.to_currency%TYPE;
TYPE currency_rate_type IS TABLE OF ARM_STG_CURRENCY_RT.currency_rate%TYPE;
TYPE update_date_type IS TABLE OF ARM_STG_CURRENCY_RT.update_date%TYPE;
TYPE stg_event_id_type IS TABLE OF ARM_STG_CURRENCY_RT.stg_event_id%TYPE;

TYPE currency_rec_type IS RECORD (
      from_currency from_currency_type
    , to_currency to_currency_type
    , currency_rate currency_rate_type
    , update_date update_date_type
    , stg_event_id stg_event_id_type
);

currency_rec currency_rec_type;

i  PLS_INTEGER;
j  PLS_INTEGER;
l_error_index PLS_INTEGER;
l_error_code VARCHAR2(255);
l_error_stg_event_id PLS_INTEGER;
l_num_records_processed NUMBER;
l_sqlerrm VARCHAR2(500);
------------------------------------------------------------------------------------------------
-- execution --
------------------------------------------------------------------------------------------------
BEGIN

    -- Backup the existing table.
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE ARM_CURRENCY_RATE_BKP';
        --
        EXCEPTION WHEN OTHERS THEN NULL;
    END;

    EXECUTE IMMEDIATE 'CREATE TABLE ARM_CURRENCY_RATE_BKP
                       AS SELECT * FROM ARM_CURRENCY_RATE';

    --  Delete all data before inserting.
    BEGIN
        DELETE FROM ARM_CURRENCY_RATE;
        --
        EXCEPTION
            WHEN OTHERS THEN
                return_status := l_failure;
                return_message := SQLERRM;
    END;

    COMMIT;

    OPEN  currency_cur;
    FETCH currency_cur BULK COLLECT
    INTO    currency_rec.from_currency
          , currency_rec.to_currency
          , currency_rec.currency_rate
          , currency_rec.update_date
          , currency_rec.stg_event_id
    ;
    CLOSE currency_cur;

    BEGIN
        UPDATE arm_stg_currency_rt
        SET  stg_process_date = SYSDATE;
        --
        EXCEPTION WHEN OTHERS THEN NULL;
    END;

    l_num_records_processed := currency_rec.from_currency.COUNT();

    COMMIT;


    BEGIN
    FORALL i IN 1..currency_rec.from_currency.COUNT()
        save EXCEPTIONS
            INSERT INTO ARM_CURRENCY_RATE
            (
                  id_cny_from
                , id_cny_to
                , mo_rt_to_buy
                , update_dt
            )
            VALUES
            (
                  currency_rec.from_currency(i)
                , currency_rec.to_currency(i)
                , currency_rec.currency_rate(i)
                , TO_DATE(currency_rec.update_date(i),'YYYYMMDD')
            );

        -- Exception section
        EXCEPTION
        WHEN bulk_errors THEN
            FOR j IN 1..SQL%bulk_exceptions.COUNT()
            LOOP
                l_error_index := SQL%BULK_EXCEPTIONS(j).ERROR_INDEX;
                l_error_code := SQL%BULK_EXCEPTIONS(j).ERROR_CODE;
                l_error_stg_event_id := currency_rec.stg_event_id(l_error_index);
                UPDATE ARM_STG_CURRENCY_RT
                SET      stg_status = 1
                       , stg_error_message = stg_error_message || '  Error inserting ARM_CURRENCY_RATE - ' || l_error_code
                       , STG_PROCESS_DATE = SYSDATE
                WHERE  stg_event_id = l_error_stg_event_id;
            END LOOP;
            return_status := l_failure;
            return_message := 'BULK_ERRORS encountered';
            COMMIT;
        WHEN OTHERS THEN
            l_sqlerrm := SQLERRM;
            return_status := '1';
            return_message := SQLERRM;
            COMMIT;
    END;

    IF ( NVL(return_status,'A') != l_failure )
    THEN
        return_status := '0';
        return_message := '';
    END IF;


    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE ARM_CURRENCY_RATE_BKP';
        --
        EXCEPTION WHEN OTHERS THEN NULL;
    END;

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
             , return_status
             , l_num_records_processed
             , in_file_name
         );

     END;

    --
    --

    COMMIT;

END load_currency_rt;


------------------------------------------------------------------------------------------------
PROCEDURE load_register
------------------------------------------------------------------------------------------------
(
      in_interface_key  IN  VARCHAR2
    , in_start_time     IN  VARCHAR2
    , in_file_name      IN  VARCHAR2
    , return_status OUT VARCHAR2
    , return_message OUT VARCHAR2
)
IS
------------------------------------------------------------------------------------------------
-- Register load related declarations --
------------------------------------------------------------------------------------------------
CURSOR register_cur
IS
SELECT   company_cd
       , store_id
       , register_id
       , description
       , arrounding_type
       , max_till_amount
       , register_type
       , stg_event_id
FROM   ARM_STG_REGISTER
WHERE  NVL(stg_status,0) IN (0,2);

TYPE company_cd_type IS TABLE OF ARM_STG_REGISTER.company_cd%TYPE;
TYPE store_id_type IS TABLE OF ARM_STG_REGISTER.store_id%TYPE;
TYPE register_id_type IS TABLE OF ARM_STG_REGISTER.register_id%TYPE;
TYPE description_type IS TABLE OF ARM_STG_REGISTER.description%TYPE;
TYPE arrounding_type IS TABLE OF ARM_STG_REGISTER.arrounding_type%TYPE;
TYPE max_till_amount_type IS TABLE OF ARM_STG_REGISTER.max_till_amount%TYPE;
TYPE register_type_type IS TABLE OF ARM_STG_REGISTER.register_type%TYPE;
TYPE stg_event_id_type IS TABLE OF ARM_STG_CURRENCY_RT.stg_event_id%TYPE;


TYPE register_rec_type IS RECORD (
      company_cd company_cd_type
    , store_id store_id_type
    , register_id register_id_type
    , description description_type
    , arrounding arrounding_type
    , max_till_amount max_till_amount_type
    , register_type register_type_type
    , stg_event_id stg_event_id_type
);

register_rec register_rec_type;

i  PLS_INTEGER;
j  PLS_INTEGER;
l_error_index PLS_INTEGER;
l_error_code VARCHAR2(255);
l_num_records_processed NUMBER;
l_error_stg_event_id PLS_INTEGER;
------------------------------------------------------------------------------------------------
-- execution --
------------------------------------------------------------------------------------------------
BEGIN

    OPEN  register_cur;
    FETCH register_cur BULK COLLECT
    INTO    register_rec.company_cd
          , register_rec.store_id
          , register_rec.register_id
          , register_rec.description
          , register_rec.arrounding
          , register_rec.max_till_amount
          , register_rec.register_type
          , register_rec.stg_event_id
    ;
    CLOSE register_cur;

    BEGIN
        UPDATE ARM_STG_REGISTER
        SET    stg_process_date = SYSDATE
        WHERE  NVL(stg_status,0) = 0;
        --
        EXCEPTION WHEN OTHERS THEN NULL;
    END;
    l_num_records_processed := register_rec.company_cd.COUNT();

    BEGIN
    FORALL i IN 1..register_rec.company_cd.COUNT()
        save EXCEPTIONS
            INSERT INTO AS_TL
            (
                  id_rpsty_tnd
                , id_str_rt
                , lu_tnd_mxm_alw
                , de_rpsty_tnd
                , ty_rnd
                , ty_rpsty_tnd
            )
            VALUES
            (
                  register_rec.register_id(i)
                , register_rec.company_cd(i) || register_rec.store_id(i)
                , register_rec.max_till_amount(i)
                , register_rec.description(i)
                , register_rec.arrounding(i)
                , register_rec.register_type(i)
            );

        -- Exception section
        EXCEPTION
        WHEN bulk_errors THEN
            FOR j IN 1..SQL%bulk_exceptions.COUNT()
            LOOP
                l_error_index := SQL%BULK_EXCEPTIONS(j).ERROR_INDEX;
                l_error_code := SQL%BULK_EXCEPTIONS(j).ERROR_CODE;
                l_error_stg_event_id := register_rec.stg_event_id(l_error_index);
                UPDATE arm_stg_register
                SET      stg_status = 1
                       , stg_error_message = stg_error_message || '  Error inserting as_tl - ' || l_error_code
                       , STG_PROCESS_DATE = SYSDATE
                WHERE  stg_event_id = l_error_stg_event_id;
            END LOOP;
            return_status := l_failure;
            return_message := 'BULK_ERRORS encountered';
            COMMIT;
        WHEN OTHERS THEN
            return_status := l_failure;
            return_message := SQLERRM;
            COMMIT;
    END;

    IF ( NVL(return_status,'A') != l_failure )
    THEN
        return_status := l_success;
        return_message := '';
    END IF;

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
            , return_status
            , l_num_records_processed
            , in_file_name
        );
    END;

    COMMIT;
END load_register;

PROCEDURE load_tax_rate
(
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
)
IS
    l_return_message VARCHAR2(50) := NULL;
    l_return_status VARCHAR2(1) := '0';
    l_num_records_processed NUMBER := 0;
BEGIN
    l_return_status := '0';
    BEGIN
        SELECT COUNT(*) INTO l_num_records_processed FROM ARM_STG_TAX_RATE WHERE NVL(STG_STATUS,0) IN (0,2);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            l_num_records_processed := 0;
    END;

    BEGIN
        MERGE INTO ARM_TAX_RATE DESTINATION
        USING (SELECT ZIP_CODE, CITY, COUNTY, STATE, TAX_RATE, EFFECTIVE_DT
        FROM ARM_STG_TAX_RATE) SOURCE
        ON (DESTINATION.ZIP_CODE=SOURCE.ZIP_CODE
        AND DESTINATION.CITY=SOURCE.CITY
        AND DESTINATION.COUNTY=SOURCE.COUNTY
        AND DESTINATION.STATE=SOURCE.STATE
        AND DESTINATION.EFFECTIVE_DT=SOURCE.EFFECTIVE_DT)
        WHEN MATCHED THEN
            UPDATE SET TAX_RATE=TAX_RATE
        WHEN NOT MATCHED THEN
            INSERT (ZIP_CODE, CITY, COUNTY, STATE, TAX_RATE, EFFECTIVE_DT)
            VALUES
            (SOURCE.ZIP_CODE, SOURCE.CITY, SOURCE.COUNTY, SOURCE.STATE, SOURCE.TAX_RATE,
            SOURCE.EFFECTIVE_DT);
    EXCEPTION
        WHEN OTHERS THEN
            l_return_status := '1';
            l_return_message := return_message || ',' || SQLERRM;
    END;
    BEGIN
        DELETE ARM_TAX_RATE SOURCE WHERE SOURCE.EFFECTIVE_DT < (SELECT MAX(DESTINATION.EFFECTIVE_DT)
                                    FROM ARM_TAX_RATE DESTINATION
                                    WHERE DESTINATION.ZIP_CODE=SOURCE.ZIP_CODE
                                        AND DESTINATION.CITY=SOURCE.CITY
                                        AND DESTINATION.COUNTY=SOURCE.COUNTY
                                        AND DESTINATION.STATE=SOURCE.STATE
                                        AND DESTINATION.EFFECTIVE_DT <= SYSDATE);
    EXCEPTION
        WHEN OTHERS THEN
            l_return_status := '1';
            l_return_message := return_message || ',' || SQLERRM;
    END;

    UPDATE ARM_STG_TAX_RATE
    SET   STG_STATUS = l_return_status,
    STG_ERROR_MESSAGE = l_return_message,
    STG_PROCESS_DATE = SYSDATE;

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
            , l_return_message
            , l_num_records_processed
            , in_file_name
        );
        END;

    return_status := l_return_status;
    return_message := l_return_message;
END load_tax_rate;

PROCEDURE load_inventory
(
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
)
IS
    CURSOR INVENTORY_cur
    IS
    SELECT STORE_ID,
                      ITEM_ID,
                       BALANCE_DATE,
                       AVAILABLE_QTY,
                       UNAVAILABLE_QTY,
                       IS_BALANCE,
                       TOTAL_SALE_QTY,
                       RECEIPT_QTY,
                       TRANSFER_QTY,
                       STOCK_ADJ_QTY,
                       ON_ORDER_QTY,
                       STG_EVENT_ID,
                       STG_STATUS,
                       STG_ERROR_MESSAGE,
                       STG_LOAD_DATE,
                       STG_PROCESS_DATE
    FROM   ARM_STG_INVENTORY
    WHERE  ((NVL(stg_status, 0) = 0 AND stg_process_date IS NULL) OR
    (stg_status=2 AND stg_process_date IS NOT NULL));

    TYPE id_str_rt_type IS TABLE OF ARM_STG_INVENTORY.store_id%TYPE;
    TYPE id_itm_type IS TABLE OF ARM_STG_INVENTORY.item_id%TYPE;
    TYPE balance_dt_type IS TABLE OF ARM_STG_INVENTORY.balance_date%TYPE;
    TYPE AVAILABLE_QTY_type IS TABLE OF ARM_STG_INVENTORY.AVAILABLE_QTY%TYPE;
    TYPE UNAVAILABLE_QTY_type IS TABLE OF ARM_STG_INVENTORY.UNAVAILABLE_QTY%TYPE;
    TYPE IS_BALANCED_type IS TABLE OF ARM_STG_INVENTORY.IS_BALANCE%TYPE;
    TYPE TOTAL_SALE_QTY_type IS TABLE OF ARM_STG_INVENTORY.TOTAL_SALE_QTY%TYPE;
    TYPE RECEIPT_QTY_type IS TABLE OF ARM_STG_INVENTORY.RECEIPT_QTY%TYPE;
    TYPE TRANSFER_QTY_type IS TABLE OF ARM_STG_INVENTORY.TRANSFER_QTY%TYPE;
    TYPE STOCK_ADJ_QTY_type IS TABLE OF ARM_STG_INVENTORY.STOCK_ADJ_QTY%TYPE;
    TYPE ON_ORDER_QTY_type IS TABLE OF ARM_STG_INVENTORY.ON_ORDER_QTY%TYPE;
    TYPE  STG_EVENT_ID_TYPE IS TABLE OF ARM_STG_INVENTORY.STG_EVENT_ID%TYPE;
    TYPE  STG_STATUS_TYPE IS TABLE OF ARM_STG_INVENTORY.STG_STATUS%TYPE;
    TYPE  STG_ERROR_MESSAGE_TYPE IS TABLE OF ARM_STG_INVENTORY.STG_ERROR_MESSAGE%TYPE;
    TYPE  STG_LOAD_DATE_TYPE IS TABLE OF ARM_STG_INVENTORY.STG_LOAD_DATE%TYPE;
    TYPE  STG_PROCESS_DATE_TYPE IS TABLE OF ARM_STG_INVENTORY.STG_PROCESS_DATE%TYPE;

    TYPE inventory_rec_type IS RECORD (
        id_str_rt id_str_rt_type,
        id_itm id_itm_type,
        balance_dt balance_dt_type,
        AVAILABLE_QTY AVAILABLE_QTY_type,
        UNAVAILABLE_QTY UNAVAILABLE_QTY_type,
        IS_BALANCED IS_BALANCED_type,
        TOTAL_SALE_QTY TOTAL_SALE_QTY_type,
        RECEIPT_QTY RECEIPT_QTY_type,
        TRANSFER_QTY TRANSFER_QTY_type,
        STOCK_ADJ_QTY STOCK_ADJ_QTY_type,
        ON_ORDER_QTY ON_ORDER_QTY_type,
        stg_event_id stg_event_id_type,
        stg_status stg_status_type,
        stg_error_message stg_error_message_type,
        stg_load_date stg_load_date_type,
        stg_process_date stg_load_date_type

    );

    l_return_status CHAR(1) := '0';
    l_error_index  VARCHAR2(255);
    l_error_code VARCHAR2(255);
    l_total_records_processed NUMBER := 0;
    inventory_rec inventory_rec_type;
    dml_errors EXCEPTION;
    PRAGMA EXCEPTION_INIT ( dml_errors, -24381 );
BEGIN
    OPEN INVENTORY_cur;
        LOOP
            FETCH INVENTORY_cur BULK COLLECT
            INTO inventory_rec.id_str_rt,
                inventory_rec.id_itm,
                inventory_rec.balance_dt,
                inventory_rec.AVAILABLE_QTY,
                inventory_rec.UNAVAILABLE_QTY,
                inventory_rec.IS_BALANCED,
                inventory_rec.TOTAL_SALE_QTY,
                inventory_rec.RECEIPT_QTY,
                inventory_rec.TRANSFER_QTY,
                inventory_rec.STOCK_ADJ_QTY,
                inventory_rec.ON_ORDER_QTY,
                inventory_rec.stg_event_id,
                inventory_rec.stg_status,
                inventory_rec.stg_error_message,
                inventory_rec.stg_load_date,
                inventory_rec.stg_process_date
            LIMIT 100;
            l_total_records_processed := l_total_records_processed + inventory_rec.id_str_rt.COUNT;
            BEGIN
              FORALL i IN 1..inventory_rec.id_itm.COUNT SAVE EXCEPTIONS
                MERGE INTO ARM_ITM_SOH DESTINATION
                USING (SELECT inventory_rec.ID_itm(i) item_id
                    , inventory_rec.id_str_rt(i) store_id
                    , inventory_rec.BALANCE_DT(i) balance_date
                    , inventory_rec.AVAILABLE_QTY(i) qu_available
                    , inventory_rec.UNAVAILABLE_QTY(i) qu_unavailable
                    , inventory_rec.TOTAL_SALE_QTY(i) qu_sale_total
                    , inventory_rec.RECEIPT_QTY(i) qu_receipt
                    , inventory_rec.TRANSFER_QTY(i) qu_transfer
                    , inventory_rec.STOCK_ADJ_QTY(i) qu_stock_adj
                    , inventory_rec.ON_ORDER_QTY(i) qu_on_order
                    , inventory_rec.IS_BALANCEd(i) fl_balanced
                FROM DUAL) SOURCE
                ON (DESTINATION.ITEM_ID=SOURCE.ITEM_ID
                AND DESTINATION.STORE_ID=SOURCE.STORE_ID)
                WHEN MATCHED THEN
                    UPDATE SET BALANCE_DATE=source.balance_date,
                        QU_AVAILABLE=source.qu_available,
                        QU_UNAVAILABLE=source.qu_unavailable,
                        FL_BALANCED=source.fl_balanced,
                        QU_SALE_TOTAL=source.qu_sale_total,
                        QU_RECEIPT=source.qu_receipt,
                        QU_TRANSFER=source.qu_transfer,
                        QU_STOCK_ADJ=source.qu_stock_adj,
                        QU_ON_ORDER=source.qu_on_order,
                        QU_STORE_AVAILABLE=DECODE(source.fl_balanced, '1', 0, QU_STORE_AVAILABLE),
                        QU_STORE_UNAVAILABLE=DECODE(source.fl_balanced, '1', 0, QU_STORE_UNAVAILABLE)
                WHEN NOT MATCHED THEN
                    INSERT (ITEM_ID, STORE_ID, BALANCE_DATE,
                        QU_AVAILABLE, QU_UNAVAILABLE, FL_BALANCED, QU_SALE_TOTAL,
                        QU_RECEIPT, QU_TRANSFER, QU_STOCK_ADJ, QU_ON_ORDER,
                        QU_STORE_AVAILABLE, QU_STORE_UNAVAILABLE)
                    VALUES
                        (source.ITEM_ID, source.STORE_ID, source.BALANCE_DATE,
                        source.QU_AVAILABLE,source.QU_UNAVAILABLE, source.FL_BALANCED,
                        source.QU_SALE_TOTAL, source.QU_RECEIPT, source.QU_TRANSFER,
                        source.QU_STOCK_ADJ, source.QU_ON_ORDER, 0, 0);
            EXCEPTION
                WHEN dml_errors THEN
                    l_return_status := '1';
                    FOR j IN 1..SQL%bulk_exceptions.COUNT()
                    LOOP
                        l_error_index := SQL%BULK_EXCEPTIONS(j).ERROR_INDEX;
                        l_error_code := SQL%BULK_EXCEPTIONS(j).ERROR_CODE;
                        UPDATE ARM_STG_INVENTORY
                        SET stg_status = 1
                            , stg_error_message = stg_error_message || ' Error INSERTING/UPDATING ARM_ITM_SOH - ' || l_error_code
                        WHERE  stg_event_id = inventory_rec.stg_event_id(l_error_index);
                    END LOOP;
            END;
			BEGIN
			    FORALL i IN 1..inventory_rec.id_itm.COUNT
			        UPDATE ARM_STG_INVENTORY
			        SET STG_PROCESS_DATE=SYSDATE,
			        STG_STATUS=0
			        WHERE STG_EVENT_ID=inventory_rec.stg_event_id(i)
			        AND STG_STATUS NOT IN (1);
			END;			
            COMMIT;
            EXIT WHEN INVENTORY_cur%NOTFOUND;
        END LOOP;
    CLOSE inventory_cur;

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
            , l_return_status
            , l_total_records_processed
            , in_file_name
        );
    END;
    return_status := l_return_status;
    COMMIT;

END load_inventory;

PROCEDURE Load_Redeemable
(
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
)
IS
    CURSOR REDEEMABLE_cur
    IS
    SELECT REDEEMABLE_TYPE,
        ISSUE_DATE,
        ISSUE_STORE_ID,
        CURRENCY_CD,
        FACE_VALUE_AMOUNT,
        BALANCE_AMOUNT,
        CONTROL_ID,
        CUSTOMER_ID,
        EXPIRY_DATE,
	FN_HOLDER,
	LN_HOLDER,
	STATUS,
        STG_EVENT_ID,
        STG_STATUS,
        STG_ERROR_MESSAGE,
        STG_LOAD_DATE,
        STG_PROCESS_DATE
    FROM   ARM_STG_REDEEMABLE
    WHERE  ((NVL(stg_status, 0) = 0 AND stg_process_date IS NULL) OR
    (stg_status=2 AND stg_process_date IS NOT NULL));

    TYPE REDEEMABLE_TYPE_type IS TABLE OF ARM_STG_REDEEMABLE.REDEEMABLE_TYPE%TYPE;
    TYPE ISSUE_DATE_type IS TABLE OF ARM_STG_REDEEMABLE.ISSUE_DATE%TYPE;
    TYPE ISSUE_STORE_ID_type IS TABLE OF ARM_STG_REDEEMABLE.ISSUE_STORE_ID%TYPE;
    TYPE CURRENCY_CD_type IS TABLE OF ARM_STG_REDEEMABLE.CURRENCY_CD%TYPE;
    TYPE FACE_VALUE_AMOUNT_type IS TABLE OF ARM_STG_REDEEMABLE.FACE_VALUE_AMOUNT%TYPE;
    TYPE BALANCE_AMOUNT_type IS TABLE OF ARM_STG_REDEEMABLE.BALANCE_AMOUNT%TYPE;
    TYPE CONTROL_ID_type IS TABLE OF ARM_STG_REDEEMABLE.CONTROL_ID%TYPE;
    TYPE CUSTOMER_ID_type IS TABLE OF ARM_STG_REDEEMABLE.CUSTOMER_ID%TYPE;
    TYPE EXPIRY_DATE_type IS TABLE OF ARM_STG_REDEEMABLE.EXPIRY_DATE%TYPE;
    TYPE FN_HOLDER_type IS TABLE OF ARM_STG_REDEEMABLE.FN_HOLDER%TYPE;
    TYPE LN_HOLDER_type IS TABLE OF ARM_STG_REDEEMABLE.LN_HOLDER%TYPE;
    TYPE STATUS_type IS TABLE OF ARM_STG_REDEEMABLE.STATUS%TYPE;
    TYPE  STG_EVENT_ID_TYPE IS TABLE OF ARM_STG_REDEEMABLE.STG_EVENT_ID%TYPE;
    TYPE  STG_STATUS_TYPE IS TABLE OF ARM_STG_REDEEMABLE.STG_STATUS%TYPE;
    TYPE  STG_ERROR_MESSAGE_TYPE IS TABLE OF ARM_STG_REDEEMABLE.STG_ERROR_MESSAGE%TYPE;
    TYPE  STG_LOAD_DATE_TYPE IS TABLE OF ARM_STG_REDEEMABLE.STG_LOAD_DATE%TYPE;
    TYPE  STG_PROCESS_DATE_TYPE IS TABLE OF ARM_STG_REDEEMABLE.STG_PROCESS_DATE%TYPE;

    TYPE redeemable_rec_type IS RECORD (
        REDEEMABLE_TYPE REDEEMABLE_TYPE_type,
        ISSUE_DATE ISSUE_DATE_type,
        ISSUE_STORE_ID ISSUE_STORE_ID_type,
        CURRENCY_CD CURRENCY_CD_type,
        FACE_VALUE_AMOUNT FACE_VALUE_AMOUNT_type,
        BALANCE_AMOUNT BALANCE_AMOUNT_type,
        CONTROL_ID CONTROL_ID_type,
        CUSTOMER_ID CUSTOMER_ID_type,
        EXPIRY_DATE EXPIRY_DATE_type,
	FN_HOLDER FN_HOLDER_type,
	LN_HOLDER LN_HOLDER_type,
	STATUS STATUS_type,
        stg_event_id stg_event_id_type,
        stg_status stg_status_type,
        stg_error_message stg_error_message_type,
        stg_load_date stg_load_date_type,
        stg_process_date stg_load_date_type

    );

    l_return_status CHAR(1) := '0';
    l_return_message VARCHAR2(50) := NULL;
    l_error_index  VARCHAR2(255);
    l_error_code VARCHAR2(255);
    l_total_records_processed NUMBER := 0;
    redeemable_rec redeemable_rec_type;
    dml_errors EXCEPTION;
    PRAGMA EXCEPTION_INIT ( dml_errors, -24381 );

BEGIN
    OPEN REDEEMABLE_cur;
        LOOP
            FETCH REDEEMABLE_cur BULK COLLECT
            INTO redeemable_rec.REDEEMABLE_TYPE,
                redeemable_rec.ISSUE_DATE,
                redeemable_rec.ISSUE_STORE_ID,
                redeemable_rec.CURRENCY_CD,
                redeemable_rec.FACE_VALUE_AMOUNT,
                redeemable_rec.BALANCE_AMOUNT,
                redeemable_rec.CONTROL_ID,
                redeemable_rec.CUSTOMER_ID,
                redeemable_rec.EXPIRY_DATE,
		redeemable_rec.FN_HOLDER,
		redeemable_rec.LN_HOLDER,
		redeemable_rec.STATUS,
                redeemable_rec.stg_event_id,
                redeemable_rec.stg_status,
                redeemable_rec.stg_error_message,
                redeemable_rec.stg_load_date,
                redeemable_rec.stg_process_date
            LIMIT 100;
            l_total_records_processed := l_total_records_processed + redeemable_rec.CONTROL_ID.COUNT;
            BEGIN
                FORALL i IN 1..redeemable_rec.CONTROL_ID.COUNT SAVE EXCEPTIONS
                    MERGE INTO DO_CF_GF DESTINATION
                    USING (SELECT redeemable_rec.REDEEMABLE_TYPE(i) REDEEMABLE_TYPE,
                            redeemable_rec.ISSUE_DATE(i) ISSUE_DATE,
                            redeemable_rec.ISSUE_STORE_ID(i) ISSUE_STORE_ID,
                            redeemable_rec.CURRENCY_CD(i) CURRENCY_CD,
                            redeemable_rec.FACE_VALUE_AMOUNT(i) FACE_VALUE_AMOUNT,
                            redeemable_rec.BALANCE_AMOUNT(i) BALANCE_AMOUNT,
                            redeemable_rec.CONTROL_ID(i) CONTROL_ID,
                            redeemable_rec.CUSTOMER_ID(i) CUSTOMER_ID,
                            redeemable_rec.EXPIRY_DATE(i) EXPIRY_DATE,
			    redeemable_rec.FN_HOLDER(i) FN_HOLDER,
			    redeemable_rec.LN_HOLDER(i) LN_HOLDER,
			    redeemable_rec.STATUS(I) STATUS
                    FROM DUAL) SOURCE
                    ON (DESTINATION.TY_GF_CF=SOURCE.REDEEMABLE_TYPE
                    AND DESTINATION.ID_NMB_SRZ_GF_CF=SOURCE.CONTROL_ID)
                    WHEN MATCHED THEN
                        UPDATE SET MO_VL_FC_GF_CF=SOURCE.CURRENCY_CD||SOURCE.FACE_VALUE_AMOUNT,
                            ID_CT=SOURCE.CUSTOMER_ID,
                            TS_ISS_GF_CF=SOURCE.ISSUE_DATE,
                            ID_STR_ISSG=SOURCE.ISSUE_STORE_ID,
                            DC_EP_GF_CF=EXPIRY_DATE,
                            GIFT_CONTROL=SOURCE.CONTROL_ID,
			    FN_DNR_GF_CF=SOURCE.FN_HOLDER,
			    NM_DNR_GF_CF=SOURCE.LN_HOLDER,
			    DELETED=SOURCE.STATUS
                    WHEN NOT MATCHED THEN
                        INSERT (TY_GF_CF, TS_ISS_GF_CF, ID_STR_ISSG, MO_VL_FC_GF_CF,
                        MO_BLNC_UNSP_GF_CF, ID_NMB_SRZ_GF_CF, ID_CT, DC_EP_GF_CF, GIFT_CONTROL,
			FN_DNR_GF_CF, NM_DNR_GF_CF, DELETED)
                        VALUES
                        (SOURCE.REDEEMABLE_TYPE, SOURCE.ISSUE_DATE, SOURCE.ISSUE_STORE_ID,
                        SOURCE.CURRENCY_CD||SOURCE.FACE_VALUE_AMOUNT,
                        SOURCE.CURRENCY_CD||SOURCE.BALANCE_AMOUNT, SOURCE.CONTROL_ID,
                        SOURCE.CUSTOMER_ID, SOURCE.EXPIRY_DATE, SOURCE.CONTROL_ID,
			SOURCE.FN_HOLDER, SOURCE.LN_HOLDER, SOURCE.STATUS);
            EXCEPTION
                WHEN dml_errors THEN
                    l_return_status := '1';
                    FOR j IN 1..SQL%bulk_exceptions.COUNT()
                    LOOP
                        l_error_index := SQL%BULK_EXCEPTIONS(j).ERROR_INDEX;
                        l_error_code := SQL%BULK_EXCEPTIONS(j).ERROR_CODE;
                        UPDATE ARM_STG_REDEEMABLE
                        SET stg_status = 1
                        , stg_error_message = stg_error_message || ' Error INSERTING/UPDATING DO_CF_GF - ' || l_error_code
                        WHERE  stg_event_id = redeemable_rec.stg_event_id(l_error_index);
                    END LOOP;
            END;

            BEGIN
                FORALL i IN 1..redeemable_rec.CONTROL_ID.COUNT SAVE EXCEPTIONS
                    INSERT INTO RK_REDM_HIST (AMOUNT_USED, TRANS_ID_USED, DATE_USED, ID_NMB_SRZ_GF_CF, TY_GF_CF, SEQ_NUM)
                    SELECT redeemable_rec.CURRENCY_CD(i)||TO_CHAR(redeemable_rec.BALANCE_AMOUNT(i)-(redeemable_rec.FACE_VALUE_AMOUNT(i)-REDM_HIST.BALANCE)),
                    'BALANCE_CORRECTION', SYSDATE, redeemable_rec.CONTROL_ID(i), redeemable_rec.REDEEMABLE_TYPE(i), NVL(REDM_HIST.SEQ_NUM, 0) FROM
                    (SELECT MAX(SEQ_NUM)+1 SEQ_NUM, SUM(TO_NUMBER(REPLACE(NVL(AMOUNT_USED,'USD0'),redeemable_rec.CURRENCY_CD(i), ''))) BALANCE
                    FROM RK_REDM_HIST
                    WHERE ID_NMB_SRZ_GF_CF=redeemable_rec.CONTROL_ID(i)
                    AND TY_GF_CF=redeemable_rec.REDEEMABLE_TYPE(i)) REDM_HIST;
            EXCEPTION
                WHEN dml_errors THEN
                    l_return_status := '1';
                    FOR j IN 1..SQL%bulk_exceptions.COUNT()
                    LOOP
                        l_error_index := SQL%BULK_EXCEPTIONS(j).ERROR_INDEX;
                        l_error_code := SQL%BULK_EXCEPTIONS(j).ERROR_CODE;
                        UPDATE ARM_STG_REDEEMABLE
                        SET stg_status = 1
                        , stg_error_message = stg_error_message || ' Error INSERTING RK_REDM_HIST - ' || l_error_code
                        WHERE  stg_event_id = redeemable_rec.stg_event_id(l_error_index);
                    END LOOP;
            END;
	BEGIN
	    FORALL i IN 1..redeemable_rec.CONTROL_ID.COUNT
		UPDATE ARM_STG_REDEEMABLE
		SET STG_PROCESS_DATE=SYSDATE,
		STG_STATUS=0
		WHERE STG_EVENT_ID=redeemable_rec.stg_event_id(i)
		AND STG_STATUS NOT IN (1);
	END;			
            COMMIT;
            EXIT WHEN REDEEMABLE_cur%NOTFOUND;
        END LOOP;
    CLOSE REDEEMABLE_cur;

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
                , l_return_status
            , l_total_records_processed
            , in_file_name
        );
    END;
    COMMIT;
    return_status := l_return_status;
    return_message := l_return_message;
END Load_Redeemable;

PROCEDURE load_tax_free
(
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
)
IS
    l_return_message VARCHAR2(50) := NULL;
    l_return_status VARCHAR2(1) := '0';
    l_num_records_processed NUMBER := 0;
BEGIN
    l_return_status := '0';
    BEGIN
        SELECT COUNT(*) INTO l_num_records_processed FROM ARM_STG_TAX_FREE WHERE (NVL(STG_STATUS,0)= 0 AND STG_PROCESS_DATE IS NULL)
        OR (STG_STATUS=2 AND STG_PROCESS_DATE IS NOT NULL);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            l_num_records_processed := 0;
    END;

    BEGIN
        MERGE INTO ARM_TAX_FREE DESTINATION
        USING (SELECT STORE_CODE, DETAX_CODE, DESC_CODE, RATIO, START_DATE, NET_MIN_VALUE,
        GROSS_MIN_VALUE, PAYMENT_CODE, MIN_PRICE, MAX_PRICE, MIN_AMOUNT, MAX_AMOUNT,
        REFUND_AMOUNT, REFUND_PERCENT, COMMISSION
        FROM ARM_STG_TAX_FREE
        WHERE (NVL(STG_STATUS,0)= 0 AND STG_PROCESS_DATE IS NULL AND TRAN_TYPE = 0)
        OR (STG_STATUS=2 AND STG_PROCESS_DATE IS NOT NULL AND TRAN_TYPE = 0)) SOURCE
        ON (DESTINATION.STORE_CODE=SOURCE.STORE_CODE
        AND DESTINATION.DETAX_CODE=SOURCE.DETAX_CODE
        AND DESTINATION.START_DATE=SOURCE.START_DATE)

        WHEN MATCHED THEN
            UPDATE SET DESC_CODE=SOURCE.DESC_CODE,
            RATIO=SOURCE.RATIO,
            NET_MIN_VALUE=SOURCE.NET_MIN_VALUE,
            GROSS_MIN_VALUE=SOURCE.GROSS_MIN_VALUE,
            PAYMENT_CODE=SOURCE.PAYMENT_CODE,
            MIN_PRICE=SOURCE.MIN_PRICE,
            MAX_PRICE=SOURCE.MAX_PRICE,
            MIN_AMOUNT=SOURCE.MIN_AMOUNT,
            MAX_AMOUNT=SOURCE.MAX_AMOUNT,
            REFUND_AMOUNT=SOURCE.REFUND_AMOUNT,
            REFUND_PERCENT=SOURCE.REFUND_PERCENT,
            COMMISSION=SOURCE.COMMISSION
        WHEN NOT MATCHED THEN
            INSERT (STORE_CODE, DETAX_CODE, DESC_CODE, RATIO, START_DATE, NET_MIN_VALUE,
            GROSS_MIN_VALUE, PAYMENT_CODE, MIN_PRICE, MAX_PRICE, MIN_AMOUNT, MAX_AMOUNT,
            REFUND_AMOUNT, REFUND_PERCENT, COMMISSION)
            VALUES
            (SOURCE.STORE_CODE, SOURCE.DETAX_CODE, SOURCE.DESC_CODE, SOURCE.RATIO,
            SOURCE.START_DATE, SOURCE.NET_MIN_VALUE, SOURCE.GROSS_MIN_VALUE, SOURCE.PAYMENT_CODE,
            SOURCE.MIN_PRICE, SOURCE.MAX_PRICE, SOURCE.MIN_AMOUNT, SOURCE.MAX_AMOUNT,
            SOURCE.REFUND_AMOUNT, SOURCE.REFUND_PERCENT, SOURCE.COMMISSION);
    EXCEPTION
        WHEN OTHERS THEN
            l_return_status := '1';
            l_return_message := return_message || ',' || SQLERRM;
    END;
    BEGIN
        DELETE ARM_TAX_FREE SOURCE WHERE SOURCE.START_DATE < (SELECT MAX(DESTINATION.START_DATE)
                                    FROM ARM_TAX_FREE DESTINATION
                                    WHERE DESTINATION.STORE_CODE=SOURCE.STORE_CODE
                                        AND DESTINATION.DETAX_CODE=SOURCE.DETAX_CODE
                                        AND DESTINATION.START_DATE <= SYSDATE);
    EXCEPTION
        WHEN OTHERS THEN
            l_return_status := '1';
            l_return_message := return_message || ',' || SQLERRM;
    END;

    UPDATE ARM_STG_TAX_FREE
    SET   STG_STATUS = l_return_status,
    STG_ERROR_MESSAGE = l_return_message,
    STG_PROCESS_DATE = SYSDATE;

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
            , l_return_message
            , l_num_records_processed
            , in_file_name
        );
        END;

    return_status := l_return_status;
    return_message := l_return_message;
END load_tax_free;

PROCEDURE load_fiscal_doc_no
(
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
)
IS
    l_return_message VARCHAR2(50) := NULL;
    l_return_status VARCHAR2(1) := '0';
    l_num_records_processed NUMBER := 0;
BEGIN
    l_return_status := '0';
    BEGIN
        SELECT COUNT(*) INTO l_num_records_processed FROM ARM_STG_FISCAL_DOC_NO WHERE (NVL(STG_STATUS,0)= 0
        AND STG_PROCESS_DATE IS NULL AND TRAN_TYPE=0)
        OR (STG_STATUS=2 AND STG_PROCESS_DATE IS NOT NULL AND TRAN_TYPE=0);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            l_num_records_processed := 0;
    END;

    BEGIN
        MERGE INTO ARM_FISCAL_DOC_NO DESTINATION
        USING (SELECT REGISTER_ID, ID_STR_RT, LAST_DDT_NO, LAST_VAT_NO, LAST_CREDIT_NOTE
        FROM ARM_STG_FISCAL_DOC_NO
        WHERE (NVL(STG_STATUS,0)= 0 AND STG_PROCESS_DATE IS NULL AND TRAN_TYPE = 0)
        OR (STG_STATUS=2 AND STG_PROCESS_DATE IS NOT NULL AND TRAN_TYPE = 0)) SOURCE
        ON (DESTINATION.REGISTER_ID=SOURCE.REGISTER_ID
        AND DESTINATION.ID_STR_RT=SOURCE.ID_STR_RT)

        WHEN MATCHED THEN
            UPDATE SET LAST_DDT_NO=SOURCE.LAST_DDT_NO,
            LAST_VAT_NO=SOURCE.LAST_VAT_NO,
            LAST_CREDIT_NOTE=SOURCE.LAST_CREDIT_NOTE

        WHEN NOT MATCHED THEN
            INSERT (REGISTER_ID, ID_STR_RT, LAST_DDT_NO, LAST_VAT_NO, LAST_CREDIT_NOTE)
            VALUES
            (SOURCE.REGISTER_ID, SOURCE.ID_STR_RT, SOURCE.LAST_DDT_NO, SOURCE.LAST_VAT_NO,
            SOURCE.LAST_CREDIT_NOTE);
    EXCEPTION
        WHEN OTHERS THEN
            l_return_status := '1';
            l_return_message := return_message || ',' || SQLERRM;
    END;

    UPDATE ARM_STG_FISCAL_DOC_NO
    SET   STG_STATUS = l_return_status,
    STG_ERROR_MESSAGE = l_return_message,
    STG_PROCESS_DATE = SYSDATE;

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
            , l_return_message
            , l_num_records_processed
            , in_file_name
        );
        END;

    return_status := l_return_status;
    return_message := l_return_message;
END load_fiscal_doc_no;
END Arm_Load_Data_Pkg;
/
