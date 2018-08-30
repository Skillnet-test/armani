CREATE TABLE ARM_CURRENCY_RATE
(
    ID_CNY_FROM  VARCHAR2(10),
    ID_CNY_TO  VARCHAR2(10),
    MO_RT_TO_BUY NUMBER,
    UPDATE_DT DATE,
    ED_CO VARCHAR2(10),
    ED_LA VARCHAR2(10),
    CD_FIN VARCHAR2(10)
);

CREATE TABLE ARM_BRN
(
	ID_BRN	VARCHAR2(6),
	NM_BRN	VARCHAR2(30),
	ED_CO	VARCHAR2(20),
	ED_LA	VARCHAR2(20)
);

CREATE TABLE ARM_SPR
(
	ID_SPR VARCHAR2(10),
	NM_SPR VARCHAR2(30)
);

CREATE TABLE ARM_SEASON
(
	ID_SEASON VARCHAR2(6),
	DE_SEASON VARCHAR2(30),
	ED_CO	VARCHAR2(20),
	ED_LA	VARCHAR2(20)
);


CREATE TABLE ARM_SIZE
(
	ID_SIZE VARCHAR2(6),
	DE_SIZE VARCHAR2(30),
	SIZE_INDEX VARCHAR2(10),
	EXT_SIZE_INDEX VARCHAR2(10),
	ED_CO	VARCHAR2(20),
	ED_LA	VARCHAR2(20)
);


CREATE TABLE ARM_KIDS_SIZE
(
	ID_SIZE VARCHAR2(6),
	DE_SIZE VARCHAR2(30),
	ED_CO	VARCHAR2(20),
	ED_LA	VARCHAR2(20)
);

CREATE TABLE ARM_COLOR
(
	ID_COLOR VARCHAR2(6),
	DE_COLOR VARCHAR2(30)
);

CREATE TABLE ARM_CLASS
(
	ID_DPT VARCHAR2(128),
	ID_CLSS VARCHAR2(128),
	NM_CLSS VARCHAR2(10)
);

CREATE TABLE ARM_SUBCLASS
(
	ID_DPT VARCHAR2(128),
	ID_CLSS VARCHAR2(128),
	ID_SBCL VARCHAR2(128),
	NM_SBCL VARCHAR2(20)
);

CREATE TABLE ARM_LABEL
(
	ID_LABEL VARCHAR2(30),
	NM_LABEL VARCHAR2(30),
	ED_CO VARCHAR2(20),
	ED_LA VARCHAR2(20)
);

CREATE TABLE ARM_SUBLINE
(
	ID_SUBLINE VARCHAR2(30),
	DE_SUBLINE VARCHAR2(30),
	ED_CO	VARCHAR2(20),
	ED_LA	VARCHAR2(20)
);

CREATE TABLE ARM_GENDER
(
	ID_GENDER VARCHAR2(30),
	DE_GENDER VARCHAR2(30),
	ED_CO	VARCHAR2(20),
	ED_LA	VARCHAR2(20)
);


CREATE TABLE ARM_CATEGORY
(
	ID_CATEGORY VARCHAR2(30),
	NM_CATEGORY VARCHAR2(30),
	ED_CO	VARCHAR2(20),
	ED_LA	VARCHAR2(20)
);

CREATE TABLE ARM_DROP
(
	ID_DROP VARCHAR2(30),
	DE_DROP VARCHAR2(30),
	ED_CO	VARCHAR2(20),
	ED_LA	VARCHAR2(20)
);

CREATE TABLE ARM_PRODUCT
(
	ID_PRODUCT VARCHAR2(30),
	DE_PRODUCT VARCHAR2(30)
);

CREATE TABLE ARM_ITM_HIST
(
        ID_ITM VARCHAR2(128),
        ID_STR_RT VARCHAR2(128),
        ID_ITM_HIST VARCHAR2(128),
        KEY VARCHAR2(25),
        VALUE VARCHAR2(255),
        EFFECTIVE_DT DATE,
        EXPIRATION_DT DATE
);

CREATE TABLE ARM_TAX_RATE 
( 
  ZIP_CODE      VARCHAR2 (10), 
  CITY          VARCHAR2 (50), 
  COUNTY        VARCHAR2 (50), 
  STATE         VARCHAR2 (10), 
  TAX_RATE      NUMBER (9,4), 
  EFFECTIVE_DT  DATE
);


CREATE TABLE TR_LTM_DSC_DTL
(
  AI_TRN       VARCHAR2(128),
  AL_LN_ITM    INTEGER,
  SEQ_NUM      NUMBER (3),
  DSC_SEQ_NUM  NUMBER (3)
);


CREATE TABLE ARM_CT_DTL (
ID_CT                                              VARCHAR2(20) NOT NULL,
VAT_NUM                                            VARCHAR2(25),
FISCAL_CODE                                        VARCHAR2(25),
ID_TYPE                                            VARCHAR2(25),
DOC_NUM                                            VARCHAR2(25),
PLACE_OF_ISSUE                                     VARCHAR2(25),
ISSUE_DT                                           DATE,
TY_PAY                                             VARCHAR2(25),
ID_CMY                                             VARCHAR2(11),
CD_INTER_CMY                                       VARCHAR2(11),
ACCT_NUM                                           VARCHAR2(11),
AGE                                                VARCHAR2(2),
REFERRED_BY                                        VARCHAR2(11),
PROFESSION                                         VARCHAR2(25),
EDUCATION                                          VARCHAR2(25),
NOTES1                                             VARCHAR2(100),
NOTES2                                             VARCHAR2(100),
NM_PTNR_FAM                                        VARCHAR2(30),
NM_PTNR                                            VARCHAR2(30),
BIRTH_PLACE                                        VARCHAR2(30),
TY_SPL_EVT                                         VARCHAR2(20),
DC_SPL_EVT                                         DATE,
NM_CHLD                                            VARCHAR2(50),
CHLD_NUM                                           VARCHAR2(2),
CREATE_OFFLINE                                     VARCHAR2(1),
SUPPLIER_PAYMENT				   VARCHAR2(20),
BANK						   VARCHAR2(30),
CRDT_CRD_NUM_1					   VARCHAR2(30),
CRDT_CRD_TYP_1					   VARCHAR2(30),
CRDT_CRD_NUM_2					   VARCHAR2(30),
CRDT_CRD_TYP_2					   VARCHAR2(30)
);

CREATE TABLE ARM_ADS_PH (
ID_ADS        VARCHAR2(128) NOT NULL,
ID_PH_TYP     VARCHAR2(20) NOT NULL,
TL_PH         VARCHAR2(15) NULL,
CC_PH         VARCHAR2(10) NULL,
TA_PH         VARCHAR2(10) NULL,
PH_EXTN       VARCHAR2(10) NULL
);

