include "head.iol"

main {
    with( request ) {
      .id = 13;
      .language = "it";
      .name = "forno"
    };
    updateTool@DbService( request )( result )
}
