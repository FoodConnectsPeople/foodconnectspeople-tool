include "config.iol"

outputPort Admin {
  Location: Location_Admin
  Protocol: sodep
  OneWay: shutdown
}

main {
  shutdown@Admin( )
}
