load data
    into table ARM_STG_SUBCLASS APPEND
    fields terminated by "|" optionally enclosed by '"'
    trailing nullcols
    (
        ID_DPT,
        ID_CLSS,
        ID_SBCL,
        NM_SBCL,
	STG_LOAD_DATE "SYSDATE",
	STG_EVENT_ID "STG_EVENT_ID_S.nextval",
	STG_STATUS "NVL(:STG_STATUS,0)"
    )
