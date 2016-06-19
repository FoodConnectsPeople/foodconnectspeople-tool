include "public/interfaces/FrontendInterface.iol"
include "../../data_sources/jolie/public/interfaces/DbServiceInterface.iol"

include "../../data_sources/jolie/constants.iol"

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

main {
  dummy()() { nullProcess }
}
