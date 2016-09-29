include "head.iol"

main {

      language = "italian";
      
      if (language == "english") {
        t.language = "english";
        t.recipe_name = "sauced shrimps";
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
        t.not_ingredient[1] = "whole milk";
        t.yes_tool[0] = "frying pan";
        t.not_tool[0] = "spoon";
        t.not_tool[1] = "cake pan";
        t.appears_in_event = "2nd Meze Workshop"
      };

      if (language == "italian") {
          t.language = "italian";
          t.recipe_name = "Gamberi alla salsa";
          t.max_preparation_time = 45;
          t.difficulty_value[0] = 2;
          t.difficulty_value[1] = 3;
          t.country[0] = "thailandia";
          t.country[1] = "grecia";
          t.recipe_category = "main";
          t.main_ingredient = "piatto principale";
          t.cooking_technique[0] = "in padella";
          t.cooking_technique[1] = "arrosto";
          t.eater_category[0] = "onnivoro";
          t.not_allergene[0] = "glutine";
          t.not_allergene[1] = "lattosio";
          t.yes_ingredient[0] = "aglio";
          t.yes_ingredient[1] = "peperoncino rosso";
          t.not_ingredient[0] = "cetriolo";
          t.not_ingredient[1] = "latte intero";
          t.yes_tool[0] = "padella";
          t.not_tool[0] = "cucchiaio";
          t.not_tool[1] = "padella per torte";
          t.appears_in_event = "Secondo Seminario sui Meze"
        };

      mostGeneralRecipeQuery@DbService(t)(res);

      println@Console("Number of recipes satisfying the query :" + #res.recipe)();
      for( i = 0, i < #res.recipe, i++ ) {
        println@Console("Recipe #" + i + " : ")();
        println@Console("  ID : " + res.recipe[i].recipe_id)();
        println@Console("  Name : " + res.recipe[i].recipe_name)();
        println@Console("  Link : " + res.recipe[i].recipe_link)()
      }
}
