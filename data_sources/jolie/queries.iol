define __queries {
  with( queries ) {
    .insert_ingredient = "INSERT INTO foodconnectspeople.ingredients ( name, properties, allergene ) VALUES ( :name, :properties, :allergene )";
    .insert_ingredient_property = "INSERT INTO foodconnectspeople.ingredientsproperties ( ingredient_id, property_id ) VALUES ( :ingredient_id, :property_id )";
    .insert_recipe = "INSERT INTO foodconnectspeople.Recipes ( name,
      preparation_time_minutes, difficulty, place_of_origin, is_from_latitude,
      is_from_longitude, category, cooking_technique, is_vegetarian, is_vegan,
      is_gluten_free, is_lactose_free) VALUES ( :name,
        :preparation_time_minutes, :difficulty, :place_of_origin,
        :is_from_latitude, :is_from_longitude, :category, :cooking_technique,
        :is_vegetarian, :is_vegan, :is_gluten_free, :is_lactose_free )";
    .select_properties = "SELECT name, property_id FROM foodconnectspeople.properties";
    .select_ingredients = "SELECT ingredient_id, name, properties, allergene FROM foodconnectspeople.ingredients"
  }
}
