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
      t.recipe_name = "curry";
      t.max_preparation_time = 45;
      t.difficulty_value[0] = 2;
      t.difficulty_value[1] = 3;
      t.country[0] = "thailand";
      t.country[1] = "greece";
      t.recipe_category = "main";
      t.main_ingredient = "shrimp";
      t.cooking_technique[0] = "pan-fried";
      t.cooking_technique[1] = "roasted";
      t.eater_category[0] = "onnivore";
      t.not_allergene[0] = "gluten";
      t.not_allergene[1] = "lactose";
      t.yes_ingredient[0] = "garlic";
      t.yes_ingredient[1] = "red hot chilli pepper";
      t.not_ingredient[0] = "cocumber";
      t.not_ingredient[1] = "cream";
      t.yes_tool[0] = "frying pan";
      t.not_tool[0] = "spoon";
      t.not_tool[1] = "scissors";
      t.appears_in_event = "2nd Meze Workshop";
      t.language = "English";

      mostGeneralRecipeQuery@DbService(t)(res);

      println@Console("Number of recipes satisfying the query :" + #res.recipe)();
      for( i = 0, i < #res.recipe, i++ ) {
        println@Console("Recipe #" + i + " : ")();
        println@Console("  ID : " + res.recipe[i].recipe_id)();
        println@Console("  Name : " + res.recipe[i].recipe_name)();
        println@Console("  Link : " + res.recipe[i].recipe_link)()
      }
}
