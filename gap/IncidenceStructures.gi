#
# IncidenceStructures: GAP implementation of abstract incidence structures
#
# Implementations
#
###############################################################################
##  CONSTRUCTORS
##  ---------------------------------------------------------------------------

InstallGlobalFunction( IncidenceStructureByIncidenceMatrixNC,
function( pts, bls, incmat )
    local s;
    s := Objectify( NewType( IncidenceStructureFamily, IsIncidenceStructure and
                               IsIncidenceStructureRep ),
                      rec( bmat := incmat ) );
	SetPointsOfIncidenceStructure( s, pts );
	SetBlocksOfIncidenceStructure( s, bls );
	return s;
end );

InstallGlobalFunction( IncidenceStructureByIncidenceMatrix,
function( pts, bls, incmat )
	if not ( 
		IsRectangularTable( incmat ) and
		Length( incmat ) = Length( bls ) and
		Length( incmat[1] ) = Length( pts ) and
		ForAll( incmat, IsBlist )
	) then
		Error( "IncStr: <3> must be a boolean matrix of size |<1>| x |<2>|" );
	fi;		
	return IncidenceStructureByIncidenceMatrixNC( pts, bls, incmat );
end );

InstallGlobalFunction( IncidenceStructureByBlocks,
function( pts, bls )
    local q, bmat, s;
	pts := Set( pts );
	if not ForAll( bls, b -> IsSubset( pts, b ) ) then
		Error( "IncStr: the elements of <2> must be subsets of <1>" );
	fi;
    bmat := List( bls, b -> BlistList( pts, b ) );
	s := IncidenceStructureByIncidenceMatrix( pts, bls, bmat );
	SetIsIndexBasedIncidenceStructure( s, pts = [ 1..Length(pts) ] );
	return s;
end );

InstallMethod( IsIndexBasedIncidenceStructure, "for an abstract incidence structure",
    [ IsIncidenceStructure ],
function( s )
	local n;
	n := Length( PointsOfIncidenceStructure( s ) );
	return PointsOfIncidenceStructure( s ) = [ 1..n ] and
		ForAll( BlocksOfIncidenceStructure( s ), b -> IsSet(b) and IsSubset([1..n],b) );
end );

InstallMethod( IsSimpleIncidenceStructure, "for an abstract incidence structure",
    [ IsIncidenceStructure ],
function( s )
	return IsDuplicateFree( s!.bmat );
end );

InstallMethod( TraceOfBlock, "for an abstract incidence structure and an object",
    [ IsIncidenceStructure, IsObject ],
function( s, bl )
	if not bl in BlocksOfIncidenceStructure( s ) then
		Error( "IncStr: <2> must be a block of <1>");
	fi;
	if IsIndexBasedIncidenceStructure( s ) then
		return BlocksOfIncidenceStructure( s )[bl];
	fi;
	bl := Position( BlocksOfIncidenceStructure( s ), bl );
	return ListBlist( PointsOfIncidenceStructure( s ), s!.bmat[bl] );
end );

InstallMethod( TraceOfPoint, "for an abstract incidence structure and an object",
    [ IsIncidenceStructure, IsObject ],
function( s, pt )
	if not pt in PointsOfIncidenceStructure( s ) then
		Error( "IncStr: <2> must be a point of <1>");
	fi;
	pt := Position( PointsOfIncidenceStructure( s ), pt );
	pt := TransposedMat( s!.bmat )[pt];
	return ListBlist( BlocksOfIncidenceStructure( s ), pt );
end );


###############################################################################
##  DISPLAYING AND COMPARING ELEMENTS
##  ---------------------------------------------------------------------------

InstallMethod( ViewObj, "for an abstract incidence structure",
    [ IsIncidenceStructure ],
function( s )
    Print( "<Incidence structure on ", Length( PointsOfIncidenceStructure ( s ) ), " points>" );
end );

InstallMethod( \=, "for two abstract incidence structures",
    IsIdenticalObj,
    [ IsIncidenceStructure, IsIncidenceStructure ],
function( s1, s2 )
    return PointsOfIncidenceStructure( s1 ) = PointsOfIncidenceStructure( s1 ) and
		BlocksOfIncidenceStructure( s1 ) = BlocksOfIncidenceStructure( s2 ) and
		s1!.bmat = s2!.bmat;
end );

