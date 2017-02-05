include "console.iol"
include "string_utils.iol"
include "database.iol"
include "ini_utils.iol"
include "runtime.iol"

include "public/interfaces/DbServiceInterface.iol"


include "constants.iol"
include "queries.iol"

execution { concurrent }

constants {
  DEFAULT_LANGUAGE = "en"
}

inputPort DbService {
  Location: DB_SERVICE_LOCATION
  Protocol: sodep
  Interfaces: DbServiceInterface
}

// Output port to invoke "internal functions"
outputPort MySelf {
  Interfaces: DbServiceInterface
}

outputPort AnotherMySelf {
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

define __check_language  {

    /* check if the language exists */
    if ( is_defined( request.language ) && request.language != DEFAULT_LANGUAGE ) {
        undef( q );
        q = queries.select_languages;
        q.language_id = request.language;
        query@Database( q )( result );
        if ( #result.row == 0 ) {
            throw( LanguageNotPermitted )
        }
        ;
        language = request.language
    } else {
        language = DEFAULT_LANGUAGE
    }

}


init {
    getLocalLocation@Runtime()( MySelf.location );
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

/***
  [ defLanguage( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

              if (is_defined(request.language)) {
                response = request.language
              } else {
                response = "english"
              }
        }
  }]
***/


  [ getIngredients( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

              if (is_defined(request.language)) {
                language = request.language
              } else {
                language = "english"
              };
              transla.fuzzy = false;
              transla.from = "english";
              transla.to = language;
              translal.fuzzy = false;
              translal.from = "english";
              translal.to = language;
              translal.separator = "__";

              q = queries.select_ingredients;
              query@Database( q )( result );
              for( i = 0, i < #result.row, i++ ) {
                  with( response.ingredient[ i ] ) {
                      .ingredient_id = result.row[ i ].ingredient_id;
                      .name = result.row[i].name;
                      .properties = result.row[ i ].properties;
                      .allergene = result.row[i].allergene;
                      .ingredient_class = result.row[i].ingredient_class
/*
                      transla.str = result.row[i].name;
                      translate@MySelf(transla)(str);
                      .name = str;

                      translal.str = result.row[ i ].properties;
                      translateList@MySelf(translal)(str);
                      .properties = str;

                      translal.str = result.row[i].allergene;
                      .ingredient_class =
                      translateList@MySelf(translal)(str);
                      .allergene = str;

                      transla.str = result.row[i].ingredient_class;
                      translate@MySelf(transla)(str);
                      .ingredient_class = str
*/
                  }
              }
        }
  }]

  [ insertIngredient( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

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



  [ insertCategory( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

              q = queries.insert_category;
              q.id = request.id;
              q.name = request.name;
              q.category = request.category;
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

  [ insertRecipeIngredient( request )( response ) {
        scope( sql ) {
              install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                       throw( DatabaseError )
              );

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

        if (is_defined(request.language)) {
          language = request.language
        } else {
          language = "english"
        };

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

                  sanitizeSQLQueryString@MySelf(ingredient)(q_ingredient);
                  sanitizeSQLQueryString@MySelf(unit)(q_unit);
                  q = "SELECT grocery_list_unit, conversion_rate, is_standard_conversion FROM fcp.unitconversions WHERE ingredient = '" + q_ingredient + "' AND unit_of_measure = '" + q_unit + "'";

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
                sanitizeSQLQueryString@MySelf(ingredient)(q_ingredient);
                q = "SELECT ingredient_class FROM fcp.ingredients WHERE name = '" + q_ingredient + "'";
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
      req.to = language;
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

    [ getCountries( request )( response ) {
      scope( sql ) {
            install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                     throw( DatabaseError )
            );

            __check_language;
            if ( language == DEFAULT_LANGUAGE ) {
                q = queries.select_countries
            } else {
                q = queries.select_countries_i18n;
                q.language = language
            };
            query@Database( q )( result );
            for( i = 0, i < #result.row, i++ ) {
                with( response.country[ i ] ) {
                    .name = result.row[ i ].name;
                    .country_id = result.row[ i ].country_id
                }
            }
            /*


            //for( i = 0, i < #result.row, i++ ) {
            //  println@Console("Country " + i + " is '" + result.row[i].name + "'")();
            //  response.name[i] = str
            //};

            for( i = 0, i < #result.row, i++ ) {
              transla.fuzzy = false;
              transla.from = "english";
              transla.to = language;
              transla.str = result.row[i].name;
              translate@MySelf(transla)(str);
              response.name[i] = str
            }
            */
      }
    }]

    [ getEaterCategories( request )( response ) {
      scope( sql ) {
            install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                     throw( DatabaseError )
            );

            if (is_defined(request.language)) {
              language = request.language
            } else {
              language = "english"
            };


            q = "SELECT name FROM FCP.categories WHERE (category = 'eater-category')";
            query@Database( q )( result );
            for( i = 0, i < #result.row, i++ ) {
                response.name[ i ] = result.row[ i ].name
            };

            for( i = 0, i < #response.name, i++ ) {
              transla.fuzzy = false;
              transla.from = "english";
              transla.to = language;
              transla.str = response.name[i];
              translate@MySelf(transla)(str);
              response.name[i] = str
            }

      }
    }]

    [ getEventCategories( request )( response ) {
      scope( sql ) {
            install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                     throw( DatabaseError )
            );


            if (is_defined(request.language)) {
              language = request.language
            } else {
              language = "english"
            };

            // q = "SELECT DISTINCT category FROM fcp.events";
            q = "SELECT name FROM fcp.categories WHERE (category = 'event-category')";
            query@Database( q )( result );
            for( i = 0, i < #result.row, i++ ) {
                transla.from = "english";
                transla.fuzzy = false;
                transla.to = language;
                // transla.str = result.row[ i ].category;
                transla.str = result.row[ i ].name;
                translate@MySelf(transla)(response.name[ i ])
              }
      }
    }]

    [ getAllergenes( request )( response ) {
      scope( sql ) {
            install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                     throw( DatabaseError )
            );

            if (is_defined(request.language)) {
              language = request.language
            } else {
              language = "english"
            };

            q = "SELECT name FROM FCP.categories WHERE (category = 'allergene')";
            query@Database( q )( result );
            for( i = 0, i < #result.row, i++ ) {
                response.name[ i ] = result.row[ i ].name
            };

            for( i = 0, i < #response.name, i++ ) {
              transla.fuzzy = false;
              transla.from = "english";
              transla.to = language;
              transla.str = response.name[i];
              translate@MySelf(transla)(str);
              response.name[i] = str
            }

      }
    }]


    [ getCookingTechniques( request )( response ) {
      scope( sql ) {
            install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                     throw( DatabaseError )
            );

            if (is_defined(request.language)) {
              language = request.language
            } else {
              language = "english"
            };

            q = queries.select_cooking_techniques;
            query@Database( q )( result );
            for( i = 0, i < #result.row, i++ ) {
              transla.fuzzy = false;
              transla.from = "english";
              transla.to = language;
              transla.str = result.row[i].name;
              translate@MySelf(transla)(str);
              response.name[i] = str
            }
      }
    }]

    [ getRecipes( request )( response ) {
      scope( sql ) {
            install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                     throw( DatabaseError )
            );

            if (is_defined(request.language)) {
              language = request.language
            } else {
              language = "english"
            };
            transla.fuzzy = false;
            transla.from = "english";
            transla.to = language;

            q = queries.select_recipes + " ORDER BY name";
            query@Database( q )( result );
            for( i = 0, i < #result.row, i++ ) {
                with( response.recipe[ i ] ) {
                    .recipe_id = result.row[ i ].recipe_id;

                    transla.str = result.row[ i ].name;
                    translate@MySelf(transla)(str);
                    .recipe_name = str;

                    .recipe_link = result.row[ i ].link;
                    .preparation_time_minutes = result.row[ i ].preparation_time_minutes;
                    .difficulty = result.row[ i ].difficulty;

                    transla.str = result.row[ i ].place_of_origin;
                    translate@MySelf(transla)(str);
                    .place_of_origin = str;

                    transla.str = result.row[ i ].category;
                    translate@MySelf(transla)(str);
                    .category = str;

                    transla.str = result.row[ i ].cooking_technique;
                    translate@MySelf(transla)(str);
                    .cooking_technique = str
                }
            }
      }
    }]

    [ getRecipeCategories( request )( response ) {
      scope( sql ) {
            install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                     throw( DatabaseError )
            );

            if (is_defined(request.language)) {
              language = request.language
            } else {
              language = "english"
            };

            // q = "SELECT DISTINCT category FROM fcp.recipes";
            q = "SELECT name FROM fcp.categories WHERE (category = 'recipe-category')";
            query@Database( q )( result );
            for( i = 0, i < #result.row, i++ ) {
                transla.fuzzy = false;
                transla.from = "english";
                transla.to = language;
                // transla.str = result.row[i].category;
                transla.str = result.row[i].name;
                translate@MySelf(transla)(str);
                response.name[i] = str
            }
      }
    }]

    [ getTools( request )( response ) {
      scope( sql ) {
            install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                     throw( DatabaseError )
            );

            if (is_defined(request.language)) {
              language = request.language
            } else {
              language = "english"
            };

            q = queries.select_tools;
            query@Database( q )( result );
            for( i = 0, i < #result.row, i++ ) {

              transla.fuzzy = false;
              transla.from = "english";
              transla.to = language;
              transla.str = result.row[i].name;
              translate@MySelf(transla)(str);
              response.name[i] = str
            }
      }
    }]


    [ getEvents( request )( response ) {
      scope( sql ) {
            install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                     throw( DatabaseError )
            );

            if (is_defined(request.language)) {
              language = request.language
            } else {
              language = "english"
            };

            transla.fuzzy = false;
            transla.from = "english";
            transla.to = language;

            q = queries.select_events;
            query@Database( q )( result );
            for( i = 0, i < #result.row, i++ ) {
                response.event[ i ].event_id = result.row[ i ].event_id;
                transla.str = result.row[i].name;
                translate@MySelf(transla)(str);
                response.event[ i ].name = str;
                response.event[ i ].place = result.row[ i ].place;
                response.event[ i ].start_date = result.row[ i ].start_date;
                response.event[ i ].end_date = result.row[ i ].end_date;
                transla.str = result.row[i].category;
                translate@MySelf(transla)(str);
                response.event[ i ].category = str
            }
      }
    }]

    [ getRecipeDetails( request )( response ) {
      scope( sql ) {
            install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                     throw( DatabaseError )
            );

            if (is_defined(request.language)) {
              language = request.language
            } else {
              language = "english"
            };

            transla.to = language;
            transla.from   = "english";
            transla.fuzzy = false;

            q = "SELECT name, link, preparation_time_minutes, persons, difficulty, place_of_origin, is_from_latitude, is_from_longitude, category, main_ingredient, cooking_technique FROM fcp.recipes WHERE recipe_id = " + request.recipe_id;
            query@Database( q )( result );
            if (#result.row != 1) { println@Console("ERROR: recipe #" + request.recipe_id + " has no (unambiguous) entry in table recipes")() };

            transla.str = result.row[0].name;
            translate@MySelf(transla)(recipe_name);
            response.name = recipe_name;

            response.link = result.row[0].link;
            response.preparation_time = result.row[0].preparation_time_minutes;
            response.is_from_latitude = result.row[0].is_from_latitude;
            response.is_from_longitude = result.row[0].is_from_longitude;
            response.persons = result.row[0].persons;
            response.difficulty = result.row[0].difficulty;

            transla.str = result.row[0].place_of_origin;
            translate@MySelf(transla)(place_of_origin);
            response.place_of_origin = place_of_origin;

            transla.str = result.row[0].category;
            translate@MySelf(transla)(category);
            response.category = category;

            transla.str = result.row[0].main_ingredient;
            translate@MySelf(transla)(main_ingredient);
            response.main_ingredient = main_ingredient;

            transla.str = result.row[0].cooking_technique;
            translate@MySelf(transla)(cooking_technique);
            response.cooking_technique = cooking_technique;

            q = "SELECT ingredient, quantity, unit_of_measure, preparation_technique, alternate_ingredient FROM fcp.recipeingredients WHERE recipe_id = " + request.recipe_id;
            query@Database( q )( result );
            if (#result.row == 0) { println@Console("ERROR: recipe #" + request + " has no ingredients")() };
            for (i = 0, i < #result.row, i++) {

              transla.str = result.row[i].ingredient;
              translate@MySelf(transla)(ingredient);
              response.ingredient[i].ingredient_name = ingredient;

              response.ingredient[i].ingredient_quantity = result.row[i].quantity;

              transla.str = result.row[i].unit_of_measure;
              translate@MySelf(transla)(unit_of_measure);
              response.ingredient[i].unit_of_measure = unit_of_measure;

              transla.str = result.row[i].preparation_technique;
              translate@MySelf(transla)(preparation_technique);
              response.ingredient[i].preparation_technique = preparation_technique;

              transla.str = result.row[i].alternate_ingredient;
              translate@MySelf(transla)(alternate_ingredient);
              response.ingredient[i].alternate_ingredient = alternate_ingredient

            };

            q = "SELECT tool_name, tool_quantity FROM fcp.recipetools WHERE recipe_id = " + request.recipe_id;
            query@Database( q )( result );
            for (i = 0, i < #result.row, i++) {

              transla.str = result.row[i].tool_name;
              translate@MySelf(transla)(tool_name);
              response.tool[i].tool_name = tool_name;
              response.tool[i].tool_quantity = result.row[i].tool_quantity
            };

            q = "SELECT event_id FROM fcp.recipeevents WHERE recipe_id = " + request.recipe_id;
            query@Database( q )( result );
            if (#result.row == 0) { println@Console("ERROR: recipe #" + request + " appears in no event")() };
            for (i = 0, i < #result.row, i++) {
              q2 = "SELECT name, place, start_date, end_date, category FROM fcp.events WHERE event_id = " + result.row[i].event_id;
              query@Database( q2 )( result2 );
              if (#result2.row != 1) { println@Console("ERROR: event #" + result.row[i].event_id + " is not (univoquely) defined ")() };

              transla.str = result2.row[0].name;
              translate@MySelf(transla)(name);
              response.event[i].event_name = name;
              response.event[i].event_place = result2.row[0].place;
              response.event[i].event_start_date = result2.row[0].start_date;
              response.event[i].event_end_date = result2.row[0].end_date;
              transla.str = result2.row[0].category;
              translate@MySelf(transla)(category);
              response.event[i].event_category = category
            }
      }
    }]

    [ mostGeneralRecipeQuery( request )( response ) {
      valueToPrettyString@StringUtils( request )( s ); println@Console( s )();
          scope( sql ) {
                install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                         throw( DatabaseError )
                );

                if (is_defined(request.language)) {
                  language = request.language
                } else {
                  language = "english"
                };

                ////////////////////////////////////////////////////////////////////////
                // Section 0: select the recipe_ids from the portion of query involving only
                // the recipe table, i.e. : name, preparation time, difficulty, country,
                // recipe category, main ingredient, cooking technique

                verbose = request.verbose;
                q = queries.select_recipes;
                constraint_adder = " WHERE ";
                transla.from = language;
                transla.to   = "english";
                transla.fuzzy = true;

                // DB.name LIKE *user_specified_name*
                if (is_defined(request.recipe_name)) {
                    transla.str = request.recipe_name;
                    translate@MySelf(transla)(recipe_name);
                    sanitizeSQLQueryString@MySelf(recipe_name)(q_recipe_name);
                    constraint = " ( name LIKE '%" + q_recipe_name + "%' ) ";
                    if (verbose) { println@Console ("Adding name constraint: '" + constraint + "'")() };
                    q = q + constraint_adder + constraint;
                    constraint_adder = " AND "
                };

                transla.from = language;
                transla.to   = "english";
                transla.fuzzy = false;

                // DB.preparation_time <= user_specified_time
                if (is_defined(request.max_preparation_time)) {
                  constraint = " ( preparation_time_minutes <= " + request.max_preparation_time + " ) ";
                  if (verbose) { println@Console ("Adding prep. time constraint: '" + constraint + "'")() };
                  q = q + constraint_adder + constraint;
                  constraint_adder = " AND "
                };


                // DB.difficulty IN (user_specified_value_1, ... user_specified_value_n)
                if (is_defined(request.difficulty_value)) {
                  req.vector << request.difficulty_value;
                  req.sep = "";
                  buildIntList@MySelf(req)(list);
                  //buildIntList@MySelf({.vector << request.difficulty_value, .sep = "" })(list);
                  if (verbose) { println@Console ("Adding diff. level constraint: '( difficulty IN " + list + ")'")() };
                  q = q + constraint_adder + "( difficulty IN " + list + ")";
                  constraint_adder = " AND "
                };

                // (DB.country LIKE *user_country_1*) OR ... OR (DB.country LIKE *user_country_n*)
                if (is_defined(request.country)) {
                  req.field = "place_of_origin";
                  req.vector << request.country;
                  for (t = 0, t < #req.vector, t++) {
                    transla.str = req.vector[t];
                    translate@MySelf(transla)(req.vector[t]);
                    sanitizeSQLQueryString@MySelf(req.vector[t])(req.vector[t])
                  };
                  req.sep = "";
                  buildSetVsSet@MySelf(req)(constraint);
                  if (verbose) { println@Console ("Adding place of origin constraint: '" + constraint + "'")() };
                  q = q + constraint_adder + constraint;
                  constraint_adder = " AND "
                };

                // DB.recipe_category LIKE *user_specified_category*
                if (is_defined(request.recipe_category)) {
                    transla.str = request.recipe_category;
                    translate@MySelf(transla)(recipe_category);
                    sanitizeSQLQueryString@MySelf(recipe_category)(q_recipe_category);
                    constraint = " ( category LIKE '%" + q_recipe_category + "%' ) ";
                    if (verbose) { println@Console ("Adding category constraint: '" + constraint + "'")() };
                    q = q + constraint_adder + constraint;
                    constraint_adder = " AND "
                };

                // DB.main_ingredient LIKE *user_specified_main_ingredient*
                if (is_defined(request.main_ingredient)) {
                    transla.str = request.main_ingredient;
                    translate@MySelf(transla)(main_ingredient);
                    sanitizeSQLQueryString@MySelf(main_ingredient)(q_main_ingredient);
                    constraint = " ( main_ingredient LIKE '%" + q_main_ingredient + "%' ) ";
                    if (verbose) { println@Console ("Adding main ingredient constraint: '" + constraint + "'")() };
                    q = q + constraint_adder + constraint;
                    constraint_adder = " AND "
                };

                // (DB.cooking_technique LIKE *user_technique_1*) OR ... OR (DB.cooking_technique LIKE *user_technique_n*)
                if (is_defined(request.cooking_technique)) {
                  req.field = "cooking_technique";
                  req.vector << request.cooking_technique;
                  for (t = 0, t < #req.vector, t++) {
                    transla.str = req.vector[t];
                    translate@MySelf(transla)(req.vector[t]);
                    sanitizeSQLQueryString@MySelf(req.vector[t])(req.vector[t])
                  };
                  req.sep = "";
                  buildSetVsSet@MySelf(req)(constraint);
                  // buildSetVsSet@MySelf({.field = "cooking_technique", .vector << request.cooking_technique, .sep = "" })(constraint);
                  if (verbose) { println@Console ("Adding cooking constraint: '" + constraint + "'")() };
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

                //q = queries.select_recipes;
                //constraint_adder = " WHERE ";

                if (is_defined(request.yes_ingredient)) {
                  for (idx = 0, idx < #request.yes_ingredient, idx++) {
                    transla.str = request.yes_ingredient[idx];
                    translate@MySelf(transla)(yes_ingr);
                    sanitizeSQLQueryString@MySelf(yes_ingr)(q_yes_ingr);
                    constraint1 = " ( EXISTS ( SELECT * FROM FCP.recipeIngredients WHERE  ";
                    constraint2 = " FCP.recipes.recipe_id = FCP.recipeIngredients.recipe_id AND ";
                    constraint3 = " FCP.recipeIngredients.ingredient = '" + q_yes_ingr + "' ) ) ";
                    constraint = constraint1 + constraint2 + constraint3;
                    if (verbose) { println@Console ("Adding yes ingredient constraint: '" + constraint + "'")() };
                    q = q + constraint_adder + constraint;
                    constraint_adder = " AND "
                  }
                };

                if (is_defined(request.not_ingredient)) {
                  for (idx = 0, idx < #request.not_ingredient, idx++) {
                    transla.str = request.not_ingredient[idx];
                    translate@MySelf(transla)(not_ingr);
                    sanitizeSQLQueryString@MySelf(not_ingr)(q_not_ingr);
                    constraint1 = " ( NOT EXISTS ( SELECT * FROM FCP.recipeIngredients WHERE  ";
                    constraint2 = " FCP.recipes.recipe_id = FCP.recipeIngredients.recipe_id AND ";
                    constraint3 = " FCP.recipeIngredients.ingredient = '" + q_not_ingr + "' ) ) ";
                    constraint = constraint1 + constraint2 + constraint3;
                    if (verbose) { println@Console ("Adding not ingredient constraint: '" + constraint + "'")() };
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

                //q = queries.select_recipes;
                //constraint_adder = " WHERE ";

                if (is_defined(request.yes_tool)) {
                  for (idx = 0, idx < #request.yes_tool, idx++) {
                    transla.str = request.yes_tool[idx];
                    translate@MySelf(transla)(yes_tool);
                    sanitizeSQLQueryString@MySelf(yes_tool)(q_yes_tool);
                    constraint1  = " ( EXISTS ( SELECT * FROM FCP.recipeTools WHERE  ";
                    constraint2 = " FCP.recipes.recipe_id = FCP.recipeTools.recipe_id AND ";
                    constraint3 = " FCP.recipeTools.tool_name = '" + q_yes_tool + "' ) ) ";
                    constraint = constraint1 + constraint2 + constraint3;
                    if (verbose) { println@Console ("Adding yes tool constraint: '" + constraint + "'")() };
                    q = q + constraint_adder + constraint;
                    constraint_adder = " AND "
                  }
                };

                if (is_defined(request.not_tool)) {
                  for (idx = 0, idx < #request.not_tool, idx++) {
                    transla.str = request.not_tool[idx];
                    translate@MySelf(transla)(not_tool);
                    sanitizeSQLQueryString@MySelf(not_tool)(q_not_tool);
                    constraint1 = " ( NOT EXISTS ( SELECT * FROM FCP.recipeTools WHERE  ";
                    constraint2 = " FCP.recipes.recipe_id = FCP.recipeTools.recipe_id AND ";
                    constraint3 = " FCP.recipeTools.tool_name = '" + q_not_tool + "' ) ) ";
                    constraint = constraint1 + constraint2 + constraint3;
                    if (verbose) { println@Console ("Adding not tool constraint: '" + constraint + "'")() };
                    q = q + constraint_adder + constraint;
                    constraint_adder = " AND "
                    }
                  };

                ////////////////////////////////////////////////////////////////////////
                // Section 3: select the recipe_ids from the portion of query involving only
                // the recipeEvents table, namely the recipes of an event

                // q = queries.select_recipes;
                // constraint_adder = " WHERE ";

                if (is_defined(request.appears_in_event)) {
                  transla.str = request.appears_in_event;
                  translate@MySelf(transla)(appears_in_event);
                  sanitizeSQLQueryString@MySelf(appears_in_event)(q_appears_in_event);
                  constraint1 = " (EXISTS ( SELECT * FROM FCP.recipeEventsNames WHERE ";
                  constraint2 = " FCP.recipes.recipe_id = FCP.recipeEventsNames.recipe_id AND ";
                  constraint3 = " FCP.recipeEventsNames.name = '" + q_appears_in_event + "' ) ) ";
                  constraint = constraint1 + constraint2 + constraint3;
                  if (verbose) { println@Console ("Adding event constraint: '" + constraint + "'")() };
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

                //q = queries.select_recipes;
                //constraint_adder = " WHERE ";

                if (is_defined(request.not_allergene)) {
                  for (idx = 0, idx < #request.not_allergene, idx ++) {
                    transla.str = request.not_allergene[idx];
                    translate@MySelf(transla)(not_allergene);
                    sanitizeSQLQueryString@MySelf(not_allergene)(q_not_allergene);
                    constraint1 = " ( NOT EXISTS ( SELECT * FROM FCP.recipeIngredientsProperties WHERE  ";
                    constraint2 = " FCP.recipes.recipe_id = FCP.recipeIngredientsProperties.recipe_id AND ";
                    constraint3 = " FCP.recipeIngredientsProperties.properties LIKE '%" + q_not_allergene + "%' ) ) ";
                    constraint = constraint1 + constraint2 + constraint3;
                    if (verbose) { println@Console ("Adding not allergene constraint: '" + constraint + "'")() };
                    q = q + constraint_adder + constraint;
                    constraint_adder = " AND "
                  }
                };

                if (is_defined(request.eater_category)) {
                  for (idx = 0, idx < #request.eater_category, idx++) {
                    transla.str = request.eater_category[idx];
                    translate@MySelf(transla)(eater);
                    sanitizeSQLQueryString@MySelf(eater)(q_eater);
                    constraint1 = " ( NOT EXISTS ( SELECT * FROM FCP.recipeIngredientsProperties WHERE  ";
                    constraint2 = " FCP.recipes.recipe_id = FCP.recipeIngredientsProperties.recipe_id AND ";
                    constraint3 = " FCP.recipeIngredientsProperties.properties NOT LIKE '%" + q_eater + "%' ) ) ";
                    constraint = constraint1 + constraint2 + constraint3;
                    if (verbose) { println@Console ("Adding eater category constraint: '" + constraint + "'")() };
                    q = q + constraint_adder + constraint;
                    constraint_adder = " AND "
                  }
                };

                if (verbose) {
                  println@Console(" ")();
                  println@Console("------------------------------------------------------")();
                  println@Console("Query on Recipe, Ingredients, Events, Tools, Eaters : " + q)()
                };

                query@Database( q )( result );

                if (verbose) { println@Console(" Result consists of " + #result.row + " recipes.")() };

                transla.from = "english";
                transla.to   = language;

                for( i = 0, i < #result.row, i++ ) {
                    with( response.recipe[ i ] ) {
                        .recipe_id   = result.row[ i ].recipe_id;

                        transla.str  = result.row[ i ].name;
                        translate@MySelf(transla)(recname);
                        .recipe_name = recname;

                        if (verbose) { println@Console( (i+1) + " - Recipe #" + result.row[i].recipe_id + " : " + recname)() };

                        .recipe_link = result.row[ i ].link;
                        .preparation_time_minutes = result.row[ i ].preparation_time_minutes;
                        .difficulty = result.row[ i ].difficulty;
                        .place_of_origin = result.row[ i ].place_of_origin;

                        transla.str = result.row[ i ].category;
                        translate@MySelf(transla)(catname);
                        .category = catname;

                        transla.str = result.row[ i ].cooking_technique;
                        translate@MySelf(transla)(ckname);
                        .cooking_technique = ckname
                    }
                }
          }
    }]



    [ getEventRecipes ( request )( response ) {
              scope( sql ) {
                    install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                             throw( DatabaseError )
                    );

                    if (is_defined(request.language)) {
                      language = request.language
                    } else {
                      language = "english"
                    };

                    q = "SELECT recipe_id FROM fcp.recipeevents WHERE event_id = " + request.event_id;
                    query@Database( q )( result0 );

                    if (#result0.row == 0) { println@Console("ERROR: no recipe found for event #" + request.event_id)() };

                    for( i = 0, i < #result0.row, i++ ) {

                        q2 = "SELECT recipe_id, name, difficulty, link, preparation_time_minutes, place_of_origin, category, cooking_technique FROM fcp.recipes WHERE recipe_id = " + result0.row[i].recipe_id;
                        query@Database( q2 )( result );
                        if (#result.row != 1) { println@Console("ERROR: recipe #" + result0.row[i].recipe_id + " not (univoquely) defined.")() };

                        with( response.recipe[ i ] ) {
                            .recipe_id   = result.row[ 0].recipe_id;
                            transla.fuzzy = false;
                            transla.from = "english";
                            transla.to = language;

                            transla.str  = result.row[ 0 ].name;
                            translate@MySelf(transla)(recname);
                            .recipe_name = recname;

                            .recipe_link = result.row[ 0 ].link;
                            .preparation_time_minutes = result.row[ 0 ].preparation_time_minutes;
                            .difficulty = result.row[ 0 ].difficulty;
                            .place_of_origin = result.row[ 0 ].place_of_origin;

                            transla.str = result.row[ 0 ].category;
                            translate@MySelf(transla)(catname);
                            .category = catname;

                            transla.str = result.row[ 0 ].cooking_technique;
                            translate@MySelf(transla)(ckname);
                            .cooking_technique = ckname

                        }
                    }



              }
        }]


    [ sanitizeSQLQueryString ( request )( response ) {
              scope( sql ) {
                    install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                             throw( DatabaseError )
                    );

              // println@Console("Into sanitize of '" + request +"'")();
              str2 = request;
              str2.replacement = "''";
              str2.regex       = "'";
              replaceAll@StringUtils(str2)(str);
              response = str
              // println@Console("Exiting sanitize of '" + request +"'")()
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


                trim@StringUtils(request.str)(str);

                if ( (str == ",," ) || (str == ",") ) {
                  str = ""
                } else {
                  str.prefix = ",";
                  startsWith@StringUtils(str)(swith);
                  undef(str.prefix);
                  if (swith) {
                    length@StringUtils(str)(len);
                    str.begin = 1;
                    str.end   = len - 1;
                    substring@StringUtils(str)(str1);
                    str = str1;
                    undef(str.begin);
                    undef(str.end)
                  };
                  str.suffix = ",";
                  endsWith@StringUtils(str)(ewith);
                  undef(str.suffix);
                  if (ewith) {
                    length@StringUtils(str)(len);
                    str.begin = 0;
                    str.end   = len - 2;
                    substring@StringUtils(str)(str1);
                    str = str1;
                    undef(str.begin);
                    undef(str.end)
                  }
                };

                str2 = str;
                undef(str);
                undef(str2.regex);
                undef(str2.replacement);
                undef(str2.begin);
                undef(str2.end);
                undef(str2.prefix);
                undef(str2.suffix);
                trim@StringUtils(str2)(str);
                undef(str2);

                if ( (str == "") || (request.from == request.to) ) {
                  response = str
                } else {

                  //println@Console("Before sanitize: '" + str + "'")();
                  //sanitizeSQLQueryString@MySelf(str)(str3);
                  //println@Console("After sanitize: '" + str3 + "'")();
                  //str = str3;

                  str2 = str;
                  str2.replacement = "''";
                  str2.regex       = "'";
                  replaceAll@StringUtils(str2)(str);


                  q = "SELECT " + request.to + " FROM fcp.translations WHERE " ;
                  if (request.fuzzy) {
                     q = q + " ( "+ request.from + " LIKE '%" + str + "%' ) "
                  } else {
                     q = q + " ( "+ request.from + " = '" + str + "' ) "
                  };
                  if (is_defined(request.table) && is_defined(request.column)) {
                    q = q + "AND ( ( table_1 = '" + request.table + "' AND column_1 = '" + request.column + ") OR ";
                    q = q + "      ( table_2 = '" + request.table + "' AND column_2 = '" + request.column + ") OR ";
                    q = q + "      ( table_3 = '" + request.table + "' AND column_3 = '" + request.column + ") OR ";
                    q = q + "      ( table_4 = '" + request.table + "' AND column_4 = '" + request.column + ") )  "
                  };

                  //println@Console ("Now querying translation: {" + q + "}" )();
                  query@Database( q )( result );
                  if (#result.row > 1 ) {
                    println@Console("WARNING: non-univoque translation for '" + str + "' in ( " + request.table + ", " + request.column + ")")();
                    println@Console("(DB query was " + q + ")")()
                  };
                  if (#result.row < 1 ) {
                    println@Console("ERROR: non-existing translation for '" + str + "' in ( " + request.table + ", " + request.column + ")")();
                    println@Console("(DB query was " + q + ")")();
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

[ translateList ( requestt )( responsee ) {
      scope( sql ) {
            install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                     throw( DatabaseError )
            );

            // println@Console("Translating List '" + requestt.str + "' from '" + requestt.from + "' to '" + requestt.to + "'")();
            if ((requestt.from != "english") && (requestt.from != "italian")) {
              println@Console ("Error: unknown origin language " + requestt.from)()
            };
            if ((requestt.to != "english") && (requestt.to != "italian")) {
              println@Console ("Error: unknown target language " + requestt.to)()
            };

            responsee = "";
            if (requestt.str != "") {

              transla.from = requestt.from;
              transla.to    = requestt.to;
              transla.fuzzy = requestt.fuzzy;
              if (is_defined(requestt.table)) {
                transla.table = requestt.table
              };
              if (is_defined(requestt.column)) {
                transla.column = requestt.column
              };

              tosplit       = requestt.str;
              tosplit.regex = requestt.separator;
              split@StringUtils(tosplit)(splitted);
              for (i = 0 , i < #splitted.result, i++) {

                //println@Console("Splitted #" + i + " : '" + splitted.result[i] + "'")();
                if (splitted.result[i] != "") {
                  undef(translated);
                  transla.str = splitted.result[i];
                  //println@Console("Now translating splitted '" + transla.str + "'")();

                  // NOTICE: this self-call issues a bug. Replicating internal lines below.
                  // translate@MySelf(transla)(translated);


                  undef(request);
                  request.str = transla.str;
                  request.from = transla.from;
                  request.to = transla.to;

                  //println@Console("Now trimming " + request.str)();
                  undef(str);
                  trim@StringUtils(request.str)(str);
                  //println@Console("Now trimmed")();

                  if ( (str == ",," ) || (str == ",") ) {
                    str = ""
                  } else {
                    str.prefix = ",";
                    startsWith@StringUtils(str)(swith);
                    undef(str.prefix);
                    if (swith) {
                      length@StringUtils(str)(len);
                      str.begin = 1;
                      str.end   = len - 1;
                      substring@StringUtils(str)(str1);
                      str = str1;
                      undef(str.begin);
                      undef(str.end)
                    };
                    str.suffix = ",";
                    endsWith@StringUtils(str)(ewith);
                    undef(str.suffix);
                    if (ewith) {
                      length@StringUtils(str)(len);
                      str.begin = 0;
                      str.end   = len - 2;
                      substring@StringUtils(str)(str1);
                      str = str1;
                      undef(str.begin);
                      undef(str.end)
                    }
                  };

                  //println@Console("Retrim " + str)();
                  str2 = str;
                  undef(str);
                  undef(str2.regex);
                  undef(str2.replacement);
                  undef(str2.begin);
                  undef(str2.end);
                  undef(str2.prefix);
                  undef(str2.suffix);
                  trim@StringUtils(str2)(str);
                  undef(str2);
                  //println@Console("Retrimmed ")();

                  if ( (str == "") || (request.from == request.to) ) {
                    response = str
                  } else {

                    //println@Console("Before sanitize: '" + str + "'")();
                    //sanitizeSQLQueryString@MySelf(str)(str3);
                    //println@Console("After sanitize: '" + str3 + "'")();
                    //str = str3;

                    str2 = str;
                    str2.replacement = "''";
                    str2.regex       = "'";
                    replaceAll@StringUtils(str2)(str);


                    q = "SELECT " + request.to + " FROM fcp.translations WHERE " ;
                    if (request.fuzzy) {
                       q = q + " ( "+ request.from + " LIKE '%" + str + "%' ) "
                    } else {
                       q = q + " ( "+ request.from + " = '" + str + "' ) "
                    };
                    if (is_defined(request.table) && is_defined(request.column)) {
                      q = q + "AND ( ( table_1 = '" + request.table + "' AND column_1 = '" + request.column + ") OR ";
                      q = q + "      ( table_2 = '" + request.table + "' AND column_2 = '" + request.column + ") OR ";
                      q = q + "      ( table_3 = '" + request.table + "' AND column_3 = '" + request.column + ") OR ";
                      q = q + "      ( table_4 = '" + request.table + "' AND column_4 = '" + request.column + ") )  "
                    };

                    //println@Console ("Now querying translation: {" + q + "}" )();
                    query@Database( q )( result );
                    if (#result.row > 1 ) {
                      println@Console("WARNING: non-univoque translation for '" + str + "' in ( " + request.table + ", " + request.column + ")")();
                      println@Console("(DB query was " + q + ")")()
                    };
                    if (#result.row < 1 ) {
                      println@Console("ERROR: non-existing translation for '" + str + "' in ( " + request.table + ", " + request.column + ")")();
                      println@Console("(DB query was " + q + ")")();
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
                  };

                  translated = response;


                  //println@Console("Outcome is '" + translated + "'")();
                  responsee = responsee + requestt.separator + translated
                  //println@Console("Current outcome is " + responsee)()
                }
              };
            responsee = responsee + requestt.separator
            // println@Console("Final outcome is " + responsee)()
          }
    }
}]

[ updateCountry( request )( response ) {
  scope( sql ) {
        install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                 throw( DatabaseError )
        );

        __check_language;
        undef( q );
        if ( language == DEFAULT_LANGUAGE ) {
            /* update of the source table */
            q = queries.update_country;
            q.name = request.name;
            q.id = request.id;
            update@Database( q )()
        } else {
            /* update of the i18n table */
            q = queries.update_country_i18n;
            q.content = request.name;
            q.id = request.id;
            update@Database( q )()
        }
  }
}]

[ shutdown( request ) ] {
  exit
}

/******   OLD-REDUNDANT STUFF

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


        [ buildCommaSeparatedString( request )( response ) {
              scope( sql ) {
                    install( SQLException => println@Console( sql.SQLException.stackTrace )();
                                             throw( DatabaseError )
                    );

                    // response = "," + request.name[0] + ","

                    println@Console(" Entered comma separated")();
                    response = ",";
                    for (idx = 0, idx < #request.name, idx++) {
                      response = response + request.name[idx] + ","
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

*********/

}
