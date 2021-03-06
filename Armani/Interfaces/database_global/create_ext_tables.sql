REM ..................................
REM Execute these as "ARMANI_EXT" user
REM ..................................

DROP TABLE ARM_STG_CURRENCY_RT;

CREATE TABLE ARM_STG_CURRENCY_RT 
(
  FROM_CURRENCY  VARCHAR2 (10), 
  TO_CURRENCY    VARCHAR2 (10), 
  CURRENCY_RATE  NUMBER, 
  UPDATE_DATE    CHAR(8),
  STG_EVENT_ID       NUMBER,
  STG_STATUS         NUMBER DEFAULT 0, 
  STG_ERROR_MESSAGE  VARCHAR2 (255), 
  STG_LOAD_DATE      DATE, 
  STG_PROCESS_DATE   DATE
);

DROP TABLE ARM_STG_EMPLOYEE;

CREATE TABLE ARM_STG_EMPLOYEE 
(
  TRAN_TYPE          NUMBER (2), 
  ID                 VARCHAR2 (30), 
  FIRST_NAME         VARCHAR2 (30), 
  LAST_NAME          VARCHAR2 (30), 
  DATE_OF_BIRTH      DATE, 
  EMAIL              VARCHAR2 (30), 
  HOME_PHONE_AREA    VARCHAR2 (4), 
  HOME_PHONE_NUMBER  VARCHAR2 (10), 
  ADDRESS_LINE1      VARCHAR2 (50), 
  ADDRESS_LINE2      VARCHAR2 (50), 
  CITY               VARCHAR2 (30), 
  STATE              VARCHAR2 (30), 
  POSTAL_CODE        VARCHAR2 (30), 
  COUNTRY            VARCHAR2 (20), 
  STATUS             NUMBER, 
  HOME_STORE_ID      VARCHAR2 (30), 
  HIRE_DATE          DATE, 
  TERM_DATE          DATE, 
  ROLE               CHAR (1), 
  STG_EVENT_ID       NUMBER,
  STG_STATUS         NUMBER,
  STG_ERROR_MESSAGE  VARCHAR2 (255), 
  STG_LOAD_DATE      DATE, 
  STG_PROCESS_DATE   DATE
);

REM ..............................................
DROP TABLE ARM_STG_PRM;

CREATE TABLE ARM_STG_PRM 
(
  START_DATE         DATE,
  START_TIME         VARCHAR2(10),
  END_DATE           DATE, 
  END_TIME       VARCHAR2(10),
  STORE_ID           VARCHAR2 (10), 
  PROMOTION_NUM      VARCHAR2 (10), 
  PROMOTION_NAME     VARCHAR2(50),
  APPLY_TO           CHAR (1), 
  DISCOUNT_AMOUNT    NUMBER (20), 
  DISCOUNT_PERCENT   NUMBER (20), 
  DISCOUNT_TYPE      CHAR (1), 
  THRESHOLD_AMT      NUMBER (20), 
  IS_DISCOUNT        CHAR (1), 
  APPLICABLE_ITM     CHAR (1), 
  STG_EVENT_ID       NUMBER,
  STG_STATUS         NUMBER DEFAULT 0, 
  STG_ERROR_MESSAGE  VARCHAR2 (255), 
  STG_LOAD_DATE      DATE, 
  STG_PROCESS_DATE   DATE
);

REM ..............................................
DROP TABLE ARM_STG_REGISTER;

CREATE TABLE ARM_STG_REGISTER 
(
  COMPANY_CD         VARCHAR2 (50), 
  STORE_ID           VARCHAR2 (50), 
  REGISTER_ID        VARCHAR2 (10), 
  DESCRIPTION        VARCHAR2 (50), 
  ARROUNDING_TYPE    VARCHAR2 (10), 
  MAX_TILL_AMOUNT    NUMBER (10),
  REGISTER_TYPE      VARCHAR2(1),
  STG_EVENT_ID       NUMBER,
  STG_STATUS         NUMBER DEFAULT 0, 
  STG_ERROR_MESSAGE  VARCHAR2 (255), 
  STG_LOAD_DATE      DATE, 
  STG_PROCESS_DATE   DATE
);

REM ..............................................
DROP TABLE ARM_STG_STORE;

CREATE TABLE ARM_STG_STORE 
(
  TRAN_TYPE            NUMBER (2), 
  COMPANY_CODE         VARCHAR2 (30), 
  COMPANY_DESC         VARCHAR2(50),
  COMP_OFFICE_PHONE_AREA VARCHAR2(4),
  COMP_OFFICE_PHONE_NUMBER VARCHAR2(10),
  COMP_ADDRESS_LINE1    VARCHAR2(50),
  COMP_ADDRESS_LINE2    VARCHAR2(50),
  COMP_CITY             VARCHAR2(30),
  COMP_STATE            VARCHAR2(30),
  COMP_POSTAL_CODE      VARCHAR2(30),
  COMP_COUNTRY          VARCHAR2(20),
  SHOP_CODE             VARCHAR2(30), 
  SHOP_DESC         VARCHAR2(50),
  OFFICE_PHONE_AREA     VARCHAR2 (4), 
  OFFICE_PHONE_NUMBER   VARCHAR2 (10), 
  ADDRESS_LINE1         VARCHAR2 (50), 
  ADDRESS_LINE2         VARCHAR2 (50), 
  CITY                  VARCHAR2 (30), 
  STATE                 VARCHAR2 (30), 
  POSTAL_CODE           VARCHAR2 (30), 
  COUNTRY               VARCHAR2 (20), 
  CURRENCY              VARCHAR2 (10), 
  TAX_RATE              NUMBER (4,2), 
  COUNTRY_CODE          VARCHAR2 (5), 
  LANGUAGE_CODE         VARCHAR2 (5), 
  BRAND_ID              VARCHAR2(30),
  FRANKING_COMPANY_NAME VARCHAR2(30),
  FRANKING_COMPANY_AC_NUM VARCHAR2(30),
  FISCAL_CODE          VARCHAR2(30),
  STG_EVENT_ID         NUMBER,
  STG_STATUS           NUMBER, 
  STG_ERROR_MESSAGE    VARCHAR2 (255), 
  STG_LOAD_DATE        DATE, 
  STG_PROCESS_DATE     DATE
);

