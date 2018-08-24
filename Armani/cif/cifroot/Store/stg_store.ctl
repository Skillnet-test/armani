load data
    into table ARM_STG_STORE APPEND
    fields terminated by "|" optionally enclosed by '"'
    trailing nullcols
    (
        TRAN_TYPE,
        COMPANY_CODE,
        COMPANY_DESC,
        COMP_OFFICE_PHONE_AREA,
        COMP_OFFICE_PHONE_NUMBER,
        COMP_ADDRESS_LINE1,
        COMP_ADDRESS_LINE2,
        COMP_CITY,
        COMP_STATE,
        COMP_POSTAL_CODE,
        COMP_COUNTRY,
        SHOP_CODE,
        SHOP_DESC,
        OFFICE_PHONE_AREA,
        OFFICE_PHONE_NUMBER,
        ADDRESS_LINE1,
        ADDRESS_LINE2,
        CITY,
        STATE,
        POSTAL_CODE,
        COUNTRY,
        CURRENCY,
	TAX_RATE "ARM_TO_NUMBER(:TAX_RATE,:CURRENCY)",
        COUNTRY_CODE,
        LANGUAGE_CODE,
        BRAND_ID,
        FRANKING_COMPANY_NAME,
        FRANKING_COMPANY_AC_NUM,
        FISCAL_CODE,
        STG_EVENT_ID "STG_EVENT_ID_S.nextval",
	STG_STATUS "NVL(:STG_STATUS, 0)"
    )
