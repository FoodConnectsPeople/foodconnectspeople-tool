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
  import.filename = "./files/ingredients.csv";
	importFile@CSVImport( import )( ingredients );
  for( i = 0, i < #ingredients.line, i++ ) {
      undef( req );
      prop_index = 0;
      with( req ) {
          .name = ingredients.line[ i ].ingredient;
          /*TODO extract allergene from excel */
          if ( ingredients.line[ i ].is_vegan == "true" ) {
              .properties[ prop_index ] = "vegan";
              prop_index++
          };
          if ( ingredients.line[ i ].is_vegetarian == "true" ) {
              .properties[ prop_index ] = "vegetarian";
              prop_index++
          };
          if ( ingredients.line[ i ].is_gluten_free == "true" ) {
              .properties[ prop_index ] = "gluten_free";
              prop_index++
          };
          if ( ingredients.line[ i ].is_lactose_free == "true" ) {
              .properties[ prop_index ] = "lactose_free";
              prop_index++
          };
          if ( ingredients.line[ i ].is_spicy == "true" ) {
              .properties[ prop_index ] = "spicy"
          }
      };
      valueToPrettyString@StringUtils( req )( s );
      println@Console( s )();
      insertIngredient@DbService( req )()
  }
}
