
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

CREATE SCHEMA FCP;

CREATE TABLE FCP.Recipes (
  recipe_id SERIAL PRIMARY KEY
  , name VARCHAR(1024) NOT NULL
  , link VARCHAR(1024)
  , preparation_time_minutes SMALLINT
  , persons INT
  , difficulty SMALLINT
  --, countries  VARCHAR
  , place_of_origin VARCHAR(256)
  , is_from_latitude DECIMAL(9,6)
  , is_from_longitude DECIMAL(9,6)
  , category VARCHAR(1024)
  , main_ingredient VARCHAR(1024)
  , cooking_technique VARCHAR(1024)
);

CREATE TABLE FCP.FcpUsers (
  fcp_user_id SERIAL PRIMARY KEY
  , username varchar(255) NOT NULL
  , full_name VARCHAR(1024)
  , is_author BOOLEAN -- has contributed >=1 recipe
  , is_cook BOOLEAN -- has cooked in >=1 events
  --, (hashed) password?
);

CREATE TABLE FCP.AuthorRecipe (
  author_id SERIAL
  , recipe_id SERIAL
  , PRIMARY KEY (author_id, recipe_id)
  , FOREIGN KEY (author_id) REFERENCES FCP.FcpUsers(fcp_user_id)
  , FOREIGN KEY (recipe_id) REFERENCES FCP.Recipes(recipe_id)
);

CREATE TABLE FCP.Ingredients (
  ingredient_id SERIAL
  , name VARCHAR(1024)
  , properties VARCHAR
  , allergene VARCHAR
  , ingredient_class VARCHAR
  , PRIMARY KEY (name)
  , CONSTRAINT unique_ingredient_name UNIQUE (name)
);

CREATE TABLE FCP.RecipeIngredients (
  recipe_id INTEGER
  , ingredient VARCHAR(1024)
  -- , is_main BOOLEAN
  , quantity VARCHAR(10)
  , unit_of_measure VARCHAR(128)
  , preparation_technique VARCHAR(1024)
  , alternate_ingredient VARCHAR(1024)
  -- , PRIMARY KEY (recipe_id, ingredient)
  , FOREIGN KEY (recipe_id) REFERENCES FCP.Recipes(recipe_id)
  , FOREIGN KEY (ingredient) REFERENCES FCP.Ingredients(name)
);


-- CREATE TABLE FCP.CookingTechniques (
--  cooking_technique_id SERIAL
--  , name VARCHAR(1024)
--  , CONSTRAINT unique_cooking_technique_name UNIQUE (name)
-- );

CREATE TABLE FCP.Categories (
  id SERIAL
  , name VARCHAR(1024)
  , category VARCHAR(1024)
  , CONSTRAINT unique_name UNIQUE (name)
);

CREATE TABLE FCP.Countries (
  country_id SERIAL
  , name VARCHAR(128)
  , PRIMARY KEY (country_id)
);

CREATE TABLE FCP.Tools (
  tool_id SERIAL
  , name VARCHAR(128)
  , PRIMARY KEY (tool_id)
);

-- CREATE TABLE FCP.RecipeCategories (
--   category_id SERIAL
--   , name VARCHAR(128)
--   , PRIMARY KEY (category_id)
--  );

CREATE TABLE FCP.UnitConversions (
  ingredient VARCHAR
  , unit_of_measure VARCHAR(30)
  , grocery_list_unit VARCHAR(30)
  , conversion_rate VARCHAR(30)
  , is_standard_conversion BOOLEAN
  , FOREIGN KEY (ingredient) REFERENCES FCP.Ingredients (name)
  , PRIMARY KEY (ingredient,unit_of_measure)
);

--CREATE TABLE FCP.RecipeCountries (
--  recipe_id INTEGER
--  , country_id INTEGER
--  , PRIMARY KEY (recipe_id, country_id)
--  , FOREIGN KEY (recipe_id) REFERENCES FCP.Recipes(recipe_id)
--);


CREATE TABLE FCP.Events (
  event_id SERIAL PRIMARY KEY
  , name VARCHAR(1024) NOT NULL
  , place VARCHAR(255) NOT NULL
  , start_date VARCHAR(255) NOT NULL
  , end_date VARCHAR(255) NOT NULL
  , category VARCHAR(255) NOT NULL
);

CREATE TABLE FCP.RecipeEvents (
  recipe_id SERIAL
  , event_id SERIAL
  , PRIMARY KEY (recipe_id, event_id)
);

CREATE TABLE FCP.RecipeTools(
  recipe_id SERIAL
  , tool_name VARCHAR(1024)
  , tool_quantity SMALLINT
  , PRIMARY KEY (recipe_id, tool_name)
  , FOREIGN KEY (recipe_id) REFERENCES FCP.Recipes(recipe_id)
);

--CREATE TABLE FCP.Multilanguage (
--  table_name VARCHAR(128)
--  , field_name VARCHAR(128)
--  , item_id INTEGER
--  , language_id INTEGER
--  , content VARCHAR(2048)
--);


CREATE TABLE FCP.Translations (
    english VARCHAR(128)
  , italian VARCHAR(128)
  , table_1 VARCHAR(128)
  , column_1 VARCHAR(128)
  , table_2 VARCHAR(128)
  , column_2 VARCHAR(128)
  , table_3 VARCHAR(128)
  , column_3 VARCHAR(128)
  , table_4 VARCHAR(128)
  , column_4 VARCHAR(128)
  , PRIMARY KEY (english,italian)
);

CREATE TABLE fcp.i18n
(
  field character varying NOT NULL,
  language character varying NOT NULL,
  content character varying,
  dbtable character varying NOT NULL,
  row_id integer NOT NULL,
  CONSTRAINT "i18n_PK" PRIMARY KEY (field, language, dbtable, row_id),
  CONSTRAINT "lang_idFK" FOREIGN KEY (language)
      REFERENCES fcp.languages (language_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE fcp.languages
(
  language_id character varying NOT NULL,
  description character varying,
  CONSTRAINT "lang_idPK" PRIMARY KEY (language_id)
);

CREATE VIEW FCP.recipeingredientsproperties
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


CREATE VIEW FCP.recipeeventsnames
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

CREATE OR REPLACE VIEW fcp.countries_i18n AS
 SELECT c.country_id,
    i.language,
    i.content
   FROM fcp.countries c
     JOIN fcp.i18n i ON i.dbtable::text = 'countries'::text AND i.field::text = 'name'::text AND i.row_id = c.country_id;
