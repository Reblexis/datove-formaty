# Find the last names of students who study "Informatika" and whose last name starts with 'P'
.specializations | .[] | select(.title.cs == "Informatika") | .students | .[] | select(.lastName.cs | startswith("P")) | .lastName.cs


