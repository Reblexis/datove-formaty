# Find all students attending subjects with code starting with 'NPRG' taught by teachers earning at least 45000
.specializations | .[] | .students | .[] | select(any(.subjects | .[]; (.code | startswith("NPRG")) and (.teachers | any(.[]; .salary >= 45000)))) | .firstName.cs
