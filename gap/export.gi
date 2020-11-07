#
# IncidenceStructures: GAP implementation of abstract incidence structures
#
# Implementations
#
###############################################################################
InstallGlobalFunction("BmatToString@", 
function( mat )
    local x,y,i,str;
    str := "";
    Append( str, String( Size( mat ) ) );
    Append( str, " ");
    Append( str, String( Size( mat[1] ) ) );
    Append( str, " ");
    x := List( Concatenation( mat ), function(a) if a then return 1; else return 0; fi; end );
    while 0 <> (Size(x) mod 6) do Add( x, 0); od;
    for i in [1..Size(x)/6] do
        y := Sum( [ 0..5 ], j -> 2^(5 - j) * x[ 6 * i - j ] ) + 63;
        Add( str, CharInt( y ) );
    od;
    return str;
end);

InstallGlobalFunction("BmatFromString@", 
function( str )
    local ncols,nrows,mat;
    str := SplitString( str, " " );
    nrows := EvalString( str[1] );
    ncols := EvalString( str[2] );
    mat := List( str[3], a -> IntChar(a)+1 );
    Apply( mat, a -> CoefficientsQadic(a,2){[1..6]} );
    mat := List( Concatenation(mat), IsOne );
    mat := List( [0..nrows-1], i -> mat{ncols*i+[1..ncols]} );
    return mat;
end);
