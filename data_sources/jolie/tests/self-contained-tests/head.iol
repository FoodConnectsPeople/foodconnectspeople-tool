include "console.iol"
include "string_utils.iol"
include "../../public/interfaces/DbServiceInterface.iol"
include "../../constants.iol"

outputPort DbService {
  Interfaces: DbServiceInterface
}

embedded {
  Jolie:
    "../../db_service.ol" in DbService
}
