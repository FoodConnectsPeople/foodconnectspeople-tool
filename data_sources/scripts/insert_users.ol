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
  import.filename = "./files/fcpusers.csv";
	importFile@CSVImport( import )( users );
  for( i = 0, i < #users.line, i++ ) {
      undef( req );
      with( req ) {
          .fcp_user_id = int(users.line[ i ].fcp_user_id);
          .username = users.line[ i ].username;
          .full_name = users.line[ i ].full_name;
          .is_author = bool(users.line[ i ].is_author);
          .is_cook = bool(users.line[ i ].is_cook)
      };
      valueToPrettyString@StringUtils( req )( s );
      println@Console( s )();
      insertUser@DbService( req )()
  }
}