REM ..............................................
DROP TABLE ARM_OUT_STG_TIMECARD;

CREATE TABLE ARM_OUT_STG_TIMECARD 
(
  TRN_CODE           VARCHAR2 (20), 
  COMPANY_CODE       VARCHAR2 (30), 
  SHOP_CODE          VARCHAR2 (30), 
  EMP_HR_ID          VARCHAR2 (30), 
  WEEK_ENDING        VARCHAR2 (8), 
  TIMESTAMP          TIMESTAMP(6), 
  STATUS         CHAR(1),
  DATA_POPULATION_DT DATE,
  EXTRACTED_DT       DATE
);

REM ..............................................
DROP TABLE ARM_OUT_STG_TIMECARD_MODS;

CREATE TABLE ARM_OUT_STG_TIMECARD_MODS 
(
  TRN_CODE           VARCHAR2 (20), 
  COMPANY_CODE       VARCHAR2 (30), 
  SHOP_CODE          VARCHAR2 (30), 
  EMP_HR_ID          VARCHAR2 (30), 
  WEEK_ENDING        VARCHAR2 (8), 
  BF_TIMESTAMP       TIMESTAMP(6), 
  AF_TIMESTAMP       TIMESTAMP(6), 
  MOD_TIMESTAMP      TIMESTAMP(6), 
  MOD_EMP_HR_ID      VARCHAR2 (30), 
  MOD_REASON         VARCHAR2 (200), 
  STATUS         CHAR(1),
  DATA_POPULATION_DT DATE,
  EXTRACTED_DT       DATE
);

DROP SEQUENCE STG_EVENT_ID_S;

CREATE SEQUENCE STG_EVENT_ID_S;



DROP TABLE ARM_PROCESS_LOG;

CREATE TABLE ARM_PROCESS_LOG
(
  INTERFACE_KEY  VARCHAR2(20),
  START_TIME     DATE,
  END_TIME       DATE,
  STATUS         CHAR(1),
  RECORD_NUM     NUMBER,
  FILE_NAME      VARCHAR2(100)
);

DROP TABLE ARM_MISC_LOOKUP;

CREATE TABLE ARM_MISC_LOOKUP
(
  LOOKUP_TYPE   VARCHAR2(30)               NOT NULL PRIMARY KEY,
  LOOKUP_CODE   VARCHAR2(30)               NOT NULL,
  MEANING       VARCHAR2(80)               NOT NULL,
  DESCRIPTION   VARCHAR2(240),
  ENABLED_FLAG  VARCHAR2(1)                NOT NULL
);


REM ..................................
REM Execute these as "ARMANI_EXT" user
REM ..................................

DROP TABLE ARM_STG_TAX_FREE;

CREATE TABLE ARM_STG_TAX_FREE (
    TRAN_TYPE           NUMBER(2) NOT NULL,
    STORE_CODE          VARCHAR2(20) NOT NULL,
    DETAX_CODE          VARCHAR2(50) NOT NULL,
    DESC_CODE           VARCHAR2(50),
    RATIO               NUMBER(9,2),
    START_DATE          DATE NOT NULL,
    NET_MIN_VALUE       VARCHAR2(75),
    GROSS_MIN_VALUE     VARCHAR2(75),
    PAYMENT_CODE        VARCHAR2(20),
    MIN_PRICE           VARCHAR2(75),
    MAX_PRICE           VARCHAR2(75),
    MIN_AMOUNT          VARCHAR2(75),
    MAX_AMOUNT          VARCHAR2(75),
    REFUND_AMOUNT       VARCHAR2(75),
    REFUND_PERCENT      VARCHAR2(10),
    COMMISSION          VARCHAR2(20),
    STG_EVENT_ID        NUMBER,
    STG_STATUS          NUMBER DEFAULT 0, 
    STG_ERROR_MESSAGE   VARCHAR2(255), 
    STG_LOAD_DATE       DATE, 
    STG_PROCESS_DATE    DATE
);

DROP TABLE ARM_FISCAL_DOC_NO;

CREATE TABLE ARM_STG_FISCAL_DOC_NO (
    TRAN_TYPE           NUMBER(2) NOT NULL,
    REGISTER_ID         VARCHAR2(10) NOT NULL,
    ID_STR_RT           VARCHAR2(20) NOT NULL,
    LAST_DDT_NO         VARCHAR2(20),
    LAST_VAT_NO         VARCHAR2(20),
    LAST_CREDIT_NOTE    VARCHAR2(20),
    STG_EVENT_ID        NUMBER,
    STG_STATUS          NUMBER DEFAULT 0, 
    STG_ERROR_MESSAGE   VARCHAR2(255), 
    STG_LOAD_DATE       DATE, 
    STG_PROCESS_DATE    DATE
);

DROP TABLE ARM_STG_FISCAL_DOC;

