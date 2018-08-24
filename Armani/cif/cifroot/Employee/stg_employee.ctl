load data
    into table ARM_STG_EMPLOYEE APPEND
    fields terminated by "|" optionally enclosed by '"'
    trailing nullcols
    (
        TRAN_TYPE,
        ID,
        FIRST_NAME,
        LAST_NAME,
        DATE_OF_BIRTH "to_date(:DATE_OF_BIRTH, 'YYYYMMDD')",
        EMAIL,
        HOME_PHONE_AREA,
        HOME_PHONE_NUMBER,
        ADDRESS_LINE1,
        ADDRESS_LINE2,
        CITY,
        STATE,
        POSTAL_CODE,
        COUNTRY,
        STATUS,
        HOME_STORE_ID,
        HIRE_DATE "to_date(:HIRE_DATE, 'YYYYMMDD')",
        TERM_DATE "to_date(:TERM_DATE, 'YYYYMMDD')",
        ROLE,
	STG_EVENT_ID "STG_EVENT_ID_S.nextval",
	STG_LOAD_DATE   "SYSDATE",
	STG_STATUS "NVL(:STG_STATUS, 0)"
    )
