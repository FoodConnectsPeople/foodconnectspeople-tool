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

init {
    __queries;
    parseIniFile@IniUtils( "../../jolie/config.ini" )( config );
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
    println@Console("DbService is running...")();

    // loading properties from DB
    q = queries.select_properties;
    query@Database( q )( result );
    for( i = 0, i < #result.row, i++ ) {
        global.properties.( result.row[ i ].name ).id = result.row[ i ].property_id
    };
    undef( q )
}

main {
  [ getIngredients( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

              q = queries.select_ingredients_properties;
              query@Database( q )( result );

              current_ingredient = result.row[ 0 ].ingredient_name;
              ingredient_index = 0;
              prop_index = 0;
              response.ingredient[ ingredient_index ].name = current_ingredient;
              for( i = 0, i < #result.row, i++ ) {
                  if ( current_ingredient != result.row[ i ].ingredient_name ) {
                      current_ingredient = result.row[ i ].ingredient_name;
                      ingredient_index++;
                      prop_index = 0;
                      response.ingredient[ ingredient_index ].name = current_ingredient
                  };
                  response.ingredient[ ingredient_index ].properties[ prop_index ] = result.row[ i ].property_name;
                  prop_index++
              }
        }
  }]

  [ insertIngredient( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

              q.statement[ 0 ] = queries.insert_ingredient;
              q.statement[ 0 ].name = request.name;
              q.statement[ 1 ] = queries.select_ingredient_id;
              q.statement[ 1 ].name = request.name;
              executeTransaction@Database( q )( transaction_result );

              undef( q );
              for( i = 0, i < #request.properties, i++ ) {
                  q.statement[ i ] = queries.insert_ingredient_property;
                  q.statement[ i ].ingredient_id = transaction_result.result[ 1 ].row.ingredient_id;
                  q.statement[ i ].property_id = global.properties.( request.properties[ i ] ).id
              }
              ;
              executeTransaction@Database( q )( )

        }
  }]
}