CREATE TABLE ARM_STG_FISCAL_DOC ( 
    TRANSACTION_ID     VARCHAR2 (20)  NOT NULL, 
    DOC_NUM            VARCHAR2 (10)  NOT NULL, 
    DOC_TYPE           VARCHAR2 (2)   NOT NULL, 
    COMPANY_NAME       VARCHAR2 (30)  NOT NULL, 
    COMPANY_NAME2      VARCHAR2 (30)  NOT NULL, 
    ADDRESS            VARCHAR2 (60)  NOT NULL, 
    ADDRESS_2          VARCHAR2 (60), 
    CITY               VARCHAR2 (30)  NOT NULL, 
    COUNTY             VARCHAR2 (30)  NOT NULL, 
    ZIP_CODE           VARCHAR2 (10)  NOT NULL, 
    COUNTRY            VARCHAR2 (30)  NOT NULL, 
    PRE_VAT_AMOUNT     NUMBER (9,2), 
    POST_VAT_AMOUNT    NUMBER (9,2), 
    VAT_EXEMPT_CD      VARCHAR2 (20), 
    FISCAL_CD          VARCHAR2 (20), 
    SUPP_PAYMENT_TYPE  VARCHAR2 (20), 
    VAT_NUM            VARCHAR2 (20), 
    TAX_FREE_CD        VARCHAR2 (20), 
    PAYMENT_TYPE       VARCHAR2 (20), 
    ID_TYPE            VARCHAR2 (20), 
    PLACE_OF_ISSUE     VARCHAR2 (20), 
    DATE_OF_ISSUE      VARCHAR2 (20), 
    REFUND_AMOUNT      NUMBER(9,2), 
    DESTINATION_CD     VARCHAR2 (10), 
    SENDER             VARCHAR2 (30), 
    SENDER_CD          VARCHAR2 (20), 
    CARRIER_TYPE       VARCHAR2 (20), 
    EXPEDITION_CD      VARCHAR2 (10), 
    GOODS_NUM          VARCHAR2 (20), 
    CARRIER_CD         VARCHAR2 (10), 
    CARRIER_DESC       VARCHAR2 (50), 
    PACKAGE_TYPE       VARCHAR2 (10), 
    WEIGHT             NUMBER(5,2), 
    NOTE               VARCHAR2 (100) 
 ); 
 
 ALTER TABLE ARM_STG_FISCAL_DOC ADD PRIMARY KEY (TRANSACTION_ID, DOC_NUM, DOC_TYPE);
 
 
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
   DEPT                NUMBER(4),
   CLASS               NUMBER(4),
   SUB_CLASS           NUMBER(4),
   NEW_PRICE           NUMBER,
   OLD_PRICE           NUMBER,
   CURRENCY            VARCHAR2(3),
   TAXABLE_IND         VARCHAR2(1),
   VAT_RATE            NUMBER,
   VAT_CODE            VARCHAR2(6),
   YEAR                VARCHAR2(4),
   SEASON              NUMBER(3),
   BRAND               VARCHAR2(10),
   LABEL               VARCHAR2(30),
   SUBLINE             VARCHAR2(30),
   GENDER              VARCHAR2(10),
   CATEGORY            VARCHAR2(30),
   ITEM_DROP           VARCHAR2(30),
   VARIANT             VARCHAR2(30),
   SIZE_INDEX          VARCHAR2(6),
   SIZE_INDEX_1        VARCHAR2(6),
   SUPPLIER            NUMBER(10),
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
 

CREATE TABLE ARM_STG_TAX_RATE
(
  ZIP_CODE      VARCHAR2(10),
  CITY          VARCHAR2(50),
  COUNTY        VARCHAR2(50),
  STATE         VARCHAR2(10),
  TAX_RATE      NUMBER(9,4),
  EFFECTIVE_DT  DATE,
  STG_EVENT_ID        NUMBER,
  STG_STATUS          NUMBER                    DEFAULT 0,
  STG_ERROR_MESSAGE   VARCHAR2(255),
  STG_LOAD_DATE       DATE,
  STG_PROCESS_DATE    DATE
);



CREATE TABLE ARM_STG_CUST_OUT ( 
  RECORD_TYPE          CHAR (2)      NOT NULL, 
  CUSTOMER_ID          VARCHAR2 (20)  NOT NULL, 
  STATUS               NUMBER (1) DEFAULT 0, 
  DATA_POPULATION_DT   DATE, 
  EXTRACTED_DT         DATE, 
  CUST_BARCODE         VARCHAR2 (20), 
  TITLE                VARCHAR2 (10), 
  FIRST_NM             VARCHAR2 (30), 
  LAST_NM              VARCHAR2 (30), 
  MIDDLE_NM            VARCHAR2 (15), 
  SUFFIX               VARCHAR2 (12), 
  DB_FIRST_NM          VARCHAR2 (30), 
  DB_LAST_NM           VARCHAR2 (30), 
  GENDER               CHAR (1), 
  CUST_TYPE            VARCHAR2 (10), 
  LOYALTY_PROGRAM      CHAR (1), 
  VIP_PERCENT          NUMBER (4,2), 
  PRIVACY              CHAR (1), 
  NO_MAIL              CHAR (1), 
  NO_EMAIL             CHAR (1), 
  NO_CALL              CHAR (1), 
  NO_SMS               CHAR (1), 
  EMAIL1               VARCHAR2 (40), 
  EMAIL2               VARCHAR2 (40), 
  VAT_NUM              VARCHAR2 (25), 
  FISCAL_CD            VARCHAR2 (25), 
  ID_TYPE              VARCHAR2 (25), 
  DOC_NUM              VARCHAR2 (25), 
  PLACE_OF_ISSUE       VARCHAR2 (25), 
  ISSUE_DT             DATE, 
  PAY_TYPE             VARCHAR2 (25), 
  COMPANY_ID           VARCHAR2 (11), 
  INTER_CMY_CD         VARCHAR2 (11), 
  CUST_STATUS          VARCHAR2 (6), 
  ACC_NUM              VARCHAR2 (11), 
  BIRTH_DAY            VARCHAR2 (2), 
  BIRTH_MONTH          VARCHAR2 (2), 
  REAL_BIRTHDAY        VARCHAR2 (10), 
  AGE                  VARCHAR2 (2), 
  REFERRED_BY          VARCHAR2 (11), 
  PROFESSION           VARCHAR2 (25), 
  EDUCATION            VARCHAR2 (25), 
  NOTES1               VARCHAR2 (100), 
  NOTES2               VARCHAR2 (100), 
  PNTR_FMLY_NM         VARCHAR2 (30), 
  PNTR_NM              VARCHAR2 (30), 
  BIRTH_PLACE          VARCHAR2 (30), 
  SPL_EVT_TYPE         VARCHAR2 (20), 
  SPL_EVT_DT           DATE, 
  CHILDREN_NAMES       VARCHAR2 (50), 
  NUM_OF_CHILDREN      NUMBER (2), 
  CREATEDOFFLINE       CHAR (1), 
  COUNTRY              VARCHAR2 (30), 
  POST_CODE            VARCHAR2 (10), 
  STATE                VARCHAR2 (30), 
  CITY                 VARCHAR2 (30), 
  ADDRESS_LINE_1       VARCHAR2 (50), 
  ADDRESS_LINE_2       VARCHAR2 (50), 
  UNIT_NAME            VARCHAR2 (50), 
  ADDRESS_TYPE         VARCHAR2 (20), 
  PHONE_TYPE_1         VARCHAR2 (20), 
  PHONE_NUMBER_1       VARCHAR2 (20), 
  PHONE_TYPE_2         VARCHAR2 (20), 
  PHONE_NUMBER_2       VARCHAR2 (20), 
  PHONE_TYPE_3         VARCHAR2 (20), 
  PHONE_NUMBER_3       VARCHAR2 (20), 
  USE_AS_PRIMARY_ADDR  CHAR (1), 
  STORE_ID             VARCHAR2 (30), 
  COMPANY_CD           VARCHAR2 (30), 
  BRAND                VARCHAR2 (30), 
  ASSOCIATE_ID         VARCHAR2 (30), 
  CREATE_DATE          DATE, 
  COMMENTS             VARCHAR2 (50), 
  SUPPLIER_PAYMENT     VARCHAR2 (20), 
  BANK                 VARCHAR2 (30), 
  CRDT_CRD_NUM_1       VARCHAR2 (30), 
  CRDT_CRD_TYP_1       VARCHAR2 (30), 
  CRDT_CRD_NUM_2       VARCHAR2 (30), 
  CRDT_CRD_TYP_2       VARCHAR2 (30) 
) ; 


