LOAD data
    into table ARM_STG_FISCAL_DOC_NO APPEND
    fields terminated by "|" optionally enclosed by '"'
    trailing nullcols
(
  TRAN_TYPE,
  REGISTER_ID,
  ID_STR_RT,          
  LAST_DDT_NO,       
  LAST_VAT_NO,        
  LAST_CREDIT_NOTE,    
  STG_EVENT_ID "STG_EVENT_ID_S.nextval",
  STG_LOAD_DATE "SYSDATE"
)
