#! /bin/sh

export LC_ALL=C
rm -f u-*.csv

tail -n +2 recipe2ingredients.csv | cut -f2 -d"," | sort | uniq > u-recipeingredients.csv
tail -n +2 ingredients.csv | cut -f1 -d"," | sort | uniq > u-ingredients.csv
echo "==== Differences between recipe-ingredients and ingredients: only in ingredients"
diff u-recipeingredients.csv u-ingredients.csv | grep ">"
echo "==== Differences between recipe-ingredients and ingredients: only in recipe ingredients"
diff u-recipeingredients.csv u-ingredients.csv | grep "<"


tail -n +2 recipe2ingredients.csv | cut -f2,4 -d"," | sort | uniq > u-recipeingredientsunits.csv
tail -n +2 unitconversions.csv | cut -f1,2 -d"," | sort | uniq > u-unitconversions.csv
echo "==== Differences between recipe-ingredients and unit conversions: only in conversions"
diff u-recipeingredientsunits.csv u-unitconversions.csv | grep ">"
echo "==== Differences between recipe-ingredients and unit conversions: only in recipe ingredients"
diff u-recipeingredientsunits.csv u-unitconversions.csv | grep "<"

tail -n +2 recipe2tools.csv | cut -f2 -d"," | sort | uniq > u-recipetools.csv
tail -n +2 tools.csv | cut -f2 -d"," | sort | uniq > u-tools.csv
echo "==== Differences between recipe-tools and tools: only in tools"
diff -w u-recipetools.csv u-tools.csv | grep ">"
echo "==== Differences between recipe-tools and tools: only in recipe-tools"
diff -w u-recipetools.csv u-tools.csv | grep "<"

tail -n +2 recipes.csv | cut -f2 -d","   > terms.csv
tail -n +2 recipes.csv | cut -f7 -d","  >> terms.csv
tail -n +2 recipes.csv | cut -f10 -d"," >> terms.csv
tail -n +2 recipes.csv | cut -f11 -d"," >> terms.csv
tail -n +2 recipes.csv | cut -f12 -d"," >> terms.csv

tail -n +2 recipe2ingredients.csv | cut -f2 -d"," >> terms.csv
tail -n +2 recipe2ingredients.csv | cut -f4 -d"," >> terms.csv
tail -n +2 recipe2ingredients.csv | cut -f5 -d"," >> terms.csv
tail -n +2 recipe2ingredients.csv | cut -f6 -d"," >> terms.csv

tail -n +2 events.csv | cut -f2 -d"," >> terms.csv
tail -n +2 events.csv | cut -f6 -d"," >> terms.csv

tail -n +2 recipe2tools.csv | cut -f2 -d"," >> terms.csv
tail -n +2 countries.csv | cut -f2 -d"," >> terms.csv
tail -n +2 categories.csv | cut -f2 -d"," >> terms.csv

cat terms.csv | sort | uniq > u-terms.csv

tail -n +2 translations.csv | cut -f1 -d"," | sort | uniq > u-translations.csv

echo "==== Differences between terms and translations: only in terms"
diff -w u-terms.csv u-translations.csv | grep "<"
