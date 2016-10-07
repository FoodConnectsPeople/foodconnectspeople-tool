include "head.iol"

main {

        language = "italian";
        t.verbose = false;

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
            t.recipe_category = "piatto principale";
            t.main_ingredient = "gamberetti";
            t.cooking_technique[0] = "in padella";
            t.cooking_technique[1] = "arrosto";
            t.eater_category[0] = "onnivoro";
            t.not_allergene[0] = "glutine";
            t.not_allergene[1] = "lattosio";
            t.yes_ingredient[0] = "aglio";
            t.yes_ingredient[1] = "peperoncino piccante rosso";
            t.not_ingredient[0] = "cetriolo";
            t.not_ingredient[1] = "latte intero";
            t.yes_tool[0] = "padella da frittura";
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
      };


      optlanguage.language = language;

      println@Console("-------------------")();
      getCookingTechniques@DbService(optlanguage)(res);
      for (i = 0, i < #res.name, i++) {
        println@Console("Cooking technique : " + res.name[i])()
      };

      println@Console("-------------------")();
      getEaterCategories@DbService(optlanguage)(res);
      for (i = 0, i < #res.name, i++) {
        println@Console("Eater category : " + res.name[i])()
      };

      println@Console("-------------------")();
      getRecipeCategories@DbService(optlanguage)(res);
      for (i = 0, i < #res.name, i++) {
        println@Console("Recipe category : " + res.name[i])()
      };

      println@Console("-------------------")();
      getEventCategories@DbService(optlanguage)(res);
      for (i = 0, i < #res.name, i++) {
        println@Console("Event category : " + res.name[i])()
      };

      println@Console("-------------------")();
      getAllergenes@DbService(optlanguage)(res);
      for (i = 0, i < #res.name, i++) {
        println@Console("Allergene : " + res.name[i])()
      };

      println@Console("-------------------")();
      getTools@DbService(optlanguage)(res);
      for (i = 0, i < #res.name, i++) {
        println@Console("Tool : " + res.name[i])()
      };

      println@Console("-------------------")();
      getEvents@DbService()(res);
      for (i = 0, i < #res.event, i++) {
        println@Console("Event : #"
            + res.event[i].event_id + " " + res.event[i].name + " , "
            + res.event[i].start_date + "-" + res.event[i].end_date + " , "
            + res.event[i].place + " ( " + res.event[i].category + " )")()
      };

      undef(request);
      request.recipe_id = 28;
      request.language = language;
      getRecipeDetails@DbService(request)(response);

      println@Console("Name : " + response.name)();
      println@Console("Prep. time : " + response.preparation_time)();
      println@Console("Lat. : " + response.is_from_latitude)();
      println@Console("Lon. : " + response.is_from_longitude)();
      println@Console("Number of persons : " + response.persons)();
      println@Console("Difficulty : " + response.difficulty)();
      println@Console("Origin : " + response.place_of_origin)();
      println@Console("Category : " + response.category)();
      println@Console("Main ingredient : " + response.main_ingredient)();
      println@Console("Cooking_technique : " + response.cooking_technique)();
      println@Console("Link : " + response.link)();

      println@Console(" --- Ingredients : ")();
      for (i = 0, i < #response.ingredient, i++) {
        println@Console(" Ingredient #" + (i+1)+ " : ")();
        println@Console("     Name : " + response.ingredient[i].ingredient_name)();
        println@Console("     Qty  : " + response.ingredient[i].ingredient_quantity + " " + response.ingredient[i].unit_of_measure)();
        println@Console("     Prep.: " + response.ingredient[i].preparation_technique)();
        println@Console("     Alt. : " + response.ingredient[i].alternate_ingredient)()
      };

      println@Console(" --- Tools : ")();
      for (i = 0, i < #response.tool, i++) {
        println@Console(" Tool #" + (i+1)+ " : ")();
        println@Console("   Name : " + response.tool[i].tool_name)();
        println@Console("   Qty  : " + response.tool[i].tool_quantity)()
      };

      println@Console(" --- Events : ")();
      for (i = 0, i < #response.event, i++) {
        println@Console(" Event #" + (i+1)+ " : ")();
        println@Console("   Name : " + response.event[i].event_name)();
        println@Console("   Place : " + response.event[i].event_place)();
        println@Console("   From : " + response.event[i].event_start_date)();
        println@Console("   To   : " + response.event[i].event_end_date)();
        println@Console("   Type : " + response.event[i].event_category)()
      };

      undef(request);
      request.language = language;
      request.event_id = 2;
      getEventRecipes@DbService(request)(res);
      println@Console("Number of recipes for event #" + request.event_id + " : " + #res.recipe)();
      for( i = 0, i < #res.recipe, i++ ) {
        println@Console("Recipe #" + i + " : ")();
        println@Console("  ID : " + res.recipe[i].recipe_id)();
        println@Console("  Name : " + res.recipe[i].recipe_name)();
        println@Console("  Link : " + res.recipe[i].recipe_link)()
      }

}
