/*
 * Copyright (c) 2016 FoodConnectsPeople.
 * 
 * Requires a DB to be created.
 * 
 * PostgreSQL cheat-sheet:
 * - Launch console: psql
 * - Execute script: \i <name of this file>.sql
 * - Show all DB's: \l
 * - Show tables: \dt
 * - Describe table: \d FoodConnectsPeople.<tablename>
 * - Drop the whole schema (e.g., for tests):
 *    drop schema FoodConnectsPeople cascade;
*/

CREATE SCHEMA FoodConnectsPeople;

CREATE TABLE FoodConnectsPeople.Recipe (
  id SERIAL PRIMARY KEY
  , name VARCHAR(1024) NOT NULL
  , preparation_time_minutes SMALLINT
  , difficulty SMALLINT
  
  , place_of_origin VARCHAR(256)
  , is_from_latitude DECIMAL(9,6)
  , is_from_longitude DECIMAL(9,6)

  , category VARCHAR(1024)
  , main_ingredient VARCHAR(1024)
  , cooking_technique VARCHAR(1024)
  , is_vegetarian BOOLEAN
  , is_vegan BOOLEAN
  , is_gluten_free BOOLEAN
  , is_lactose_free BOOLEAN
);

CREATE TABLE FoodConnectsPeople.FcpUser (
  id SERIAL PRIMARY KEY
  , username varchar(255) NOT NULL
  , full_name VARCHAR(1024)
  , is_author BOOLEAN -- has contributed >=1 recipe
  , is_cook BOOLEAN -- has cooked in >=1 events
  --, (hashed) password?
);

CREATE TABLE FoodConnectsPeople.AuthorRecipe (
  author_id SERIAL
  , recipe_id SERIAL
  , PRIMARY KEY (author_id, recipe_id)
  , FOREIGN KEY (author_id) REFERENCES FoodConnectsPeople.FcpUser(id)
  , FOREIGN KEY (recipe_id) REFERENCES FoodConnectsPeople.Recipe(id)
);

CREATE TABLE FoodConnectsPeople.RecipeCategory (
  recipe_id SERIAL
  , category_name VARCHAR(512)
  , PRIMARY KEY (recipe_id, category_name)
  , FOREIGN KEY (recipe_id) REFERENCES FoodConnectsPeople.Recipe(id)
);

CREATE TABLE FoodConnectsPeople.RecipeIngredients (
  recipe_id SERIAL
  , ingredient VARCHAR(1024)
  , quantity SMALLINT
  , unit_of_measure VARCHAR(128)
  , is_vegetarian BOOLEAN
  , is_vegan BOOLEAN
  , is_gluten_free BOOLEAN
  , is_lactose_free BOOLEAN
  , preparation_technique VARCHAR(1024)
  , PRIMARY KEY (recipe_id, ingredient, preparation_technique)
  , FOREIGN KEY (recipe_id) REFERENCES FoodConnectsPeople.Recipe(id)
);

CREATE TABLE FoodConnectsPeople.Event (
  id SERIAL PRIMARY KEY
  , name VARCHAR(1024) NOT NULL
  , place VARCHAR(255) NOT NULL
  , start_date DATE NOT NULL
  , end_date DATE
);

CREATE TABLE FoodConnectsPeople.RecipeEvents (
  recipe_id SERIAL
  , event_id SERIAL
  , PRIMARY KEY (recipe_id, event_id)
  , FOREIGN KEY (recipe_id) REFERENCES FoodConnectsPeople.Recipe(id)
  , FOREIGN KEY (event_id) REFERENCES FoodConnectsPeople.Event(id)
);

CREATE TABLE FoodConnectsPeople.RecipeTools(
  recipe_id SERIAL
  , tool_name VARCHAR(1024)
  , tool_quantity SMALLINT
  , PRIMARY KEY (recipe_id, tool_name)
  , FOREIGN KEY (recipe_id) REFERENCES FoodConnectsPeople.Recipe(id)
);
