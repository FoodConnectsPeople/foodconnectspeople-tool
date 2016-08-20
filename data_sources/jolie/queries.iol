define __queries {
  with( queries ) {
    .insert_ingredient = "INSERT INTO foodconnectspeople.ingredients ( name, properties, allergene ) VALUES ( :name, :properties, :allergene )";
    .select_properties = "SELECT name, property_id FROM foodconnectspeople.properties";
    .select_ingredients = "SELECT ingredient_id, name, properties, allergene FROM foodconnectspeople.ingredients"
  }
}
