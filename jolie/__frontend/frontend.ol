include "public/interfaces/FrontendInterface.iol"
include "../../data_sources/jolie/constants.iol"

include "time.iol"
include "../leonardo/config.iol"

execution{ concurrent }

outputPort DbService {
  Location: DB_SERVICE_LOCATION
  Protocol: sodep
  Interfaces: DbServiceInterface
}

inputPort Frontend {
  Location: "local"
  Interfaces: FrontendInterface
  Aggregates: DbService
}

init {
  global.last_cache_timeout = 0L
}

main {
  getInitData( request )( response ) {
      getCurrentTimeMillis@Time( )( tm );
      if ( ( tm - last_cache_timeout ) > CacheExpirationTime ) {
          synchronized( sync_cache ) {
              getCountries@DbService( request )( global.cache.countries );
              getCookingTechniques@DbService( request )( global.cache.cooking_techniques );
              getRecipeCategories@DbService( request )( global.cache.recipe_categories );
              getEaterCategories@DbService( request )( global.cache.eater_categories );
              getAllergenes@DbService( request )( global.cache.allergenes );
              getTools@DbService( request )( global.cache.tools );
              getEvents@DbService( request )( events );
              global.cache.event -> events.event;
              getIngredients@DbService( request )( ingredients );
              global.cache.ingredient -> ingredients.ingredient;
              getCurrentTimeMillis@Time( )( last_cache_timeout );
              getRecipeNames@DbService( request )( global.cache.recipe_names )
          }
      }
      ;
      response -> global.cache
  }
}
