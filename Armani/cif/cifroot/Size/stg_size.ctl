load data
    into table ARM_STG_SIZE APPEND
    fields terminated by "|" optionally enclosed by '"'
    trailing nullcols
    (
        ID_SIZE,
	DE_SIZE,
	SIZE_INDEX,
	EXT_SIZE_INDEX,
        ED_CO,
	ED_LA,
	STG_LOAD_DATE "SYSDATE",
	STG_EVENT_ID "STG_EVENT_ID_S.nextval",
	STG_STATUS "NVL(:STG_STATUS,0)"
    )
