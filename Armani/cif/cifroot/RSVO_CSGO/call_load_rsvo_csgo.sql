whenever SQLERROR EXIT 1
whenever OSERROR EXIT 2
set serverout on
begin
    declare
        interface_key varchar2(100);
        start_time varchar2(100);
        file_name varchar2(100);
        return_status integer;
        return_message varchar2(255);
    begin
        interface_key := '&1';
        start_time    := '&2';
        file_name     := '&3';
        return_status := arm_load_rsvo_csgo_pkg.load_txn_data(
                interface_key
              , start_time
              , file_name
        );
    end;
end;
/
exit 0
/