CREATE TABLE ARM_STG_INVENTORY
(
	ITEM_ID VARCHAR2(25),
	STORE_ID VARCHAR2(30),
	BALANCE_DATE DATE,
	AVAILABLE_QTY NUMBER(4) DEFAULT 0,
	UNAVAILABLE_QTY NUMBER(4) DEFAULT 0,
	TOTAL_SALE_QTY NUMBER(4) DEFAULT 0,
	RECEIPT_QTY NUMBER(4) DEFAULT 0,
	TRANSFER_QTY NUMBER(4) DEFAULT 0,
	STOCK_ADJ_QTY NUMBER(4) DEFAULT 0,
	ON_ORDER_QTY NUMBER(4) DEFAULT 0,
	IS_BALANCE CHAR(1),
	STG_EVENT_ID        NUMBER,
	STG_STATUS          NUMBER                    DEFAULT 0,
	STG_ERROR_MESSAGE   VARCHAR2(255),
	STG_LOAD_DATE       DATE,
	STG_PROCESS_DATE    DATE
);


CREATE TABLE ARM_STG_CUST_IN
(
  RECORD_TYPE          CHAR(2),
  CUSTOMER_ID          VARCHAR2(20),
  CUST_BARCODE         VARCHAR2(20),
  TITLE                VARCHAR2(10),
  FIRST_NM             VARCHAR2(30),
  LAST_NM              VARCHAR2(30),
  MIDDLE_NM            VARCHAR2(15),
  SUFFIX               VARCHAR2(12),
  DBYTE_FIRST_NM       VARCHAR2(30),
  DBYTE_LAST_NM        VARCHAR2(30),
  GENDER               CHAR(1),
  CUST_TYPE            VARCHAR2(10),
  LOYALTY_PROGRAM      CHAR(1),
  VIP_PERCENT          NUMBER(4,2),
  PRIVACY              CHAR(1),
  NO_MAIL              CHAR(1),
  NO_CALL              CHAR(1),
  NO_EMAIL             CHAR(1),
  NO_SMS               CHAR(1),
  EMAIL1               VARCHAR2(40),
  EMAIL2               VARCHAR2(40),
  VAT_NUM              VARCHAR2(25),
  FISCAL_CD            VARCHAR2(25),
  ID_TYPE              VARCHAR2(25),
  DOC_NUM              VARCHAR2(25),
  PLACE_OF_ISSUE       VARCHAR2(25),
  ISSUE_DT             DATE,
  PAY_TYPE             VARCHAR2(25),
  COMPANY_ID           VARCHAR2(11),
  INTER_CMY_CD         VARCHAR2(11),
  STATUS               CHAR(1),
  ACCT_NUM             VARCHAR2(11),
  BIRTH_DAY            VARCHAR2(2),
  BIRTH_MONTH          VARCHAR2(2),
  REAL_BIRTHDAY        VARCHAR2(10),
  AGE                  VARCHAR2(2),
  REFERRED_BY          VARCHAR2(11),
  PROFESSION           VARCHAR2(25),
  EDUCATION            VARCHAR2(25),
  NOTES_1              VARCHAR2(100),
  NOTES_2              VARCHAR2(100),
  PNTR_FMLY_NM         VARCHAR2(30),
  PNTR_NM              VARCHAR2(30),
  BIRTH_PLACE          VARCHAR2(30),
  SPL_EVT_TYPE         VARCHAR2(20),
  SPL_EVT_DT           DATE,
  CHILDREN_NAMES       VARCHAR2(50),
  NUM_OF_CHILDREN      NUMBER(2),
  CR_CARD_NUM_1        VARCHAR2(30),
  CR_CARD_TYPE_1       VARCHAR2(30),
  CR_CARD_NUM_2        VARCHAR2(30),
  CR_CARD_TYPE_2       VARCHAR2(30),
  COUNTRY              VARCHAR2(50),
  POST_CODE            VARCHAR2(10),
  STATE                VARCHAR2(30),
  CITY                 VARCHAR2(30),
  ADDRESS_LINE_1       VARCHAR2(50),
  ADDRESS_LINE_2       VARCHAR2(50),
  UNIT_NAME            VARCHAR2(50),
  ADDRESS_TYPE         VARCHAR2(20),
  PHONE_TYPE_1         VARCHAR2(20),
  PHONE_NUMBER_1       VARCHAR2(20),
  PHONE_TYPE_2         VARCHAR2(20),
  PHONE_NUMBER_2       VARCHAR2(20),
  PHONE_TYPE_3         VARCHAR2(20),
  PHONE_NUMBER_3       VARCHAR2(20),
  USE_AS_PRIMARY_ADDR  CHAR(1),
  STORE_ID             VARCHAR2(30),
  COMPANY_CODE         VARCHAR2(30),
  BRAND                VARCHAR2(30),
  ASSOCIATE_ID         VARCHAR2(30),
  CREATE_DATE          DATE,
  COMMENTS             VARCHAR2(50),
  OLD_CUSTOMER_ID      VARCHAR2(20),
  STG_EVENT_ID         NUMBER,
  STG_STATUS           NUMBER DEFAULT 0,
  STG_ERROR_MESSAGE    VARCHAR2(255),
  STG_LOAD_DATE        DATE,
  STG_PROCESS_DATE     DATE
);


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



