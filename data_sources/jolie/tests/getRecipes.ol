include "head.iol"

main {
    getRecipes@DbService()( result );
    valueToPrettyString@StringUtils( result )( s );
    println@Console( s )()
}
