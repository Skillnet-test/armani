/*
History:
+------+------------+-----------+-----------+----------------------------------------------------+
| Ver# | Date       | By        | Defect #  | Description                                        |
+------+------------+-----------+-----------+----------------------------------------------------+
| 1    | 05/23/2005 | Vikram    | N/A       | Provides Client specific version                   |
--------------------------------------------------------------------------------------------------
*/




/**
 * <p>Title: Version</p>
 *
 * <p>Description: Client specific version</p>
 *
 * <p>Copyright: Copyright (c) 2005</p>
 *
 * <p>Company: </p>
 *
 * @author Vikram Mundhra
 * @version 1.0
 */
public class Version
{
    public static final String DELIM = ".";
    public static final String MAJOR = "3";
    public static final String MINOR = "0";
    public static final String UPDATE = "0";
    public static final String BUILD = "0";
    public static final String VERSION = "3.0.0.0";
    public static final String VERSION_PROPERTY_KEY = "com.armani.cif.version";


    /**
     *
     */
    public static void applyVersion()
    {
        System.setProperty(VERSION_PROPERTY_KEY, VERSION);
    }

    /**
     *
     * @param args String[]
     */
    public static void main(String args[])
    {
            System.out.println("Armani CIF Version: 3.0.0.0");
    }


}
