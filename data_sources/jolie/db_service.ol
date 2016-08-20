include "console.iol"
include "string_utils.iol"
include "database.iol"
include "ini_utils.iol"

include "public/interfaces/DbServiceInterface.iol"


include "constants.iol"
include "queries.iol"

execution { concurrent }


inputPort DbService {
  Location: DB_SERVICE_LOCATION
  Protocol: sodep
  Interfaces: DbServiceInterface
}

inputPort DbServiceHttp {
  Location: DB_SERVICE_LOCATION_HTTP
  Protocol: http { .format = "json" }
  Interfaces: DbServiceInterface
}

init {
    __queries;
    parseIniFile@IniUtils( INI_FILE )( config );
    HOST = config.db.HOST;
    DRIVER = config.db.DRIVER;
    PORT = int( config.db.PORT );
    DBNAME = config.db.DBNAME;
    USERNAME = config.db.USERNAME;
    PASSWORD = config.db.PASSWORD;
    scope( db_connect ) {
      with( connectionInfo ) {
        .host = HOST;
        .driver = DRIVER;
        .port = PORT;
        .database= DBNAME;
        .username = USERNAME;
        .password = PASSWORD;
        .toLowerCase = true
      };
      connect@Database( connectionInfo )();
      println@Console("Connected to Database " + DBNAME + "@" + HOST )()
    };
    println@Console("DbService is running...")()
}

main {
  [ getIngredients( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

              q = queries.select_ingredients;
              query@Database( q )( result );

              for( i = 0, i < #result.row, i++ ) {
                  with( response.ingredient[ i ] ) {
                      .ingredient_id = result.row[ i ].ingredient_id;
                      .name = result.row[ i ].name;
                      .properties = result.row[ i ].properties;
                      .allergene = result.row[ i ].allergene
                  }
              }
        }
  }]

  [ getProperties( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

              q = queries.select_properties;
              query@Database( q )( result );

              for( i = 0, i < #result.row, i++ ) {
                  with( response.property[ i ] ) {
                      .name = result.row[ i ].name;
                      .property_id = result.row[ i ].property_id
                  }
              }
        }

  }]

  [ insertIngredient( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

              // prepare properties
              properties = "";
              for( i = 0, i < #request.properties, i++ ) {
                 properties = properties + request.properties[ i ] + ","
              };
              allergene = "";
              for( i = 0, i < #request.allergene, i++ ) {
                 allergene = allergene + request.allergene[ i ] + ","
              };

              q = queries.insert_ingredient;
              q.name = request.name;
              q.properties = properties;
              q.allergene = request.allergene;
              update@Database( q )( )

        }
  }]
}