CREATE TABLE  ARM_CT_ASSOC (
ID_CT_ASSOCIATE VARCHAR2(128),
ID_CT          VARCHAR2(128) NOT NULL,
ID_STR_RT      VARCHAR2(128) NOT NULL,
ID_ASSOCIATE   VARCHAR2(128) NOT NULL
);


CREATE TABLE ARM_CT_COMMENTS (
ID_CT                                              VARCHAR2(30) NOT NULL,
ID_STR_RT                                          VARCHAR2(30) NOT NULL,
ID_CMY                                             VARCHAR2(30),
ID_BRN                                             VARCHAR2(30),
ID_ASSOCIATE                                       VARCHAR2(30) NOT NULL,
CREATE_DT                                          DATE,
COMMENTS                                           VARCHAR2(50),
ID_CT_COMMENT                                      VARCHAR2(128) NOT NULL
);

CREATE TABLE ARM_CUST_SALE_SUMMARY (
ID_CT  		VARCHAR2(128) NOT NULL,
ID_STR_RT	VARCHAR2(128) NOT NULL,
TXN_TYPE	VARCHAR2(20) NOT NULL,
TXN_DATE 	DATE NOT NULL,
TXN_AMOUNT	VARCHAR2(75) NOT NULL
);


CREATE TABLE ARM_POS_PRS ( 
  AI_TRN      VARCHAR2 (128)  NOT NULL, 
  ID_PRESALE  VARCHAR2 (128),
  EXP_DT      DATE
);

CREATE TABLE ARM_PRS_POS_LN_ITM_DTL ( 
  AI_TRN          VARCHAR2 (128)  NOT NULL, 
  AI_LN_ITM       NUMBER        NOT NULL, 
  SEQUENCE_NUM    NUMBER (3)    NOT NULL, 
  ORG_AI_TRN      VARCHAR2 (128), 
  ORIG_AI_LN_ITM  NUMBER, 
  ORIG_SEQ_NUM    NUMBER (3)
); 

CREATE TABLE ARM_POS_CSG ( 
  AI_TRN      	  VARCHAR2 (128)  NOT NULL, 
  ID_CONSIGNMENT  VARCHAR2 (128),
  EXP_DT      	  DATE
); 

CREATE TABLE ARM_CSG_POS_LN_ITM_DTL ( 
  AI_TRN          VARCHAR2 (128)  NOT NULL, 
  AI_LN_ITM       NUMBER        NOT NULL, 
  SEQUENCE_NUM    NUMBER (3)    NOT NULL, 
  ORG_AI_TRN      VARCHAR2 (128), 
  ORIG_AI_LN_ITM  NUMBER, 
  ORIG_SEQ_NUM    NUMBER (3)
); 

CREATE TABLE ARM_ITM_SOH
(
	ITEM_ID VARCHAR2(128),
	STORE_ID VARCHAR2(128),
	BALANCE_DATE DATE,
	QU_AVAILABLE          NUMBER(4)               DEFAULT 0,
	QU_UNAVAILABLE        NUMBER(4)               DEFAULT 0,
	FL_BALANCED           CHAR(1),
	QU_SALE_TOTAL         NUMBER(4)               DEFAULT 0,
	QU_RECEIPT            NUMBER(4)               DEFAULT 0,
	QU_TRANSFER           NUMBER(4)               DEFAULT 0,
	QU_STOCK_ADJ          NUMBER(4)               DEFAULT 0,
	QU_ON_ORDER           NUMBER(4)               DEFAULT 0,
	QU_STORE_AVAILABLE    NUMBER(4)               DEFAULT 0,
	QU_STORE_UNAVAILABLE  NUMBER(4)               DEFAULT 0
);

CREATE TABLE ARM_CT_XREF
(
  ID_CT         VARCHAR2(128),
  OLD_ID_CT     VARCHAR2(128),
  EFFECTIVE_DT  DATE
);

CREATE TABLE ARM_ALTERN_LN_ITM_DTL 
( 
  AI_TRN		VARCHAR2(128)	NOT NULL,
  AI_LN_ITM		NUMBER		NOT NULL, 
  DET_SEQ_NUM		NUMBER (3)	NOT NULL,
  SEQ_NUM		NUMBER (3)	NOT NULL,
  ID_ALTERN		VARCHAR2 (128)	NOT NULL,
  TRY_DT		DATE,
  PROMISE_DT		DATE,
  FITTER_ID		VARCHAR2(128),
  TAILOR		VARCHAR2(128),
  TOTAL_PRICE		VARCHAR2(128),
  COMMENTS		VARCHAR2(150)
);

CREATE TABLE ARM_ALTERN_DTL 
( 
  AI_TRN		VARCHAR2(128)	NOT NULL,
  AI_LN_ITM		NUMBER		NOT NULL, 
  DET_SEQ_NUM		NUMBER (3)	NOT NULL,
  ALTERN_SEQ_NUM	NUMBER(3)	NOT NULL,
  CD_ALTERN		VARCHAR2 (128)	NOT NULL,
  DESCRIPTION		VARCHAR2  (128),
  ESTIMATED_PRICE	VARCHAR2(128),
  ESTIMATED_TIME	DATE,
  ACTUAL_PRICE		VARCHAR2(128),
  ACTUAL_TIME		DATE  
);


CREATE TABLE ARM_LOYALTY_RULE
(
    ID_RULE  VARCHAR2(128) NOT NULL,
    DC_START  DATE NOT NULL,
    DC_END  DATE,
    ID_STR_RT VARCHAR2(128) NOT NULL,
    TY_CT VARCHAR2(10) NOT NULL,
    POINTS NUMBER NOT NULL,
    ID_DPT_POS VARCHAR2(128),
    ID_CLSS VARCHAR2(128),
    ID_SBCL VARCHAR2(128),
    STYLE_NUM VARCHAR2(10)
);

CREATE TABLE ARM_LOYALTY
(
    ID_CT  VARCHAR2(128) NOT NULL,
    LOYALTY_NUM VARCHAR2(20) NOT NULL,
    TY_STR_RT VARCHAR2(30) NOT NULL,
    DC_ISSUED  DATE NOT NULL,
    ISSUED_BY  VARCHAR2(128) NOT NULL,
    CURRENT_BAL NUMBER DEFAULT 0 NOT NULL,
    LIFETIME_BAL NUMBER DEFAULT 0 NOT NULL,
    FL_STATUS CHAR(1) DEFAULT 'Y' NOT NULL
);

CREATE TABLE ARM_LOYALTY_HIST
(
    LOYALTY_NUM VARCHAR2(20) NOT NULL,
    DC_TRANSACTION DATE NOT NULL,
    ID_STR_RT VARCHAR2(128) NOT NULL,
    AI_TRN VARCHAR2(128) NOT NULL,
    POINTS NUMBER NOT NULL,
    TY_TRN VARCHAR2(60) NOT NULL,
    CD_REASON VARCHAR2(200)
);


