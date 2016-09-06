include "ini_utils.iol"
include "console.iol"
include "file.iol"
include "database.iol"

main
{
	  parseIniFile@IniUtils( "../../jolie/config.ini" )( config );
    HOST = config.db.HOST;
		DRIVER = config.db.DRIVER;
		PORT = int( config.db.PORT );
		DBNAME = config.db.DBNAME;
		USERNAME = config.db.USERNAME;
		PASSWORD = config.db.PASSWORD;


	 scope( create_views ) {
				install( SQLException =>
					fault.message = create_tables.SQLException.stackTrace;
					throw( CreationError, fault )
				);
				install( SQLServerException =>
					fault.message = create_tables.SQLServerException.stackTrace;
					throw( CreationError, fault )
				);

				with( connectionInfo ) {
				      .host = HOST;
				      .driver = DRIVER;
				      .port = PORT;
				      .database = DBNAME;
				      .username = USERNAME;
				      .password = PASSWORD;
				      .checkConnection = 1
				}
				;
				connect@Database( connectionInfo )()
				;
        f.filename = "../create-views.sql";
        readFile@File( f )( schema );
				q = schema;
				update@Database( q )( )
		};

		println@Console("Views created successfully!")()
}
