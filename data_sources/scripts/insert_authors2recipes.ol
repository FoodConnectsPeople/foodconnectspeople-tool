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
  import.filename = "./files/authorsrecipes.csv";
	importFile@CSVImport( import )( authorsrecipes );
  for( i = 0, i < #authorsrecipes.line, i++ ) {
      undef( req );
      with( req ) {
          .author_id = int(authorsrecipes.line[ i ].author_id);
          .recipe_id = int(authorsrecipes.line[ i ].recipe_id)
      };
      valueToPrettyString@StringUtils( req )( s );
      println@Console( s )();
      insertAuthorRecipe@DbService( req )()
  }
}
