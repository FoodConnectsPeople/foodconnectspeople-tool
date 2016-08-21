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

CREATE SCHEMA foodconnectspeople;


CREATE TABLE foodconnectspeople.Recipes (
  recipe_id SERIAL PRIMARY KEY
  , name VARCHAR(1024) NOT NULL
  , preparation_time_minutes SMALLINT
  , difficulty SMALLINT
  , countries  VARCHAR
  , place_of_origin VARCHAR(256)
  , is_from_latitude DECIMAL(9,6)
  , is_from_longitude DECIMAL(9,6)

  , category VARCHAR(1024)
  , cooking_technique VARCHAR(1024)
);

CREATE TABLE foodconnectspeople.FcpUser (
  fcp_user_id SERIAL PRIMARY KEY
  , username varchar(255) NOT NULL
  , full_name VARCHAR(1024)
  , is_author BOOLEAN -- has contributed >=1 recipe
  , is_cook BOOLEAN -- has cooked in >=1 events
  --, (hashed) password?
);

CREATE TABLE foodconnectspeople.AuthorRecipe (
  author_id SERIAL
  , recipe_id SERIAL
  , PRIMARY KEY (author_id, recipe_id)

  , FOREIGN KEY (author_id) REFERENCES foodconnectspeople.FcpUser(fcp_user_id)
  , FOREIGN KEY (recipe_id) REFERENCES foodconnectspeople.Recipes(recipe_id)
);

CREATE TABLE foodconnectspeople.Ingredients (
  ingredient_id SERIAL
  , name VARCHAR(1024)
  , properties VARCHAR
  , allergene VARCHAR
  , CONSTRAINT unique_ingredient_name UNIQUE (name)
);

CREATE TABLE foodconnectspeople.CookingTechniques (
  cooking_technique_id SERIAL
  , name VARCHAR(1024)
  , CONSTRAINT unique_cooking_technique_name UNIQUE (name)
);

CREATE TABLE foodconnectspeople.Properties (
  property_id SERIAL
  , name VARCHAR
  , CONSTRAINT unique_property_name UNIQUE (name)
);

CREATE TABLE foodconnectspeople.RecipeIngredients (
  recipe_id INTEGER
  , ingredient_id INTEGER
  , is_main BOOLEAN
  , quantity SMALLINT
  , unit_of_measure VARCHAR(128)
  , preparation_technique VARCHAR(1024)
  , PRIMARY KEY (recipe_id, ingredient_id)
  , FOREIGN KEY (recipe_id) REFERENCES foodconnectspeople.Recipes(recipe_id)
);


CREATE TABLE foodconnectspeople.Countries (
  country_id SERIAL
  , name VARCHAR(128)
  , PRIMARY KEY (country_id)
);

CREATE TABLE foodconnectspeople.RecipeCountries (
  recipe_id INTEGER
  , country_id INTEGER
  , PRIMARY KEY (recipe_id, country_id)
  , FOREIGN KEY (recipe_id) REFERENCES foodconnectspeople.Recipes(recipe_id)
);

CREATE TABLE foodconnectspeople.Event (
  event_id SERIAL PRIMARY KEY
  , name VARCHAR(1024) NOT NULL
  , place VARCHAR(255) NOT NULL
  , start_date DATE NOT NULL
  , end_date DATE
);

CREATE TABLE foodconnectspeople.RecipeEvents (
  recipe_id SERIAL
  , event_id SERIAL
  , PRIMARY KEY (recipe_id, event_id)
  , FOREIGN KEY (recipe_id) REFERENCES foodconnectspeople.Recipes(recipe_id)
  , FOREIGN KEY (event_id) REFERENCES foodconnectspeople.Event(event_id)
);

CREATE TABLE foodconnectspeople.RecipeTools(
  recipe_id SERIAL
  , tool_name VARCHAR(1024)
  , tool_quantity SMALLINT
  , PRIMARY KEY (recipe_id, tool_name)
  , FOREIGN KEY (recipe_id) REFERENCES foodconnectspeople.Recipes(recipe_id)
);

CREATE TABLE foodconnectspeople.Multilanguage (
  table_name VARCHAR(128)
  , field_name VARCHAR(128)
  , item_id INTEGER
  , language_id INTEGER
  , content VARCHAR(2048)
);

CREATE TABLE foodconnectspeople.Languages (
  language_id SERIAL
  , label VARCHAR(64)
  , abbreviation VARCHAR(3)
);

INSERT INTO foodconnectspeople.Properties ( name ) VALUES ('vegan');
INSERT INTO foodconnectspeople.Properties ( name ) VALUES ('vegetarian');
INSERT INTO foodconnectspeople.Properties ( name ) VALUES ('gluten_free');
INSERT INTO foodconnectspeople.Properties ( name ) VALUES ('lactose_free');
INSERT INTO foodconnectspeople.Properties ( name ) VALUES ('spicy');
