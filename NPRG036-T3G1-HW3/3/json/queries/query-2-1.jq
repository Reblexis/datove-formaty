# Find the unique names of buildings that contain at least one classroom with a capacity greater than 100 and host a subject with code containing 'PRG'
[.buildings | .[] | select(.classrooms | any(.[]; .capacity > 100 and (.subjects | any(.[]; .code | contains("PRG"))))) | .name.en] | unique | .[]
