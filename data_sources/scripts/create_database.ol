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

	  scope( db_creation ) {
				install( ConnectionError =>
					fault.message = "ERROR connecting with Database";
					throw( ConnectionError, fault )
				);
        install( SQLException =>
          fault.message = create_database.SQLException.stackTrace;
          throw( CreationError, fault )
        );
        install( SQLServerException =>
          fault.message = create_database.SQLServerException.stackTrace;
          throw( CreationError, fault )
        );

				with( connectionInfo ) {
					.host = HOST;
					.driver = DRIVER;
					.port = PORT;
					.database= "postgres";
					.username = USERNAME;
					.password = PASSWORD;
					.checkConnection = 1
				};
				connect@Database( connectionInfo )();

			  q = "CREATE DATABASE " + DBNAME + " OWNER " + USERNAME;
        update@Database( q )()
	 }
	 ;
   println@Console("Database created")()
   ;

	 scope( create_tables ) {
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
        f.filename = "../create-schema.sql";
        readFile@File( f )( schema );
				q = schema;
				update@Database( q )( )
		};

		println@Console("Tables created successfully!")()
}
