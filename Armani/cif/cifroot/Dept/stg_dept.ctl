load data
    into table ARM_STG_DEPT APPEND
    fields terminated by "|" optionally enclosed by '"'
    trailing nullcols
    (
        ID_DPT_POS,
        NM_DPT_POS,
        ID_DPT_POS_PRNT,
	STG_LOAD_DATE "SYSDATE",
	STG_EVENT_ID "STG_EVENT_ID_S.nextval",
	STG_STATUS "NVL(:STG_STATUS,0)"
    )