CREATE TABLE ARM_TAX_FREE (
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
    COMMISSION          VARCHAR2(20)
);

CREATE TABLE ARM_FISCAL_DOC_NO (
    REGISTER_ID         VARCHAR2(10) NOT NULL,
    ID_STR_RT           VARCHAR2(20) NOT NULL,
    LAST_DDT_NO         VARCHAR2(20),
    LAST_VAT_NO         VARCHAR2(20),
    LAST_CREDIT_NOTE    VARCHAR2(20)
);

CREATE TABLE ARM_POS_RSV ( 
  AI_TRN          VARCHAR2 (128)  NOT NULL, 
  ID_RESERVATION  VARCHAR2 (128),
  EXP_DT          DATE,
  REASON_CODE     VARCHAR2(20),
  DEPOSIT_AMT	  VARCHAR2(75),
  ORIG_RSV_ID	  VARCHAR2(128)
); 

CREATE TABLE ARM_RSV_POS_LN_ITM_DTL ( 
  AI_TRN          VARCHAR2 (128)  NOT NULL, 
  AI_LN_ITM       NUMBER        NOT NULL, 
  SEQUENCE_NUM    NUMBER (3)    NOT NULL, 
  ORG_AI_TRN      VARCHAR2 (128), 
  ORIG_AI_LN_ITM  NUMBER, 
  ORIG_SEQ_NUM    NUMBER (3)
); 

CREATE TABLE ARM_FISCAL_DOCUMENT (
	AI_TRN		VARCHAR2(128) NOT NULL,
	DOC_NUM		VARCHAR2(20) NOT NULL,
	TY_DOC		VARCHAR2(10) NOT NULL,
	REFUND_AMOUNT   VARCHAR2(50),
	VAT_NUM		VARCHAR2(50),
	DESTINATION	VARCHAR2(50),
	TY_PKG		VARCHAR2(50),
	WEIGHT		NUMBER(5,2),
	NOTE		VARCHAR2(100),
	COMPANY_NAME    VARCHAR2(50) NOT NULL,
	COMPANY_NAME2   VARCHAR2(50) NOT NULL,
	ADDRESS_LINE_1  VARCHAR2(50) NOT NULL,
	ADDRESS_LINE_2  VARCHAR2(50),
	CITY		VARCHAR2(50) NOT NULL,
	COUNTY		VARCHAR2(50) NOT NULL,
	ZIP_CODE	VARCHAR2(10) NOT NULL,
	STATE		VARCHAR2(50) NOT NULL,
	COUNTRY		VARCHAR2(50) NOT NULL,
	CD_DEST		VARCHAR2(10),
	SENDER		VARCHAR2(10),
	CD_SENDER	VARCHAR2(10),
	TY_CARRIER	VARCHAR2(10),
	CD_EXPEDITION   VARCHAR2(10),
	GOODS_NUM	VARCHAR2(50),
	CD_CARRIER	VARCHAR2(10),
	DE_CARRIER	VARCHAR2(50),
	TY_PACKAGE	VARCHAR2(10),
	TY_PAYMENT	VARCHAR2(10)
);

CREATE TABLE ARM_ASIS_TXN_DATA (
	AI_TRN			VARCHAR2(128) NOT NULL,
	COMPANY_CODE		VARCHAR2(20),
	STORE_ID		VARCHAR2(20),
	REGISTER_ID		VARCHAR2(20),
	TXN_NO			VARCHAR2(50),
	TXN_DATE		DATE,
	FISCAL_RECEIPT_NO	VARCHAR2(20),
	FISCAL_RECEIPT_DATE	DATE,
	FISCAL_DOC_NO		VARCHAR2(20),
	FISCAL_DOC_DATE		DATE,
	FISCAL_DOC_TYPE		VARCHAR2(20),
	CUSTOMER_NO		VARCHAR2(20),
	CUSTOMER_NAME		VARCHAR2(50),
	COMMENTS		VARCHAR2(200)
);

CREATE TABLE ARM_CUST_DEPOSIT_HIST
(     
  DC_TRANSACTION        DATE            NOT NULL,
  ID_STR_RT             VARCHAR2(128)   NOT NULL, 
  AI_TRN		VARCHAR2(128)   NOT NULL,
  TY_TRN		VARCHAR2(60)    NOT NULL,
  CUST_ID               VARCHAR2(128)   NOT NULL,
  ASSOC                 VARCHAR2(128),
  AMOUNT                VARCHAR2(75) 
   
);

CREATE TABLE ARM_CUSTOMER_MESSAGES
(
ID_CT VARCHAR2(128),
TY_CT VARCHAR2(10),
TY_MSG VARCHAR2(1) NOT NULL,
MESSAGE VARCHAR2(255)  NOT NULL,
STATUS VARCHAR2(1)  DEFAULT 'O' NOT NULL, 
RESPONSE VARCHAR2(255)
);

CREATE TABLE ARM_EOD_GROUP
(
	CD_GROUP VARCHAR2(50),
	DE_GROUP VARCHAR2(100)
);

CREATE TABLE ARM_EOD_DTL
(
	AI_TRN VARCHAR2(128),
	CD_GROUP VARCHAR2(50),
	CD_TYPE  VARCHAR2(50),
	TOTAL VARCHAR2(75),
	COUNT NUMBER(3)
);

CREATE TABLE ARM_ALTERN_CLSS_GRP ( 
  GROUP_ID      VARCHAR2(30) , 
  SUB_GROUP_ID  VARCHAR2(30) 
); 

CREATE TABLE ARM_ALTERN_GRP ( 
  GROUP_ID   VARCHAR2(30) , 
  GROUP_NAME  VARCHAR2(50),
  ED_CO   VARCHAR2(20),
  ED_LA   VARCHAR2(20)
);

CREATE TABLE ARM_ALTERN_CODE ( 
  GROUP_ID     VARCHAR2(30) , 
  ALTERN_CODE  VARCHAR2(50) , 
  ALTERN_DESC  VARCHAR2(50) ,
  ALTERN_PRICE VARCHAR2(20),
  ALTERN_TIME  DATE         
); 

CREATE TABLE ARM_CFG_DETAIL ( 
  TY_CFG  VARCHAR2(50) , 
  CD_CFG  VARCHAR2(50) , 
  ED_CO   VARCHAR2(20) , 
  ED_LA   VARCHAR2(20) , 
  DE_CFG  VARCHAR2(200),
  PRIORITY CHAR(3) DEFAULT '0' NOT NULL
) ;

CREATE TABLE "ARM_CT_CRDB_CRD_DTL" (
"ID_CT" VARCHAR2(20),
"ID_STR_RT" VARCHAR2(20), 
"ID_ACNT_DB_CR_CRD" VARCHAR2(100),
"EXPIRATION_DATE" DATE,
"ZIP_CODE" VARCHAR2(10),
"TY_CRD" VARCHAR2(20)
); 

