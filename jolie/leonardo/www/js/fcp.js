var countries;

function onError( data ) {
    alert( data.error.message );
}

function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

function initData() {
  JolieClient.getCountries({}, function( data ) {
    countries = data.name;
  }, onError);
}

function getRecipes() {
  JolieClient.getRecipes({}, function( data ) {
    var recipeList = "<ul>";
    for (var i = 0; i < data.recipe.length; i++) {
      recipeList += "<li>" + data.recipe[ i ].name + " [" +
            capitalizeFirstLetter(data.recipe[ i ].place_of_origin) + "]</li>";
    }
    recipeList += "</ul>";
    $("#panel").html(recipeList);
  }, onError);
}

function showIngredients() {
  $("#workarea").empty();
  JolieClient.getIngredients({}, function( data ) {

      $("#workarea").append("<table id=\"ingredient-table\" class=\"table table-striped\"></table>");
      $("#ingredient-table").append( "<tr><th>Ingredient</th><th>Class</th><th>Properties</th><th>Allergene</th></tr>");
      for( var i = 0; i < data.ingredient.length; i++ ) {
          var name = data.ingredient[ i ].name;
          var ingredient_class = data.ingredient[ i ].ingredient_class;
          var ingredient_properties = data.ingredient[ i ].properties.replace(/_/g," ");
          var ingredient_allergene = data.ingredient[ i ].allergene.replace(/_/g," ");

          $("#ingredient-table").append( "<tr><td>"
            + name + "</td><td>" +
            "<img src=\"images/ingredients/" + ingredient_class.replace(" ","-") + ".png\"></td><td>" +
             ingredient_properties + "</td><td>" + ingredient_allergene + "</td></tr>");
      }
  }, onError);
}

function createRecipeTable( data ) {
    $("#recipes-table").remove();
    $("#workarea").append("<table id=\"recipes-table\" class=\"table table-striped\"></table>");
    $("#recipes-table").append( "<tr><th>Recipe</th><th>Category</th><th>Cooking Tecnique</th>"
    + "<th>Place of Origin</th><th>Preparation Time</th><th>Difficulty</th></tr>");
    for( var i = 0; i < data.recipe.length; i++ ) {
        var name = data.recipe[ i ].name;
        var category = data.recipe[ i ].category;
        var cooking_technique = data.recipe[ i ].cooking_technique;
        var place_of_origin = data.recipe[ i ].place_of_origin;
        var preparation_time = data.recipe[ i ].preparation_time_minutes;
        var difficulty = data.recipe[ i ].difficulty;

        $("#recipes-table").append( "<tr><td>"
          + name + "</td><td>" + category +
          "</td><td>" + cooking_technique + "</td><td>"
          + place_of_origin + "</td><td>"
          + preparation_time + "</td><td>"
          + difficulty + "</td></tr>");
    }
}

function showRecipes() {
    $("#workarea").empty();
    $("#workarea").load( "recipe_filter.html" );

    JolieClient.getRecipes({}, function( data ) {
        createRecipeTable( data )
    }, onError);

}

function searchForRecipes() {
  var request = { "verbose":false, "language":"english" };
  var max_preparation_time = $("#max_preparation_time").val();
  var difficulty_value = $("#difficulty_value").val();
  var country = $("#country").val();
  var recipe_category = $("#recipe_category").val();
  var main_ingredient = $("#main_ingredient").val();
  var cooking_technique = $("#cooking_technique").val();
  var eater_category = $("#eater_category").val();
  var not_allergene = $("#not_allergene").val();
  var yes_ingredient = $("#yes_ingredient").val();
  var not_ingredient = $("#not_ingredient").val();
  var yes_tool = $("#yes_tool").val();
  var not_tool = $("#not_tool").val();
  var appears_in_event = $("#appears_in_event").val();

  if ( max_preparation_time != "" ) {
    request.max_preparation_time = max_preparation_time
  }
  if ( difficulty_value != "" ) {
    request.difficulty_value = difficulty_value
  }
  if ( country != "" ) {
    request.country = country
  }
  if ( recipe_category != "" ) {
    request.recipe_category = recipe_category
  }
  if ( main_ingredient != "" ) {
    request.main_ingredient = main_ingredient
  }
  if ( cooking_technique != "" ) {
    request.cooking_technique = cooking_technique
  }
  if ( eater_category != "" ) {
    request.eater_category = eater_categoryù
  }
  if ( not_allergene != "" ) {
    request.not_allergene = not_allergene
  }
  if ( yes_ingredient != "" ) {
    request.yes_ingredient = yes_ingredient
  }
  if ( not_ingredient != "" ) {
    request.not_ingredient = not_ingredient
  }
  if ( yes_tool != "" ) {
    request.yes_tool = yes_tool
  }
  if ( not_tool != "" ) {
    request.not_tool = not_tool
  }
  if ( appears_in_event != "" ) {
    request.appears_in_event = appears_in_event
  }
  JolieClient.mostGeneralRecipeQuery(request, function( data ) {
      createRecipeTable( data )
  }, onError);


}
