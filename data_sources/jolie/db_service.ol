include "console.iol"
include "string_utils.iol"
include "database.iol"
include "ini_utils.iol"

include "public/interfaces/DbServiceInterface.iol"


include "constants.iol"
include "queries.iol"

execution { concurrent }


inputPort DbService {
  Location: DB_SERVICE_LOCATION
  Protocol: sodep
  Interfaces: DbServiceInterface
}

// Output port to invoke "internal functions"
outputPort MySelf {
  Location: DB_SERVICE_LOCATION
  Protocol: sodep
  Interfaces: DbServiceInterface
}

inputPort DbServiceHttp {
  Location: DB_SERVICE_LOCATION_HTTP
  Protocol: http { .format = "json" }
  Interfaces: DbServiceInterface
}

// used for self-contained tests
inputPort DbServiceLocal {
  Location: "local"
  Protocol: sodep
  Interfaces: DbServiceInterface
}




init {
    __queries;
    parseIniFile@IniUtils( INI_FILE )( config );
    HOST = config.db.HOST;
    DRIVER = config.db.DRIVER;
    PORT = int( config.db.PORT );
    DBNAME = config.db.DBNAME;
    USERNAME = config.db.USERNAME;
    PASSWORD = config.db.PASSWORD;
    scope( db_connect ) {
      with( connectionInfo ) {
        .host = HOST;
        .driver = DRIVER;
        .port = PORT;
        .database= DBNAME;
        .username = USERNAME;
        .password = PASSWORD;
        .toLowerCase = true
      };
      connect@Database( connectionInfo )();
      println@Console("Connected to Database " + DBNAME + "@" + HOST )()
    };
    println@Console("DbService is running...")()
}

