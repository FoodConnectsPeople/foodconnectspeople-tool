var countries;
var cooking_techniques;
var ingredients;
var ingredient_names = [];
var recipe_categories;
var tools;
var allergenes;
var eater_categories;
var events;
var languages = {"English":"english", "Italiano":"italian"}
var current_language = languages.English;

function onError( data ) {
    alert( data.error.message );
}

function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

function changeCurrentLanguage( language ) {
  current_language = language;
  console.log( current_language );
}


/* initalize the web app with useful data */
function initData( funct ) {
  var request = { language:current_language };
  JolieClient.getInitData( request , function( data ) {
      countries = data.countries.name;
      cooking_techniques = data.cooking_techniques.name;
      recipe_categories = data.recipe_categories.name;
      eater_categories = data.eater_categories.name;
      tools = data.tools.name;
      allergenes = data.allergenes.name;
      events = data.event;
      ingredients = data.ingredient;
      recipe_names = data.recipe_names.name;
      ingredient_names = [];
      for( var i = 0; i < ingredients.length; i++ ) {
        ingredient_names.push( ingredients[ i ].name );
      }
      funct();

  })
}

/* it creates a recipe table starting from a response GetRecipeResponse */
function createRecipeTable( data ) {
    $("#recipes-table").remove();
    $("#workarea").append("<table id=\"recipes-table\" class=\"table table-striped\"></table>");
    if ( current_language == "italian" ) {
      $("#recipes-table").append( "<tr><th>Ricetta</th><th>Categoria</th><th>Stile di cottura</th>"
      + "<th>Nazione</th><th>Tempo di Preparazione</th><th>Difficoltà</th></tr>");
    } else {
      $("#recipes-table").append( "<tr><th>Recipe</th><th>Category</th><th>Cooking Tecnique</th>"
      + "<th>Place of Origin</th><th>Preparation Time</th><th>Difficulty</th></tr>");
    }

    if ( data.hasOwnProperty( "recipe") ) {
        for( var i = 0; i < data.recipe.length; i++ ) {
            var name = data.recipe[ i ].recipe_name;
            var link = data.recipe[ i ].recipe_link;
            var category = data.recipe[ i ].category;
            var cooking_technique = data.recipe[ i ].cooking_technique;
            var place_of_origin = data.recipe[ i ].place_of_origin;
            var preparation_time = data.recipe[ i ].preparation_time_minutes;
            var difficulty = data.recipe[ i ].difficulty;
            var difficulty_stars = "";
            for( d = 0; d < difficulty; d++ ) {
              difficulty_stars = difficulty_stars + "<img src=\"images/star-icon.png\">"
            }

            $("#recipes-table").append( "<tr>"
              + "<td>" + '<a target="fcp_recipe" href= "http://www.foodconnectspeople.com/' + link + '">' + name + "</a></td>"
              // + "<td>" + name + "</td>"
              + "<td>" + category + "</td>"
              + "<td>" + cooking_technique + "</td>"
              + "<td>" + place_of_origin + "</td>"
              + "<td>" + preparation_time + "</td>"
              + "<td>" + difficulty_stars + "</td>"
              + "</tr>");
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

  var recipeNamesBloodhound = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    local: recipe_names
  });

  var ingredientsBloodhound = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    local: ingredient_names
  });

  var toolsBloodhound = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    local: tools
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

  $('#recipe_names').typeahead({
    hint: false,
    highlight: true,
    minLength: 1
  },
  {
    name: 'recipe_names',
    source: recipeNamesBloodhound
  });

  $('#main_ingredient').typeahead({
    hint: false,
    highlight: true,
    minLength: 1
  },
  {
    name: 'main_ingredient',
    source: ingredientsBloodhound
  });

  $('#yes_tool').tagsinput({
    typeaheadjs: {
      name: 'yes_tool',
      source: toolsBloodhound
    },
    tagClass: 'yes_tag'
  });

  $('#not_tool').tagsinput({
    typeaheadjs: {
      name: 'not_tool',
      source: toolsBloodhound
    },
    tagClass: 'not_tag'
  });

  $('#yes_ingredient').tagsinput({
    typeaheadjs: {
      name: 'yes_ingredient',
      source: ingredientsBloodhound
    },
    tagClass: 'yes_tag'
  });

  $('#not_ingredient').tagsinput({
    typeaheadjs: {
      name: 'not_ingredient',
      source: ingredientsBloodhound
    },
    tagClass: 'not_tag'
  });

  $("#country").parent().css("display","");
  $("#recipe_names").parent().css("display","");
  $("#main_ingredient").parent().css("display","");

  for( var c = 0; c < cooking_techniques.length; c++ ) {
    $("#cooking_technique").append("<option>" + cooking_techniques[ c ] + "</option>")
  }
  for( var c = 0; c < eater_categories.length; c++ ) {
    $("#eater_category").append("<option>" + eater_categories[ c ] + "</option>")
  }
  for( var c = 0; c < allergenes.length; c++ ) {
    $("#not_allergene").append("<option>" + allergenes[ c ] + "</option>")
  }
  $("#recipe_category").append("<option></option>");
  for( var c = 0; c < recipe_categories.length; c++ ) {
    $("#recipe_category").append("<option>" + recipe_categories[ c ] + "</option>")
  }
  $("#appears_in_event").append("<option></option>");
  for( var c = 0; c < events.length; c++ ) {
    $("#appears_in_event").append("<option>" + events[ c ].name + "</option>")
  }
}

