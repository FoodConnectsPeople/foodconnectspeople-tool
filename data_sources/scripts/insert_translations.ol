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
  import.filename = "./files/translations.csv";
	importFile@CSVImport( import ) ( translations );
  for( i = 0, i < #translations.line, i++ ) {
      undef( req );
      with( req ) {
          .italian  = translations.line[ i ].italian;
          .english  = translations.line[ i ].english;
          .table_1  = translations.line[ i ].table_1;
          .column_1 = translations.line[ i ].column_1;
          .table_2  = translations.line[ i ].table_2;
          .column_2 = translations.line[ i ].column_2;
          .table_3  = translations.line[ i ].table_3;
          .column_3 = translations.line[ i ].column_3;
          .table_4  = translations.line[ i ].table_4;
          .column_4 = translations.line[ i ].column_4
      };
      valueToPrettyString@StringUtils( req )( s );
      println@Console( s )();
      insertTranslation@DbService( req )()
  }
}
