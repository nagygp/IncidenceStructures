#
# IncidenceStructures: GAP implementation of abstract point-line incidence structures
#
# Declarations
#

#! @Chapter Abstract incidence structures

#! @Section Mathematical background
#! @Section Constructing abstract incidence structures
#! @Section Methods for abstract incidence structures
#! @Section Examples

#! @ChapterInfo Abstract incidence structures, Constructing abstract incidence structures
#! @Arguments object
#! @Description
#!   A &GAP; category of abstract incidence structures. 
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
#!   the list <A>bls</A> of blocks and the incidence matrix <A>incmat</A>. <A>incmat</A>
#!   must be a boolean matrix with <C>|bls|</C> rows and <C>|pts|</C> columns.
DeclareGlobalFunction( "IncidenceStructureByIncidenceMatrix" );

#! @ChapterInfo Abstract incidence structures, Constructing abstract incidence structures
#! @Arguments pts,bls,incmat
#! @Description
#!   The non-checking version of the command <C>IncidenceStructureByIncidenceMatrix</C>.
DeclareGlobalFunction( "IncidenceStructureByIncidenceMatrixNC" );

#! @ChapterInfo Abstract incidence structures, Constructing abstract incidence structures
#! @Arguments pts,bls
#! @Returns
#!   The incidence structure object corresponding to the set <A>pts</A> of points and
#!   the list <A>bls</A> of blocks. The elements of <A>bls</A> must be subsets of <A>pts</A>. 
DeclareGlobalFunction( "IncidenceStructureByBlocks" );

#! @ChapterInfo Abstract incidence structures, Constructing abstract incidence structures
#! @Arguments s
#! @Description
#!   We call the incident structre <A>s</A> **index based** if its set of points is the 
#!   integer range <C>[1..n]</C> and blocks are subsets of <C>[1..n]</C>.
DeclareAttribute( "IsIndexBasedIncidenceStructure", IsIncidenceStructure );

#! @ChapterInfo Abstract incidence structures, Constructing abstract incidence structures
#! @Arguments s
#! @Returns
#!   <K>true</K> if <A>s</A> is a simple incident structure. 
#! @Description
#!   An incident structure is said to be **simple** if each block is uniquely 
#!   determined by the set of points which are incident with it. 
DeclareAttribute( "IsSimpleIncidenceStructure", IsIncidenceStructure );

#! @ChapterInfo Abstract incidence structures, Constructing abstract incidence structures
#! @Description
#!   An infoclass for the package. Its default value is $0$.
DeclareInfoClass( "InfoIncidenceStructures" );

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
#!   The isomorphism is a bijection between the points sets and between the line sets of 
#!   the incidence structures $S_1$ and $S_2$ such that the incidence relations are 
#!   preserved. In this implementation, an isomorphism is given by a permutation $\beta$ 
#!   of degree $n+m$, where $n$ is the number of points and $m$ is the number of lines. 
#!   The bijections defined by $\beta$ are $p[i]\mapsto p'[i^\beta]$ and $b[j] 
#!   \mapsto b'[(j+n)^\beta-n]$, where $p[i]$, $p'[i']$ are points and $b[j]$, $b'[j']$ are 
#!   blocks of $S_1$, $S_2$, respectively. 
#!   
#!   Canonocal labellings, automorphisms and isomorphisms of incidence structures are  
#!   computed with the help of their **incidence graphs**, which is are bipartite graphs
#!   with upper vertices the points and lower vertices the blocks. The computation
#!   is done using the &GAP; package <Package>BlissInterface</Package> <Cite 
#!   Key="BlissInterface0.2" />.
DeclareOperation( "Isomorphism", [ IsIncidenceStructure, IsIncidenceStructure ] );

#####################################################
#####################################################

