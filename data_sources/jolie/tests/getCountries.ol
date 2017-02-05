include "head.iol"

main {
    getCountries@DbService()( result );
    valueToPrettyString@StringUtils( result )( s );
    println@Console( s )();
    rq.language = "it";
    getCountries@DbService( rq )( result );
    valueToPrettyString@StringUtils( result )( s );
    println@Console( s )()
}
