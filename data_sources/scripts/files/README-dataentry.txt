0.1 Move the local repository renaming it with the current date
0.2 Import the local repository: git clone https://github.com/FoodConnectsPeople/foodconnectspeople-tool

1. Start Postgres in local services
2. Start PGadminIII app
3. Start 2 gitBash shells
4. Loop:
   4.1- in PGadminIII, drop database foodconnectspeople
   4.2- in gitBash1, go to ~/data-sources/scripts and execute jolie create_database.ol
   4.3- in gitBash2, go to ~/data-sources/jolie and execute jolie db_service.ol . Leave it listening.
   4.4- edit using Excel the file ~/data-sources/scripts/files/FoodConnectsPeople.xslx according to guidelines below
   4.5- in gitBash1, go to ~/data-sources/scripts/files and execute ./export-and-check.bat . If errors goto 4.4
   4.6- in gitBash1, go to ~/data-sources/scripts and execute ./insert-all.bat . 
        If errors: kill listener in gitBash2 and go to 4.1
5. Stop Postgres and kill gitBash1, gitBash2, PGadminIII

6. git status
7. git add *
8. git commit -m "Commit message"
9. git push


1. Insert recipe in Recipe table.  
2. If recipe category is new then add it to RecipeCategories 
3. If event of recipe is new then add it to Event table
4. If category of event of recipe is new, then add it to EventCategories table
5. If cooking technique of recipe is new, then add it to CookingTechniques table
6. If author of recipe is new, add it to FcpUser table
7. Add association author-recipe into AuthorRecipe table
5. for every ingredient of the recipe:
   5.1 add it to recipeingredients
   5.2 add its conversion into UnitConversions, unless already present or quantity unspecified 
   5.3 if ingredient is new, then add it into the Ingredients table
   5.4 if ingredient is new, also add it  *by now manually* into the ingredients.csv 
6. for every element added into the tables, add (unless already present) its translation into Translation table. Consider specifically the following contexts: 
- Ingredients.{Ingredient,Ingredient_class}
- Recipe.*
- RecipeIngredients.{Ingredient,Alt_Ingredient,Preparation_Technique,Unit_of_Measure}
- RecipeTools.Tool_Name   

 