LOAD data
    into table ARM_STG_TAX_FREE APPEND
    fields terminated by "|" optionally enclosed by '"'
    trailing nullcols
(
  TRAN_TYPE,
  STORE_CODE,
  DETAX_CODE,
  DESC_CODE,
  RATIO "arm_to_number(:RATIO, null)",
  START_DATE "to_date(:START_DATE, 'YYYYMMDD')",
  NET_MIN_VALUE,
  GROSS_MIN_VALUE,
  PAYMENT_CODE,
  MIN_PRICE,
  MAX_PRICE,
  MIN_AMOUNT,
  MAX_AMOUNT,
  REFUND_AMOUNT,
  REFUND_PERCENT,
  COMMISSION,
  STG_EVENT_ID "STG_EVENT_ID_S.nextval",
  STG_LOAD_DATE "SYSDATE"
)
