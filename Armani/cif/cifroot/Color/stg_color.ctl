load data
    into table ARM_STG_COLOR APPEND
    fields terminated by "|" optionally enclosed by '"'
    trailing nullcols
    (
        ID_COLOR,
        DE_COLOR,
	STG_LOAD_DATE "SYSDATE",
	STG_EVENT_ID "STG_EVENT_ID_S.nextval",
	STG_STATUS "NVL(:STG_STATUS,0)"
    )
