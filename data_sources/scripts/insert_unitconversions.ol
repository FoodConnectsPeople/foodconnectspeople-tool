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
  import.filename = "./files/unitconversions.csv";
	importFile@CSVImport( import )( ucs );
  for( i = 0, i < #ucs.line, i++ ) {
      undef( req );
      with( req ) {
          .ingredient = ucs.line[ i ].ingredient;
          .unit_of_measure = ucs.line[ i ].unit_of_measure;
          .grocery_list_unit = ucs.line[ i ].grocery_list_unit;
          .conversion_rate = double(ucs.line[ i ].conversion_rate);
          if (req.conversion_rate == double(0)) {
            .conversion_rate = double(1)
          };
          .is_standard_conversion = bool(ucs.line[ i ].is_standard_conversion)
      };
      valueToPrettyString@StringUtils( req )( s );
      println@Console( s )();
      insertUnitConversion@DbService( req )()
  }
}
