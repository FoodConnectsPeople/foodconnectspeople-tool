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

type InsertIngredientRequest: void {
  .name: string
  .properties*: string
  .allergene*: string
}

type InsertRecipeRequest: void {
  .recipe*: void {
    .name: string
    .preparation_time_minutes: int
    .difficulty: int
    .place_of_origin: string
    .is_from_latitude: double
    .is_from_longitude: double
    .category: string
    .cooking_technique: string
    .is_vegetarian: bool
    .is_vegan: bool
    .is_gluten_free: bool
    .is_lactose_free: bool
  }
}

type InsertIngredientResponse: void
type InsertRecipeResponse: void

interface DbServiceInterface {
  RequestResponse:
    getIngredients( void )( GetIngredientsResponse ) throws DatabaseError,
    getProperties( void )( GetPropertiesResponse ) throws DatabaseError,
    insertIngredient( InsertIngredientRequest )( InsertIngredientResponse ) throws DatabaseError,
    insertRecipe( InsertRecipeRequest )( InsertRecipeResponse ) throws DatabaseError
}
