load data
    into table ARM_STG_INVENTORY APPEND
    fields terminated by "|" optionally enclosed by '"'
    trailing nullcols
    (
    ITEM_ID,
    STORE_ID,
    BALANCE_DATE "to_date(:BALANCE_DATE,'YYYYMMDD')",
    AVAILABLE_QTY "TO_NUMBER(:AVAILABLE_QTY)",
    UNAVAILABLE_QTY "TO_NUMBER(:UNAVAILABLE_QTY)",
    TOTAL_SALE_QTY "TO_NUMBER(:TOTAL_SALE_QTY)",
    RECEIPT_QTY "TO_NUMBER(:RECEIPT_QTY)",
    TRANSFER_QTY "TO_NUMBER(:TRANSFER_QTY)",
    STOCK_ADJ_QTY "TO_NUMBER(:STOCK_ADJ_QTY)",
    ON_ORDER_QTY "TO_NUMBER(:ON_ORDER_QTY)",
    IS_BALANCE "TRIM(:IS_BALANCE)",
    STG_EVENT_ID "STG_EVENT_ID_S.nextval",
    STG_STATUS "NVL(:STG_STATUS,0)",
    STG_LOAD_DATE   "SYSDATE"
    )