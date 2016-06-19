define __queries {
  with( queries ) {
    .insert_ingredient = "INSERT INTO foodconnectspeople.ingredients ( name ) VALUES ( :name )";
    .insert_ingredient_property = "INSERT INTO foodconnectspeople.ingredientsproperties ( ingredient_id, property_id ) VALUES ( :ingredient_id, :property_id )";

    .select_properties = "SELECT name, property_id FROM foodconnectspeople.properties";
    .select_ingredient_id = "SELECT ingredient_id FROM foodconnectspeople.ingredients WHERE name=:name";
    .select_ingredients_properties = "SELECT ingredient_name, property_name FROM foodconnectspeople.ingredients_properties_view"
  }
}
