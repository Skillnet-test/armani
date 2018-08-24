DROP TABLE ARM_STG_ITEM;

CREATE TABLE ARM_STG_ITEM
(
   TRAN_TYPE           NUMBER(2),
   START_DATE          VARCHAR2(8),
   START_TIME          VARCHAR2(6),
   END_DATE            VARCHAR2(8),
   END_TIME            VARCHAR2(6),
   STORE_ID            VARCHAR2(10),
   ITEM                VARCHAR2(25),
   REF_ITEM            VARCHAR2(25),
   BARCODE             VARCHAR2(50),
   DESCRIPTION         VARCHAR2(40),
   DEPT                VARCHAR2(20),
   CLASS               NUMBER(4),
   SUB_CLASS           NUMBER(4),
   NEW_PRICE           NUMBER,
   OLD_PRICE           NUMBER,
   CURRENCY            VARCHAR2(3),
   TAXABLE_IND         VARCHAR2(1),
   VAT_RATE            NUMBER,
   VAT_CODE            VARCHAR2(6),
   YEAR                VARCHAR2(4),
   SEASON              VARCHAR2(6),
   BRAND               VARCHAR2(10),
   LABEL               VARCHAR2(30),
   SUBLINE             VARCHAR2(30),
   GENDER              VARCHAR2(10),
   CATEGORY            VARCHAR2(30),
   ITEM_DROP           VARCHAR2(30),
   VARIANT             VARCHAR2(30),
   SIZE_INDEX          VARCHAR2(6),
   SIZE_INDEX_1        VARCHAR2(6),
   SUPPLIER            VARCHAR2(20),
   MODEL               VARCHAR2(10),
   FABRIC              VARCHAR2(10),
   COLOR               VARCHAR2(10),
   PRODUCT             VARCHAR2(30),
   STYLE_NUM           VARCHAR2(10),
   PROMOTION_NUM       VARCHAR2(10),
   MANUAL_PRICE_ENTRY  VARCHAR2(6),
   STATUS              VARCHAR2(1),
   STG_EVENT_ID        NUMBER,
   STG_STATUS          NUMBER                    DEFAULT 0,
   STG_ERROR_MESSAGE   VARCHAR2(255),
   STG_LOAD_DATE       DATE,
   STG_PROCESS_DATE    DATE
);

DROP SYNONYM &&2..ARM_STG_ITEM;

CREATE  SYNONYM &&2..ARM_STG_ITEM FOR &&1..ARM_STG_ITEM;

GRANT ALL ON  &&2..ARM_STG_ITEM TO &&2;
