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

DROP SYNONYM &&2..ARM_STG_DEPT;

CREATE SYNONYM &&2..ARM_STG_DEPT FOR &&1..ARM_STG_DEPT;

GRANT ALL ON  &&2..ARM_STG_DEPT TO &&2;


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


DROP SYNONYM &&2..ARM_STG_CLASS;

CREATE SYNONYM &&2..ARM_STG_CLASS FOR &&1..ARM_STG_CLASS;

GRANT ALL ON  &&2..ARM_STG_CLASS TO &&2;


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

DROP SYNONYM &&2..ARM_STG_SUBCLASS;

CREATE SYNONYM &&2..ARM_STG_SUBCLASS FOR &&1..ARM_STG_SUBCLASS;

GRANT ALL ON  &&2..ARM_STG_SUBCLASS TO &&2;


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


DROP SYNONYM &&2..ARM_STG_SPR;

CREATE SYNONYM &&2..ARM_STG_SPR FOR &&1..ARM_STG_SPR;

GRANT ALL ON  &&2..ARM_STG_SPR TO &&2;


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

DROP SYNONYM &&2..ARM_STG_SIZE;

CREATE SYNONYM &&2..ARM_STG_SIZE FOR &&1..ARM_STG_SIZE;

GRANT ALL ON  &&2..ARM_STG_SIZE TO &&2;


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


DROP SYNONYM &&2..ARM_STG_SEASON;

CREATE SYNONYM &&2..ARM_STG_SEASON FOR &&1..ARM_STG_SEASON;

GRANT ALL ON  &&2..ARM_STG_SEASON TO &&2;



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

DROP SYNONYM &&2..ARM_STG_COLOR;

CREATE SYNONYM &&2..ARM_STG_COLOR FOR &&1..ARM_STG_COLOR;

GRANT ALL ON  &&2..ARM_STG_COLOR TO &&2;


