whenever SQLERROR EXIT 1
whenever OSERROR EXIT 2
begin
    declare
        l_folder_name varchar2(100);
        l_file_name varchar2(100);
        return_status varchar2(10);
        return_message varchar2(255);
    begin
        l_file_name := '&1';
        BEGIN
            SELECT LOOKUP_CODE
            INTO   l_folder_name
            FROM   ARM_MISC_LOOKUP
            WHERE  LOOKUP_TYPE = 'ITEM_DOWNLOAD_SUB_DIRECTORY'
            AND    ENABLED_FLAG = 'Y';
            --
            EXCEPTION
		    WHEN NO_DATA_FOUND THEN  
                return_status := 'FAILURE';
                return_message := 'ITEM_DOWNLOAD_SUB_DIRECTORY is not found';
                return;
		    WHEN OTHERS THEN  
                return_status := 'FAILURE';
                return_message := 'Error fetching from ARM_MISC_LOOKUP - ' || SQLERRM;
                return;
	END;
        utl_file.fremove(l_folder_name, l_file_name);
        return_status := 'SUCCESS';
        return_message := '';
        --
        EXCEPTION
        WHEN utl_file.invalid_mode THEN
            return_status := 'FAILURE';
            return_message := 'utl_file.invalid_mode: ' || SQLERRM;
        WHEN utl_file.invalid_path THEN
            return_status := 'FAILURE';
            return_message := 'utl_file.invalid_path: ' || SQLERRM;
        WHEN utl_file.invalid_filehandle THEN
            return_status := 'FAILURE';
            return_message := 'utl_file.invalid_filehandle: ' || SQLERRM;
        WHEN utl_file.invalid_operation THEN
            return_status := 'FAILURE';
            return_message := 'utl_file.invalid_operation: ' || SQLERRM;
        WHEN utl_file.read_error THEN
            return_status := 'FAILURE';
            return_message := 'utl_file.read_error: ' || SQLERRM;
        WHEN utl_file.write_error THEN
            return_status := 'FAILURE';
            return_message := 'utl_file.write_error: ' || SQLERRM;
        WHEN utl_file.internal_error THEN
            return_status := 'FAILURE';
            return_message := 'utl_file.internal_error: ' || SQLERRM;
        WHEN others THEN
           return_status := 'FAILURE';
           return_message := SQLERRM;
           COMMIT;
    end;
end;
/
exit 0
/
