Steps to execute
------------------
	1. Extract the util.zip
	2. Go to properties folder
	3. Specify the Database information into Reader.properties
	4. Before running the utility run the execute the add_status_column.sql at SQL prompt.
		4.1 Go to main folder where the add_status_column.sql is avaulable.
		4.2 Connect to the SQLPlus.
		4.3 Run the add_status_column.sql script by executing the following command.
			@add_status_column.sql

			e.g. SQL> @add_status_column.sql
	5. Start the encryption by executing the encrypt_ccno.sh script.
		e.g. ./encrypt_ccno.sh
	
	6. Once the utility stop - Check for any error/failure in the CCNoEncrypter.log.
	7. If the utility executed sussfully run the following db script.
			@remove_status_column.sql

			e.g. SQL> @remove_status_column.sql


	
Note:
Befoer executing any script please set the execute permissoin for the same.
