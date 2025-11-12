# HW3 Changes Summary

## schema-1.xsd (Line 31)
**Changed:** `xs:int` → `xs:integer`  
**Why:** FAQ explicitly warns: "xsd:int exists, but it is a more specific data type than xsd:integer, which is the one used everywhere on the web." HW2 uses `xsd:integer`.

## schema-1.xsd (Lines 49, 55, 59, 65)
**Added:** `id` attribute (type `xs:anyURI`, required) to Teacher, Subject, Student, Specialization  
**Why:** FAQ requires: "In XML and JSON, entities should have globally unique identifiers. You have those from RDF, so reuse them." Without IRIs, entities can't be properly mapped back to RDF in XSLT transformation.

## schema-2.xsd (Lines 36, 40, 44)
**Added:** `id` attribute (type `xs:anyURI`, required) to Subject, Classroom, Building  
**Why:** Same as above - required for RDF mapping and avoiding redundancy.

## schema-3.xsd (Lines 39, 48, 52)
**Added:** `id` attribute (type `xs:anyURI`, required) to Subject, Building, Teacher  
**Why:** Same as above - required for RDF mapping and avoiding redundancy.

## data-1.xml (All entity elements)
**Added:** `id="https://example.org/data/..."` attributes to all Specialization, Student, Subject, Teacher elements  
**Why:** Assignment requires same data instances as HW2. Without IRIs, can't reference entities and must duplicate them. IRIs enable proper RDF lifting transformation.

## data-2.xml (All entity elements)
**Added:** `id="https://example.org/data/..."` attributes to all Building, Classroom, Subject elements  
**Why:** Same as above.

## data-3.xml (Complete rewrite)
**Changed:** Replaced entire file content with HW2-matching data (Pavel Veselý, Marta Vomlelová, Petr Dvořák instead of Jan Novák, Petra Svobodová, Tomáš Dvořák)  
**Why:** Assignment line 5: "use the same data instances as in HW2". Lines 15 & 18: "resulting RDF should be identical to HW2". Original data-3.xml had wrong teachers and subjects not in HW2, making XSLT/JSON-LD transformations produce incorrect RDF.

