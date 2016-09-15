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
  import.filename = "./files/tools.csv";
	importFile@CSVImport( import ) ( tools );
  for( i = 0, i < #tools.line, i++ ) {
      undef( req );
      with( req ) {
          .tool_id = int(tools.line[ i ].tool_id);
          .name = tools.line[ i ].name
      };
      valueToPrettyString@StringUtils( req )( s );
      println@Console( s )();
      insertTool@DbService( req )()
  }
}
