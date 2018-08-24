load data
    into table ARM_STG_PRM APPEND
    fields terminated by "|" optionally enclosed by '"'
    trailing nullcols
    (
        START_DATE  "to_date(:START_DATE||:START_TIME,'YYYYMMDDHH24MISS')",
        START_TIME,
	END_DATE    "to_date(:END_DATE||:END_TIME,'YYYYMMDDHH24MISS')",
	END_TIME,
        STORE_ID,
        PROMOTION_NUM,
	PROMOTION_NAME,
        APPLY_TO,
        DISCOUNT_AMOUNT,
        DISCOUNT_PERCENT,
        DISCOUNT_TYPE,
        THRESHOLD_AMT,
        IS_DISCOUNT,
        APPLICABLE_ITM,
	STG_EVENT_ID "STG_EVENT_ID_S.nextval",
	STG_STATUS "NVL(:STG_STATUS,0)"
    )
