# Find the names of classrooms that are part of "Malostranské náměstí" building and host more than one subject
.buildings | .[] | select(.name.cs == "Malostranské náměstí") | .classrooms | .[] | select(.subjects | length > 1) | .name.en


