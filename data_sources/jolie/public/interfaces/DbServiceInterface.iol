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

type InsertIngredientResponse: void

interface DbServiceInterface {
  RequestResponse:
    getIngredients( void )( GetIngredientsResponse ) throws DatabaseError,
    getProperties( void )( GetPropertiesResponse ) throws DatabaseError,
    insertIngredient( InsertIngredientRequest )( InsertIngredientResponse ) throws DatabaseError
}
