del .\ingredients.csv
del files\ingredients-transformed.csv
copy files\ingredients.csv .
call py -2 transform-ingredients-py2.py > files\ingredients-transformed.csv
del .\ingredients.csv

call jolie insert_ingredients.ol
call jolie insert_recipes.ol
call jolie insert_events.ol
call jolie insert_recipe2ingredients.ol
call jolie insert_recipe2events.ol
call jolie insert_recipe2tools.ol
call jolie insert_users.ol
call jolie insert_authors2recipes.ol
call jolie insert_countries.ol
call jolie insert_tools.ol
call jolie insert_unitconversions.ol
call jolie insert_translations.ol
call jolie insert_categories.ol
