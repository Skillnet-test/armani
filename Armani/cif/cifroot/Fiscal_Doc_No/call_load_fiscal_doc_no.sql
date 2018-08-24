whenever SQLERROR EXIT 1
whenever OSERROR EXIT 2
set serverout on
begin
    declare
        interface_key varchar2(100);
        start_time varchar2(100);
        file_name varchar2(100);
        return_status varchar2(10);
        return_message varchar2(255);
    begin
        interface_key := '&1';
        start_time := '&2';
        file_name := '&3';
        arm_load_data_pkg.load_fiscal_doc_no(
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
