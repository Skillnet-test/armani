CREATE OR REPLACE package garpos_fiscal is
function fiscal_half(trntime in date) return varchar2;
function fiscal_day(trntime in date) return varchar2;
function fiscal_seq(trntime in date) return number;
end;
/