/* it shows the result of a filtered search on recipes */
function searchForRecipes() {
  var request = { "verbose":false, "language":"english" };
  var max_preparation_time = $("#max_preparation_time").val();
  var country = $("#country").val();
  var recipe_name = $("#recipe_names").val();
  var recipe_category = $("#recipe_category").val();
  var main_ingredient = $("#main_ingredient").val();
  var eater_category = $("#eater_category").val();
  var not_allergene = $("#not_allergene").val();
  var not_ingredient = $("#not_ingredient").val().split(",");
  var yes_tool = $("#yes_tool").val();
  var not_tool = $("#not_tool").val();
  var appears_in_event = $("#appears_in_event").val();

  if ( max_preparation_time != "" ) {
    request.max_preparation_time = max_preparation_time.toLowerCase().trim()
  }
  if ( $("#difficulty_value :selected").length > 0 ) {
    request.difficulty_value = [];
    $("#difficulty_value option:selected").each( function() {
      request.difficulty_value.push( $(this).text()  );
    });
  }
  if ( country != "" ) {
    request.country = country.toLowerCase().trim()
  }
  if ( recipe_name != "" ) {
    request.recipe_name = recipe_name
  }
  if ( recipe_category != "" ) {
    request.recipe_category = recipe_category.toLowerCase().trim()
  }
  if ( main_ingredient != "" ) {
    request.main_ingredient = main_ingredient.toLowerCase().trim()
  }
  if ( $("#cooking_technique :selected").length > 0 ) {
    request.cooking_technique = [];
    $("#cooking_technique option:selected").each( function() {
      request.cooking_technique.push( $(this).text()  );
    });
  }

  if ( $("#eater_category :selected").length > 0 ) {
    request.eater_category = [];
    $("#eater_category option:selected").each( function() {
      request.eater_category.push( $(this).text()  );
    });
  }
  if ( $("#not_allergene :selected").length > 0 ) {
    request.not_allergene = [];
    $("#not_allergene option:selected").each( function() {
      request.not_allergene.push( $(this).text()  );
    });
  }
  if ( $("#yes_ingredient").val() != "" ) {
    var yes_ingredient = $("#yes_ingredient").val().split(",");
    request.yes_ingredient = [];
    for( var i = 0; i < yes_ingredient.length; i++ ) {
        request.yes_ingredient.push( yes_ingredient[ i ].toLowerCase().trim() );
    }
  }
  if ( $("#not_ingredient").val() != "" ) {
    var not_ingredient = $("#not_ingredient").val().split(",");
    request.not_ingredient = [];
    for( var i = 0; i < not_ingredient.length; i++ ) {
        request.not_ingredient.push( not_ingredient[ i ].toLowerCase().trim() );
    }
  }
  if ( yes_tool != "" ) {
    request.yes_tool = yes_tool.toLowerCase().trim().split(",")
  }
  if ( not_tool != "" ) {
    request.not_tool = not_tool.toLowerCase().trim().split(",")
  }
  if ( appears_in_event != "" ) {
    request.appears_in_event = appears_in_event.trim()
  }
  request.language = current_language;
  JolieClient.mostGeneralRecipeQuery(request, function( data ) {
      createRecipeTable( data )
  }, onError);
}

/* it shows the list of events */
function showEvents() {
  $("#workarea").empty();
  $("#workarea").append("<table id=\"events-table\" class=\"table table-striped\"></table>");
  $("#events-table").append( "<tr><th>Event</th><th>Place</th><th>Start Date</th><th>End Date</th><th>Category</th></tr>");
  for( var i = 0; i < events.length; i++ ) {
      var name = events[ i ].name;
      var event_place = events[ i ].place;
      var event_start_date = events[ i ].start_date;
      var event_end_date = events[ i ].end_date;
      var category = events[ i ].category;

      $("#events-table").append( "<tr><td>"
        + name + "</td><td>"
        + event_place + "</td><td>"
        + event_start_date + "</td><td>"
        + event_end_date + "</td><td>"
        + category + "</td></tr>");
  }
}

/* it shows the list of ingredients */
function showIngredients() {
  $("#workarea").empty();
  $("#workarea").append("<table id=\"ingredient-table\" class=\"table table-striped\"></table>");
  $("#ingredient-table").append( "<tr><th>Ingredient</th><th>Class</th><th>Properties</th><th>Allergene</th></tr>");
  for( var i = 0; i < ingredients.length; i++ ) {
      var name = ingredients[ i ].name;
      var ingredient_class = ingredients[ i ].ingredient_class;
      var ingredient_properties = ingredients[ i ].properties.replace(/_/g," ");
      var ingredient_allergene = ingredients[ i ].allergene.replace(/_/g," ");

      $("#ingredient-table").append( "<tr><td>"
        + name + "</td><td>" +
        "<img src=\"images/ingredients/" + ingredient_class.replace(" ","-") + ".png\"></td><td>" +
         ingredient_properties + "</td><td>" + ingredient_allergene + "</td></tr>");
  }
}

/* it shows all the recipes */
function showRecipes() {
    $("#workarea").empty();
    $("#workarea").load( "recipe_filter_" + current_language +  ".html", function() {
      $("#language option[value='" + current_language + "']").attr("selected","selected");
      initializeRecipeFilter();
      $(".selectpicker").selectpicker('refresh');
      $("#workarea input[data-role='tagsinput']").tagsinput('refresh');
    } );
    var request = { language: current_language }
    JolieClient.getRecipes( request, function( data ) {
        createRecipeTable( data )
    }, onError);

}