CREATE TABLE ARM_STG_REDEEMABLE
(
	TRAN_TYPE		NUMBER(2),
	REDEEMABLE_TYPE		VARCHAR2(30),
	ISSUE_DATE		DATE,
	ISSUE_STORE_ID		VARCHAR2(30),
	CURRENCY_CD		CHAR(3),
	FACE_VALUE_AMOUNT	NUMBER(8,2),
	BALANCE_AMOUNT		NUMBER(8,2),
	CONTROL_ID		VARCHAR2(50),
	CUSTOMER_ID		VARCHAR2(20),
	EXPIRY_DATE		DATE,
	STG_EVENT_ID		NUMBER,
	STG_STATUS		NUMBER                    DEFAULT 0,
	STG_ERROR_MESSAGE	VARCHAR2(255),
	STG_LOAD_DATE		DATE,
	STG_PROCESS_DATE	DATE
);


CREATE TABLE ARM_STG_RSVO_CSGO
(
	RECORD_TYPE		CHAR(1),
	TRANSACTION_ID		VARCHAR2(20),
	ADD_NO			VARCHAR2(20),
	EXPIRATION_DATE		DATE,
	TRANSACTION_TYPE	VARCHAR2(10),
	TRANSACTION_DATE	CHAR(14),
	STORE_ID		VARCHAR2(50),
	REGISTER_NO		VARCHAR2(50),
	OPERATOR_ID		VARCHAR2(50),
	SALES_ASSOCIATE_ID	VARCHAR2(50),
	TRANSACTION_NET_AMOUNT	NUMBER(10,2)              DEFAULT 0,
	LINE_ITEM_TYPE		CHAR(1),
	ITEM_ID			VARCHAR2(20),
	MISC_ITEM_ID		VARCHAR2(20),
	IS_PROCESSED		CHAR(1),
	QUANTITY		NUMBER(3)	DEFAULT 0,
	CURRENCY_CODE		CHAR(3),
	RETAIL_PRICE		NUMBER(10,2)              DEFAULT 0,
	SELLING_PRICE		NUMBER(10,2)              DEFAULT 0,
	LN_ITM_NET_AMT		NUMBER(10,2)              DEFAULT 0,
	LN_ITM_TAX_AMT		NUMBER(10,2)              DEFAULT 0,
	TAX_EXEMPT_ID		VARCHAR2(20),
	MANUAL_TAX_AMT		NUMBER(10,2)              DEFAULT 0,
	CUSTOMER_ROLE		CHAR(1),
	CUSTOMER_ID		VARCHAR2(30),
	CUST_FIRST_NAME		VARCHAR2(30),
	CUST_LAST_NAME		VARCHAR2(60),
	CUST_ADDRRESS_LINE_1	VARCHAR2(60),
	CUST_ADDRRESS_LINE_2	VARCHAR2(30),
	CUST_CITY		VARCHAR2(30),
	CUST_STATE		VARCHAR2(30),
	CUST_COUNTRY		VARCHAR2(30),
	CUST_PCODE		VARCHAR2(10),
	CUST_PHONE_1		VARCHAR2(30),
	CUST_PHONE_2		VARCHAR2(30),
	TND_TYPE		VARCHAR2(20),
	TND_AMOUNT		NUMBER(10,2)              DEFAULT 0,
	STG_EVENT_ID		NUMBER,
	STG_STATUS		NUMBER                    DEFAULT 0,
	STG_ERROR_MESSAGE	VARCHAR2(255),
	STG_LOAD_DATE		DATE,
	STG_PROCESS_DATE	DATE
);



CREATE TABLE ARM_STG_TXN_HIST
(
	RECORD_TYPE		CHAR(1),
	TRANSACTION_ID		VARCHAR2(20),
	TRANSACTION_TYPE	VARCHAR2(10),
	TRANSACTION_DATE	DATE,
	STORE_ID		VARCHAR2(50),
	REGISTER_NO		VARCHAR2(50),
	OPERATOR_ID		VARCHAR2(50),
	ASSOCIATE_ID		VARCHAR2(50),
	TXN_NET_AMOUNT		NUMBER,
	LINE_ITEM_TYPE		CHAR(1),
	ITEM_ID			VARCHAR2(20),
	MISC_ITEM_ID		VARCHAR2(20),
	QUANTITY		NUMBER,
	CURRENCY_CD		CHAR(3),
	RETAIL_PRICE		NUMBER,
	SELLING_PRICE		NUMBER,
	MANUAL_MARKDOWN_AMT	NUMBER,
	MANUAL_UNIT_PRICE	NUMBER,
	REDUCTION_AMT		NUMBER,
	REDUCTION_REASON	CHAR(1),
	LN_ITM_NET_AMT		NUMBER,
	LN_ITM_TAX_AMT		NUMBER,
	TAX_EXEMPT_ID		VARCHAR2(20),
	MANUAL_TAX_AMT		NUMBER,
	RETURN_REASON_ID	VARCHAR2(20),
	RETURN_COMMENTS		VARCHAR2(50),
	ORIG_TRANSACTION_ID	VARCHAR2(50),
	ORIG_STORE_ID		VARCHAR2(50),
	ORIG_PROCESS_DT		VARCHAR2(50),
	ORIG_OPERATOR_ID	VARCHAR2(50),
	ORIG_REGISTER_ID	VARCHAR2(50),
	CUST_ROLE		CHAR(1),
	EXT_CUST_ID		VARCHAR2(30),
	CUST_FIRST_NAME		VARCHAR2(30),
	CUST_LAST_NAME		VARCHAR2(60),
	CUST_ADDR_LINE_1	VARCHAR2(60),
	CUST_ADDR_LINE_2	VARCHAR2(30),
	CUST_CITY		VARCHAR2(30),
	CUST_STATE		VARCHAR2(30),
	CUST_COUNTRY		VARCHAR2(30),
	CUST_PCODE		VARCHAR2(10),
	CUST_PHONE_1		VARCHAR2(30),
	CUST_PHONE_2		VARCHAR2(30),
	TND_TYPE		VARCHAR2(20),
	TND_AMOUNT		NUMBER,
	TND_ID_ACNT_NMB		VARCHAR2(30),
	TND_RESP_AUTH		VARCHAR2(30),
	TND_APPROVAL_DATE	DATE,
	TND_EXPIRATION_DT	DATE,
	TND_HOLDER_NAME		VARCHAR2(50),
	CC_CVV_CODE		VARCHAR2(10),
	CC_AMEX_CID_NUM		VARCHAR2(10),
	TND_SWIPE_IND		CHAR(1),
	TND_RESP_ADDRESS_VERIF	VARCHAR2(20),
	TND_RESP_JOURNAL_KEY	VARCHAR2(50),
	TND_RESP_MSG		VARCHAR2(50),
	TND_RESP_MSG_NUM	NUMBER,
	TND_MERCHANT_ID		VARCHAR2(20),
	TND_CARD_IDNFR		CHAR(2),
	CC_CARD_PLAN		VARCHAR2(20),
	TND_MANUAL_OVERRIDE	CHAR(1),
	CHK_ABA_NUM		VARCHAR2(20),
	CHK_ROUTING_NUM		VARCHAR2(20),
	CHK_BANK		VARCHAR2(20),
	CHK_IS_SCANNED		CHAR(1),
	RDM_TYPE		VARCHAR2(50),
	RDM_CONTROL_NUMBER	NUMBER,
	RDM_TND_ID_STR_RT	VARCHAR2(20),
	RDM_DC_CPN_SCAN_CODE	VARCHAR2(20),
	RDM_TND_PRM_CODE	VARCHAR2(10),
	RDM_EXPIRATION_DATE	DATE,
	STG_EVENT_ID		NUMBER,
	STG_STATUS		NUMBER                    DEFAULT 0,
	STG_ERROR_MESSAGE	VARCHAR2(255),
	STG_LOAD_DATE		DATE,
	STG_PROCESS_DATE	DATE
);


