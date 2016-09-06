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
  import.filename = "./files/recipes.csv"; /* extracted manually from data spreadsheet */
	importFile@CSVImport( import )( recipes );

  undef( req );
  for ( i = 0, i < #recipes.line, i++ ) {

    //  Build the requests fields from the fields declared in the recipes object.
    with ( req.recipe[ i ] ) {
      .name = recipes.line[ i ].name;
      .link = recipes.line[ i ].link;
      .preparation_time_minutes = int(recipes.line[ i ].preparation_time_minutes);
      .persons = int(recipes.line[ i ].persons);
      .difficulty = int(recipes.line[ i ].difficulty);
      .place_of_origin = recipes.line[ i ].place_of_origin;
      .is_from_latitude = double(recipes.line[ i ].is_from_latitude);
      .is_from_longitude = double(recipes.line[ i ].is_from_longitude);
      .category = recipes.line[ i ].category;
      .main_ingredient = SEPARATOR + recipes.line[ i ].main_ingredient + SEPARATOR;
      .cooking_technique = recipes.line[ i ].cooking_technique
    }
  };

  valueToPrettyString@StringUtils( req )( s );
  println@Console( s )();

  insertRecipe@DbService( req )( )
}
