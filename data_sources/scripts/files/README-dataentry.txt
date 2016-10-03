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
 