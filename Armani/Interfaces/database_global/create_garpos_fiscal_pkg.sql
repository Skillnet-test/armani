CREATE OR REPLACE package garpos_fiscal is
function fiscal_half(trntime in date) return varchar2;
function fiscal_day(trntime in date) return varchar2;
function fiscal_seq(trntime in date) return number;
end;
/


CREATE OR REPLACE PACKAGE BODY Garpos_Fiscal IS
FUNCTION Fiscal_Seq(trntime IN DATE) RETURN NUMBER IS
v_fiscalchar VARCHAR2(3);
v_half VARCHAR2(20);
v_sequence NUMBER;
BEGIN
SELECT DECODE(TRIM(Fiscal_Half(trntime)),
'07:00AM-07:29AM', '1',
'07:30AM-07:59AM', '2',
'08:00AM-08:29AM', '3',
'08:30AM-08:59AM', '4',
'09:00AM-09:29AM', '5',
'09:30AM-09:59AM', '6',
'10:00AM-10:29AM', '7',
'10:30AM-10:59AM', '8',
'11:00AM-11:29AM', '9',
'11:30AM-11:59AM', '10',
'12:00PM-12:29PM', '11',
'12:30PM-12:59PM', '12',
'1:00PM-1:29PM', '13',
'1:30PM-1:59PM', '14',
'2:00PM-2:29PM', '15',
'2:30PM-2:59PM', '16',
'3:00PM-3:29PM', '17',
'3:30PM-3:59PM', '18',
'4:00PM-4:29PM', '19',
'4:30PM-4:59PM', '20',
'5:00PM-5:29PM', '21',
'5:30PM-5:59PM', '22',
'6:00PM-6:29PM', '23',
'6:30PM-6:59PM', '24',
'7:00PM-7:29PM', '25',
'7:30PM-7:59PM', '26',
'8:00PM-8:29PM', '27',
'8:30PM-8:59PM', '28',
'9:00PM-9:29PM', '29',
'9:30PM-9:59PM', '30',
'10:00PM-10:29PM', '31',
'10:30PM-10:59PM', '32',
'11:00PM-11:29PM', '33',
'11:30PM-11:59PM', '34',
'00:00AM-00:29AM', '35',
'00:30AM-00:59AM', '36',
'01:00AM-01:29AM', '37',
'01:30AM-01:59AM', '38',
'02:00AM-02:29AM', '39',
'02:30AM-02:59AM', '40',
'03:00AM-03:29AM', '41',
'03:30AM-03:59AM', '42',
'04:00AM-04:29AM', '43',
'04:30AM-04:59AM', '44',
'05:00AM-05:29AM', '45',
'05:30AM-05:59AM', '46',
'06:00AM-06:29AM', '47',
'06:30AM-06:59AM', '48',
'99')
INTO  v_fiscalchar FROM dual;
v_sequence:=TO_NUMBER(v_fiscalchar);
RETURN v_sequence;
END;

FUNCTION Fiscal_Half(trntime IN DATE) RETURN VARCHAR2 IS
v_halftime VARCHAR2(50);
BEGIN
SELECT DISTINCT TRIM(DECODE(SIGN(TO_NUMBER(TO_CHAR(trntime, 'MI')) - 30), -1,
(TO_CHAR(trntime, 'HH12')||':00'||TO_CHAR(trntime, 'AM')||'-'||TO_CHAR(trntime, 'HH12')||':29'||TO_CHAR(trntime, 'AM')),
 1,( TO_CHAR(trntime, 'HH12')||':30'||TO_CHAR(trntime, 'AM')||'-'||
TO_CHAR(TO_CHAR(trntime, 'HH12')||':59'||TO_CHAR(trntime, 'AM'))), 0, ( TO_CHAR(trntime, 'HH12')||':30'||TO_CHAR(trntime, 'AM')||'-'||
TO_CHAR(TO_CHAR(trntime, 'HH12')))||':59'||TO_CHAR(trntime, 'AM'))) INTO v_halftime FROM dual ;
RETURN v_halftime;
END;

FUNCTION Fiscal_Day(trntime IN DATE) RETURN VARCHAR2 IS
v_fiscalday VARCHAR2(20);
BEGIN
SELECT DISTINCT DECODE(SIGN(TO_NUMBER(TO_CHAR(trntime, 'HH24'))-8), -1,TO_DATE(TO_CHAR(trntime,'DD-MON-YY'))-1,trntime) INTO v_fiscalday FROM dual ;
RETURN v_fiscalday;
END;

END;
/