CREATE TABLE ARM_GRP_CLS_TND
(
  LU_CLS_TND  VARCHAR2(40)	NOT NULL,
  TND_CODE    VARCHAR2(10)      NOT NULL,
  ED_CO       VARCHAR2(20)      NOT NULL,
  ED_LA       VARCHAR2(20)      NOT NULL,
  DE_CLS_TND  VARCHAR2(255)     NOT NULL
);

ALTER TABLE AS_TL
ADD (
 DE_RPSTY_TND VARCHAR2(50),
 TY_RND VARCHAR2(10),
 TY_RPSTY_TND VARCHAR2(10)
);

ALTER TABLE PA_STR_RTL
ADD (
   ID_BRAND VARCHAR2(30),
   FISCAL_CODE VARCHAR2(30),
   DE_STR_RT VARCHAR2(50),
   DE_CNY VARCHAR2(50),
   DE_CMY VARCHAR2(50),
   ID_CMY VARCHAR2(50)	
);

ALTER TABLE PA_EM
ADD (
  ARM_EXTERNAL_ID VARCHAR2(30),
  ID_CT VARCHAR2(128)
 );

ALTER TABLE RU_PRM_PRDV
ADD ( ID_STR_RT  VARCHAR2(128) );

ALTER TABLE RK_PRM_ITM
ADD ( ID_STR_RT  VARCHAR2(128) );

ALTER TABLE LO_ADS_PRTY ADD TY_ADS VARCHAR2 (30);

ALTER TABLE RU_PRDV ADD APPLICABLE_ITM CHAR(1);

ALTER TABLE RK_TH_PRM ADD (ID_STR_RT VARCHAR2(128),PROMOTION_NAME VARCHAR2(50));

ALTER TABLE RU_PRDV ADD IS_DISCOUNT CHAR(1);

ALTER TABLE PA_EM ADD CONSTRAINT ARM_EXTERNAL_ID_UNIQ UNIQUE (ARM_EXTERNAL_ID);

ALTER TABLE AS_ITM
ADD (
      ID_BRN  VARCHAR2(6),
      BARCODE VARCHAR2(50),
      STYLE_NUM VARCHAR2(10),
      ID_COLOR VARCHAR2(6),
      ID_SPR   VARCHAR2(10),
      ID_SIZE  VARCHAR2(6),
      ID_KIDS_SIZE  VARCHAR2(6),
      MODEL VARCHAR2(10),
      FABRIC VARCHAR2(10),
      GENDER VARCHAR2(10),
      SUBLINE VARCHAR2(30),
      VARIANT VARCHAR2(30),
      LABEL VARCHAR2(30),
      ITEM_DROP VARCHAR2(30),
      CATEGORY VARCHAR2(50),
      PRODUCT_NUM VARCHAR2(50),
      ID_SEASON   VARCHAR2(10)
);

ALTER TABLE AS_ITM_RTL_STR
ADD (
      LU_EXM_TX VARCHAR2(2),
      UPDATE_DT DATE,
      NM_ITM VARCHAR2(40)	
);

ALTER TABLE ID_IDN_PS
ADD (ID_STR_RT VARCHAR2(128));

ALTER TABLE RK_COMP_PRM_PK
ADD (ID_STR_RT VARCHAR2(128));

ALTER TABLE TR_LTM_DSC ADD DISCOUNT_CODE VARCHAR2(10);

ALTER TABLE TR_LTM_TND ADD ( 
	JOURNAL_KEY VARCHAR2(16), 
	RES_MSG VARCHAR2(38), 
	MSG_NUM VARCHAR2(2), 
	MERCHANT_ID VARCHAR2(15),
	CODE VARCHAR2(20)
);

ALTER TABLE TR_LTM_CRDB_CRD_TN ADD CARD_IDENTIFIER VARCHAR2(2);

ALTER TABLE PA_PRS ADD (
DB_FN_PRS	VARCHAR2(30),
DB_LN_PRS       VARCHAR2(30),
SUFFIX         	VARCHAR2(12)
);

ALTER TABLE LO_ADS_NSTD ADD (
MU_NM		VARCHAR2(20),
FL_PRMY_ADS     VARCHAR2(1)
);

ALTER TABLE PA_CT ADD (
TY_CT			VARCHAR2(10),
FL_LOYALTY              VARCHAR2(1),
PE_VIP_DISC             NUMBER(4,2),
CD_PRIVACY              VARCHAR2(1),
FL_MAIL                 VARCHAR2(1),
FL_CALL                 VARCHAR2(1),
FL_EML                  VARCHAR2(1),
FL_SMS                  VARCHAR2(1),
CUST_BARCODE            VARCHAR2(20),
SC_CT			VARCHAR(6)
);

ALTER TABLE ARM_CLASS
MODIFY NM_CLSS VARCHAR2(50);

ALTER TABLE RK_POS_LN_ITM_DTL ADD (
FL_PROCESSED CHAR(1),
POS_LN_ITM_TY_ID NUMBER(3)
);

ALTER TABLE RK_SHIP_REQ ADD (ADDRESS2 VARCHAR2(100));

ALTER TABLE LO_EML_ADS ADD TY_EML_ADS VARCHAR2(10);

ALTER TABLE DO_CF_GF ADD (
ID_CT VARCHAR2(128),
DC_EXPIRATION DATE
);

ALTER TABLE TR_LTM_GF_CF_TND ADD (
MANUAL_AUTH_CODE VARCHAR2(50),
FL_MANUAL CHAR(1)
);

ALTER TABLE RK_COLLECTION
ADD REDEEMABLE_CONTROL_ID VARCHAR2(50);

ALTER TABLE RK_PAY_SUM 
ADD MEDIA_COUNT NUMBER DEFAULT 0;


ALTER TABLE RK_POS_LN_ITM_DTL
ADD (
    LOYALTY_PT NUMBER DEFAULT 0
);

ALTER TABLE DO_CF_GF
ADD (
    LOYALTY_NUM VARCHAR2(20)
);

ALTER TABLE TR_TRN ADD (TRN_SEQ_NUM NUMBER(12,0));

UPDATE TR_TRN SET TRN_SEQ_NUM = SUBSTR(AI_TRN, LENGTH(AI_TRN) - 3);

ALTER TABLE TR_LTM_DSC ADD (AUTH_CODE VARCHAR2(50));

ALTER TABLE TR_LTM_RTL_TRN
ADD (DOC_NUM VARCHAR2(20),
VAT_COMMENTS VARCHAR2(200),
TY_DOC VARCHAR2(10),
FL_EXCHANGE NUMBER(1)
);

ALTER TABLE TR_RTL 
ADD FISCAL_DOC_NUMBERS VARCHAR2(2000);

