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
  import.filename = "./files/recipes.csv"; /* extract manually from data spreadsheet */
	importFile@CSVImport( import )( recipes );
  undef( req );
  for ( i = 0, i < #recipes.line, i++ ) {

    //  Build the requests fields from the fields declared in the recipes object.
    with ( req.recipe[ i ] ) {
      .name = recipes.line[ i ].name;
      .preparation_time_minutes = int(recipes.line[ i ].preparation_time_minutes);
      .difficulty = int(recipes.line[ i ].difficulty);
      .place_of_origin = recipes.line[ i ].place_of_origin;
      .is_from_latitude = double(recipes.line[ i ].is_from_latitude);
      .is_from_longitude = double(recipes.line[ i ].is_from_longitude);
      .category = recipes.line[ i ].category;
      .cooking_technique = recipes.line[ i ].cooking_technique;
      .is_vegetarian = bool(recipes.line[ i ].is_vegetarian);
      .is_vegan = bool(recipes.line[ i ].is_vegan);
      .is_gluten_free = bool(recipes.line[ i ].is_gluten_free);
      .is_lactose_free = bool(recipes.line[ i ].is_lactose_free)
    }

    // foreach ( f : recipes.line[ i ] ) {
    //   req.recipe[ i ].( f ) = recipes.line[ i ].( f )
    // }

  };
  // Check output
  valueToPrettyString@StringUtils( req )( s );
  println@Console( s )();

  insertRecipe@DbService( req )( )
}