CREATE TABLE ARM_STG_TXN_HDR
(	
TRANSACTION_ID		VARCHAR2(50) NOT NULL,
TRANSACTION_TYPE	VARCHAR2(6) NOT NULL,
PAY_TXN_TYPE		VARCHAR2(20),
TRANSACTION_NUM		NUMBER(9),
ADD_NO			VARCHAR2(20),
FISCAL_NO		NUMBER,
FISCAL_RECEIPT_DATE	DATE,
ASIS_COMPANY_CD		VARCHAR2(50),
ASIS_STORE_ID		VARCHAR2(50),
ASIS_REGISTER_ID	VARCHAR2(50),
ASIS_TXN_NUM		NUMBER(9),
ASIS_TXN_DATE		DATE,
ASIS_FISCAL_RECEIPT_NO	NUMBER,
ASIS_FISCAL_DATE	DATE,
ASIS_FISCAL_DOC_NUM	VARCHAR2(50),
ASIS_FISCAL_DOC_DATE	DATE,
ASIS_FISCAL_DOC_TYPE	CHAR(2),
ASIS_CUSTOMER_ID	VARCHAR2(50),
ASIS_CUSTOMER_NAME	VARCHAR2(100),	
ASIS_COMMENTS		VARCHAR2(200),
TXN_CATEGORY		CHAR(1) NOT NULL,
ENTRY_DATE		DATE,
TR_BEGIN_DATE		DATE,
TR_END_DATE		DATE,
TRAINING_FLAG		CHAR(1),
POST_DATE		DATE NOT NULL,
SUBMIT_DATE		DATE NOT NULL,
CREATE_DATE		DATE NOT NULL,
PROCESS_DATE		DATE NOT NULL,
VOID_FLAG		CHAR(1),
CASHIER			VARCHAR2(50) NOT NULL,
REGISTER_ID		VARCHAR2(50) NOT NULL,
STORE_ID		VARCHAR2(50) NOT NULL,
COMPANY_ID		VARCHAR2(50),
EMPLOYEE_ID		VARCHAR2(50),
CUSTOMER_ID		VARCHAR2(50),
CONSULTANT_ID		VARCHAR2(50),
TAX_EXEMPT_ID		VARCHAR2(20),
TAX_JURISDICTION	VARCHAR2(20),
CLOSEOUT_FLAG		CHAR(1),
CURRENCY_CD		CHAR(3),
REDUCTION_AMOUNT	NUMBER(9,2),
NET_AMOUNT		NUMBER(9,2)
);


