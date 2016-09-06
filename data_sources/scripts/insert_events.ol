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
  import.filename = "./files/events.csv";
	importFile@CSVImport( import )( events );
  for( i = 0, i < #events.line, i++ ) {
      undef( req );
      with( req ) {
          .name = events.line[ i ].name;
          .place = events.line[ i ].place;
          .start_date = events.line[ i ].start_date;
          .end_date = events.line[ i ].end_date;
          .category = events.line[ i ].category
      };
      valueToPrettyString@StringUtils( req )( s );
      println@Console( s )();
      insertEvent@DbService( req )()
  }
}
