CREATE TABLE ARM_TAX_RATE 
( 
  ZIP_CODE      VARCHAR2 (10), 
  CITY          VARCHAR2 (50), 
  COUNTY        VARCHAR2 (50), 
  STATE         VARCHAR2 (10), 
  TAX_RATE      NUMBER (9,4), 
  EFFECTIVE_DT  DATE
);

CREATE INDEX INDX_TAX_RATE ON ARM_TAX_RATE(ZIP_CODE, CITY, COUNTY, STATE);

CREATE TABLE TR_LTM_DSC_DTL
(
  AI_TRN       VARCHAR2(128),
  AL_LN_ITM    INTEGER,
  SEQ_NUM      NUMBER (3),
  DSC_SEQ_NUM  NUMBER (3)
);


ALTER TABLE TR_LTM_DSC_DTL ADD PRIMARY KEY(AI_TRN, AL_LN_ITM, SEQ_NUM);

ALTER TABLE TR_LTM_DSC_DTL ADD FOREIGN KEY (AI_TRN,DSC_SEQ_NUM) REFERENCES TR_LTM_DSC(AI_TRN,AI_LN_ITM);

ALTER TABLE TR_LTM_DSC_DTL ADD FOREIGN KEY (AI_TRN, AL_LN_ITM) REFERENCES TR_LTM_RTL_TRN (AI_TRN,AI_LN_ITM);

ALTER TABLE TR_LTM_DSC ADD DISCOUNT_CODE VARCHAR2(10);

INSERT INTO TR_DSC ( TY_DSC, ID_STR_RT, ID_ACNT_LDG, NM_DSC, DE_DSC, CD_RDN_MTH, MO_RDN_AMT,
PE_RDN_AMT, MO_NW_PRC ) VALUES ( 'RD', NULL, NULL, 'REWARD DISCOUNT', 'REWARD DISCOUNT', NULL, '0', 0, '0');

ALTER TABLE TR_LTM_TND ADD ( JOURNAL_KEY VARCHAR2(16), RES_MSG VARCHAR2(38), MSG_NUM VARCHAR2(2), MERCHANT_ID VARCHAR2(15));

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
SC_CT			VARCHAR(20)
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

INSERT INTO CO_CLS_GF_CF ( TY_GF_CF, ID_STR_RT, ID_ACNT_LDG, DE_TYP_GF_CF, NM_AF_BSN_GF_CF, QU_DY_RDM_PRD, ID_FRM_GF_CF, DP_BLNC_UNSP_GF_CF ) VALUES ( 
'HOUSE_ACCOUNT', NULL, NULL, 'HOUSE_ACCOUNT', NULL, 0, NULL, NULL); 


ALTER TABLE ARM_CLASS
MODIFY NM_CLSS VARCHAR2(50);

INSERT INTO CO_CLS_TND (LU_CLS_TND, DE_CLS_TND) values ('HOUSE_ACCOUNT', 'HOUSE_ACCOUNT');
INSERT INTO CO_CLS_TND (LU_CLS_TND, DE_CLS_TND) values ('JCB', 'JCB');
INSERT INTO CO_CLS_TND (LU_CLS_TND, DE_CLS_TND) values ('DINERS', 'DINERS');
INSERT INTO CO_CLS_TND (LU_CLS_TND, DE_CLS_TND) values ('JPY_CASH', 'JPY_CASH');
INSERT INTO CO_CLS_TND (LU_CLS_TND, DE_CLS_TND) values ('COUPON', 'COUPON');
INSERT INTO CO_CLS_TND (LU_CLS_TND, DE_CLS_TND) values ('MAIL_CHECK', 'MAIL_CHECK');
INSERT INTO CO_CLS_TND (LU_CLS_TND, DE_CLS_TND) values ('MALL_CERTIFICATE', 'MALL_CERTIFICATE');









