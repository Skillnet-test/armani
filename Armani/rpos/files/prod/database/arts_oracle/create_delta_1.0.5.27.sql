CREATE OR REPLACE VIEW V_ARM_ITEM_SALE
(ID_STR_RT, DIV,DEPT_ID, DEPT_NM, CLASS_ID, CLASS_NM, 
 ITEM_ID, ITEM_NM, SALES_DATE, SALE_MARKDOWN_AMT, NET_SALE_AMT, 
 TOTAL_SALE_QTY, RTN_MARKDOWN_AMT, NET_RTN_AMT, TOTAL_RTN_QTY)
AS 
( 
SELECT SUMM.ID_STR_RT ID_STR_RT, 
DECODE(TO_NUMBER(SUBSTR(ITEM.ID_DPT_POS,1, 1)), '1', 'GAW', '2', 'GAM', '3', 'GAUJUN', '4', 'EAW', '5', 'EAM', '6', 'EAU', '7', 'ACGIFT', '8', 'ACTEXT', '9', 'ACTABLE', '99') DIV,
ITEM.ID_DPT_POS DEPT_ID, DEPT.NM_DPT_POS DEPT_NM  , 
NVL(ITEM.ID_CLSS,'NONE') CLASS_ID, NVL(CLASS.NM_CLSS,'NONE') CLASS_NM, 
SUMM.ID_ITM ITEM_ID,  ITEMSTORE.NM_ITM ITEM_NM,SUMM.SALES_DATE SALES_DATE, 
NVL(SUMM.MARKDOWN_AMT,0)  SALE_MARKDOWN_AMT, 
NVL(SUMM.NET_AMOUNT,0) NET_SALE_AMT, 
TOTAL_QUANTITY TOTAL_SALE_QTY, 
 '0' RTN_MARKDOWN_AMT, 
'0' NET_RTN_AMT, 
 0 TOTAL_RTN_QTY 
FROM 
RK_SALES_SUMMARY SUMM, AS_ITM ITEM,  AS_ITM_RTL_STR ITEMSTORE, ID_DPT_PS DEPT,  ARM_CLASS CLASS 
WHERE SUMM.ID_ITM = ITEM.ID_ITM 
AND ITEM.ID_ITM = ITEMSTORE.ID_ITM  AND SUMM.ID_STR_RT = ITEMSTORE.ID_STR_RT 
AND ITEM.ID_DPT_POS = DEPT.ID_DPT_POS 
AND ITEM.ID_DPT_POS = CLASS.ID_DPT(+) 
AND ITEM.ID_CLSS = CLASS.ID_CLSS(+) 
AND NVL(SUMM.TYPE,'S') ='S' 
UNION ALL 
SELECT SUMM.ID_STR_RT ID_STR_RT, 
DECODE(TO_NUMBER(SUBSTR(ITEM.ID_DPT_POS,1, 1)), '1', 'GAW', '2', 'GAM', '3', 'GAUJUN', '4', 'EAW', '5', 'EAM', '6', 'EAU', '7', 'ACGIFT', '8', 'ACTEXT', '9', 'ACTABLE', '99') DIV,
ITEM.ID_DPT_POS DEPT_ID, DEPT.NM_DPT_POS DEPT_NM  , 
NVL(ITEM.ID_CLSS,'NONE') CLASS_ID, NVL(CLASS.NM_CLSS,'NONE') CLASS_NM, 
SUMM.ID_ITM ITEM_ID,  ITEMSTORE.NM_ITM ITEM_NM, SUMM.SALES_DATE SALES_DATE, 
'0' SALE_MARKDOWN_AMT, 
'0' NET_SALE_AMT, 
0 TOTAL_SALE_QTY, 
NVL(SUMM.MARKDOWN_AMT,0)  RTN_MARKDOWN_AMT, 
NVL(SUMM.NET_AMOUNT,0) NET_RTN_AMT, 
TOTAL_QUANTITY TOTAL_RTN_QTY 
FROM 
RK_SALES_SUMMARY SUMM, AS_ITM ITEM,  AS_ITM_RTL_STR ITEMSTORE, ID_DPT_PS DEPT, ARM_CLASS CLASS 
WHERE SUMM.ID_ITM = ITEM.ID_ITM 
AND ITEM.ID_ITM = ITEMSTORE.ID_ITM  AND SUMM.ID_STR_RT = ITEMSTORE.ID_STR_RT 
AND ITEM.ID_DPT_POS = DEPT.ID_DPT_POS 
AND ITEM.ID_DPT_POS = CLASS.ID_DPT(+) 
AND ITEM.ID_CLSS = CLASS.ID_CLSS(+) 
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
ON TR_TRN.AI_TRN = RK_PAY_TRN.AI_TRN;

