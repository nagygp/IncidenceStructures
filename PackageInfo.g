#
# IncidenceStructures: GAP implementation of abstract incidence structures
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "IncidenceStructures",
Subtitle := "GAP implementation of abstract incidence structures",
Version := "0.2",
Date := "01/09/2019", # dd/mm/yyyy format
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Gábor P.",
    LastName := "Nagy",
    WWWHome := "https://algebra.math.bme.hu/nagy-gabor",
    Email := "nagyg@math.bme.hu",
    PostalAddress := Concatenation(
               "Department of Algebra, Budapest University of Technology\n",
               "Egry József utca 1\n",
               "H-1111 Budapest (Hungary)" ),
    Place := "Budapest",
    Institution := "Budapest University of Technology and Economics",
  ),
],

SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/nagygp/IncidenceStructures",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://nagygp.github.io/IncidenceStructures/",
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
README_URL      := Concatenation( ~.PackageWWWHome, "README.md" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),

ArchiveFormats := ".tar.gz",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "IncidenceStructures",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "GAP implementation of abstract incidence structures",
),

Dependencies := rec(
  GAP := ">= 4.9",
  NeededOtherPackages := [ ["BlissInterface", ">=0.2" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

Keywords := [ "incidence", "incidence structure", "design", "Steiner system", "finite geometry" ],

));


