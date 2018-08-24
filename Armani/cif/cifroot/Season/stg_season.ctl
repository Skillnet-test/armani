load data
    into table ARM_STG_SEASON APPEND
    fields terminated by "|" optionally enclosed by '"'
    trailing nullcols
    (
        ID_SEASON,
        DE_SEASON,
        ED_CO,
	ED_LA,
	STG_LOAD_DATE "SYSDATE",
	STG_EVENT_ID "STG_EVENT_ID_S.nextval",
	STG_STATUS "NVL(:STG_STATUS,0)"
    )
