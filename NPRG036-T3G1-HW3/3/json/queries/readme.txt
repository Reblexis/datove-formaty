jq Queries Explanation
=======================

Data file 1 (data-1.jsonld) - Specializations with Students and Subjects:

query-1-1.jq:
    Finds first names (Czech) of all students attending subjects with code starting with 'NPRG' taught by teachers earning at least 45000.
    Usage: jq -r -f query-1-1.jq ../data/data-1.jsonld

query-1-2.jq:
    Finds unique English names of subjects taught by teachers with more than one mobile number and a salary of at least 50000.
    Usage: jq -r -f query-1-2.jq ../data/data-1.jsonld

query-1-3.jq:
    Finds unique English names of specializations where at least one student attends a subject whose name contains "Database".
    Usage: jq -r -f query-1-3.jq ../data/data-1.jsonld

query-1-4.jq:
    Finds Czech last names of students who study "Informatika" and whose last name starts with 'P'.
    Usage: jq -r -f query-1-4.jq ../data/data-1.jsonld


Data file 2 (data-2.jsonld) - Buildings with Classrooms and Subjects:

query-2-1.jq:
    Finds unique English names of buildings that contain at least one classroom with a capacity greater than 100 and host a subject with code containing 'PRG'.
    Usage: jq -r -f query-2-1.jq ../data/data-2.jsonld

query-2-2.jq:
    Finds English names of classrooms that are part of "Malostranské náměstí" building and host more than one subject.
    Usage: jq -r -f query-2-2.jq ../data/data-2.jsonld
