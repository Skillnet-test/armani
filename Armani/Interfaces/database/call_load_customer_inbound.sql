whenever SQLERROR EXIT 1
whenever OSERROR EXIT 2
set serverout on
begin
    declare
        in_day varchar2(10);
        in_date varchar2(20);
        in_time varchar2(20);
        interface_key varchar2(100);
        start_time varchar2(100);
        file_name varchar2(100);
        return_status varchar2(10);
        return_message varchar2(255);
    begin
        interface_key := '&1';
        in_day        := '&2';
        in_date       := '&3';
        in_time       := '&4';
        file_name     := '&5';
        start_time := in_date || ' ' || substr(in_time,1,5);
        arm_load_data_pkg.load_currency_rt(
                interface_key
              , start_time
              , file_name
              , return_status
              , return_message
        );
        dbms_output.put_line(start_time);
    end;
end;
/
exit 0
/
