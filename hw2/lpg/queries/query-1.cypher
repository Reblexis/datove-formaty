// Calculates teacher's average grades across all subjects and students of theirs
// Match subjects attended by someone taught by a teacher
MATCH (t:Teacher)-[:TEACHES]->(sub:Subject)<-[a:ATTENDS]-(s:Student)
WITH t,
    // Convert grade to a numeric value for averaging
    CASE a.grade
        WHEN 'A' THEN 1.0
        WHEN 'B' THEN 2.0
        WHEN 'C' THEN 3.0
        WHEN 'D' THEN 4.0
        ELSE 0.0 // Handle missing or other grades
    END AS gradeValue
// Format into final output
RETURN t.firstName + ' ' + t.lastName AS Teacher,
       avg(gradeValue) AS AverageGradeValue
ORDER BY AverageGradeValue DESC