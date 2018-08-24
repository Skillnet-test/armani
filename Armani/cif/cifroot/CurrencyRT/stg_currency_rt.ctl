load data
    into table ARM_STG_CURRENCY_RT APPEND
    fields terminated by "|" optionally enclosed by '"'
    trailing nullcols
    (
        FROM_CURRENCY,
        TO_CURRENCY,
	CURRENCY_RATE "ARM_TO_NUMBER(:CURRENCY_RATE, :TO_CURRENCY)",
	UPDATE_DATE,
	COUNTRY_CD,
	LANG_CD,
	FIN_CD,
	STG_LOAD_DATE "SYSDATE",
	STG_EVENT_ID "STG_EVENT_ID_S.nextval",
	STG_STATUS "NVL(:STG_STATUS, 0)"
    )