CREATE TABLE ARM_STG_TXN_DTL
(
RECORD_TYPE		CHAR(2) NOT NULL,
TRANSACTION_ID		VARCHAR2(20) NOT NULL,
LINE_ID			NUMBER,
LINE_SEQ_NUM		NUMBER,
LINE_ITEM_TYPE		CHAR(1),
DOC_NUM			VARCHAR2(20),
MISC_ITEM_ID		VARCHAR2(20),
MISC_ITEM_TXBL		CHAR(1),
ID_ITM			VARCHAR2(50),
QUANTITY		NUMBER,
ITM_RTL_PRICE		NUMBER(9,2),
ITM_SEL_PRICE		NUMBER(9,2),
MANUAL_MD_AMT		NUMBER(9,2),
MANUAL_UNIT_PRICE	NUMBER(9,2),
CONSULTANT_ID		VARCHAR2(20),
ADD_CONSULTANT_ID	VARCHAR2(20),
RETURN_REASON_ID	VARCHAR2(20),
RETURN_COMMENTS		VARCHAR2(50),
VAT_RATE		NUMBER(9,2),
TAX_EXEMPT_ID		VARCHAR2(20),
SHIP_STATE		VARCHAR2(20),
SHIP_ZIP_CODE		VARCHAR2(10),
NET_AMT			NUMBER(9,2),
TAX_AMT			NUMBER(9,2),
MANUAL_TAX_AMT		NUMBER(9,2),
EXCEPTION_TAX_JUR	VARCHAR2(20),
DEAL_MKDN_AMT		NUMBER(9,2),
DEAL_ID			VARCHAR2(20),
RTN_SALE_AI_TRN		VARCHAR2(20),
RTN_ORIG_STORE_ID	VARCHAR2(30),
RTN_ORIG_PROCESS_DT	DATE,
RTN_ORIG_OPR_ID		VARCHAR2(30),
RTN_ORIG_REGISTER_ID	VARCHAR2(30),
ORIG_TRANSACTION_ID	VARCHAR2(30),
ORIG_ADD_NO		VARCHAR2(30),
REDUCTION_AMOUNT	NUMBER(9,2),
REDUCTION_REASON	VARCHAR2(50),
DSC_AMOUNT		NUMBER(9,2),
DSC_PERCENT		NUMBER(9,2),
DSC_REASON		VARCHAR2(50),
DSC_EMPLOYEE_ID		VARCHAR2(50),
DSC_ADVERTISING_CODE	VARCHAR2(50),
DSC_IS_DSC_PERCENT	CHAR(1),
TND_TYPE		VARCHAR2(20),
TND_CODE		VARCHAR2(20),
TND_AMOUNT		NUMBER(9,2),
TND_ID_ACNT_NMB		VARCHAR2(30),
TND_RESP_AUTH		VARCHAR2(30),
TND_APPROVAL_DATE	DATE,
TND_EXPIRATION_DT	DATE,
TND_HOLDER_NAME		VARCHAR2(50),
TND_MANUAL_OVERRIDE	CHAR(1),
CHK_ABA_NUM		VARCHAR2(20),
CHK_ROUTING_NUM		VARCHAR2(20),
CHK_BANK		VARCHAR2(20),
CHK_IS_SCANNED		CHAR(1),
CC_CVV_CODE		VARCHAR2(10),
CC_AMEX_CID_NUM		VARCHAR2(10),
RDM_CONTROL_NUMBER	VARCHAR2(20),
TND_SWIPE_IND		CHAR(1),
TND_RESP_ADDRESS_VERIF	VARCHAR2(20),
TND_RESP_JOURNAL_KEY	VARCHAR2(50),
TND_RESP_MSG		VARCHAR2(50),
TND_RESP_MSG_NUM	VARCHAR2(20),
TND_MERCHANT_ID		VARCHAR2(20),
TND_CARD_IDENTIFIER	CHAR(2),
CC_CARD_PLAN		VARCHAR2(20),
RDM_TND_ID_STR_RT	VARCHAR2(20),
RDM_DC_CPN_SCAN_CODE	VARCHAR2(20),
RDM_TND_PRM_CODE	VARCHAR2(10),
RDM_EXPIRATION_DATE	DATE,
FC_XCHANGE_RATE		NUMBER(9,2),
FC_FROM_CURRENCY	CHAR(3),
FC_TO_CURRENCY		CHAR(3),
RDM_TYPE		VARCHAR2(20),
RDM_ISSUING_STORE	VARCHAR2(50),
RDM_CUST_NUM		VARCHAR2(50),
RDM_ISSUANCE_DT		DATE,
RDM_EXPIRATION_DT	DATE,
RDM_FACE_VALUE_AMT	NUMBER(9,2),
RDM_BALANCE_AMT		NUMBER(9,2),
RDM_BUYBACK_AMT		NUMBER(9,2),
RDM_BUYBACK_COMMENT	VARCHAR2(50),
POST_VOIDED_TRANS_NO	VARCHAR2(20),
POST_VOID_REASON	VARCHAR2(20),
POST_VOID_REGISTER	VARCHAR2(50),
CUSTOMER_ROLE		CHAR(1),
CUST_ID			VARCHAR2(30),
CUST_FIRST_NAME		VARCHAR2(30),
CUST_LAST_NAME		VARCHAR2(60),
CUST_ADDR_1		VARCHAR2(60),
CUST_ADDR_2		VARCHAR2(30),
CUST_CITY		VARCHAR2(30),
CUST_STATE		VARCHAR2(30),
CUST_COUNTRY		VARCHAR2(30),
CUST_PCODE		VARCHAR2(10),
CUST_PHONE_1		VARCHAR2(30),
CUST_PHONE_2		VARCHAR2(30),
CASHIER_TXN_COMMENT	VARCHAR2(500),
CASHIER_TXN_REASON	VARCHAR2(500),
OPENING_DRWR_FND	NUMBER(9,2),
EOD_CASH_TOTAL		VARCHAR2(100),
EOD_CHECK_TOTAL		VARCHAR2(100),
EOD_CC_TOTAL		NUMBER(9,2),
EOD_AMEX_TOTAL		NUMBER(9,2),
EOD_DISC_TOTAL		NUMBER(9,2),
EOD_TR_CHKS_TOTAL	NUMBER(9,2),
EOD_DRWR_FND		NUMBER(9,2),
ORIG_LINE_ITEM_TYPE	CHAR(1)
);



ALTER TABLE ARM_STG_ITEM
ADD (SIZE_ID VARCHAR2(6));

ALTER TABLE ARM_STG_ITEM
MODIFY (
	MODEL VARCHAR2(50),
	FABRIC VARCHAR2(50)
);


ALTER TABLE ARM_STG_REDEEMABLE
ADD (
	FN_HOLDER VARCHAR2(50),
	LN_HOLDER VARCHAR2(50),
	STATUS CHAR(1)
);


ALTER TABLE ARM_STG_TXN_HIST
MODIFY (RDM_CONTROL_NUMBER NUMBER);

alter table ARM_STG_TAX_RATE
    modify TAX_RATE number(10,5);
    


ALTER TABLE ARM_STG_TXN_DTL 
ADD (
	EOD_TND_TYPE	VARCHAR2(20),
	EOD_TND_TOTAL	VARCHAR2(200)
);


ALTER TABLE ARM_STG_CUST_IN
ADD (
    CA_STORE_ID VARCHAR2(30),
    CA_COMPANY_CODE VARCHAR2(30),
    CA_BRAND    VARCHAR2(30),
    CA_ASSOCIATE_ID VARCHAR2(30)
);