main {
  [ getIngredients( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

              q = queries.select_ingredients;
              query@Database( q )( result );
              for( i = 0, i < #result.row, i++ ) {
                  with( response.ingredient[ i ] ) {
                      .ingredient_id = result.row[ i ].ingredient_id;
                      .name = result.row[ i ].name;
                      .properties = result.row[ i ].properties;
                      .allergene = result.row[ i ].allergene;
                      .ingredient_class = result.row[ i ].ingredient_class
                  }
              }
        }
  }]

  [ getProperties( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

              q = queries.select_properties;
              query@Database( q )( result );

              for( i = 0, i < #result.row, i++ ) {
                  with( response.property[ i ] ) {
                      .name = result.row[ i ].name;
                      .property_id = result.row[ i ].property_id
                  }
              }
        }

  }]

  [ insertIngredient( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

              /*
              // prepare properties
              properties = "";
              for( i = 0, i < #request.properties, i++ ) {
                 properties = properties + request.properties[ i ] + SEPARATOR
              };
              allergene = "";
              for( i = 0, i < #request.allergene, i++ ) {
                 allergene = allergene + request.allergene[ i ] + SEPARATOR
              };
              */

              q = queries.insert_ingredient;
              q.name = request.name;
              q.properties = request.properties;
              q.allergene = request.allergene;
              q.ingredient_class = request.ingredient_class;
              update@Database( q )( )

        }
  }]

  [ insertEvent( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

              q = queries.insert_event;
              q.name = request.name;
              q.place = request.place;
              q.start_date = request.start_date;
              q.end_date = request.end_date;
              q.category = request.category;
              update@Database( q )( )

        }
  }]

  [ insertUnitConversion( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

              q = queries.insert_unit_conversion;
              q.ingredient = request.ingredient;
              q.unit_of_measure = request.unit_of_measure;
              q.grocery_list_unit = request.grocery_list_unit;
              q.conversion_rate = request.conversion_rate;
              q.is_standard_conversion = request.is_standard_conversion;
              update@Database( q )( )

        }
  }]

  [ insertUser( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

              q = queries.insert_user;
              q.fcp_user_id = request.fcp_user_id;
              q.username = request.username;
              q.full_name = request.full_name;
              q.is_author = request.is_author;
              q.is_cook = request.is_cook;
              update@Database( q )( )

        }
  }]

  [ insertAuthorRecipe( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

              q = queries.insert_authorrecipe;
              q.author_id = request.author_id;
              q.recipe_id = request.recipe_id;
              update@Database( q )( )
        }
  }]

  [ insertCookingTechnique( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

              q = queries.insert_cookingtechnique;
              q.cooking_technique_id = request.cooking_technique_id;
              q.name = request.name;
              update@Database( q )( )
        }
  }]

  [ insertCountry( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

              q = queries.insert_country;
              q.country_id = request.country_id;
              q.name = request.name;
              update@Database( q )( )
        }
  }]

  [ insertTool( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

              q = queries.insert_tool;
              q.tool_id = request.tool_id;
              q.name = request.name;
              update@Database( q )( )
        }
  }]

  [ insertRecipeCategory( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

              q = queries.insert_recipecategory;
              q.category_id = request.category_id;
              q.name = request.name;
              update@Database( q )( )
        }
  }]

  [ insertRecipeIngredient( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );


              /*
              // prepare properties
              preparation_techniques = "";
              for( i = 0, i < #request.preparation_technique, i++ ) {
                 preparation_techniques = preparation_techniques + request.preparation_technique[ i ] + SEPARATOR
              };
              */

              q = queries.insert_recipeingredient;
              q.recipe_id = request.recipe_id;
              q.ingredient = request.ingredient;
              q.preparation_technique = SEPARATOR + request.preparation_technique + SEPARATOR;
              q.quantity = request.quantity;
              q.unit_of_measure = request.unit_of_measure;
              q.alternate_ingredient = request.alternate_ingredient;

              update@Database( q )( )

        }
  }]

  [ insertRecipeEvent( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );
              q = queries.insert_recipeevent;
              q.recipe_id = request.recipe_id;
              q.event_id = request.event_id;
              update@Database( q )( )
        }
  }]

  [ insertRecipeTool( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );
              q = queries.insert_recipetool;
              q.recipe_id = request.recipe_id;
              q.tool_name = request.tool_name;
              q.tool_quantity  = request.tool_quantity;
              update@Database( q )( )
        }
  }]

  [ insertTranslation( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );
              q = queries.insert_translation;
              q.italian   = request.italian;
              q.english   = request.english;
              q.table_1   = request.table_1;
              q.column_1  = request.column_1;
              q.table_2   = request.table_2;
              q.column_2  = request.column_2;
              q.table_3   = request.table_3;
              q.column_3  = request.column_3;
              q.table_4   = request.table_4;
              q.column_4  = request.column_4;
              update@Database( q )( )
        }
  }]

  [ insertRecipe( request )( response ) {
    scope( sql ) {
      install( SQLException => println@Console( sql.SQLException.stackTrace )();
                               throw( DatabaseError )
      );
      undef( q );
      for( i = 0, i < #request.recipe, i++ ) {
          q.statement[ i ] = queries.insert_recipe;
          q.statement[ i ].name = request.recipe[ i ].name;
          q.statement[ i ].link = request.recipe[ i ].link;
          q.statement[ i ].preparation_time_minutes = request.recipe[ i ].preparation_time_minutes;
          q.statement[ i ].persons = request.recipe[ i ].persons;
          q.statement[ i ].difficulty = request.recipe[ i ].difficulty;
          q.statement[ i ].place_of_origin = request.recipe[ i ].place_of_origin;
          q.statement[ i ].is_from_latitude = request.recipe[ i ].is_from_latitude;
          q.statement[ i ].is_from_longitude = request.recipe[ i ].is_from_longitude;
          q.statement[ i ].category = request.recipe[ i ].category;
          q.statement[ i ].main_ingredient = request.recipe[ i ].main_ingredient;
          q.statement[ i ].cooking_technique = request.recipe[ i ].cooking_technique
      }
      ;
      executeTransaction@Database( q )( )
    }
  }]

  [ getRecipes( request )( response ) {
    scope( sql ) {
          install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                   throw( DatabaseError )
          );

          q = queries.get_recipes;
          query@Database( q )( result );
          for( i = 0, i < #result.row, i++ ) {
              with( response.recipe[ i ] ) {
                  .name = result.row[ i ].name;
                  .preparation_time_minutes = result.row[ i ].preparation_time_minutes;
                  .difficulty = result.row[ i ].difficulty;
                  .place_of_origin = result.row[ i ].place_of_origin;
                  .category = result.row[ i ].category;
                  .cooking_technique = result.row[ i ].cooking_technique
              }
          }
    }
  }]

  [ buildCommaSeparatedString( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

              /* response = "," + request.str[0] + ","  */

              println@Console(" Entered comma separated")();
              response = ",";
              for (idx = 0, idx < #request.str, idx++) {
                response = response + request.str[idx] + ","
              };
              println@Console(" Generated comma separated: #" + response + "#")()

        }
  }]

   [ buildList( request )( response ) {
          scope( sql ) {
                install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                         throw( DatabaseError )
                );

                response = "( ";
                for (idx = 0, idx < #request.vector, idx++) {
                  if (idx > 0) {
                    response = response + ","
                  };
                  response = response + request.sep + request.vector[idx] + request.sep
                };
                response = response + " ) "
          }
    }]

    [ buildIntList( request )( response ) {
          scope( sql ) {
                install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                         throw( DatabaseError )
                );

                response = "( ";
                for (idx = 0, idx < #request.vector, idx++) {
                  if (idx > 0) {
                    response = response + ","
                  };
                  response = response + request.sep + request.vector[idx] + request.sep
                };
                response = response + " ) "
          }
    }]

    [ buildSetVsSet( request )( response ) {
          scope( sql ) {
                install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                         throw( DatabaseError )
                );

                response = "( ";
                for (idx = 0, idx < #request.vector, idx++ ) {
                  if (idx > 0) {
                      response = response + " OR "
                    };
                  matcher = request.sep + request.vector[idx] + request.sep;
                  response = response + "( " + request.field + " LIKE '%" + matcher + "%' )"
                };
                response = response + " )"

          }
    }]



    [ buildGroceryList( request )( response ) {
      scope( sql ) {
        install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                 throw( DatabaseError )
        );
        undef( grocery_list );
        undef( alternate_notes);

        // Main loop: takes every recipe and persons for whom to cook it, and adds its ingredients and qties to the grocery list

        for( rr = 0, rr < #request.rec_persons, rr++ ) {
            recipe_id  = request.rec_persons[rr].recipe_id;
            persons = request.rec_persons[rr].persons;

            if (request.verbose) { println@Console("Handling recipe #" + recipe_id)()  };

            // Detects for how many persons is the recipe described
            q = "SELECT persons FROM fcp.recipes WHERE recipe_id = " + recipe_id;
            query@Database( q )( result1 );
            if (#result1.row == 0) {
              println@Console("Error: recipe #" + recipe_id + " not found!")()
            };
            if (#result1.row > 1) {
              println@Console("Error: recipe #" + recipe_id + " found multiple times!")()
            };
            number_of_persons = result1.row[0].persons;

            // Detects the ingredients for the recipe

            q = "SELECT ingredient, quantity, unit_of_measure, alternate_ingredient FROM fcp.recipeingredientsproperties WHERE recipe_id = " + recipe_id;
            query@Database( q )( result );
            if (#result.row == 0) {
              println@Console("Error: no ingredient found for recipe #" + recipe_id + " !")()
            };

            // Loop that handles every ingredient of the current recipe, adding it to the list

            for (j = 0, j < #result.row, j++ ) {
                ingredient = result.row[j].ingredient;
                quantity   = result.row[j].quantity;
                unit       = result.row[j].unit_of_measure;
                alternate_ingredient  = result.row[j].alternate_ingredient;

                if (request.verbose) { println@Console("Ingredient " + (j+1) + " of " + #result.row + " for recipe " + recipe_id + " : " + ingredient + " , " + quantity + " " + unit )() };

                if ( (quantity == "") && (unit != "") ) {
                  println@Console("Error: unspecified quantity but specified unit for ingredient " + ingredient + " in recipe #" + recipe_id + " !")()
                };
                if ( (quantity != "") && (unit == "") ) {
                  println@Console("Error: specified quantity but unspecified unit for ingredient " + ingredient + " in recipe #" + recipe_id + " !")()
                };

                // Here we convert (if needed) the quantity and unit of measure
                // - if quantity and unit are unspecified, they remain so
                // - if conversion is standard, or everything has to be converted, apply the rate; otherwise, leave as is

                undef(target_unit);
                undef(target_quantity);

                if ( quantity == "" ) {
                  target_quantity = "";
                  target_unit = ""
                }
                else {

                  q = "SELECT grocery_list_unit, conversion_rate, is_standard_conversion FROM fcp.unitconversions WHERE ingredient = '" + ingredient + "' AND unit_of_measure = '" + unit + "'";

                  query@Database( q )( result2 );
                  if (#result2.row == 0) {
                    println@Console("Error: no conversion found for ingredient " + ingredient + " on unit " + unit + " (recipe #" + recipe_id + ") !")()
                  };
                  if (#result2.row > 1) {
                    println@Console("Error: multiple conversions found for ingredient " + ingredient + " on unit " + unit + " (recipe #" + recipe_id + ") !")()
                  };

                  grocery_unit = string(result2.row[0].grocery_list_unit);
                  rate         = double(result2.row[0].conversion_rate);
                  is_standard  = bool(result2.row[0].is_standard_conversion);

                  if (is_standard || request.convert_all) {
                    // println@Console("Converting....")();
                    target_unit = grocery_unit;
                    target_quantity = double(quantity) * rate * persons / number_of_persons
                  } else {
                    // println@Console("Keeping....")();
                    target_unit = unit;
                    target_quantity = double(quantity) * persons / number_of_persons
                  }
                };


                // End of conversion: here target_unit and target_quantity are set
                if (request.verbose) { println@Console(" Targets for " + ingredient + " : " + target_quantity + " " + target_unit)() };

                // Identifies the class of the ingredient
                q = "SELECT ingredient_class FROM fcp.ingredients WHERE name = '" + ingredient + "'";
                query@Database( q )( result3 );
                if (#result3.row != 1) {
                  println@Console("Error: non-univoque or unspecified ingredient " + ingredient + " !")()
                };
                ingredient_class = result3.row[0].ingredient_class;

                // Finds whether the ingredient is already in the list:
                // - if possible, with the same target unit
                // - otherwise, with no unit of measure at all

                ingposition = -1;
                sameunit = false;
                someentry = false;
                for (k = 0, k < #grocery_list, k++) {
                  someentry = someentry || (grocery_list[k].ingredient == ingredient);
                  if ( (grocery_list[k].ingredient == ingredient) && (grocery_list[k].unit_of_measure == target_unit) ) {
                    sameunit = true;
                    ingposition = k
                  }
                };

                if (!sameunit) {
                  for (k = 0, k < #grocery_list, k++) {
                    if ( (grocery_list[k].ingredient == ingredient) && (grocery_list[k].unit_of_measure == "") ){
                      ingposition = k
                    }
                  }
                };


                // Now handles the adding into the grocery list, by cases:

                // Case 1: quantity is unspecified and ingredient is not in list. Add it with no unit of measure
                if ( (target_quantity == "") && (someentry == false) ) {
                  //println@Console("Case 1")();
                  pos = #grocery_list;
                  grocery_list[pos].ingredient       = ingredient;
                  grocery_list[pos].ingredient_class = ingredient_class;
                  grocery_list[pos].quantity         = "Quantity not specified";
                  grocery_list[pos].unit_of_measure  = ""
                };

                // Case 2: quantity is unspecified and already ingredient is in list. Do nothing
                if ( (target_quantity == "") && (someentry == true) ) {
                  //println@Console("Case 2")();
                  no_op = no_op
                };


                // Case 3: Specified quantity and unit, and exists with same unit in list. Add it.
                if ( ( target_quantity != "") && (sameunit == true) ) {
                    //println@Console("Case 3")();
                    pos = ingposition;
                    grocery_list[pos].quantity = grocery_list[pos].quantity + target_quantity
                  };

                // Case 4: Specified unit and quantity but not in list with same unit.
                // Either replace existing unknown quantity, or adds brand new entry to grocery list

                if ( ( target_quantity != "") && (sameunit == false) ) {
                  //println@Console("Case 4")();

                  if (ingposition == -1) {
                    pos = #grocery_list
                  } else {
                    pos = ingposition
                  };

                  grocery_list[pos].ingredient = ingredient;
                  grocery_list[pos].ingredient_class = ingredient_class;
                  grocery_list[pos].unit_of_measure = target_unit;
                  grocery_list[pos].quantity = target_quantity

                };

                // Handling alternate ingredient if needed (for unknown or known quantity)

                if (alternate_ingredient != "") {
                  if (request.verbose) { println@Console("Handling alternate ingredient '" + alternate_ingredient + "'")() };
                  pos = #alternate_notes;
                  if (target_quantity == "") {
                    alternate_notes[pos] = "Note: " + alternate_ingredient + " can substitute " + ingredient + " in some quantity, for recipe " + recipe_id
                  }
                  else {
                    alternate_notes[pos] = "Note: " + alternate_ingredient + " can substitute " + ingredient + " for " + target_quantity + " " + target_unit + ", for recipe " + recipe_id
                  }
                }
            }
        };

        undef(response);
        for (l = 0, l < #grocery_list, l++) {
            idxclass      = #response.classes;
            idxingredient = 0;
            for (m = 0, m < #response.classes, m++) {
              if (response.classes[m].class == grocery_list[l].ingredient_class) {
                idxclass = m;
                idxingredient   = #response.classes[idxclass].ingredients
              }
            };
            response.classes[idxclass].class = grocery_list[l].ingredient_class;
            response.classes[idxclass].ingredients[idxingredient].ingredient = grocery_list[l].ingredient;
            response.classes[idxclass].ingredients[idxingredient].quantity = grocery_list[l].quantity;
            response.classes[idxclass].ingredients[idxingredient].unit_of_measure = grocery_list[l].unit_of_measure
        };

      // Finally, the translation into the target language:

      req. from = "english";
      req.to = request.language;
      req.fuzzy = false;
      for (l = 0, l < #response.classes, l++) {
        req.str = response.classes[l].class;
        translate@MySelf(req)(response.classes[l].class);
        for (m = 0, m < #response.classes[l].ingredients, m++) {
          req.str = response.classes[l].ingredients[m].ingredient;
          translate@MySelf(req)(response.classes[l].ingredients[m].ingredient);
          req.str = response.classes[l].ingredients[m].unit_of_measure;
          translate@MySelf(req)(response.classes[l].ingredients[m].unit_of_measure )
        }
      }
    }
    }]


    [ mostGeneralRecipeQuery( request )( response ) {
          scope( sql ) {
                install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                         throw( DatabaseError )
                );

                ////////////////////////////////////////////////////////////////////////
                // Section 0: select the recipe_ids from the portion of query involving only
                // the recipe table, i.e. : name, preparation time, difficulty, country,
                // recipe category, main ingredient, cooking technique


                q = "SELECT recipe_id, name, link FROM FCP.recipes";
                constraint_adder = " WHERE ";

                transla.from = request.language;
                transla.to   = "english";
                transla.fuzzy = true;

                // DB.name LIKE *user_specified_name*
                if (is_defined(request.recipe_name)) {
                    transla.str = request.recipe_name;
                    translate@MySelf(transla)(recipe_name);
                    constraint = " ( name LIKE '%" + recipe_name + "%' ) ";
                    if (request.verbose) { println@Console ("Adding name constraint: '" + constraint + "'")() };
                    q = q + constraint_adder + constraint;
                    constraint_adder = " AND "
                };

                transla.from = request.language;
                transla.to   = "english";
                transla.fuzzy = false;

                // DB.preparation_time <= user_specified_time
                if (is_defined(request.max_preparation_time)) {
                  constraint = " ( preparation_time_minutes <= " + request.max_preparation_time + " ) ";
                  if (request.verbose) { println@Console ("Adding prep. time constraint: '" + constraint + "'")() };
                  q = q + constraint_adder + constraint;
                  constraint_adder = " AND "
                };


                // DB.difficulty IN (user_specified_value_1, ... user_specified_value_n)
                if (is_defined(request.difficulty_value)) {
                  req.vector << request.difficulty_value;
                  req.sep = "";
                  buildIntList@MySelf(req)(list);
                  //buildIntList@MySelf({.vector << request.difficulty_value, .sep = "" })(list);
                  if (request.verbose) { println@Console ("Adding diff. level constraint: '( difficulty IN " + list + ")'")() };
                  q = q + constraint_adder + "( difficulty IN " + list + ")";
                  constraint_adder = " AND "
                };

                // (DB.country LIKE *user_country_1*) OR ... OR (DB.country LIKE *user_country_n*)
                if (is_defined(request.country)) {
                  req.field = "place_of_origin";
                  req.vector << request.country;
                  for (t = 0, t < #req.vector, t++) {
                    transla.str = req.vector[t];
                    translate@MySelf(transla)(req.vector[t])
                  };
                  req.sep = "";
                  buildSetVsSet@MySelf(req)(constraint);
                  if (request.verbose) { println@Console ("Adding place of origin constraint: '" + constraint + "'")() };
                  q = q + constraint_adder + constraint;
                  constraint_adder = " AND "
                };

                // DB.recipe_category LIKE *user_specified_category*
                if (is_defined(request.recipe_category)) {
                    transla.str = request.recipe_category;
                    translate@MySelf(transla)(recipe_category);
                    constraint = " ( category LIKE '%" + recipe_category + "%' ) ";
                    if (request.verbose) { println@Console ("Adding category constraint: '" + constraint + "'")() };
                    q = q + constraint_adder + constraint;
                    constraint_adder = " AND "
                };

                // DB.main_ingredient LIKE *user_specified_main_ingredient*
                if (is_defined(request.main_ingredient)) {
                    transla.str = request.main_ingredient;
                    translate@MySelf(transla)(main_ingredient);
                    constraint = " ( main_ingredient LIKE '%" + main_ingredient + "%' ) ";
                    if (request.verbose) { println@Console ("Adding main ingredient constraint: '" + constraint + "'")() };
                    q = q + constraint_adder + constraint;
                    constraint_adder = " AND "
                };

                // (DB.cooking_technique LIKE *user_technique_1*) OR ... OR (DB.cooking_technique LIKE *user_technique_n*)
                if (is_defined(request.cooking_technique)) {
                  req.field = "cooking_technique";
                  req.vector << request.cooking_technique;
                  for (t = 0, t < #req.vector, t++) {
                    transla.str = req.vector[t];
                    translate@MySelf(transla)(req.vector[t])
                  };
                  req.sep = "";
                  buildSetVsSet@MySelf(req)(constraint);
                  // buildSetVsSet@MySelf({.field = "cooking_technique", .vector << request.cooking_technique, .sep = "" })(constraint);
                  if (request.verbose) { println@Console ("Adding cooking constraint: '" + constraint + "'")() };
                  q = q + constraint_adder + constraint;
                  constraint_adder = " AND "
                };

                ////////////////////////////////////////////////////////////////////////
                // Section 1: select the recipe_ids from the portion of query involving only
                // the recipeIngredients table, i.e. : ingredients to be contained,
                // ingredients to be avoided

                // Selects recipe_id from recipe where, for all ingredients and not_ingredients,
                // in recipeIngredients, it exists (resp. does not exist)
                // a pair <recipe_id,ingredient> (resp. <recipe_id,not_ingredient>)

                //q = "SELECT recipe_id FROM FCP.recipe";
                //constraint_adder = " WHERE ";

                if (is_defined(request.yes_ingredient)) {
                  for (idx = 0, idx < #request.yes_ingredient, idx++) {
                    transla.str = request.yes_ingredient[idx];
                    translate@MySelf(transla)(yes_ingr);
                    constraint1 = " ( EXISTS ( SELECT * FROM FCP.recipeIngredients WHERE  ";
                    constraint2 = " FCP.recipes.recipe_id = FCP.recipeIngredients.recipe_id AND ";
                    constraint3 = " FCP.recipeIngredients.ingredient = '" + yes_ingr + "' ) ) ";
                    constraint = constraint1 + constraint2 + constraint3;
                    if (request.verbose) { println@Console ("Adding yes ingredient constraint: '" + constraint + "'")() };
                    q = q + constraint_adder + constraint;
                    constraint_adder = " AND "
                  }
                };

                if (is_defined(request.not_ingredient)) {
                  for (idx = 0, idx < #request.not_ingredient, idx++) {
                    transla.str = request.not_ingredient[idx];
                    translate@MySelf(transla)(not_ingr);
                    constraint1 = " ( NOT EXISTS ( SELECT * FROM FCP.recipeIngredients WHERE  ";
                    constraint2 = " FCP.recipes.recipe_id = FCP.recipeIngredients.recipe_id AND ";
                    constraint3 = " FCP.recipeIngredients.ingredient = '" + not_ingr + "' ) ) ";
                    constraint = constraint1 + constraint2 + constraint3;
                    if (request.verbose) { println@Console ("Adding not ingredient constraint: '" + constraint + "'")() };
                    q = q + constraint_adder + constraint;
                    constraint_adder = " AND "
                    }
                  };

                ////////////////////////////////////////////////////////////////////////
                // Section 2: select the recipe_ids from the portion of query involving only
                // the recipeTools table, i.e. : tools to be used, tools to be avoided

                // Selects recipe_id from recipe where, for all tools and not_tools,
                // in recipeTools, it exists (resp. does not exist)
                // a pair <recipe_id,tool> (resp. <recipe_id,not_tool>)

                //q = "SELECT recipe_id FROM FCP.recipe";
                //constraint_adder = " WHERE ";

                if (is_defined(request.yes_tool)) {
                  for (idx = 0, idx < #request.yes_tool, idx++) {
                    transla.str = request.yes_tool[idx];
                    translate@MySelf(transla)(yes_tool);
                    constraint1  = " ( EXISTS ( SELECT * FROM FCP.recipeTools WHERE  ";
                    constraint2 = " FCP.recipes.recipe_id = FCP.recipeTools.recipe_id AND ";
                    constraint3 = " FCP.recipeTools.tool_name = '" + yes_tool + "' ) ) ";
                    constraint = constraint1 + constraint2 + constraint3;
                    if (request.verbose) { println@Console ("Adding yes tool constraint: '" + constraint + "'")() };
                    q = q + constraint_adder + constraint;
                    constraint_adder = " AND "
                  }
                };

                if (is_defined(request.not_tool)) {
                  for (idx = 0, idx < #request.not_tool, idx++) {
                    transla.str = request.not_tool[idx];
                    translate@MySelf(transla)(not_tool);
                    constraint1 = " ( NOT EXISTS ( SELECT * FROM FCP.recipeTools WHERE  ";
                    constraint2 = " FCP.recipes.recipe_id = FCP.recipeTools.recipe_id AND ";
                    constraint3 = " FCP.recipeTools.tool_name = '" + not_tool + "' ) ) ";
                    constraint = constraint1 + constraint2 + constraint3;
                    if (request.verbose) { println@Console ("Adding not tool constraint: '" + constraint + "'")() };
                    q = q + constraint_adder + constraint;
                    constraint_adder = " AND "
                    }
                  };

                ////////////////////////////////////////////////////////////////////////
                // Section 3: select the recipe_ids from the portion of query involving only
                // the recipeEvents table, namely the recipes of an event

                // q = "SELECT recipe_id FROM FCP.recipe";
                // constraint_adder = " WHERE ";

                if (is_defined(request.appears_in_event)) {
                  transla.str = request.appears_in_event;
                  translate@MySelf(transla)(appears_in_event);
                  constraint1 = " (EXISTS ( SELECT * FROM FCP.recipeEventsNames WHERE ";
                  constraint2 = " FCP.recipes.recipe_id = FCP.recipeEventsNames.recipe_id AND ";
                  constraint3 = " FCP.recipeEventsNames.name = '" + appears_in_event + "' ) ) ";
                  constraint = constraint1 + constraint2 + constraint3;
                  if (request.verbose) { println@Console ("Adding event constraint: '" + constraint + "'")() };
                  q = q + constraint_adder + constraint;
                  constraint_adder = " AND "
                };

                ////////////////////////////////////////////////////////////////////////
                // Section 4: select the recipe_ids from the portion of query involving only
                // the recipeIngredientsProperties table, i.e. : recipes that :
                // (a) do not contain any ingredient with some of the user-specified allergenes
                // (b) do not contain any ingredient not suitable for some eater category,
                // i.e. for all eater categories, all ingredients are ok

                // selects recipe_id from recipe where, for each not_allergene[idx],
                // in recipeIngredientsProperties, it does not exist a pair <recipe_id,properties>
                // s.t. properties contains allergene[idx]

                //q = "SELECT recipe_id FROM FCP.recipe";
                //constraint_adder = " WHERE ";

                if (is_defined(request.not_allergene)) {
                  for (idx = 0, idx < #request.not_allergene, idx ++) {
                    transla.str = request.not_allergene[idx];
                    translate@MySelf(transla)(not_allergene);
                    constraint1 = " ( NOT EXISTS ( SELECT * FROM FCP.recipeIngredientsProperties WHERE  ";
                    constraint2 = " FCP.recipes.recipe_id = FCP.recipeIngredientsProperties.recipe_id AND ";
                    constraint3 = " FCP.recipeIngredientsProperties.properties LIKE '%" + not_allergene + "%' ) ) ";
                    constraint = constraint1 + constraint2 + constraint3;
                    if (request.verbose) { println@Console ("Adding not allergene constraint: '" + constraint + "'")() };
                    q = q + constraint_adder + constraint;
                    constraint_adder = " AND "
                  }
                };

                if (is_defined(request.eater_category)) {
                  for (idx = 0, idx < #request.eater_category, idx++) {
                    transla.str = request.eater_category[idx];
                    translate@MySelf(transla)(eater);
                    constraint1 = " ( NOT EXISTS ( SELECT * FROM FCP.recipeIngredientsProperties WHERE  ";
                    constraint2 = " FCP.recipes.recipe_id = FCP.recipeIngredientsProperties.recipe_id AND ";
                    constraint3 = " FCP.recipeIngredientsProperties.properties NOT LIKE '%" + eater + "%' ) ) ";
                    constraint = constraint1 + constraint2 + constraint3;
                    if (request.verbose) { println@Console ("Adding eater category constraint: '" + constraint + "'")() };
                    q = q + constraint_adder + constraint;
                    constraint_adder = " AND "
                  }
                };

                if (request.verbose) {
                  println@Console(" ")();
                  println@Console("------------------------------------------------------")();
                  println@Console("Query on Recipe, Ingredients, Events, Tools, Eaters : " + q)()
                };

                query@Database( q )( result );

                for( i = 0, i < #result.row, i++ ) {
                    with( response.recipe[ i ] ) {
                        .recipe_id   = result.row[ i ].recipe_id;

                        transla.from = "english";
                        transla.to   = request.language;
                        transla.str  = result.row[ i ].name;
                        translate@MySelf(transla)(recname);
                        .recipe_name = recname;
                        .recipe_link = result.row[ i ].link
                    }
                }


          }
    }]


    // Input: a list of strings.
    // Output: all those entries where one property in the comma-separated value in the cell
    // matches at least one in the input list

    [ getIngredients_set_vs_set( request )( response ) {
          scope( sql ) {
                install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                         throw( DatabaseError )
                );

                println@Console (" Now entering SET-INTO-SET") ();

                first = true;
                for (idx = 0, idx < #request.name , idx++ ) {
                  matcher = request.name[idx];
                  if (first) {
                    q = "SELECT name, properties FROM FCP.ingredients WHERE "
                  } else {
                    q = q + " OR "
                  };
                  q = q + "( properties LIKE '%" + matcher + "%' )";
                  first = false
                };

                //response.ingredient[0].name = q;
                //response.ingredient[0].properties = ""

                query@Database( q )( result );

                for( i = 0, i < #result.row, i++ ) {
                    with( response.ingredient[ i ] ) {
                        .name = result.row[ i ].name;
                        .properties = result.row[ i ].properties
                    }
                }
          }
    }]

    // Input: a list of strings.
    // Output: all those ingredients in that list

    [ getIngredients_into_set( request )( response ) {
          scope( sql ) {
                install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                         throw( DatabaseError )
                );

                q = queries.select_ingredients_into_set;
                q = q + "(";
                for (idx = 0, idx < #request.name , idx++) {
                  if (idx > 0) {
                    q = q + ","
                  };
                  q = q + "'" + request.name[idx] + "'"
                };
                q = q + ")";

                query@Database( q )( result );

                for( i = 0, i < #result.row, i++ ) {
                    with( response.ingredient[ i ] ) {
                        .name = result.row[ i ].name;
                        .properties = result.row[ i ].properties
                    }
                }
          }
    }]

    // Input: an ingredient
    // Output: the ingredients "containing" that string

    [ getIngredients_fuzzy_match( request )( response ) {
          scope( sql ) {
                install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                         throw( DatabaseError )
                );

                q = queries.select_ingredients_fuzzy_match;
                q.fuzzyname = "%" + request.name + "%";
                query@Database( q )( result );

                for( i = 0, i < #result.row, i++ ) {
                    with( response.ingredient[ i ] ) {
                        .name = result.row[ i ].name;
                        .properties = result.row[ i ].properties
                    }
                }
          }
    }]

    // Input: one ingredient
    // Output: The ingredient(s) whose name is exactly that string

    [ getIngredients_exact_match ( request )( response ) {
          scope( sql ) {
                install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                         throw( DatabaseError )
                );

                q = queries.select_ingredients_PG_exact_name;
                q.name = request.name;
                query@Database( q )( result );

                for( i = 0, i < #result.row, i++ ) {
                    with( response.ingredient[ i ] ) {
                        .name = result.row[ i ].name;
                        .properties = result.row[ i ].properties
                    }
                }
          }
    }]

    [ translate ( request )( response ) {
          scope( sql ) {
                install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                         throw( DatabaseError )
                );

                if ((request.from != "english") && (request.from != "italian")) {
                  println@Console ("Error: unknown origin language " + request.from)()
                };
                if ((request.to != "english") && (request.to != "italian")) {
                  println@Console ("Error: unknown target language " + request.to)()
                };

                if ( (request.str == "") || (request.from == request.to) ) {
                  response = request.str
                } else {
                  q = "SELECT " + request.to + " FROM fcp.translations WHERE " ;
                  if (request.fuzzy) {
                     q = q + " ( "+ request.from + " LIKE '%" + request.str + "%' ) "
                  } else {
                     q = q + " ( "+ request.from + " = '" + request.str + "' ) "
                  };
                  if (is_defined(request.table) && is_defined(request.column)) {
                    q = q + "AND ( ( table_1 = '" + request.table + "' AND column_1 = '" + request.column + ") OR ";
                    q = q + "      ( table_2 = '" + request.table + "' AND column_2 = '" + request.column + ") OR ";
                    q = q + "      ( table_3 = '" + request.table + "' AND column_3 = '" + request.column + ") OR ";
                    q = q + "      ( table_4 = '" + request.table + "' AND column_4 = '" + request.column + ") )  "
                  };

                  // println@Console ("Now querying translation: {" + q + "}" )();
                  query@Database( q )( result );
                  if (#result.row > 1 ) {
                    println@Console("WARNING: non-univoque translation for '" + request.str + "' in ( " + request.table + ", " + request.column + ")")()
                  };
                  if (#result.row < 1 ) {
                    println@Console("ERROR: non-existing translation for '" + request.str + "' in ( " + request.table + ", " + request.column + ")")();
                    response = "**********"
                  };
                  if (#result.row > 0) {
                    if (request.to == "english") {
                       response = result.row[0].english
                    };
                    if (request.to == "italian") {
                       response = result.row[0].italian
                    }
                  }
                }
          }
    }]

}
