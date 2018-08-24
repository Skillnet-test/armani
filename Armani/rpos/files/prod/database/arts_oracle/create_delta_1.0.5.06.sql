--DROP SEQUENCE ARM_SEQ_CUSTID;

CREATE SEQUENCE ARM_SEQ_CUSTID
  START WITH 1000000000
  NOMAXVALUE
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;

alter table rk_pos_ln_itm_dtl drop column loyalty_pt;

alter table rk_pos_ln_itm_dtl add loyalty_pt number(15,2);

alter table arm_loyalty_hist drop column points;

alter table arm_loyalty_hist add points number(15,2);

alter table arm_loyalty drop column current_bal;

alter table arm_loyalty add current_bal number(15,2);

alter table arm_loyalty drop column lifetime_bal;

alter table arm_loyalty add lifetime_bal number(15,2);

alter table tr_rtl add loyalty_truncated number(1);