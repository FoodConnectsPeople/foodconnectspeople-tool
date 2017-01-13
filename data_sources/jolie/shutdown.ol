include "public/interfaces/DbServiceInterface.iol"
include "constants.iol"

outputPort DbService {
  Location: DB_SERVICE_LOCATION
  Protocol: sodep
  Interfaces: DbServiceInterface
}

main {
  shutdown@DbService()
}