ALTER TABLE PA_CT ADD CUST_BALANCE VARCHAR2(75);

ALTER TABLE TR_TRN
ADD (
	FISCAL_RECEIPT_NUMBER	VARCHAR2(128),
	FISCAL_RECEIPT_DATE	DATE
);
 
ALTER TABLE TR_LTM_RTL_TRN
ADD FL_EXCHANGE DECIMAL(1);

ALTER TABLE ARM_LOYALTY_RULE
    MODIFY POINTS DECIMAL(6,2);
    
ALTER TABLE ARM_TAX_RATE ADD TAX_JUR VARCHAR2(10);

DROP SEQUENCE ARM_SEQ_CUSTID;

CREATE SEQUENCE ARM_SEQ_CUSTID
  START WITH 1000000000
  NOMAXVALUE
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;

ALTER TABLE RK_POS_LN_ITM_DTL DROP COLUMN LOYALTY_PT;

ALTER TABLE RK_POS_LN_ITM_DTL ADD LOYALTY_PT NUMBER(15,2);

ALTER TABLE ARM_LOYALTY_HIST DROP COLUMN POINTS;

ALTER TABLE ARM_LOYALTY_HIST ADD POINTS NUMBER(15,2);

ALTER TABLE ARM_LOYALTY DROP COLUMN CURRENT_BAL;

ALTER TABLE ARM_LOYALTY ADD CURRENT_BAL NUMBER(15,2);

ALTER TABLE ARM_LOYALTY DROP COLUMN LIFETIME_BAL;

ALTER TABLE ARM_LOYALTY ADD LIFETIME_BAL NUMBER(15,2);

ALTER TABLE TR_RTL ADD LOYALTY_TRUNCATED NUMBER(1);

ALTER TABLE ARM_TAX_RATE
    MODIFY TAX_RATE NUMBER(10,5);

ALTER TABLE RK_PRM_ITM
ADD (DC_PRM_EP DATE, EFFECTIVE_DT DATE
);

ALTER TABLE AS_ITM
ADD SIZE_INDEX VARCHAR2(50);

ALTER TABLE AS_ITM
MODIFY (MODEL VARCHAR2(50), FABRIC VARCHAR2(50));

ALTER TABLE RK_SHIP_REQ ADD ADS_FORMAT VARCHAR2(40);

ALTER TABLE LO_ADS_NSTD ADD ADS_FORMAT VARCHAR2(40);

UPDATE LO_ADS_NSTD SET ADS_FORMAT=MU_NM, MU_NM=NULL;

CREATE SEQUENCE ARM_SEQ_CSG_PRS_ID
  START WITH 10000000
  NOMAXVALUE
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;

ALTER TABLE ARM_CSG_POS_LN_ITM_DTL
ADD FL_VD_LN_ITM CHAR(1) DEFAULT 0;

ALTER TABLE ARM_PRS_POS_LN_ITM_DTL
ADD FL_VD_LN_ITM CHAR(1) DEFAULT 0;

ALTER TABLE TR_RTL
ADD LOYALTY_CARD_NUM VARCHAR2(20);

ALTER TABLE RK_EMP_SALE
ADD TOTAL_QTY	NUMBER(22) DEFAULT 0;

ALTER TABLE TR_RTL
MODIFY ITEMS_IDS VARCHAR2(4000);

ALTER TABLE RK_SALES_SUMMARY
ADD (
	MARKDOWN_AMT	VARCHAR2(75),
	TYPE		CHAR(1)
);

ALTER TABLE TR_RTL MODIFY DISCOUNT_TYPES VARCHAR2(2000);

ALTER TABLE RK_SALES_SUMMARY
ADD (ITEM_DEPT_ID VARCHAR2(20),
ITEM_CLSS_ID VARCHAR2(20),
MISC_ITEM_ID VARCHAR2(20));

DROP TABLE ARM_CUST_DEPOSIT_HIST;

CREATE TABLE ARM_CUST_DEPOSIT_HIST
(     
  DC_TRANSACTION        DATE            NOT NULL,
  ID_STR_RT             VARCHAR2(128)   NOT NULL, 
  AI_TRN		VARCHAR2(128)   NOT NULL,
  TY_TRN		VARCHAR2(60)    NOT NULL,
  CUST_ID               VARCHAR2(128)   NOT NULL,
  ASSOC                 VARCHAR2(128),
  AMOUNT                VARCHAR2(75) 
);

ALTER TABLE ARM_CUST_DEPOSIT_HIST ADD FOREIGN KEY (CUST_ID) REFERENCES PA_CT(ID_CT);

DROP TABLE ARM_GRP_CLS_TND;

CREATE TABLE ARM_GRP_CLS_TND
(
  LU_CLS_TND  VARCHAR2(40)	NOT NULL,
  TND_CODE    VARCHAR2(10)      NOT NULL,
  ED_CO       VARCHAR2(20)      NOT NULL,
  ED_LA       VARCHAR2(20)      NOT NULL,
  DE_CLS_TND  VARCHAR2(255)     NOT NULL
);

DROP TABLE ARM_RSV_POS_LN_ITM_DTL;

CREATE TABLE ARM_RSV_POS_LN_ITM_DTL ( 
  AI_TRN          VARCHAR2 (128)  NOT NULL, 
  AI_LN_ITM       NUMBER        NOT NULL, 
  SEQUENCE_NUM    NUMBER (3)    NOT NULL, 
  ORG_AI_TRN      VARCHAR2 (128), 
  ORIG_AI_LN_ITM  NUMBER, 
  ORIG_SEQ_NUM    NUMBER (3)
); 

ALTER TABLE ARM_CURRENCY_RATE
ADD (ED_CO VARCHAR2(10),
    ED_LA VARCHAR2(10),
    CD_FIN VARCHAR2(10));

ALTER TABLE TR_LTM_TND ADD CODE VARCHAR2(20);

ALTER TABLE PA_CT ADD CUST_BALANCE VARCHAR2(75);

ALTER TABLE ARM_POS_RSV 
ADD (DEPOSIT_AMT	  VARCHAR2(75),
     ORIG_RSV_ID	  VARCHAR2(128)); 

ALTER TABLE TR_LTM_RTL_TRN
ADD (DOC_NUM VARCHAR2(20),
VAT_COMMENTS VARCHAR2(200),
TY_DOC VARCHAR2(10),
FL_EXCHANGE NUMBER(1)
);

ALTER TABLE TR_RTL ADD FISCAL_DOC_NUMBERS VARCHAR2(2000);

ALTER TABLE TR_TRN
ADD (FISCAL_RECEIPT_NUMBER	VARCHAR2(128),
     FISCAL_RECEIPT_DATE	DATE);

ALTER TABLE ARM_POS_RSV DROP PRIMARY KEY CASCADE;

