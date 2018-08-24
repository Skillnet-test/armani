load data
    into table ARM_STG_CLASS APPEND
    fields terminated by "|" optionally enclosed by '"'
    trailing nullcols
    (
        ID_DPT,
        ID_CLSS,
        NM_CLSS,
	STG_LOAD_DATE "SYSDATE",
	STG_EVENT_ID "STG_EVENT_ID_S.nextval",
	STG_STATUS "NVL(:STG_STATUS,0)"
    )
