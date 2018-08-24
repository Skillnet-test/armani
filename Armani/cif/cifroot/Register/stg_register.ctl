load data
    into table ARM_STG_REGISTER APPEND
    fields terminated by "|" optionally enclosed by '"'
    trailing nullcols
    (
        COMPANY_CD,
        STORE_ID,
        REGISTER_ID,
        DESCRIPTION,
        ARROUNDING_TYPE,
	MAX_TILL_AMOUNT "ARM_TO_NUMBER(:MAX_TILL_AMOUNT, null)",
        REGISTER_TYPE,
	STG_LOAD_DATE "SYSDATE",
	STG_EVENT_ID "STG_EVENT_ID_S.nextval",
	STG_STATUS "NVL(:STG_STATUS,0)"
    )
