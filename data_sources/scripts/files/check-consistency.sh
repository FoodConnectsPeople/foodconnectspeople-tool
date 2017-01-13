#! /bin/sh

export LC_ALL=C
rm -f u-*.csv

tail -n +2 recipe2ingredients.csv | cut -f2 -d"," >  u-recipeingredients0.csv
tail -n +2 recipe2ingredients.csv | cut -f6 -d"," >> u-recipeingredients0.csv
cat u-recipeingredients0.csv | sort | uniq > u-recipeingredients.csv
tail -n +2 ingredients.csv | cut -f1 -d"," | sort | uniq > u-ingredients.csv
echo "==== Differences between recipe-ingredients and ingredients: only in ingredients"
diff u-recipeingredients.csv u-ingredients.csv | grep ">"
echo "==== DONE === "
echo " "

echo "==== Differences between recipe-ingredients and ingredients: only in recipe ingredients"
diff u-recipeingredients.csv u-ingredients.csv | grep "<"
echo "==== DONE === "
echo " "


tail -n +2 recipe2ingredients.csv | cut -f2,4,7 -d"," > u-recipeingredientsunits0.csv
grep -v ",," u-recipeingredientsunits0.csv | sort | uniq > u-recipeingredientsunits.csv
tail -n +2 unitconversions.csv | cut -f1,2,6 -d"," > u-unitconversions0.csv
grep -v ",," u-unitconversions0.csv | sort | uniq > u-unitconversions.csv
echo "==== Differences between recipe-ingredients and unit conversions: only in conversions"
diff -b u-recipeingredientsunits.csv u-unitconversions.csv | grep ">"
echo "==== DONE === "
echo " "

echo "==== Differences between recipe-ingredients and unit conversions: only in recipe ingredients"
diff u-recipeingredientsunits.csv u-unitconversions.csv | grep "<"
echo "==== DONE === "
echo " "

tail -n +2 recipe2tools.csv | cut -f2 -d"," | sort | uniq > u-recipetools.csv
tail -n +2 tools.csv | cut -f2 -d"," | sort | uniq > u-tools.csv
echo "==== Differences between recipe-tools and tools: only in tools"
diff -w u-recipetools.csv u-tools.csv | grep ">"
echo "==== DONE === "
echo " "

echo "==== Differences between recipe-tools and tools: only in recipe-tools"
diff -w u-recipetools.csv u-tools.csv | grep "<"
echo "==== DONE === "
echo " "

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

cat terms.csv | sed -e 's/^[ \t]*//' | sort | uniq > u-terms.csv

tail -n +2 translations.csv | cut -f1 -d"," | sed -e 's/^[ \t]*//' | sort | uniq > u-translations.csv

echo "==== Differences between terms and translations: only in terms"
diff -w u-terms.csv u-translations.csv | grep "<"
echo "==== DONE === "
echo " "

read -rsp $'Press any key to continue...\n' -n 1 key
rm -f terms.csv
rm -f u-*.csv
