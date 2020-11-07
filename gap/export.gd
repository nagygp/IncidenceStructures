#
# IncidenceStructures: GAP implementation of abstract incidence structures
#
# Declarations
#
#####################################################
#####################################################
#! @ChapterInfo Abstract incidence structures, Utilities
#! @Arguments mat
#! @Returns
#!   A string encoding the Boolean matrix <A>mat</A>.
#! @Description
#!   The encoding string consists of three space separated parts <C>n m x</C>. 
#!   The integers <C>n</C>, <C>m</C> are number of rows and columns. 
#!   The string <C>x</C> is the graph6-type 
#!   encoding of the Boolean matrix, concatenated into one binary vector. 
DeclareGlobalFunction( "BmatToString@" );

#! @ChapterInfo Abstract incidence structures, Utilities
#! @Arguments str
#! @Returns
#!   A Boolean matrix, encoded by the string <A>str</A> as explained above.
#! @Description
#!   The result is unpredicted when the argument string is not well formed. 
DeclareGlobalFunction( "BmatFromString@" );