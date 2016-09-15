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
  import.filename = "./files/countries.csv";
	importFile@CSVImport( import ) ( countries );
  for( i = 0, i < #countries.line, i++ ) {
      undef( req );
      with( req ) {
          .country_id = int(countries.line[ i ].country_id);
          .name = countries.line[ i ].name
      };
      valueToPrettyString@StringUtils( req )( s );
      println@Console( s )();
      insertCountry@DbService( req )()
  }
}
