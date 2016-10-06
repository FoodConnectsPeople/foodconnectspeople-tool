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
  import.filename = "./files/ingredients-transformed.csv";
	importFile@CSVImport( import )( ingredients );
  for( i = 0, i < #ingredients.line, i++ ) {
      undef( req );
      with( req ) {
          .name = ingredients.line[ i ].name;
          .properties = ingredients.line[ i ].properties;
          .allergene = ingredients.line[ i ].allergene;
          .ingredient_class = ingredients.line[i].ingredient_class
      };
      valueToPrettyString@StringUtils( req )( s );
      println@Console( s )();
      insertIngredient@DbService( req )()
  }
}
