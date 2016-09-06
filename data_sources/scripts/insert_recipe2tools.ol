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
  import.filename = "./files/recipe2tools.csv";
	importFile@CSVImport( import )( recipe2tools );
  for( i = 0, i < #recipe2tools.line, i++ ) {
      undef( req );
      with( req ) {
          .recipe_id = int(recipe2tools.line[ i ].recipe_id);
          .tool_name = recipe2tools.line[ i ].tool_name;
          .tool_quantity  = int(recipe2tools.line[ i ].tool_quantity)
      };
      valueToPrettyString@StringUtils( req )( s );
      println@Console( s )();
      insertRecipeTool@DbService( req )()
  }
}
