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
  import.filename = "./files/cookingtechniques.csv";
	importFile@CSVImport( import ) ( cookingtechniques );
  for( i = 0, i < #cookingtechniques.line, i++ ) {
      undef( req );
      with( req ) {
          .cooking_technique_id = int(cookingtechniques.line[ i ].cooking_technique_id);
          .name = cookingtechniques.line[ i ].cooking_technique
      };
      valueToPrettyString@StringUtils( req )( s );
      println@Console( s )();
      insertCookingTechnique@DbService( req )()
  }
}
