include "console.iol"
include "string_utils.iol"

include "public/interfaces/CSVImportSurface.iol"
include "../jolie/public/interfaces/DbServiceInterface.iol"

include "../jolie/constants.iol"

outputPort DbService {
  Location: DB_SERVICE_LOCATION
  Protocol: sodep
  Interfaces: DbServiceInterface
}

main {
  with( import ) {
    .separator = ",";
    .verbose = true
  };
  import.filename = "./files/recipe2events.csv";
	importFile@CSVImport( import )( recipe2events );
  for( i = 0, i < #recipe2events.line, i++ ) {
      undef( req );
      with( req ) {
          .recipe_id = int(recipe2events.line[ i ].recipe_id);
          .event_id = int(recipe2events.line[ i ].event_id)
      };
      valueToPrettyString@StringUtils( req )( s );
      println@Console( s )();
      insertRecipeEvent@DbService( req )()
  }
}
