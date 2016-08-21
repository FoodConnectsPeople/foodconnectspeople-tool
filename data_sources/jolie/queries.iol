define __queries {
  with( queries ) {
    .insert_ingredient = "INSERT INTO foodconnectspeople.ingredients ( name, properties, allergene ) VALUES ( :name, :properties, :allergene )";
    .insert_ingredient_property = "INSERT INTO foodconnectspeople.ingredientsproperties ( ingredient_id, property_id ) VALUES ( :ingredient_id, :property_id )";
    .insert_recipe = "INSERT INTO foodconnectspeople.Recipes ( name,
      preparation_time_minutes, difficulty, countries, place_of_origin, is_from_latitude,
      is_from_longitude, category, cooking_technique) VALUES ( :name,
        :preparation_time_minutes, :difficulty, :countries, :place_of_origin,
        :is_from_latitude, :is_from_longitude, :category, :cooking_technique)";
    .select_properties = "SELECT name, property_id FROM foodconnectspeople.properties";
    .select_ingredients = "SELECT ingredient_id, name, properties, allergene FROM foodconnectspeople.ingredients"
  }
}
