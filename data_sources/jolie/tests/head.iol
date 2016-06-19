include "console.iol"
include "string_utils.iol"

include "../public/interfaces/DbServiceInterface.iol"

include "../constants.iol"

outputPort DbService {
  Location: DB_SERVICE_LOCATION
  Protocol: sodep
  Interfaces: DbServiceInterface
}
