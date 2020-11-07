SizeScreen([72]);

LoadPackage("IncidenceStructures", false);

s:=IncidenceStructureByBlocks([1..3],[[1],[1,2],[1,2,3]]);
PointsOfIncidenceStructure(s);
BlocksOfIncidenceStructure(s);
CanonicalLabellingOfIncidenceStructure(s);
KnownAttributesOfObject(s);

s:=IncidenceStructureByIncidenceMatrix( [1..4], "abcdef", 
    [[true,true,false,false],
    [true,false,true,false],
    [true,false,false,true],
    [false,true,true,false],
    [false,true,false,true],
    [false,false,true,true]]
);
TraceOfPoint(s,2);
TraceOfBlock(s,'c');

SetInfoLevel(InfoIncidenceStructures,1);
CanonicalLabellingOfIncidenceStructure(s);
StructureDescription(AutomorphismGroup@IncidenceStructures(s));

SetInfoLevel(InfoIncidenceStructures,2);
t:=IncidenceStructureByBlocks( "rozi", 
    ["or","iz","rz","oi","ir","oz"] );
Isomorphism@IncidenceStructures(s,t);
HashValue(s);
HashValue(t);
StructureDescription(AutomorphismGroup@IncidenceStructures(t));
