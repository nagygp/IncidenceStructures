#
# IncidenceStructures: GAP implementation of abstract point-line incidence structures
#
# Declarations
#

#! @Chapter Abstract incidence structures
#! @Section Constructing abstract incidence structures
#! @Section Methods for abstract incidence structures
#! @Section Global functions for internal usage

#! @ChapterInfo Abstract incidence structures, Constructing abstract incidence structures
#! @Arguments object
#! @Description
#!   A &GAP; category of abstract incidence structures. Synonym is <C>IsIncidenceStructure</C>.
DeclareCategory( "IsIncidenceStructure", IsObject );

DeclareRepresentation( "IsIncidenceStructureRep", IsComponentObjectRep and
                       IsAttributeStoringRep, [ "bmat" ] );
PLIS_IncidenceStructureFamily := NewFamily( "IncidenceStructureFam" );

#####################################################
#####################################################
#! @ChapterInfo Abstract incidence structures, Constructing abstract incidence structures
#! @Arguments pts,bls,incmat
#! @Returns
#!   The incidence structure object corresponding to the set <A>pts</A> of points and
#!   the list <A>bls</A>of blocks and the incidence matrix <A>incmat</A>. <A>incmat</A>
#!   must be a boolean matrix of dimensions <C>|pts| x |bls|</C>
DeclareGlobalFunction( "IncidenceStructureByIncidenceMatrix" );

#! @ChapterInfo Abstract incidence structures, Constructing abstract incidence structures
#! @Arguments pts,bls,incmat
#! @Description
#!   The non-checking version of the command <F>IncidenceStructureByIncidenceMatrix</F>.
DeclareGlobalFunction( "IncidenceStructureByIncidenceMatrixNC" );

#! @ChapterInfo Abstract incidence structures, Constructing abstract incidence structures
#! @Arguments pts,bls
#! @Returns
#!   The incidence structure object corresponding to the set <A>pts</A> of points and
#!   the list <A>bls</A>of blocks. The elements of <A>bls</A> must be subsets of <A>pts</A>. 
DeclareGlobalFunction( "IncidenceStructureByBlocks" );

#! @ChapterInfo Abstract incidence structures, Methods for abstract incidence structures
#! @Arguments s
#! @Description
#!   We call the incident structre <A>s</A> *index based* if its set of points is the 
#!   integer range <C>[1..n]</C> and blocks are subsets of <C>[1..n]</C>.
DeclareAttribute( "IsIndexBasedIncidenceStructure", IsIncidenceStructure );

#! @ChapterInfo Abstract incidence structures, Methods for abstract incidence structures
#! @Arguments s
#! @Returns
#!   <K>true</K> if <A>s</A> is a simple incident structure. 
#! @Description
#!   An incident structure is said to be *simple* if each block is uniquely 
#!   determined by the set of points which are incident with it. 
DeclareAttribute( "IsSimpleIncidenceStructure", IsIncidenceStructure );

#####################################################
#####################################################
#! @ChapterInfo Abstract incidence structures, Methods for abstract incidence structures
#! @Arguments s
#! @Returns
#!   The list of points of the incidence structure <A>s</A>.
DeclareAttribute( "PointsOfIncidenceStructure", IsIncidenceStructure );

#! @ChapterInfo Abstract incidence structures, Methods for abstract incidence structures
#! @Arguments s
#! @Returns
#!   The list of blocks of the incidence structure <A>s</A>.
DeclareAttribute( "BlocksOfIncidenceStructure", IsIncidenceStructure );

#! @ChapterInfo Abstract incidence structures, Methods for abstract incidence structures
#! @Arguments s,pt
#! @Returns
#!   The list of blocks which are incident with <A>pt</A> in the incidence structure <A>s</A>.
DeclareOperation( "TraceOfPoint", [ IsIncidenceStructure, IsObject ] );

#! @ChapterInfo Abstract incidence structures, Methods for abstract incidence structures
#! @Arguments s,bl
#! @Returns
#!   The list of points which are incident with <A>bl</A> in the incidence structure <A>s</A>.
DeclareOperation( "TraceOfBlock", [ IsIncidenceStructure, IsObject ] );


#####################################################
#####################################################

DeclareAttribute( "CanonicalLabellingOfIncidenceStructure", IsIncidenceStructure );
DeclareAttribute( "PointColoringOfIncidenceStructure", IsIncidenceStructure );
DeclareAttribute( "BlockColoringOfIncidenceStructure", IsIncidenceStructure );

#! @ChapterInfo Abstract incidence structures, Methods for abstract incidence structures
#! @Arguments s
#! @Returns
#!   The automorphism group of the incidence structure <A>s</A>.
#! @Description
#!   The function computes the automorphism group of <A>s</A> with the help of
#!   its incidence digraph.
DeclareAttribute( "AutomorphismGroup", IsIncidenceStructure );

#! @ChapterInfo Abstract incidence structures, Methods for abstract incidence structures
#! @Arguments s1, s2
#! @Returns
#!   An isomorphism between the incidence structures <A>s1</A> and <A>s1</A> if they are
#!   isomorphic, and <K>fail</K> otherwise.
#! @Description
#!   The isomorphism is a permutation which sends the points of the incidence structure
#!   <A>s1</A> to the points of the incidence structure <A>s2</A> such that the it preserves
#!   the incidence between the points and the blocks. The function computes the
#!   isomorphism with the help of the incidence digraphs of the incidence structures
#!   <A>s1</A> and <A>s2</A>.
DeclareOperation( "Isomorphism", [ IsIncidenceStructure, IsIncidenceStructure ] );

#####################################################
#####################################################

#! @ChapterInfo Abstract incidence structures, Constructing abstract incidence structures
#! @Description
#!   An infoclass for the package. Its default value is $0$.
DeclareInfoClass( "InfoIncidenceStructures" );
