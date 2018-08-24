create table ARM_CUSTOMER_MESSAGES
(
ID_CT varchar2(128),
TY_CT varchar2(10),
TY_MSG varchar2(1) not null,
MESSAGE varchar2(255)  not null,
STATUS varchar2(1)  default 'O' not null, 
RESPONSE varchar2(255)
);