ALTER TABLE ARM_STG_TXN_DTL 
DROP (
    EOD_CASH_TOTAL,    
    EOD_CHECK_TOTAL,    
    EOD_CC_TOTAL,       
    EOD_AMEX_TOTAL,     
    EOD_DISC_TOTAL,     
    EOD_TR_CHKS_TOTAL,   
    EOD_DRWR_FND
);

ALTER TABLE ARM_STG_ITEM
MODIFY REF_ITEM VARCHAR2(50);

ALTER TABLE ARM_STG_TXN_DTL
MODIFY RETURN_COMMENTS VARCHAR2(200);

ALTER TABLE ARM_STG_TXN_DTL
ADD NOT_IN_FILE_SKU_DTL VARCHAR2(100);

ALTER TABLE ARM_STG_TXN_DTL
ADD (
  STATUS CHAR DEFAULT 0,
  DATA_POPULATION_DT DATE,
  EXTRACTED_DT DATE
);

ALTER TABLE ARM_STG_TXN_HDR
ADD (
  STATUS CHAR DEFAULT 0,
  DATA_POPULATION_DT DATE,
  EXTRACTED_DT DATE
);



--------------------
--  Create Dept
----------------------
CREATE TABLE ARM_STG_DEPT
(
  ID_DPT_POS         VARCHAR2(128 BYTE)         NOT NULL,
  NM_DPT_POS         VARCHAR2(40 BYTE),
  ID_DPT_POS_PRNT    VARCHAR2(128 BYTE),
  STG_EVENT_ID       NUMBER,
  STG_STATUS         NUMBER,
  STG_ERROR_MESSAGE  VARCHAR2(255 BYTE),
  STG_LOAD_DATE      DATE,
  STG_PROCESS_DATE   DATE
);

----------------------------------------
-- Create Class
----------------------------------------

CREATE TABLE ARM_STG_CLASS
(
  ID_DPT             VARCHAR2(128 BYTE),
  ID_CLSS            VARCHAR2(128 BYTE),
  NM_CLSS            VARCHAR2(50 BYTE),
  STG_EVENT_ID       NUMBER,
  STG_STATUS         NUMBER,
  STG_ERROR_MESSAGE  VARCHAR2(255 BYTE),
  STG_LOAD_DATE      DATE,
  STG_PROCESS_DATE   DATE
);




------------------------------------------------
--  Create Subclass
------------------------------------------------

CREATE TABLE ARM_STG_SUBCLASS
(
  ID_DPT             VARCHAR2(128 BYTE),
  ID_CLSS            VARCHAR2(128 BYTE),
  ID_SBCL            VARCHAR2(128 BYTE),
  NM_SBCL            VARCHAR2(20 BYTE),
  STG_EVENT_ID       NUMBER,
  STG_STATUS         NUMBER,
  STG_ERROR_MESSAGE  VARCHAR2(255 BYTE),
  STG_LOAD_DATE      DATE,
  STG_PROCESS_DATE   DATE
);



-----------------------------------------------------
-- Create Supplier
-----------------------------------------------------
CREATE TABLE ARM_STG_SPR
(
  ID_SPR             VARCHAR2(10 BYTE),
  NM_SPR             VARCHAR2(30 BYTE),
  STG_EVENT_ID       NUMBER,
  STG_STATUS         NUMBER,
  STG_ERROR_MESSAGE  VARCHAR2(255 BYTE),
  STG_LOAD_DATE      DATE,
  STG_PROCESS_DATE   DATE
);



----------------------------------------------
-- Create Size
------------------------------------------------

CREATE TABLE ARM_STG_SIZE
(
  ID_SIZE            VARCHAR2(6 BYTE),
  DE_SIZE            VARCHAR2(30 BYTE),
  SIZE_INDEX         VARCHAR2(10 BYTE),
  EXT_SIZE_INDEX     VARCHAR2(10 BYTE),
  ED_CO              VARCHAR2(20 BYTE),
  ED_LA              VARCHAR2(20 BYTE),
  STG_EVENT_ID       NUMBER,
  STG_STATUS         NUMBER,
  STG_ERROR_MESSAGE  VARCHAR2(255 BYTE),
  STG_LOAD_DATE      DATE,
  STG_PROCESS_DATE   DATE
);



--------------------------------------------------
-- Create Season
--------------------------------------------------

CREATE TABLE ARM_STG_SEASON
(
  ID_SEASON          VARCHAR2(6 BYTE),
  DE_SEASON          VARCHAR2(30 BYTE),
  ED_CO              VARCHAR2(20 BYTE),
  ED_LA              VARCHAR2(20 BYTE),
  STG_EVENT_ID       NUMBER,
  STG_STATUS         NUMBER,
  STG_ERROR_MESSAGE  VARCHAR2(255 BYTE),
  STG_LOAD_DATE      DATE,
  STG_PROCESS_DATE   DATE
);



--------------------------------------------
-- Create Color
-------------------------------------------

CREATE TABLE ARM_STG_COLOR
(
  ID_COLOR           VARCHAR2(6 BYTE),
  DE_COLOR           VARCHAR2(30 BYTE),
  STG_EVENT_ID       NUMBER,
  STG_STATUS         NUMBER,
  STG_ERROR_MESSAGE  VARCHAR2(255 BYTE),
  STG_LOAD_DATE      DATE,
  STG_PROCESS_DATE   DATE
);


ALTER TABLE ARM_STG_CURRENCY_RT
ADD (COUNTRY_CD VARCHAR2(10),
LANG_CD VARCHAR2(10),
FIN_CD VARCHAR2(10));

ALTER TABLE ARM_STG_TXN_DTL
ADD (DOC_TYPE CHAR(2),
VAT_COMMENTS VARCHAR2(200));

ALTER TABLE ARM_STG_RSVO_CSGO
ADD DEPOSIT_AMT NUMBER;

ALTER TABLE ARM_STG_FISCAL_DOC
MODIFY (DATE_OF_ISSUE DATE,
	ADDRESS_2 VARCHAR2(60));

ALTER TABLE ARM_STG_TXN_HDR
MODIFY(ASIS_FISCAL_RECEIPT_NO VARCHAR2(50),
ASIS_FISCAL_DOC_NUM VARCHAR2(50),
ASIS_TXN_NUM VARCHAR2(50),
FISCAL_NO VARCHAR2(128));
