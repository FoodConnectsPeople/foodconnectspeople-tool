define __queries {
  with( queries ) {
    .insert_ingredient = "INSERT INTO FCP.ingredients ( name, properties, allergene, ingredient_class ) VALUES ( :name, :properties, :allergene, :ingredient_class )";
    .insert_unit_conversion = "INSERT INTO FCP.unitconversions ( ingredient, unit_of_measure, grocery_list_unit, conversion_rate, is_standard_conversion ) VALUES ( :ingredient, :unit_of_measure, :grocery_list_unit, :conversion_rate, :is_standard_conversion)";
    /** .insert_ingredient_property = "INSERT INTO FCP.ingredientsproperties ( ingredient_id, property_id ) VALUES ( :ingredient_id, :property_id )"; **/
    .insert_translation = "INSERT INTO FCP.translations ( italian, english, table_1, column_1, table_2, column_2, table_3, column_3, table_4, column_4 ) VALUES ( :italian, :english, :table_1, :column_1, :table_2, :column_2, :table_3, :column_3, :table_4, :column_4 )";
    .insert_recipeingredient = "INSERT INTO FCP.recipeingredients ( recipe_id, ingredient, quantity, unit_of_measure, preparation_technique, alternate_ingredient ) VALUES ( :recipe_id, :ingredient, :quantity, :unit_of_measure, :preparation_technique, :alternate_ingredient )";
    .insert_event = "INSERT into FCP.events ( name, place, start_date, end_date, category ) VALUES ( :name, :place, :start_date, :end_date, :category )";
    .insert_user = "INSERT into FCP.fcpusers ( fcp_user_id, username, full_name, is_author, is_cook ) VALUES ( :fcp_user_id, :username, :full_name, :is_author, :is_cook ) ";
    .insert_authorrecipe = "INSERT into FCP.authorrecipe ( author_id, recipe_id ) VALUES ( :author_id, :recipe_id ) ";
    .insert_cookingtechnique = "INSERT into FCP.cookingtechniques ( cooking_technique_id, name ) VALUES ( :cooking_technique_id, :name ) ";
    .insert_category = "INSERT into FCP.categories ( id, name, category ) VALUES ( :id, :name, :category ) ";
    .insert_country = "INSERT into FCP.countries ( country_id, name ) VALUES ( :country_id, :name )";
    .insert_tool = "INSERT into FCP.tools ( tool_id, name ) VALUES ( :tool_id, :name )";
    .insert_recipecategory = "INSERT into FCP.recipecategories ( category_id, name ) VALUES ( :category_id, :name )";
    .insert_recipetool = "INSERT into FCP.recipetools ( recipe_id, tool_name, tool_quantity ) VALUES ( :recipe_id, :tool_name, :tool_quantity )";
    .insert_recipeevent = "INSERT into FCP.recipeevents ( recipe_id, event_id ) VALUES ( :recipe_id, :event_id )";
    .insert_recipe = "INSERT INTO FCP.Recipes ( name, link,
      preparation_time_minutes, persons, difficulty, place_of_origin, is_from_latitude,
      is_from_longitude, category, main_ingredient, cooking_technique) VALUES ( :name,
        :link,
        :preparation_time_minutes, :persons, :difficulty, :place_of_origin,
        :is_from_latitude, :is_from_longitude, :category, :main_ingredient, :cooking_technique)";
    .select_countries = "SELECT country_id, name FROM FCP.countries ORDER BY name";
    .select_countries_i18n = "SELECT country_id, content AS name FROM FCP.countries_i18n WHERE language=:language ORDER BY name";
    .select_cooking_techniques = "SELECT id, name FROM FCP.categories WHERE category = 'cooking-technique' ORDER BY name";
    .select_languages = "SELECT language_id FROM FCP.languages WHERE language_id=:language_id";
    .select_properties = "SELECT name, property_id FROM FCP.properties";
    .select_recipe_categories = "SELECT name, category_id FROM FCP.recipecategories ORDER BY name";
    .select_tools = "SELECT name, tool_id FROM FCP.tools ORDER BY name";
    .select_events = "SELECT name, event_id, place, start_date, end_date, category FROM FCP.events ORDER BY name";
    .select_ingredients = "SELECT ingredient_id, name, properties, allergene, ingredient_class FROM FCP.ingredients ORDER BY ingredient_class, name ";
    .select_recipes = "SELECT recipe_id, name, preparation_time_minutes,
      difficulty, place_of_origin, category, cooking_technique, link
      FROM FCP.recipes";
    .update_country = "UPDATE fcp.countries SET name=:name WHERE country_id=:id";
    .update_country_i18n = "UPDATE fcp.i18n SET content=:content WHERE dbtable='countries' AND field='name' AND row_id=:id"
  }
}
