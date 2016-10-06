#! /bin/sh

rm ./ingredients.csv
rm files/ingredients-transformed.csv
cp files/ingredients.csv .
python transform-ingredients.py > files/ingredients-transformed.csv
rm ./ingredients.csv

jolie insert_ingredients.ol
jolie insert_recipes.ol
jolie insert_events.ol
jolie insert_recipe2ingredients.ol
jolie insert_recipe2events.ol
jolie insert_recipe2tools.ol
jolie insert_users.ol
jolie insert_authors2recipes.ol
jolie insert_cookingtechniques.ol
jolie insert_countries.ol
jolie insert_tools.ol
jolie insert_recipe2categories.ol
jolie insert_unitconversions.ol
jolie insert_translations.ol
