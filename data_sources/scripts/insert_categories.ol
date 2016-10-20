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
  import.filename = "./files/categories.csv";
	importFile@CSVImport( import ) ( categories );
  for( i = 0, i < #categories.line, i++ ) {
      undef( req );
      with( req ) {
          .id       = int(categories.line[ i ].Id);
          .name     = categories.line[ i ].Name;
          .category = categories.line[ i ].Category
      };
      valueToPrettyString@StringUtils( req )( s );
      println@Console( s )();
      insertCategory@DbService( req )()
  }
}
