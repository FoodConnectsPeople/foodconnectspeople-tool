define __queries {
  with( queries ) {
    .insert_ingredient = "INSERT INTO foodconnectspeople.ingredients ( name, properties, allergene ) VALUES ( :name, :properties, :allergene )";
    .insert_ingredient_property = "INSERT INTO foodconnectspeople.ingredientsproperties ( ingredient_id, property_id ) VALUES ( :ingredient_id, :property_id )";

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
