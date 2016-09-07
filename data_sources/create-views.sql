/*
 * Copyright (c) 2016 FCP.
 *
 * Requires a DB to be created.
 *
 * PostgreSQL cheat-sheet:
 * - Launch console: psql
 * - Execute script: \i <name of this file>.sql
 * - Show all DB's: \l
 * - Show tables: \dt
 * - Describe table: \d FCP.<tablename>
 * - Drop the whole schema (e.g., for tests):
 *    drop schema FCP cascade;
*/

CREATE MATERIALIZED VIEW FCP.recipeingredientsproperties
AS SELECT
recipeingredients.recipe_id,
ingredients.ingredient_id,
recipeingredients.ingredient,
recipeingredients.quantity,
recipeingredients.unit_of_measure,
recipeingredients.preparation_technique,
recipeingredients.alternate_ingredient,
ingredients.properties,
ingredients.allergene
FROM FCP.recipeingredients recipeingredients, FCP.ingredients ingredients
WHERE recipeIngredients.ingredient = ingredients.name ;


CREATE MATERIALIZED VIEW FCP.recipeeventsnames
AS SELECT
recipeevents.recipe_id,
recipeevents.event_id,
events.name,
events.place,
events.start_date,
events.end_date,
events.category

FROM FCP.recipeevents recipeevents, FCP.events events
WHERE recipeevents.event_id = events.event_id ;