InstallMethod( \<, "for two abstract incidence structures",
    IsIdenticalObj,
    [ IsIncidenceStructure, IsIncidenceStructure ],
    function( s1, s2 )
        return PointsOfIncidenceStructure( s1 ) < PointsOfIncidenceStructure( s1 ) or (
			PointsOfIncidenceStructure( s1 ) = PointsOfIncidenceStructure( s1 ) and 
			s1!.bmat < s2!.bmat );
end );

###############################################################################
##  ACTIONS, AUTOMORPHISMS
##  ---------------------------------------------------------------------------

InstallMethod( PointColoringOfIncidenceStructure, "for an abstract incidence structure",
    [ IsIncidenceStructure ],
function( s )
	return 0*[1..Length( PointsOfIncidenceStructure ( s ) )];
end );

InstallMethod( BlockColoringOfIncidenceStructure, "for an abstract incidence structure",
    [ IsIncidenceStructure ],
function( s )
	return 0*[1..Length( BlocksOfIncidenceStructure ( s ) )];
end );

InstallMethod( CanonicalLabellingOfIncidenceStructure, "for an abstract incidence structure",
    [ IsIncidenceStructure ],
function( s )
    local nrp, nrb, outneigh, ucolours, lcolours, cl;
	nrp := Length( PointsOfIncidenceStructure ( s ) );
	nrb := Length( BlocksOfIncidenceStructure ( s ) );
	if HasPointColoringOfIncidenceStructure( s ) then
		ucolours := PointColoringOfIncidenceStructure( s );
	else 
		ucolours := ListWithIdenticalEntries( nrp, 1 );
	fi;
	if HasBlockColoringOfIncidenceStructure( s ) then
		lcolours := BlockColoringOfIncidenceStructure( s );
	else 
		lcolours := ListWithIdenticalEntries( nrb, 1 );
	fi;
	if IsIndexBasedIncidenceStructure( s ) then
		outneigh := BlocksOfIncidenceStructure( s );
	else
		outneigh := List( s!.bmat, r -> ListBlist( [1..nrp], r ) );
	fi;
	outneigh := Concatenation( List([1..nrp], i->[] ), outneigh );
	Info( InfoIncidenceStructures, 1, "GraphCanonicalLabellingNC@glabella called" );
	Info( InfoIncidenceStructures, 2, "<outneigh> parameter for glabella command: ", outneigh );
	cl := GraphCanonicalLabellingNC@glabella( nrp+nrb, outneigh, Concatenation(ucolours, lcolours), true, "bliss" );
	if cl[1] = [] then cl[1] := (); fi;
	s!.autGrGens := cl[1];
	s!.hash := cl[3];
	return cl[2];
end );

InstallMethod( AutomorphismGroup@, "for an abstract incidence structure",
    [ IsIncidenceStructure ],
function( s )
	CanonicalLabellingOfIncidenceStructure( s );
    return Group( s!.autGrGens );
end );

InstallMethod( HashValue, "for an abstract incidence structure",
    [ IsIncidenceStructure ],
function( s )
	CanonicalLabellingOfIncidenceStructure( s );
    return s!.hash;
end );

InstallMethod( Isomorphism@, "for two abstract incidence structures",
    [ IsIncidenceStructure, IsIncidenceStructure ],
function( s1, s2 )
	local nrp, nrb, i, j, iso, ret;
	nrp := Length( PointsOfIncidenceStructure( s1 ) );
	nrb := Length( BlocksOfIncidenceStructure( s1 ) );
	if nrp <> Length( PointsOfIncidenceStructure( s2 ) ) then
		return fail;
	fi;
	if nrb <> Length( BlocksOfIncidenceStructure( s2 ) ) then
		return fail;
	fi;
	iso := CanonicalLabellingOfIncidenceStructure( s1 ) * 
		CanonicalLabellingOfIncidenceStructure( s2 )^-1;
	Info( InfoIncidenceStructures, 2, "<iso>: ", iso );
	ret := true;
	i :=1; j:=1;
	if not OnSets([1..nrp],iso) = [1..nrp] then
		return fail;
	fi;
	while i<=nrb do
		# a_{ij} = a^*_{\beta(n+i)-n,\beta(j)}
		ret := ( s1!.bmat[i][j] = s2!.bmat[(nrp+i)^iso-nrp][j^iso] );
		if not ret then 
			Info( InfoIncidenceStructures, 2, "wrong position in incidence matrix: (", i, ",", j, ")" );
			break;
		fi;
		j := j + 1;
		if j>nrp then
			j := 1; 
			i := i + 1;
		fi;
	od;
	if ret = false then
		return fail;
	else
		return iso;
	fi;
end );



