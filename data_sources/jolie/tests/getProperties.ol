include "head.iol"

main {
    getProperties@DbService()( result );
    valueToPrettyString@StringUtils( result )( s );
    println@Console( s )()
}
