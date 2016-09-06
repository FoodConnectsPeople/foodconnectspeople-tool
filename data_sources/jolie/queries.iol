define __queries {
  with( queries ) {
    .insert_ingredient = "INSERT INTO foodconnectspeople.ingredients ( name, properties, allergene ) VALUES ( :name, :properties, :allergene )";
    /** .insert_ingredient_property = "INSERT INTO foodconnectspeople.ingredientsproperties ( ingredient_id, property_id ) VALUES ( :ingredient_id, :property_id )"; **/
    .insert_recipeingredient = "INSERT INTO foodconnectspeople.recipeingredients ( recipe_id, ingredient, quantity, unit_of_measure, preparation_technique, alternate_ingredient ) VALUES ( :recipe_id, :ingredient, :quantity, :unit_of_measure, :preparation_technique, :alternate_ingredient )";
    .insert_event = "INSERT into foodconnectspeople.events ( name, place, start_date, end_date, category ) VALUES ( :name, :place, :start_date, :end_date, :category )";
    .insert_recipeevent = "INSERT into foodconnectspeople.recipeevents ( recipe_id, event_id ) VALUES ( :recipe_id, :event_id )";
    .insert_recipetool = "INSERT into foodconnectspeople.recipetools ( recipe_id, tool_name, tool_quantity ) VALUES ( :recipe_id, :tool_name, :tool_quantity )";
    .insert_recipe = "INSERT INTO foodconnectspeople.Recipes ( name, link,
      preparation_time_minutes, persons, difficulty, place_of_origin, is_from_latitude,
      is_from_longitude, category, main_ingredient, cooking_technique) VALUES ( :name,
        :link,
        :preparation_time_minutes, :persons, :difficulty, :place_of_origin,
        :is_from_latitude, :is_from_longitude, :category, :main_ingredient, :cooking_technique)";
    .select_properties = "SELECT name, property_id FROM foodconnectspeople.properties";
    .select_ingredients = "SELECT ingredient_id, name, properties, allergene FROM foodconnectspeople.ingredients";
    .get_recipes = "SELECT recipe_id, name, preparation_time_minutes,
      difficulty, place_of_origin, category, cooking_technique
      FROM foodconnectspeople.recipes"
  }
}
