var countries;
var cooking_techniques;

function onError( data ) {
    alert( data.error.message );
}

function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

/* initalize the web app with useful data */
function initData() {
  JolieClient.getCountries({}, function( data ) {
    countries = data.name;
  }, onError);
  JolieClient.getCookingTechniques({}, function( data ) {
    cooking_techniques = data.name;
  }, onError);
}




/* it creates a recipe table starting from a response GetRecipeResponse */
function createRecipeTable( data ) {
    $("#recipes-table").remove();
    $("#workarea").append("<table id=\"recipes-table\" class=\"table table-striped\"></table>");
    $("#recipes-table").append( "<tr><th>Recipe</th><th>Category</th><th>Cooking Tecnique</th>"
    + "<th>Place of Origin</th><th>Preparation Time</th><th>Difficulty</th></tr>");
    if ( data.hasOwnProperty( "recipe") ) {
        for( var i = 0; i < data.recipe.length; i++ ) {
            var name = data.recipe[ i ].name;
            var category = data.recipe[ i ].category;
            var cooking_technique = data.recipe[ i ].cooking_technique;
            var place_of_origin = data.recipe[ i ].place_of_origin;
            var preparation_time = data.recipe[ i ].preparation_time_minutes;
            var difficulty = data.recipe[ i ].difficulty;
            var difficulty_stars = "";
            for( d = 0; d < difficulty; d++ ) {
              difficulty_stars = difficulty_stars + "<img src=\"images/star-icon.png\">"
            }

            $("#recipes-table").append( "<tr><td>"
              + name + "</td><td>" + category +
              "</td><td>" + cooking_technique + "</td><td>"
              + place_of_origin + "</td><td>"
              + preparation_time + "</td><td>"
              + difficulty_stars + "</td></tr>");
        }
    }
}

/* it initialize all the fields of the recipe filter with possible values */
function initializeRecipeFilter() {

  var countriesBloodhound = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    local: countries
  });

  var ctBloodhound = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    local: cooking_techniques
  });

  $('#country').typeahead({
    hint: false,
    highlight: true,
    minLength: 1
  },
  {
    name: 'countries',
    source: countriesBloodhound
  });

  $('#cooking_technique').typeahead({
    hint: false,
    highlight: true,
    minLength: 1
  },
  {
    name: 'cooking_technique',
    source: ctBloodhound
  });

  $("#country").parent().css("display","");
  $("#cooking_technique").parent().css("display","");
}

/* it shows the result of a filtered search on recipes */
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
  var appears_in_event = $("#appears_in_event").is(":checked");

  if ( max_preparation_time != "" ) {
    request.max_preparation_time = max_preparation_time.toLowerCase().trim()
  }
  if ( difficulty_value != "" ) {
    request.difficulty_value = difficulty_value.toLowerCase().trim()
  }
  if ( country != "" ) {
    request.country = country.toLowerCase().trim()
  }
  if ( recipe_category != "" ) {
    request.recipe_category = recipe_category.toLowerCase().trim()
  }
  if ( main_ingredient != "" ) {
    request.main_ingredient = main_ingredient.toLowerCase().trim()
  }
  if ( cooking_technique != "" ) {
    request.cooking_technique = cooking_technique.toLowerCase().trim()
  }
  if ( eater_category != "" ) {
    request.eater_category = eater_category.toLowerCase().trim()
  }
  if ( not_allergene != "" ) {
    request.not_allergene = not_allergene.toLowerCase().trim()
  }
  if ( yes_ingredient != "" ) {
    request.yes_ingredient = yes_ingredient.toLowerCase().trim()
  }
  if ( not_ingredient != "" ) {
    request.not_ingredient = not_ingredient.toLowerCase().trim()
  }
  if ( yes_tool != "" ) {
    request.yes_tool = yes_tool.toLowerCase().trim()
  }
  if ( not_tool != "" ) {
    request.not_tool = not_tool.toLowerCase().trim()
  }
  if ( appears_in_event != "" ) {
    request.appears_in_event = appears_in_event.toLowerCase().trim()
  }
  JolieClient.mostGeneralRecipeQuery(request, function( data ) {
      createRecipeTable( data )
  }, onError);
}

/* it shows the list of ingredients calling the operation getIngredients */
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

/* it shows all the recipes */
function showRecipes() {
    $("#workarea").empty();
    $("#workarea").load( "recipe_filter.html" );


    JolieClient.getRecipes({}, function( data ) {
        createRecipeTable( data )
    }, onError);

}
