#
# UnitalSZ: Algorithms and library of unitals of projective planes
#
# Implementations
#

###############################################################################
##  UTILITIES
##  ---------------------------------------------------------------------------

InstallGlobalFunction( AU_UnitalBlistList_axiomcheck,
function( bmat )
    local bmattr, q, i, j;
    q := SizeBlist( bmat[ 1 ] ) - 1;
    if ForAny( bmat, x -> SizeBlist( x ) <> q + 1 ) then
        return false;
    fi;
    bmattr := TransposedMat( bmat );
    for i in [ 1..q^3 ] do
        for j in [ i + 1..q^3 + 1 ] do
            if SizeBlist( IntersectionBlist( bmattr[ i ],
                                             bmattr[ j ] ) ) <> 1 then
                return false;
            fi;
        od;
    od;
    return true;
end );

InstallGlobalFunction( AU_IsUnitalBlistList,
function( bmat )
    local q, i, j;
    q := SizeBlist( bmat[ 1 ] ) - 1;
    if Length( bmat ) <> q^2 * ( q^2 - q + 1 ) or
       ForAny( bmat, x -> Length( x ) <> q^3 + 1 ) then
        Error("wrong bmat size");
    fi;
    return AU_UnitalBlistList_axiomcheck( bmat );
end );

InstallGlobalFunction( AU_IsUnitalIncidenceMatrix,
function( incmat )
    local q, bmat;
    bmat := List( incmat, x -> List( x, IsOne ) );
    q := SizeBlist( bmat[ 1 ] ) - 1;
    if Length( bmat ) <> q^2 * ( q^2 - q + 1 ) or
       ForAny( bmat, x -> Length( x ) <> q^3 + 1 ) then
        Error( "wrong incmat size" );
    fi;
    return AU_UnitalBlistList_axiomcheck(bmat);
end );

InstallGlobalFunction( AU_IsUnitalBlockDesign,
function( bls )
    local q, bmat, pts;
    pts := Union( bls );
    q := Size( bls[ 1 ] ) - 1;
    if Length( bls ) <> q^2 * ( q^2 - q + 1 ) or Size( pts ) <> q^3 + 1 then
        Error( "wrong number of points or blocks" );
    fi;
    bmat := List( bls, b -> BlistList( pts, b ) );
    return AU_UnitalBlistList_axiomcheck( bmat );
end );

###############################################################################
##  CONSTRUCTORS
##  ---------------------------------------------------------------------------

InstallGlobalFunction( AU_UnitalByBlistListNC,
function( bmat )
    local q, uni;
    q := SizeBlist( bmat[ 1 ] ) - 1;
    uni := Objectify( NewType( AU_UnitalDesignFamily, IsAbstractUnitalDesign and
                               IsAbstractUnitalDesignRep ),
                      rec( bmat := Set( bmat ) ) );
    SetOrder( uni, q );
    return uni;
end );

InstallGlobalFunction( AbstractUnitalByBlistList,
function( bmat )
    if AU_IsUnitalBlistList( bmat ) then
        return AU_UnitalByBlistListNC( bmat );
    else
        Error( "argument must be the blist list of an abstract unital" );
    fi;
end );

InstallGlobalFunction( AbstractUnitalByDesignBlocks,
function( bls )
    local q, bmat, pts, u;
    pts := Union( bls );
    q := Size( bls[ 1 ] ) - 1;
    if Length( bls ) <> q^2 * ( q^2 - q + 1 ) then
        Error( "wrong number of blocks" );
    fi;
    bmat := List( bls, b -> BlistList( pts, b ) );
    if AU_UnitalBlistList_axiomcheck( bmat ) then
        u := AU_UnitalByBlistListNC( bmat );
    else
        Error( "argument must be the list of blocks of an abstract unital" );
    fi;
    return u;
end );

