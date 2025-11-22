# Find the names of specializations where at least one student attends a subject whose name contains "Database"
[.specializations | .[] | select(.students | any(.[]; .subjects | any(.[]; .name.en | contains("Database")))) | .title.en] | unique | .[]
