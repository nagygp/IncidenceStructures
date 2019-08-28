#
# UnitalSZ: Algorithms and library of unitals of projective planes
#
# Declarations
#

#! @Chapter Abstract unitals
#! @Section Constructing abstract unitals
#! @Section Methods for abstract unitals
#! @Section Global functions for internal usage

#! @ChapterInfo Abstract unitals, Constructing abstract unitals
#! @Arguments object
#! @Description
#!   A &GAP; category of abstract unitals. Synonym is <C>IsAbstractUnital</C>.
DeclareCategory( "IsAbstractUnitalDesign", IsObject );

DeclareSynonym( "IsAbstractUnital", IsAbstractUnitalDesign );

DeclareRepresentation( "IsAbstractUnitalDesignRep", IsComponentObjectRep and
                       IsAttributeStoringRep, [ "bmat" ] );
AU_UnitalDesignFamily := NewFamily( "AbstractUnitalDesignFam" );

#! @ChapterInfo Abstract unitals, Global functions for internal usage
#! @Arguments bmat
#! @Returns
#!   <K>true</K> if <A>bmat</A> is the blist list of an abstract unital.
#! @Description
#!   Each row of <A>bmat</A> corresponds to a block of the unital. We check the
#!   sizes of the blocks and the sizes of the intersections of the dual blocks.
DeclareGlobalFunction( "AU_UnitalBlistList_axiomcheck" );

#! @ChapterInfo Abstract unitals, Global functions for internal usage
#! @Arguments bmat
#! @Returns
#!   <K>true</K> if <A>bmat</A> is the blist list of an abstract unital.
#! @Description
#!   Each row of <A>bmat</A> corresponds to a block of the unital. We check the
#!   sizes of the blocks and the sizes of the intersections of the dual blocks.
#!   Wrong <A>bmat</A> matrix size drops error.
DeclareGlobalFunction( "AU_IsUnitalBlistList" );

#! @ChapterInfo Abstract unitals, Global functions for internal usage
#! @Arguments incmat
#! @Returns
#!   <K>true</K> if <A>incmat</A> is the incidence matrix of an abstract unital.
#! @Description
#!   Each row of <A>incmat</A> corresponds to a block of the unital. We check
#!   the sizes of the blocks and the sizes of the intersections of the dual
#!   blocks. Wrong <A>incmat</A> matrix size drops error.
DeclareGlobalFunction( "AU_IsUnitalIncidenceMatrix" );

#! @ChapterInfo Abstract unitals, Global functions for internal usage
#! @Arguments blocklist
#! @Returns
#!   <K>true</K> if <A>blocklist</A> is the list of blocks of an abstract
#!   unital.
#! @Description
#!   We check the sizes of the blocks and the sizes of the intersections of the
#!   dual blocks. Wrong number of blocks or wrong number of points (union of the
#!   blocks in <A>blocklist</A>) drops error.
DeclareGlobalFunction( "AU_IsUnitalBlockDesign" );

#####################################################
#####################################################
#! @ChapterInfo Abstract unitals, Global functions for internal usage
#! @Arguments bmat
#! @Returns
#!   The unital object corresponding to the blist list <A>bmat</A>.
#! @Description
#!   The function stores <A>bmat</A> and sets the order of the unital. The
#!   function **do not check** the necessary conditions (the size of bmat,
#!   the sizes of the blocks and their intersections).
DeclareGlobalFunction( "AU_UnitalByBlistListNC" );

#! @ChapterInfo Abstract unitals, Constructing abstract unitals
#! @Arguments bmat
#! @Returns
#!   The unital object corresponding to the blist list <A>bmat</A>.
#! @Description
#!   Each row of <A>bmat</A> corresponds to a block of the unital. We check the
#!   sizes of the blocks and the sizes of the intersections of the dual blocks.
#!   Wrong <A>bmat</A> matrix size drops error. The function stores <A>bmat</A>
#!   and sets the <C>Order</C> of the unital.
DeclareGlobalFunction( "AbstractUnitalByBlistList" );

