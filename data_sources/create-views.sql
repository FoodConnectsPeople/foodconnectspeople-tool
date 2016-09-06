/*
 * Copyright (c) 2016 foodconnectspeople.
 *
 * Requires a DB to be created.
 *
 * PostgreSQL cheat-sheet:
 * - Launch console: psql
 * - Execute script: \i <name of this file>.sql
 * - Show all DB's: \l
 * - Show tables: \dt
 * - Describe table: \d foodconnectspeople.<tablename>
 * - Drop the whole schema (e.g., for tests):
 *    drop schema foodconnectspeople cascade;
*/

CREATE MATERIALIZED VIEW foodconnectspeople.recipeingredientsproperties
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
FROM foodconnectspeople.recipeingredients recipeingredients, foodconnectspeople.ingredients ingredients
WHERE recipeIngredients.ingredient = ingredients.name ;
