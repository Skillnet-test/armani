whenever SQLERROR EXIT 1
whenever OSERROR EXIT 2
set serverout on
begin
    declare
        interface_key varchar2(100);
        start_time varchar2(100);
        file_name varchar2(100);
        return_code number := 0;
        return_message varchar2(255);
    begin
        -- Delete following row when making a build
        --delete from salil_debug_table; commit;
        interface_key := '&1';
        start_time := '&2';
        file_name := '&3';
        return_code := arm_load_item_pkg.load_item(
                interface_key
              , start_time
              , file_name
        );
        commit;
    end;
end;
/
exit 0
/
