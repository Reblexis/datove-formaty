# Find all students attending subjects with code starting with 'NPRG' taught by teachers earning at least 45000
."@graph" | .[] | .students[]? | select(.subjects | any(.[]; (.code | startswith("NPRG")) and (.teachers | any(.[]; .salary >= 45000)))) | .firstName.cs
