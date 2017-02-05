include "../../../../data_sources/jolie/public/interfaces/DbServiceInterface.iol"

type GetInitDataResponse: void {
  .countries: NameList
  .cooking_techniques: NameList
  .recipe_categories: NameList
  .eater_categories: NameList
  .tools: NameList
  .allergenes: NameList
  .event*: Event
  .ingredient*: Ingredient
}

interface FrontendInterface {
  RequestResponse:
    getInitData( OptionalLanguage )( GetInitDataResponse )
}