InstallGlobalFunction( AbstractUnitalByIncidenceMatrix,
function( incmat )
    local q, bmat;
    bmat := List( incmat, x -> List( x, IsOne ) );
    q := SizeBlist( bmat[ 1 ] ) - 1;
    if Length( bmat ) <> q^2 * ( q^2 - q + 1 ) or
       ForAny( bmat, x -> Length( x ) <> q^3 + 1 ) then
        Error( "wrong incmat size" );
    fi;
    if AU_UnitalBlistList_axiomcheck( bmat ) then
        return AU_UnitalByBlistListNC( bmat );
    else
        Error( "argument must be the incident matrix of an abstract unital" );
    fi;
end );

###############################################################################
##  DISPLAYING AND COMPARING ELEMENTS
##  ---------------------------------------------------------------------------

InstallMethod( ViewObj, "for an abstract unital",
    [ IsAbstractUnitalDesign ],
function( u )
    Print( "AU_UnitalDesign<", Order( u ), ">" );
end );

InstallMethod( Display, "for an abstract unital",
    [ IsAbstractUnitalDesign ],
function( u )
    Print( "Abstract unital of order ", Order( u ) );
end );

InstallMethod( PrintObj, "for an abstract unital",
    [ IsAbstractUnitalDesign ],
function( u )
    Print( "AU_UnitalDesign<", Order( u ), ">" );
end );

InstallMethod( \=, "for two abstract unitals",
    IsIdenticalObj,
    [ IsAbstractUnitalDesign, IsAbstractUnitalDesign ],
function( u1, u2 )
    return u1!.bmat = u2!.bmat;
end );

InstallMethod( \<, "for two abstract unitals",
    IsIdenticalObj,
    [ IsAbstractUnitalDesign, IsAbstractUnitalDesign ],
    function( u1, u2 )
        return u1!.bmat < u2!.bmat;
end );

###############################################################################
##  BLOCKS, POINTS, INCIDENT DIGRAPHS
##  ---------------------------------------------------------------------------

InstallMethod( PointsOfUnital, "for an abstract unital",
    [ IsAbstractUnitalDesign ],
function( u )
    return [ 1..Order( u )^3 + 1 ];
end );

InstallMethod( PointNamesOfUnital, "for an abstract unital",
    [ IsAbstractUnitalDesign ],
function( u )
    return [ 1..Order( u )^3 + 1 ];
end );

InstallMethod( BlocksOfUnital, "for an abstract unital",
    [ IsAbstractUnitalDesign ],
function( u )
    return Set( u!.bmat, x -> ListBlist( PointsOfUnital( u ), x ) );
end );

InstallMethod( IncidenceDigraph, "for an abstract unital",
    [ IsAbstractUnitalDesign ],
function( u )
    local q;
    q := Order( u );
    return Digraph( [ 1..q^3 + 1 + q^2 * ( q^2 - q + 1 ) ],
                    function( x, y )
                        return x <= q^3 + 1 and y > q^3 + 1 and
                               u!.bmat[ y - q^3 - 1 ][ x ];
                    end );
end );

###############################################################################
##  ACTIONS, AUTOMORPHISMS
##  ---------------------------------------------------------------------------

InstallOtherMethod( \^, "for an abstract unitals and a permutation",
    [ IsAbstractUnitalDesign, IsPerm ],
    function( u, perm )
        return AU_UnitalByBlistListNC( List( u!.bmat,
                                             x -> Permuted( x, perm ) ) );
end );

InstallMethod( AutomorphismGroup, "for an abstract unital",
    [ IsAbstractUnitalDesign ],
function( u )
    local g;
    g := AutomorphismGroup( IncidenceDigraph( u ) );
    return Action( g, [ 1..Order( u )^3 + 1 ] );
end );

InstallMethod( Isomorphism, "for two abstract unitals",
    [ IsAbstractUnitalDesign, IsAbstractUnitalDesign ],
    function( u1, u2 )
        local ret;
        if Order( u1 ) <> Order( u2 ) then
            return fail;
        fi;
        ret := IsomorphismDigraphs( IncidenceDigraph( u1 ),
                                    IncidenceDigraph( u2 ) );
        if ret = fail then
            return fail;
        else
            return RestrictedPerm( ret, [ 1..Order( u1 )^3 + 1 ] );
        fi;
end );