#! @ChapterInfo Abstract unitals, Constructing abstract unitals
#! @Arguments blocklist
#! @Returns
#!   The unital object corresponding to the list of blocks <A>blocklist</A>.
# @Description
#!   We check the sizes of the blocks and the sizes of the intersections of the
#!   dual blocks. Wrong number of blocks or wrong number of points (union of the
#!   blocks in <A>blocklist</A>) drops error. The function stores <C>bmat</C>,
#!   which is based on <A>blocklist</A>, sets the <C>Order</C> of the unital and
#!   sets the names of the points, <C>PointNamesOfUnital</C> of the unital.
DeclareGlobalFunction( "AbstractUnitalByDesignBlocks" );

#! @ChapterInfo Abstract unitals, Constructing abstract unitals
#! @Arguments incmat
#! @Returns
#!   The unital object corresponding to the incidence matrix <A>incmat</A>.
#! @Description
#!   Each row of <A>incmat</A> corresponds to a block of the unital. We check
#!   the sizes of the blocks and the sizes of the intersections of the dual
#!   blocks. Wrong <A>incmat</A> matrix size drops error. The function stores
#!   <C>bmat</C>, which is based on <A>incmat</A> and sets the <C>Order</C> of
#!   the unital.
DeclareGlobalFunction( "AbstractUnitalByIncidenceMatrix" );

#####################################################
#####################################################
#! @ChapterInfo Abstract unitals, Methods for abstract unitals
#! @Arguments s
#! @Returns
#!   The range <C>[ 1..q^3 + 1 ]</C>.
#! @Description
#!   If <A>u</A> is a unital of order $q$, then <A>u</A> has $q^3 + 1$
#!   points.
DeclareAttribute( "PointsOfUnital", IsAbstractUnitalDesign );

#! @ChapterInfo Abstract unitals, Methods for abstract unitals
#! @Arguments s
#! @Returns
#!   The blocks of the unital <A>u</A>.
#! @Description
#!   If <A>u</A> is a unital of order $q$, then each block is a subset of
#!   the points of the unital with $q + 1$ points. The blocks of an abstract
#!   unital form a $2-(q^3+1,q+1,1)$ design. 
DeclareAttribute( "BlocksOfUnital", IsAbstractUnitalDesign );

#! @ChapterInfo Abstract unitals, Methods for abstract unitals
#! @Arguments s
#! @Returns
#!   The names of the $q^3+1$ points of <A>u</A>.
#! @Description
#!   The names of the points of <A>u</A> is a list of length $q^3+1$ of 
#!   arbitrary &GAP; objects. It may be set by <Code>SetPointNamesOfUnital</Code>.
#!   The default is the range <C>[ 1..q^3 + 1 ]</C>.
DeclareAttribute( "PointNamesOfUnital", IsAbstractUnitalDesign );

#! @ChapterInfo Abstract unitals, Methods for abstract unitals
#! @Arguments s
#! @Returns
#!   The (bipartite) digraph constructed from the boolean incidence matrix
#!   <C>bmat</C> of the unital <A>u</A>.
DeclareAttribute( "IncidenceDigraph", IsAbstractUnitalDesign );

#! @ChapterInfo Abstract unitals, Methods for abstract unitals
#! @Arguments s
#! @Returns
#!   The automorphism group of the unital <A>u</A>.
#! @Description
#!   The function computes the automorphism group of <A>u</A> with the help of
#!   its incidence digraph.
DeclareAttribute( "AutomorphismGroup", IsAbstractUnitalDesign );

#! @ChapterInfo Abstract unitals, Methods for abstract unitals
#! @Arguments s1, u2
#! @Returns
#!   An isomorphism between the unitals <A>u1</A> and <A>u1</A> if they are
#!   isomorphic, and <K>fail</K> otherwise.
#! @Description
#!   The isomorphism is a permutation which sends the points of the unital
#!   <A>u1</A> to the points of the unital <A>u2</A> such that the it preserves
#!   the incidence between the points and the blocks. The function computes the
#!   isomorphism with the help of the incidence digraphs of the unitals
#!   <A>u1</A> and <A>u2</A>.
DeclareOperation( "Isomorphism", [ IsAbstractUnitalDesign, IsAbstractUnitalDesign ] );

#! @ChapterInfo Abstract unitals, Constructing abstract unitals
#! @Description
#!   An infoclass for the package. Its default value is $0$.
DeclareInfoClass( "InfoUnitalSZ" );
