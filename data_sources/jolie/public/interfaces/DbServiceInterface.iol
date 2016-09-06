
type MostGeneralQueryRequest: void {
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


type GetIngredientsResponse: void {
  .ingredient*: void {
      .ingredient_id: int
      .name: string
      .properties: string
      .allergene: string
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
  .quantity : int
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


type GetRecipeResponse: void {
  .recipe*: void {
    .name: string
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
    mostGeneralRecipeQuery( MostGeneralQueryRequest )( MostGeneralQueryResponse ) throws DatabaseError,
    buildList( BuildListRequest )( string ) throws DatabaseError,
    buildCommaSeparatedString( buildCommaRequest )( string ) throws DatabaseError,
    buildIntList( BuildIntListRequest )( string ) throws DatabaseError,
    buildSetVsSet( BuildSetVsSetRequest )( string ) throws DatabaseError,
    getIngredients( void )( GetIngredientsResponse ) throws DatabaseError,
    getIngredients_exact_match( GetIngredients_nameRequest )( GetIngredients_namepropResponse ) throws DatabaseError,
    getIngredients_fuzzy_match( GetIngredients_nameRequest )( GetIngredients_namepropResponse ) throws DatabaseError,
    getIngredients_into_set( GetIngredients_namelistRequest )( GetIngredients_namepropResponse ) throws DatabaseError,
    getIngredients_set_vs_set( GetIngredients_namelistRequest )( GetIngredients_namepropResponse ) throws DatabaseError,
    getProperties( void )( GetPropertiesResponse ) throws DatabaseError,
    insertIngredient( InsertIngredientRequest )( void ) throws DatabaseError,
    insertEvent( InsertEventRequest )( void ) throws DatabaseError,
    insertRecipe( InsertRecipeRequest )( void ) throws DatabaseError,
    insertRecipeIngredient( InsertRecipeIngredientRequest )( void ) throws DatabaseError,
    insertRecipeEvent( InsertRecipeEventRequest )( void ) throws DatabaseError,
    insertRecipeTool( InsertRecipeToolRequest )( void ) throws DatabaseError,
    getRecipes( void )( GetRecipeResponse ) throws DatabaseError
}
