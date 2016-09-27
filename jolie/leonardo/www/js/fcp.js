function onError( data ) {
    alert( data.error.message );
}



function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
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
      for( var i = 0; i < data.ingredient.length; i++ ) {
          var properties = "";
          for( var x = 0; x < data.ingredient[ i ].properties.length; x++ ) {
              properties = properties + data.ingredient[ i ].properties[ x ] + " "
          }
          var name = data.ingredient[ i ].name;
          var ingredient_class = data.ingredient[ i ].ingredient_class;
          $("#workarea").append( "<div class=\"ingredient\">" +
            "<div class=\"ingredient-name\">"+ name + "</div>" +
            "<img src=\"images/" + ingredient_class.replace(" ","-") + ".png\">&nbsp;" +
            ingredient_class + "</div>");
      }
  }, onError);
}
