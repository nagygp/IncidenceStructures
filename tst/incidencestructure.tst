#############################################################################
##
#A  incidencestructure.tst      IncidenceStructures package       Gábor P. Nagy
##
##  To create a test file, place GAP prompts, input and output exactly as
##  they must appear in the GAP session. Do not remove lines containing 
##  START_TEST and STOP_TEST statements.
##
##  The first line starts the test. START_TEST reinitializes the caches and 
##  the global random number generator, in order to be independent of the 
##  reading order of several test files. Furthermore, the assertion level 
##  is set to 2 by START_TEST and set back to the previous value in the 
##  subsequent STOP_TEST call.
##
##  The argument of STOP_TEST may be an arbitrary identifier string.
## 
gap> START_TEST("IncidenceStructures package: incidencestructure.tst");
gap> SizeScreen([72]);
[ 72, 40 ]
gap> LoadPackage("IncidenceStructures", false);
true
gap> 
gap> s:=IncidenceStructureByBlocks([1..3],[[1],[1,2],[1,2,3]]);
<Incidence structure on 3 points>
gap> PointsOfIncidenceStructure(s);
[ 1, 2, 3 ]
gap> BlocksOfIncidenceStructure(s);
[ [ 1 ], [ 1, 2 ], [ 1, 2, 3 ] ]
gap> CanonicalLabellingOfIncidenceStructure(s);
(1,3)
gap> KnownAttributesOfObject(s);
[ "AutomorphismGroup", "IsIndexBasedIncidenceStructure", 
  "PointsOfIncidenceStructure", "BlocksOfIncidenceStructure", 
  "CanonicalLabellingOfIncidenceStructure" ]
gap> 
gap> s:=IncidenceStructureByIncidenceMatrix( [1..4], "abcdef", 
>     [[true,true,false,false],
>     [true,false,true,false],
>     [true,false,false,true],
>     [false,true,true,false],
>     [false,true,false,true],
>     [false,false,true,true]]
> );
<Incidence structure on 4 points>
gap> TraceOfPoint(s,2);
"ade"
gap> TraceOfBlock(s,'c');
[ 1, 4 ]
gap> 
gap> SetInfoLevel(InfoIncidenceStructures,1);
gap> CanonicalLabellingOfIncidenceStructure(s);
#I  BLISS_BIPARTITE_CANONICAL_LABELING called
(1,4)(2,3)(5,10,9)(6,8)
gap> StructureDescription(AutomorphismGroup(s));
"S4"
gap> 
gap> SetInfoLevel(InfoIncidenceStructures,2);
gap> t:=IncidenceStructureByBlocks( "rozi", 
>     ["or","iz","rz","oi","ir","oz"] );
<Incidence structure on 4 points>
gap> Isomorphism(s,t);
#I  BLISS_BIPARTITE_CANONICAL_LABELING called
#I  <outneigh> parameter for BLISS command: [ [ 2, 3 ], [ 1, 4 ], [ 3, 4 ], [ 1, 2 ], [ 1, 3 ], [ 2, 4 ] ]
#I  <iso>: ( 1, 3, 4)( 6, 7, 9, 8,10)
(1,3,4)(6,7,9,8,10)
gap> StructureDescription(AutomorphismGroup(t));
"S4"
gap> STOP_TEST( "incidencestructure.tst", 10000 );
## The first argument of STOP_TEST should be the name of the test file.
## The number is a proportionality factor that is used to output a 
## "GAPstone" speed ranking after the file has been completely processed.
## For the files provided with the distribution this scaling is roughly 
## equalized to yield the same numbers as produced by the test file 
## tst/combinat.tst. For package tests, you may leave it unchnaged. 

#############################################################################
##
#E
