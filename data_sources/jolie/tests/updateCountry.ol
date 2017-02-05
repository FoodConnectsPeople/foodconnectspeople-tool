include "head.iol"

main {
    with( request ) {
      .id = 51;
      .language = "it";
      .name = "Croazia"
    };
    updateCountry@DbService( request )( result )
}
