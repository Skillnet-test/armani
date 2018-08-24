LOAD data
    into table ARM_STG_TAX_RATE APPEND
    fields terminated by "|" optionally enclosed by '"'
    trailing nullcols
(
  ZIP_CODE,
  CITY,
  COUNTY,
  STATE,
  TAX_RATE "arm_to_number(:tax_rate, null)",
  EFFECTIVE_DT  "to_date(:EFFECTIVE_DT, 'YYYYMMDD')",
  STG_EVENT_ID "STG_EVENT_ID_S.nextval",
  STG_LOAD_DATE	"SYSDATE"
)
