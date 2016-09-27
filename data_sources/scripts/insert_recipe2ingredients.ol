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
  import.filename = "./files/recipe2ingredients.csv";
	importFile@CSVImport( import )( recipe2ingredients );
  for( i = 0, i < #recipe2ingredients.line, i++ ) {
      undef( req );
      with( req ) {
          .recipe_id = int(recipe2ingredients.line[ i ].recipe_id);
          .ingredient = recipe2ingredients.line[ i ].ingredient;
          .quantity = recipe2ingredients.line[ i ].quantity;
          .unit_of_measure = recipe2ingredients.line[ i ].unit_of_measure;
          .preparation_technique = recipe2ingredients.line[ i ].preparation_technique;
          .alternate_ingredient = recipe2ingredients.line[ i ].alternate_ingredient
      };
      valueToPrettyString@StringUtils( req )( s );
      println@Console( s )();
      insertRecipeIngredient@DbService( req )()
  }
}
