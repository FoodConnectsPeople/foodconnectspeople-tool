include "head.iol"

main {
    getIngredients@DbService()( result );
    valueToPrettyString@StringUtils( result )( s );
    println@Console( s )()
}