ALTER TABLE ARM_POS_RSV ADD PRIMARY KEY (ID_RESERVATION);

ALTER TABLE ARM_POS_RSV ADD FOREIGN KEY (ORIG_RSV_ID) REFERENCES ARM_POS_RSV(ID_RESERVATION);

ALTER TABLE ARM_RSV_POS_LN_ITM_DTL ADD PRIMARY KEY ( AI_TRN, AI_LN_ITM, SEQUENCE_NUM );

ALTER TABLE ARM_RSV_POS_LN_ITM_DTL ADD 
  FOREIGN KEY (AI_TRN,AI_LN_ITM,SEQUENCE_NUM) REFERENCES RK_POS_LN_ITM_DTL (AI_TRN,AI_LN_ITM,SEQUENCE_NUMBER);

ALTER TABLE ARM_RSV_POS_LN_ITM_DTL ADD 
  FOREIGN KEY (ORG_AI_TRN,ORIG_AI_LN_ITM,ORIG_SEQ_NUM) REFERENCES RK_POS_LN_ITM_DTL (AI_TRN,AI_LN_ITM,SEQUENCE_NUMBER);

ALTER TABLE ARM_ASIS_TXN_DATA ADD FOREIGN KEY (AI_TRN) REFERENCES TR_TRN(AI_TRN);

ALTER TABLE ARM_FISCAL_DOC_NO ADD FOREIGN KEY (REGISTER_ID, ID_STR_RT) REFERENCES AS_TL(ID_RPSTY_TND, ID_STR_RT);

ALTER TABLE ARM_CURRENCY_RATE DROP PRIMARY KEY;

ALTER TABLE ARM_CURRENCY_RATE ADD PRIMARY KEY (ID_CNY_FROM, ID_CNY_TO, ED_CO, ED_LA);

ALTER TABLE ARM_FISCAL_DOCUMENT ADD PRIMARY KEY (AI_TRN, DOC_NUM, TY_DOC);

ALTER TABLE TR_LTM_RTL_TRN
ADD FOREIGN KEY (AI_TRN, DOC_NUM, TY_DOC) REFERENCES ARM_FISCAL_DOCUMENT(AI_TRN, DOC_NUM, TY_DOC);

ALTER TABLE TR_RTL MODIFY DISCOUNT_TYPES VARCHAR2(2000);

ALTER TABLE ARM_ITM_SOH
MODIFY(
	QU_AVAILABLE		DEFAULT 0,
	QU_UNAVAILABLE		DEFAULT 0,
	QU_SALE_TOTAL		DEFAULT 0,
	QU_RECEIPT		DEFAULT 0,
	QU_TRANSFER		DEFAULT 0,
	QU_STOCK_ADJ		DEFAULT 0,
	QU_ON_ORDER		DEFAULT 0,
	QU_STORE_AVAILABLE	DEFAULT 0,
	QU_STORE_UNAVAILABLE	DEFAULT 0);

ALTER TABLE ARM_TAX_FREE MODIFY RATIO NUMBER(9,2);

ALTER TABLE ARM_FISCAL_DOCUMENT MODIFY WEIGHT NUMBER(5,2);

ALTER TABLE PA_CT MODIFY SC_CT VARCHAR(6);

CREATE OR REPLACE VIEW RK_TXN_HEADER
(CUST_ID, TY_TRN, ID_STR_RT, TY_STR_RT, ID_OPR, 
 TS_TRN_PRC, TS_TRN_SBM, TY_GUI_TRN, PAY_TYPES, TOTAL_AMT, 
 AI_TRN, CONSULTANT_ID, REDUCTION_AMOUNT, NET_AMOUNT, DISCOUNT_TYPES, 
 ITEMS_IDS, REGISTER_ID, FN_PRS, LN_PRS, EXP_DT, 
 REF_ID, CURRENCY_CD, IS_SHIPPING, FISCAL_RECEIPT_NUM, FISCAL_RECEIPT_DT, 
 FISCAL_DOC_NUMBERS)
AS 
SELECT RK_PAY_TRN.CUST_ID, TR_TRN.TY_TRN, TR_TRN.ID_STR_RT, 
    PA_STR_RTL.ID_BRAND, OPR.ARM_EXTERNAL_ID ID_OPR, TR_TRN.TS_TRN_PRC, 
    TR_TRN.TS_TRN_SBM, TR_TRN.TY_GUI_TRN, RK_PAY_TRN.PAY_TYPES, 
    RK_PAY_TRN.TOTAL_AMT, RK_PAY_TRN.AI_TRN, ASSOCIATE.ARM_EXTERNAL_ID CONSULTANT_ID, 
    TR_RTL.REDUCTION_AMOUNT, TR_RTL.NET_AMOUNT, TR_RTL.DISCOUNT_TYPES, 
    TR_RTL.ITEMS_IDS, TR_TRN.ID_RPSTY_TND, PA_PRS.FN_PRS, PA_PRS.LN_PRS, 
    DECODE(RK_PAY_TRN.TYPE_ID, 'TRNPSO', ARM_POS_PRS.EXP_DT, 'TRNCGO', ARM_POS_CSG.EXP_DT, 'TRNRSV', ARM_POS_RSV.EXP_DT, NULL) EXP_DT, 
    DECODE(RK_PAY_TRN.TYPE_ID, 'TRNPSO', ARM_POS_PRS.ID_PRESALE, 'TRNCGO', ARM_POS_CSG.ID_CONSIGNMENT, 'TRNRSV', ARM_POS_RSV.ID_RESERVATION, NULL) REF_ID, 
    PA_STR_RTL.TY_CNY CURRENCY_CD, DECODE(RK_SHIP_REQ.SEQ_NUM, NULL, 0, 1) IS_SHIPPING, 
    TR_TRN.FISCAL_RECEIPT_NUMBER FISCAL_RECEIPT_NUM, TR_TRN.FISCAL_RECEIPT_DATE FISCAL_RECEIPT_DT, 
    TR_RTL.FISCAL_DOC_NUMBERS FISCAL_DOC_NUMBERS 
