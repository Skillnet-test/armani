load data
    into table ARM_STG_SPR APPEND
    fields terminated by "|" optionally enclosed by '"'
    trailing nullcols
    (
        ID_SPR,
        NM_SPR,
	STG_LOAD_DATE "SYSDATE",
	STG_EVENT_ID "STG_EVENT_ID_S.nextval",
	STG_STATUS "NVL(:STG_STATUS,0)"
    )
