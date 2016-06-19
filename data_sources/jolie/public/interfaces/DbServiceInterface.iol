type GetIngredientsResponse: void {
  .ingredient*: void {
      .name: string
      .properties*: string
  }
}

type InsertIngredientRequest: void {
  .name: string
  .properties*: string
}

type InsertIngredientResponse: void

interface DbServiceInterface {
  RequestResponse:
    getIngredients( void )( GetIngredientsResponse ),
    insertIngredient( InsertIngredientRequest )( InsertIngredientResponse ) throws DatabaseError
}
