// Students who have an 'A' for every subject they attend.
MATCH (st:Student)-[a:ATTENDS]->(:Subject)
WITH st, collect(a.grade) AS grades, count(a) AS subjects
WHERE size(grades) > 0 AND all(g IN grades WHERE g = 'A')
RETURN st.firstName + ' ' + st.lastName AS student,
       subjects AS subjectsCount
ORDER BY subjectsCount DESC, student;