FROM TR_TRN INNER JOIN 
( 
 	 RK_PAY_TRN LEFT OUTER JOIN 
	 ( 
	 	 TR_RTL LEFT OUTER JOIN PA_PRS ON TR_RTL.CONSULTANT_ID = PA_PRS.ID_PRTY_PRS 
		 LEFT OUTER JOIN PA_EM ASSOCIATE ON TR_RTL.CONSULTANT_ID=ASSOCIATE.ID_EM 
		 LEFT OUTER JOIN RK_SHIP_REQ ON (RK_SHIP_REQ.AI_TRN=TR_RTL.AI_TRN AND RK_SHIP_REQ.SEQ_NUM=0) 
		 LEFT OUTER JOIN ARM_POS_PRS ON TR_RTL.AI_TRN = ARM_POS_PRS.AI_TRN 
		 LEFT OUTER JOIN ARM_POS_CSG ON TR_RTL.AI_TRN = ARM_POS_CSG.AI_TRN 
		 LEFT OUTER JOIN ARM_POS_RSV ON TR_RTL.AI_TRN = ARM_POS_RSV.AI_TRN 
	 ) 
	 ON RK_PAY_TRN.AI_TRN = TR_RTL.AI_TRN 
) 
ON TR_TRN.AI_TRN=RK_PAY_TRN.AI_TRN AND TR_TRN.TY_TRN IN ('TRNPAY') 
INNER JOIN 
( 
	PA_OPR INNER JOIN PA_EM OPR ON PA_OPR.ID_EM=OPR.ID_EM 
) 
ON TR_TRN.ID_OPR=PA_OPR.ID_EM 
INNER JOIN PA_STR_RTL ON TR_TRN.ID_STR_RT=PA_STR_RTL.ID_STR_RT;

CREATE OR REPLACE VIEW V_ARM_ITEM_SALE
(ID_STR_RT, DIV, DEPT_ID, DEPT_NM, CLASS_ID, 
 CLASS_NM, ITEM_ID, ITEM_NM, BARCODE, SALES_DATE, 
 SALE_MARKDOWN_AMT, NET_SALE_AMT, TOTAL_SALE_QTY, RTN_MARKDOWN_AMT, NET_RTN_AMT, 
 TOTAL_RTN_QTY)
AS 
( 
SELECT SUMM.ID_STR_RT ID_STR_RT, 
	DECODE(SUBSTR(SUMM.ITEM_DEPT_ID,1, 1), '1', 'GAW', '2', 'GAM', '3', 'GAUJUN', '4', 'EAW', '5', 'EAM', '6', 'EAU', '7', 'ACGIFT', '8', 'ACTEXT', '9', 'ACTABLE', '99') DIV, 
	SUMM.ITEM_DEPT_ID DEPT_ID, DEPT.NM_DPT_POS DEPT_NM  , NVL(SUMM.ITEM_CLSS_ID,'NONE') CLASS_ID, NVL(CLASS.NM_CLSS,'NONE') CLASS_NM, 
	SUMM.ID_ITM ITEM_ID,  ITEMSTORE.NM_ITM ITEM_NM, DECODE(SUMM.MISC_ITEM_ID, NULL, ITEM.BARCODE, SUMM.MISC_ITEM_ID) BARCODE, 
	SUMM.SALES_DATE SALES_DATE, 
	NVL(SUMM.MARKDOWN_AMT,'0')  SALE_MARKDOWN_AMT, NVL(SUMM.NET_AMOUNT,'0') NET_SALE_AMT, TOTAL_QUANTITY TOTAL_SALE_QTY, 
	'0' RTN_MARKDOWN_AMT, '0' NET_RTN_AMT, 0 TOTAL_RTN_QTY 
FROM RK_SALES_SUMMARY SUMM, AS_ITM ITEM, AS_ITM_RTL_STR ITEMSTORE, ID_DPT_PS DEPT,  ARM_CLASS CLASS 
WHERE SUMM.ID_ITM = ITEM.ID_ITM 
	AND ITEM.ID_ITM = ITEMSTORE.ID_ITM 
	AND SUMM.ID_STR_RT = ITEMSTORE.ID_STR_RT 
	AND SUMM.ITEM_DEPT_ID = DEPT.ID_DPT_POS(+) 
	AND SUMM.ITEM_DEPT_ID = CLASS.ID_DPT(+) 
	AND SUMM.ITEM_CLSS_ID = CLASS.ID_CLSS(+) 
	AND NVL(SUMM.TYPE,'S') ='S' 
UNION ALL 
SELECT SUMM.ID_STR_RT ID_STR_RT, 
	DECODE(SUBSTR(SUMM.ITEM_DEPT_ID,1, 1), '1', 'GAW', '2', 'GAM', '3', 'GAUJUN', '4', 'EAW', '5', 'EAM', '6', 'EAU', '7', 'ACGIFT', '8', 'ACTEXT', '9', 'ACTABLE', '99') DIV, 
	SUMM.ITEM_DEPT_ID DEPT_ID, DEPT.NM_DPT_POS DEPT_NM  , NVL(SUMM.ITEM_CLSS_ID,'NONE') CLASS_ID, NVL(CLASS.NM_CLSS,'NONE') CLASS_NM, 
	SUMM.ID_ITM ITEM_ID,  ITEMSTORE.NM_ITM ITEM_NM, DECODE(SUMM.MISC_ITEM_ID, NULL, ITEM.BARCODE, SUMM.MISC_ITEM_ID) BARCODE, 
	SUMM.SALES_DATE SALES_DATE, 
	'0' SALE_MARKDOWN_AMT, '0' NET_SALE_AMT, 0 TOTAL_SALE_QTY, NVL(SUMM.MARKDOWN_AMT,'0')  RTN_MARKDOWN_AMT, 
	NVL(SUMM.NET_AMOUNT,'0') NET_RTN_AMT, TOTAL_QUANTITY TOTAL_RTN_QTY 
FROM RK_SALES_SUMMARY SUMM, AS_ITM ITEM,  AS_ITM_RTL_STR ITEMSTORE, ID_DPT_PS DEPT, ARM_CLASS CLASS 
WHERE SUMM.ID_ITM = ITEM.ID_ITM 
	AND ITEM.ID_ITM = ITEMSTORE.ID_ITM 
	AND SUMM.ID_STR_RT = ITEMSTORE.ID_STR_RT 
	AND SUMM.ITEM_DEPT_ID = DEPT.ID_DPT_POS(+) 
	AND SUMM.ITEM_DEPT_ID = CLASS.ID_DPT(+) 
	AND SUMM.ITEM_CLSS_ID = CLASS.ID_CLSS(+) 
	AND NVL(SUMM.TYPE,'S') ='R' 
);

CREATE OR REPLACE VIEW V_ARM_TXN_HDR
(CUST_ID, TY_TRN, PAY_TRN_TYPE, ID_STR_RT, ID_OPR, 
 TS_TRN_PRC, TS_TRN_SBM, TY_GUI_TRN, PAY_TYPES, TOTAL_AMT, 
 AI_TRN, CONSULTANT_ID, REDUCTION_AMOUNT, NET_AMOUNT, DISCOUNT_TYPES, 
 ITEMS_IDS, REGISTER_ID, FN_PRS, LN_PRS, EXP_DT, 
 REF_ID, VOID_ID)
