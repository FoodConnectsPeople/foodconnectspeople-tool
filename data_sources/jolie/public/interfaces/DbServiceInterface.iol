
type BuildGroceryListRequest: void {
  .verbose     : bool
  .convert_all : bool
  .language    : string
  .rec_persons*: void {
    .recipe_id : int
    .persons   : int
  }
}

type BuildGroceryListResponse: void {
  .classes*     : void {
    .class : string
    .ingredients* : void {
      .ingredient : string
      .quantity   : double
      .unit_of_measure : string
    }
  }
}

type BuildListRequest: void {
  .vector*: string
  .sep:     string
}

type BuildIntListRequest: void {
  .vector*: int
  .sep:     string
}

type BuildSetVsSetRequest: void {
  .field:   string
  .vector*: string
  .sep:     string
}

type GetCookingTechniquesResponse: void {
  .name*: string
}


type GetCountriesResponse: void {
  .name*: string
}

type GetIngredientsResponse: void {
  .ingredient*: void {
      .ingredient_id: int
      .name: string
      .properties: string
      .allergene: string
      .ingredient_class: string
  }
}

type GetPropertiesResponse: void {
  .property*: void {
      .property_id: int
      .name: string
  }
}

type GetIngredients_namepropResponse: void {
  .ingredient*: void {
      .name: string
      .properties: string
  }
}

type GetIngredients_nameRequest: void {
  .name: string
}

type GetIngredients_namelistRequest: void {
  .name*: string
}

type buildCommaRequest: void {
  .str* : string
}

type InsertIngredientRequest: void {
  .name: string
  .properties*: string
  .allergene*: string
  .ingredient_class* : string
}

type InsertEventRequest: void {
  .name: string
  .place: string
  .start_date: string
  .end_date : string
  .category: string
}


type InsertRecipeIngredientRequest: void {
  .recipe_id: int
  .ingredient: string
  .quantity : string
  .unit_of_measure : string
  .preparation_technique* : string
  .alternate_ingredient : string
}

type InsertRecipeRequest: void {
  .recipe*: void {
    .name: string
    .link: string
    .preparation_time_minutes: int
    .persons: int
    .difficulty: int
    .place_of_origin: string
    .is_from_latitude: double
    .is_from_longitude: double
    .category: string
    .main_ingredient: string
    .cooking_technique: string
  }
}

type InsertRecipeEventRequest: void {
  .recipe_id: int
  .event_id: int
}

type InsertRecipeToolRequest: void {
  .recipe_id: int
  .tool_name: string
  .tool_quantity: int
}

type InsertUserRequest: void {
  .fcp_user_id: int
  .username: string
  .full_name : string
  .is_author : bool
  .is_cook: bool
}

type InsertUnitConversionRequest: void {
  .ingredient: string
  .unit_of_measure: string
  .grocery_list_unit: string
  .conversion_rate: double
  .is_standard_conversion: bool
}

type InsertAuthorRecipeRequest: void {
  .author_id: int
  .recipe_id: int
}

type InsertCookingTechniqueRequest: void {
  .cooking_technique_id: int
  .name: string
}

type InsertCountryRequest: void {
  .country_id: int
  .name: string
}

type InsertToolRequest: void {
  .tool_id: int
  .name: string
}

type InsertRecipeCategoryRequest: void {
  .category_id: int
  .name: string
}

type InsertTranslationRequest: void {
  .italian  : string
  .english  : string
  .table_1  : string
  .column_1 : string
  .table_2  : string
  .column_2 : string
  .table_3  : string
  .column_3 : string
  .table_4  : string
  .column_4 : string
}

type MostGeneralQueryRequest: void {
  .verbose                    : bool
  .recipe_name          [0,1] : string
  .max_preparation_time [0,1] : int
  .difficulty_value     [0,*] : int
  .country              [0,*] : string
  .recipe_category      [0,1] : string
  .main_ingredient      [0,1] : string
  .cooking_technique    [0,*] : string
  .eater_category       [0,*] : string
  .not_allergene        [0,*] : string
  .yes_ingredient       [0,*] : string
  .not_ingredient       [0,*] : string
  .yes_tool             [0,*] : string
  .not_tool             [0,*] : string
  .appears_in_event     [0,1] : string
  .language             [0,1] : string
}

