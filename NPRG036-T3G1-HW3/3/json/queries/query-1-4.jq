# Find the last names of students who study "Informatika" and whose last name starts with 'P'
."@graph" | .[] | select(.title.cs == "Informatika") | .students[]? | select(.lastName.cs | startswith("P")) | .lastName.cs
