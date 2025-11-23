# Find the names of specializations where at least one student attends a subject whose name contains "Database"
[."@graph" | .[] | select(.students[]? | .subjects[] | .subjectName.en | contains("Database")) | .title.en] | unique | .[]
