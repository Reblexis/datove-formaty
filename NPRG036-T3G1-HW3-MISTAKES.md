# NPRG036-T3G1-HW3 Mistakes Analysis

## Analysis of Steps 1-6

### ✅ Step 1: Fix previous homework (HW2)
- HW2 appears to be properly structured with RDF data

### ⚠️ Step 2: Create hierarchical diagrams
**Issues found:**
- Hierarchy-3 has incorrect multiplicity: `0...1` for Building-Teacher relationship. This means the student/teacher doesn't have to be related to a building in this nested hierarchy, which violates the nesting principle. According to FAQ: "Having 0..1 or 0..* multiplicities at the parent class means instances don't have to have a relation to the parent, but if only allowed nested, it corresponds to 1..1 or 1..*"
- The hierarchical models may not fully cover the RDF conceptual model (e.g., attends relationship between Student and Subject, resides relationship)

### ⚠️ Step 3: XML Schemas
**Issues found:**

1. **Incorrect datatype in schema-1.xsd:**
   - Line 31: Uses `xs:int` instead of `xs:integer`
   - According to FAQ: "xsd:int exists, but it is a more specific data type than xsd:integer, which is the one used everywhere on the web"

2. **Incorrect datatype in schema-2.xsd:**
   - Line 28: Uses `xs:integer` for capacity - should be consistent, but also check HW2 for proper type

3. **Incorrect datatype in schema-3.xsd:**
   - Line 32: Uses `xs:integer` for salary (correct)

4. **Missing unique identifiers:**
   - None of the schemas enforce globally unique identifiers (IRIs) for entities
   - According to FAQ: "In XML and JSON, entities should also have globally unique identifiers. You have those from RDF, so reuse them also in XML and JSON"
   - Schemas should have an `id` or similar attribute of type `xs:anyURI` to store IRIs

5. **address field in schema-2 and schema-3:**
   - Uses `langElement` type (correct based on HW2 RDF which uses @cs language tag)

6. **address field in schema-3:**
   - Line 44: Uses `langElement` type (correct)

### ❌ Step 4: XML data files
**Critical issues found:**

1. **Missing globally unique identifiers (IRIs):**
   - data-1.xml: No IRI identifiers for entities (Students, Teachers, Subjects, Specializations)
   - data-2.xml: No IRI identifiers for entities (Buildings, Classrooms, Subjects)
   - data-3.xml: No IRI identifiers for entities (Teachers, Subjects, Buildings)
   - According to FAQ: "entities should also have globally unique identifiers... reuse them also in XML"
   - Should use IRIs like `data:teacher1`, `data:student1`, etc. from HW2

2. **data-1.xml issues:**
   - Teachers and Students are duplicated (same teacher appears multiple times with same data)
   - Subjects are duplicated
   - No way to reference/identify entities uniquely to avoid redundancy

3. **data-2.xml issues:**
   - Subjects are duplicated across different classrooms
   - No way to reference subjects by IRI

4. **data-3.xml issues:**
   - Contains different data than data-1.xml and data-2.xml (e.g., different teachers: Jan Novák, Petra Svobodová, Tomáš Dvořák vs Pavel Veselý, Marta Vomlelová, Petr Dvořák from HW2)
   - **Does not match HW2 data** - this is a critical error
   - Subjects in data-3 don't match HW2 (e.g., "Algoritmy a datové struktury" with code NPRG031 doesn't exist in HW2)
   - Buildings don't match HW2 (e.g., "Budova MFF UK" vs "Matematicko-fyzikální fakulta")

5. **Missing translations:**
   - data-1.xml: Only Czech (`@cs`) language tags, missing English translations that exist in HW2
   - data-2.xml: Only Czech language tags
   - data-3.xml: Only Czech language tags
   - HW2 RDF has both Czech and English translations for most entities

6. **Missing relationships:**
   - Student's `resides` relationship not captured in data-1.xml
   - Teacher's `resides` relationship partially captured in data-3.xml with `0...1` multiplicity (should be explicit)

7. **Missing schema validation:**
   - XML files link to schemas via `xsi:schemaLocation` with relative paths, but actual validation status unclear

### ❌ Step 5: XPath queries
**Status: COMPLETELY MISSING**
- No `xml/queries/` folder exists
- No `.xpath` files exist
- Requirements: At least 4 non-trivial XPath queries with comments explaining their meaning
- Format: `query-1-1.xpath`, `query-1-2.xpath`, etc. (first number = data file, second = query number)

### ❌ Step 6: XSLT HTML transformation
**Status: COMPLETELY MISSING**
- No `xml/xslt-html/` folder exists
- No `toHtml.xslt` file exists
- Requirements: A non-trivial XSLT transformation producing HTML representation of a subset of XML data
- According to FAQ: Should use XSL templates, not just `xsl:for-each` loops

---

## Additional Missing Components (Steps 7-8, not in scope but noted)

### Step 7: XSLT RDF transformations
**Status: COMPLETELY MISSING**
- No `xml/xslt-rdf/` folder exists
- No `toRdf-1.xslt`, `toRdf-2.xslt`, etc. files exist
- No `xml/rdf/` folder with resulting `.ttl` files exists
- This is required for the "lifting transformation" from XML to RDF

---

## Summary of Critical Mistakes

### **BLOCKER ISSUES** (Must fix to pass):
1. ❌ **Missing XPath queries** (Step 5) - 0 out of 4+ required
2. ❌ **Missing XSLT HTML transformation** (Step 6) - completely absent
3. ❌ **Missing globally unique identifiers (IRIs)** in all XML files
4. ❌ **Data inconsistency** - data-3.xml doesn't match HW2 data

### **MAJOR ISSUES** (Significant point deductions):
5. ⚠️ **Incorrect datatype** `xs:int` in schema-1.xsd (should be `xs:integer`)
6. ⚠️ **Data duplication** - no way to reference entities by IRI, causing redundancy
7. ⚠️ **Missing translations** - only Czech, no English despite HW2 having both
8. ⚠️ **Incorrect multiplicity** in hierarchy-3 (`0...1` for Building relationship)

### **MODERATE ISSUES**:
9. ⚠️ Schemas don't enforce unique identifiers
10. ⚠️ Missing relationships in hierarchical models

---

## Recommendations

1. **Immediate fixes:**
   - Add globally unique IRI identifiers (as attributes) to all entities in all XML files
   - Create XPath queries folder and at least 4 non-trivial queries
   - Create XSLT HTML transformation
   - Fix data-3.xml to match HW2 data
   - Change `xs:int` to `xs:integer` in schema-1.xsd

2. **Data quality fixes:**
   - Use IRI references instead of duplicating entities
   - Add English translations from HW2
   - Update schemas to enforce IRI attributes

3. **Model fixes:**
   - Review hierarchical model 3 multiplicity
   - Ensure all relationships from conceptual model are covered

4. **Structure fixes:**
   - Ensure folder structure matches requirements exactly
   - Empty `log.txt` should be filled with work log

