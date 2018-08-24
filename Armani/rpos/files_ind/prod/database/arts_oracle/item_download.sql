whenever SQLERROR EXIT 1
whenever OSERROR EXIT 2
begin
    declare
        folder_name varchar2(100);
        file_name varchar2(100);
        store_id varchar2(128);
        from_date varchar2(12);
        return_status varchar2(10);
        return_message varchar2(255);
    begin
        file_name := '&1';
        store_id := '&2';
        from_date := '&3';
        arm_download_data_pkg.download_item(
             file_name
           , store_id
           , from_date
           , return_status
           , return_message
        );
    end;
end;
/
exit 0
/
