include "head.iol"

main {
    getTools@DbService()( result );
    valueToPrettyString@StringUtils( result )( s );
    println@Console( s )();
    rq.language = "it";
    getTools@DbService( rq )( result );
    valueToPrettyString@StringUtils( result )( s );
    println@Console( s )()
}