type MostGeneralQueryResponse: void {
  .recipe*: void {
      .recipe_id: int
      .recipe_name: string
      .recipe_link: string
      .preparation_time_minutes: int
      .difficulty: int
      .place_of_origin: string
      .category: string
      .cooking_technique: string
  }
}



type TranslateRequest: void {
  .str     : string
  .from    : string
  .to      : string
  .fuzzy   : bool
  .table   [0,1] : string
  .column  [0,1] : string
}



type GetRecipeResponse: void {
  .recipe*: void {
    .recipe_id: int
    .recipe_name: string
    .recipe_link: string
    .preparation_time_minutes: int
    .difficulty: int
    .place_of_origin: string
    .category: string
    .cooking_technique: string
  }
}

interface DbServiceInterface {
  OneWay:
    tester( void )

  RequestResponse:
    buildGroceryList( BuildGroceryListRequest )( BuildGroceryListResponse ) throws DatabaseError,
    translate( TranslateRequest )( string ) throws DatabaseError,
    buildList( BuildListRequest )( string ) throws DatabaseError,
    buildCommaSeparatedString( buildCommaRequest )( string ) throws DatabaseError,
    buildIntList( BuildIntListRequest )( string ) throws DatabaseError,
    buildSetVsSet( BuildSetVsSetRequest )( string ) throws DatabaseError,
    getCookingTechniques( void )( GetCookingTechniquesResponse ) throws DatabaseError,
    getCountries( void )( GetCountriesResponse ) throws DatabaseError,
    getRecipes( void )( GetRecipeResponse ) throws DatabaseError,
    getIngredients( void )( GetIngredientsResponse ) throws DatabaseError,
    getIngredients_exact_match( GetIngredients_nameRequest )( GetIngredients_namepropResponse ) throws DatabaseError,
    getIngredients_fuzzy_match( GetIngredients_nameRequest )( GetIngredients_namepropResponse ) throws DatabaseError,
    getIngredients_into_set( GetIngredients_namelistRequest )( GetIngredients_namepropResponse ) throws DatabaseError,
    getIngredients_set_vs_set( GetIngredients_namelistRequest )( GetIngredients_namepropResponse ) throws DatabaseError,
    getProperties( void )( GetPropertiesResponse ) throws DatabaseError,
    insertIngredient( InsertIngredientRequest )( void ) throws DatabaseError,
    insertEvent( InsertEventRequest )( void ) throws DatabaseError,
    insertUnitConversion( InsertUnitConversionRequest )( void ) throws DatabaseError,
    insertRecipe( InsertRecipeRequest )( void ) throws DatabaseError,
    insertRecipeIngredient( InsertRecipeIngredientRequest )( void ) throws DatabaseError,
    insertRecipeEvent( InsertRecipeEventRequest )( void ) throws DatabaseError,
    insertRecipeTool( InsertRecipeToolRequest )( void ) throws DatabaseError,
    insertIngredient( InsertIngredientRequest )( void ) throws DatabaseError,
    insertRecipe( InsertRecipeRequest )( void ) throws DatabaseError,
    insertUser( InsertUserRequest )( void ) throws DatabaseError,
    insertAuthorRecipe( InsertAuthorRecipeRequest )( void ) throws DatabaseError,
    insertCookingTechnique( InsertCookingTechniqueRequest )( void ) throws DatabaseError,
    insertCountry( InsertCountryRequest )( void ) throws DatabaseError,
    insertTool( InsertToolRequest )( void ) throws DatabaseError,
    insertRecipeCategory( InsertRecipeCategoryRequest )( void ) throws DatabaseError,
    insertTranslation( InsertTranslationRequest )( void ) throws DatabaseError,
    mostGeneralRecipeQuery( MostGeneralQueryRequest )( GetRecipeResponse ) throws DatabaseError
}