AS 
SELECT RK_PAY_TRN.CUST_ID, TR_TRN.TY_TRN, RK_PAY_TRN.TYPE_ID PAY_TRN_TYPE, TR_TRN.ID_STR_RT, 
TR_TRN.ID_OPR, TR_TRN.TS_TRN_PRC, TR_TRN.TS_TRN_SBM, 
TR_TRN.TY_GUI_TRN, RK_PAY_TRN.PAY_TYPES, RK_PAY_TRN.TOTAL_AMT, 
RK_PAY_TRN.AI_TRN, PA_EM.ARM_EXTERNAL_ID CONSULTANT_ID, TR_RTL.REDUCTION_AMOUNT, 
TR_RTL.NET_AMOUNT, TR_RTL.DISCOUNT_TYPES, TR_RTL.ITEMS_IDS, 
TR_RTL.REGISTER_ID, PA_PRS.FN_PRS, PA_PRS.LN_PRS, 
ARM_POS_PRS.EXP_DT, ARM_POS_PRS.ID_PRESALE REF_ID, TR_TRN.ID_VOID 
FROM TR_TRN INNER JOIN 
( 
	RK_PAY_TRN INNER JOIN 
	( 
		TR_RTL INNER JOIN ARM_POS_PRS ON TR_RTL.AI_TRN=ARM_POS_PRS.AI_TRN 
		LEFT OUTER JOIN PA_PRS ON TR_RTL.CONSULTANT_ID=PA_PRS.ID_PRTY_PRS 
		LEFT OUTER JOIN PA_EM ON TR_RTL.CONSULTANT_ID=PA_EM.ID_EM 
		INNER JOIN (SELECT AI_TRN, COUNT(*) FROM RK_POS_LN_ITM_DTL WHERE NVL(FL_PROCESSED,'0') IN ('0') GROUP BY AI_TRN   HAVING COUNT(*) > 0) LN_ITM_DTL 
		ON TR_RTL.AI_TRN = LN_ITM_DTL.AI_TRN 
	) 
	ON RK_PAY_TRN.AI_TRN = TR_RTL.AI_TRN 
) 
ON TR_TRN.AI_TRN = RK_PAY_TRN.AI_TRN 
UNION ALL 
SELECT RK_PAY_TRN.CUST_ID, TR_TRN.TY_TRN, RK_PAY_TRN.TYPE_ID PAY_TRN_TYPE, TR_TRN.ID_STR_RT, 
TR_TRN.ID_OPR, TR_TRN.TS_TRN_PRC, TR_TRN.TS_TRN_SBM, 
TR_TRN.TY_GUI_TRN, RK_PAY_TRN.PAY_TYPES, RK_PAY_TRN.TOTAL_AMT, 
RK_PAY_TRN.AI_TRN, PA_EM.ARM_EXTERNAL_ID CONSULTANT_ID, TR_RTL.REDUCTION_AMOUNT, 
TR_RTL.NET_AMOUNT, TR_RTL.DISCOUNT_TYPES, TR_RTL.ITEMS_IDS, 
TR_RTL.REGISTER_ID, PA_PRS.FN_PRS, PA_PRS.LN_PRS, 
ARM_POS_CSG.EXP_DT, ARM_POS_CSG.ID_CONSIGNMENT REF_ID, TR_TRN.ID_VOID 
FROM TR_TRN INNER JOIN 
( 
	RK_PAY_TRN INNER JOIN 
	( 
		TR_RTL INNER JOIN ARM_POS_CSG ON TR_RTL.AI_TRN=ARM_POS_CSG.AI_TRN 
		LEFT OUTER JOIN PA_PRS ON TR_RTL.CONSULTANT_ID=PA_PRS.ID_PRTY_PRS 
		LEFT OUTER JOIN PA_EM ON TR_RTL.CONSULTANT_ID=PA_EM.ID_EM 
		INNER JOIN (SELECT AI_TRN, COUNT(*) FROM RK_POS_LN_ITM_DTL WHERE NVL(FL_PROCESSED,'0') IN ('0') GROUP BY AI_TRN   HAVING COUNT(*) > 0) LN_ITM_DTL 
		ON TR_RTL.AI_TRN = LN_ITM_DTL.AI_TRN 
	) 
	ON RK_PAY_TRN.AI_TRN = TR_RTL.AI_TRN 
) 
ON TR_TRN.AI_TRN = RK_PAY_TRN.AI_TRN 
UNION ALL 
SELECT RK_PAY_TRN.CUST_ID, TR_TRN.TY_TRN, RK_PAY_TRN.TYPE_ID PAY_TRN_TYPE, TR_TRN.ID_STR_RT, 
TR_TRN.ID_OPR, TR_TRN.TS_TRN_PRC, TR_TRN.TS_TRN_SBM, 
TR_TRN.TY_GUI_TRN, RK_PAY_TRN.PAY_TYPES, RK_PAY_TRN.TOTAL_AMT, 
RK_PAY_TRN.AI_TRN, PA_EM.ARM_EXTERNAL_ID CONSULTANT_ID, TR_RTL.REDUCTION_AMOUNT, 
TR_RTL.NET_AMOUNT, TR_RTL.DISCOUNT_TYPES, TR_RTL.ITEMS_IDS, 
TR_RTL.REGISTER_ID, PA_PRS.FN_PRS, PA_PRS.LN_PRS, 
ARM_POS_RSV.EXP_DT, ARM_POS_RSV.ID_RESERVATION REF_ID, TR_TRN.ID_VOID 
FROM TR_TRN INNER JOIN 
( 
	RK_PAY_TRN INNER JOIN 
	( 
		TR_RTL INNER JOIN ARM_POS_RSV ON TR_RTL.AI_TRN=ARM_POS_RSV.AI_TRN 
		LEFT OUTER JOIN PA_PRS ON TR_RTL.CONSULTANT_ID=PA_PRS.ID_PRTY_PRS 
		LEFT OUTER JOIN PA_EM ON TR_RTL.CONSULTANT_ID=PA_EM.ID_EM 
		INNER JOIN (SELECT RK_POS_LN_ITM_DTL.AI_TRN, COUNT(*) FROM RK_POS_LN_ITM_DTL INNER JOIN TR_LTM_RTL_TRN 
									ON RK_POS_LN_ITM_DTL.AI_TRN = TR_LTM_RTL_TRN.AI_TRN 
									 AND RK_POS_LN_ITM_DTL.AI_LN_ITM = TR_LTM_RTL_TRN.AI_LN_ITM 
									 WHERE NVL(FL_PROCESSED,'0') IN ('0') AND TR_LTM_RTL_TRN.POS_LN_ITM_TY_ID IN ('6') GROUP BY RK_POS_LN_ITM_DTL.AI_TRN   HAVING COUNT(*) > 0) LN_ITM_DTL 
		ON TR_RTL.AI_TRN = LN_ITM_DTL.AI_TRN 
	) 
	ON RK_PAY_TRN.AI_TRN = TR_RTL.AI_TRN 
) 
ON TR_TRN.AI_TRN = RK_PAY_TRN.AI_TRN;
