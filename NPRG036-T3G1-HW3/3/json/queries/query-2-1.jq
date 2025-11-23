# Find the unique names of buildings that contain at least one classroom with a capacity greater than 100 and host a subject with code containing 'PRG'
[."@graph" | .[] | select(.classrooms[]? | .capacity > 100 and (.subjects[] | .code | contains("PRG"))) | .buildingName.en] | unique | .[]
