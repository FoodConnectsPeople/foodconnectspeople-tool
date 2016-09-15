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
  import.filename = "./files/recipe2categories.csv";
	importFile@CSVImport( import ) ( reccat );
  for( i = 0, i < #reccat.line, i++ ) {
      undef( req );
      with( req ) {
          .category_id = int(reccat.line[ i ].category_id);
          .name = reccat.line[ i ].category
      };
      valueToPrettyString@StringUtils( req )( s );
      println@Console( s )();
      insertRecipeCategory@DbService( req )()
  }
}
