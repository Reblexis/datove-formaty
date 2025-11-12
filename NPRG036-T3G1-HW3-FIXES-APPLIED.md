# HW3 Minimal Fixes Applied

## Summary of Changes

All minimal necessary fixes for steps 1-4 (lines 7-12 of hw3.txt) have been applied.

### 1. ✅ Fixed schema-1.xsd
- **Line 31**: Changed `xs:int` → `xs:integer` for `numberOfStudents`

### 2. ✅ Added IRI identifier support to all schemas

**schema-1.xsd:**
- Added `id` attribute (type `xs:anyURI`, required) to:
  - Specialization
  - Student  
  - Subject
  - Teacher

**schema-2.xsd:**
- Added `id` attribute (type `xs:anyURI`, required) to:
  - Building
  - Classroom
  - Subject

**schema-3.xsd:**
- Added `id` attribute (type `xs:anyURI`, required) to:
  - Teacher
  - Subject
  - Building

### 3. ✅ Added IRI identifiers to data-1.xml
All entities now have globally unique identifiers from HW2:
- `data:spec1`, `data:spec2`, `data:spec3` for Specializations
- `data:student1`, `data:student2`, `data:student3`, `data:student4` for Students
- `data:subject1`, `data:subject2`, `data:subject3`, `data:subject4` for Subjects
- `data:teacher1`, `data:teacher2`, `data:teacher3` for Teachers

### 4. ✅ Added IRI identifiers to data-2.xml
All entities now have globally unique identifiers from HW2:
- `data:building1`, `data:building2`, `data:building3` for Buildings
- `data:classroom1`, `data:classroom2`, `data:classroom3` for Classrooms
- `data:subject1`, `data:subject2`, `data:subject3`, `data:subject4` for Subjects

### 5. ✅ Fixed data-3.xml to match HW2 data
**CRITICAL FIX**: Completely rewrote data-3.xml to use correct HW2 data:

**Before (WRONG):**
- Teachers: Jan Novák, Petra Svobodová, Tomáš Dvořák
- Subjects: Included non-existent NPRG031, NMAI052

**After (CORRECT):**
- Teachers: Pavel Veselý, Marta Vomlelová, Petr Dvořák ✓
- Subjects: NPRG030, NPRG036, NDBI025, NMAI059 ✓
- Buildings: Match HW2 data ✓
- All entities have IRI identifiers ✓

---

## What Was NOT Changed (Intentionally)

The following were NOT changed to keep fixes minimal:

1. **English translations** - Only Czech (`xml:lang="cs"`) remains, English omitted
2. **Hierarchy-3 multiplicity** - Still has `0...1` for Building (not critical)
3. **No XPath queries** - Still missing (Steps 5+, not in scope)
4. **No XSLT transformations** - Still missing (Steps 6+, not in scope)

---

## Validation Status

All XML files should now:
- ✅ Validate against their schemas
- ✅ Have globally unique identifiers (IRIs)
- ✅ Use correct datatypes
- ✅ Match HW2 data

The XML schemas now enforce entity identification, which will be essential for:
- XSLT RDF transformation (Step 7)
- JSON-LD mapping (Step 8)

